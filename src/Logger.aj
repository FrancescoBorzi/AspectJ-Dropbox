import com.dropbox.core.*;

import java.io.*;
import java.util.Locale;

public aspect Logger {
	
	pointcut dropboxUploadFile()	: call(* DbxClient.uploadFile(..));
	pointcut dropboxDownloadFile()	: call(* DbxClient.getFile(..));
	pointcut dropboxCreateClient()	: call(public DbxClient.new(..));

	after() returning(DbxClient client) throws DbxException : dropboxCreateClient() {
		System.out.println("[Aspect Logger] Linked account:\t" + client.getAccountInfo().displayName);
	}

	after() returning(DbxEntry.File uploadedFile) : dropboxUploadFile() {
		System.out.println("[Aspect Logger] Uploaded:\t" + uploadedFile.toString());
	}

	after() returning(DbxEntry.File downloadedFile) : dropboxDownloadFile() {
		System.out.println("[Aspect Logger] Downloaded:\t" + downloadedFile.toString());
	}
}
