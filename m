Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1592DE7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgLRQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgLRQ4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:56:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98C923B28;
        Fri, 18 Dec 2020 16:55:33 +0000 (UTC)
Date:   Fri, 18 Dec 2020 11:55:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ktest.pl: Updates for 5.11
Message-ID: <20201218115532.35eca018@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

ktest.pl: Updates for 5.11

No new features. Just a couple of fixes that I had in my local repository
that fixed issues with sending the result emails.


Please pull the latest ktest-v5.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.11

Tag SHA1: 1d7125079e919a18b84f3fa180eab57171be730c
Head SHA1: 170f4869e66275f498ae4736106fb54c0fdcd036


Steven Rostedt (VMware) (2):
      ktest.pl: If size of log is too big to email, email error message
      ktest.pl: Fix the logic for truncating the size of the log file for email

----
 tools/testing/ktest/ktest.pl | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 54188ee16c48..4e2450964517 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1499,17 +1499,16 @@ sub dodie {
 	my $log_file;
 
 	if (defined($opt{"LOG_FILE"})) {
-	    my $whence = 0; # beginning of file
-	    my $pos = $test_log_start;
+	    my $whence = 2; # End of file
+	    my $log_size = tell LOG;
+	    my $size = $log_size - $test_log_start;
 
 	    if (defined($mail_max_size)) {
-		my $log_size = tell LOG;
-		$log_size -= $test_log_start;
-		if ($log_size > $mail_max_size) {
-		    $whence = 2; # end of file
-		    $pos = - $mail_max_size;
+		if ($size > $mail_max_size) {
+		    $size = $mail_max_size;
 		}
 	    }
+	    my $pos = - $size;
 	    $log_file = "$tmpdir/log";
 	    open (L, "$opt{LOG_FILE}") or die "Can't open $opt{LOG_FILE} to read)";
 	    open (O, "> $tmpdir/log") or die "Can't open $tmpdir/log\n";
@@ -4253,7 +4252,12 @@ sub do_send_mail {
     $mail_command =~ s/\$SUBJECT/$subject/g;
     $mail_command =~ s/\$MESSAGE/$message/g;
 
-    run_command $mail_command;
+    my $ret = run_command $mail_command;
+    if (!$ret && defined($file)) {
+	# try again without the file
+	$message .= "\n\n*** FAILED TO SEND LOG ***\n\n";
+	do_send_email($subject, $message);
+    }
 }
 
 sub send_email {
