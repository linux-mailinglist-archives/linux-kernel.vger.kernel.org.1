Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEBA29DEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbgJ2A5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbgJ1WRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:35 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7071F247B9;
        Wed, 28 Oct 2020 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895015;
        bh=o5fpMFDz7DGix7Klrhn+855AGlng0F/UM59klpo7meE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glqK3lNEhlpqNfzjo6sGVhMCfhp2VX561tLmn1u8nBGnl52o9rqtoqyGU02jVZ9NG
         cud0eedCdX3QDYHWtRP23c/2zIneuC1ce03hZwRDTSScSOwaoW3plJJgNIkESrd8kJ
         xgp9IttxqvIYNAl4lmQDAAdRG2+0pjxze/QJnqwA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hkn-2A; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/33] scripts: get_abi.pl: change script to allow parsing in ReST mode
Date:   Wed, 28 Oct 2020 15:22:59 +0100
Message-Id: <6bed15a4dc1587faf5312d4f63e57775b27f1ff6.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Right now, several ABI files won't parse as ReST, as they
contain severe violations to the spec, with makes the script
to crash.

So, the code has a sanity logic with escapes bad code and
cleans tags that can cause Sphinx to crash.

Add support for disabling this mode.

Right now, as enabling rst-mode causes crash, it is disabled
by default.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 74 ++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c738cb795514..107672cdacb3 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -12,8 +12,14 @@ my $man;
 my $debug;
 my $prefix="Documentation/ABI";
 
+#
+# If true, assumes that the description is formatted with ReST
+#
+my $description_is_rst = 0;
+
 GetOptions(
 	"debug|d+" => \$debug,
+	"rst-source!" => \$description_is_rst,
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
 	man => \$man
@@ -137,14 +143,15 @@ sub parse_abi {
 					next;
 				}
 				if ($tag eq "description") {
-					next if ($content =~ m/^\s*$/);
-					if ($content =~ m/^(\s*)(.*)/) {
-						my $new_content = $2;
-						$space = $new_tag . $sep . $1;
-						while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-						$space =~ s/./ /g;
-						$data{$what}->{$tag} .= "$new_content\n";
+					# Preserve initial spaces for the first line
+					$content = ' ' x length($new_tag) . $sep . $content;
+					$content =~ s,^(\s*):,$1 ,;
+					if ($content =~ m/^(\s*)(.*)$/) {
+						$space = $1;
+						$content = $2;
 					}
+					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					$data{$what}->{$tag} .= $content;
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -160,11 +167,15 @@ sub parse_abi {
 
 		if ($tag eq "description") {
 			if (!$data{$what}->{description}) {
-				next if (m/^\s*\n/);
+				s/^($space)//;
 				if (m/^(\s*)(.*)/) {
-					$space = $1;
-					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					$data{$what}->{$tag} .= "$2\n";
+					my $sp = $1;
+					while ($sp =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					my $content = "$sp$2";
+
+					$content =~ s/^($space)//;
+
+					$data{$what}->{$tag} .= "$content";
 				}
 			} else {
 				my $content = $_;
@@ -274,23 +285,27 @@ sub output_rest {
 		print "Defined on file :ref:`$file <$fileref>`\n\n" if ($type ne "File");
 
 		my $desc = $data{$what}->{description};
-		$desc =~ s/^\s+//;
-
-		# Remove title markups from the description, as they won't work
-		$desc =~ s/\n[\-\*\=\^\~]+\n/\n/g;
 
 		if (!($desc =~ /^\s*$/)) {
-			if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
-				# put everything inside a code block
-				$desc =~ s/\n/\n /g;
-
-				print "::\n\n";
-				print " $desc\n\n";
-			} else {
-				# Escape any special chars from description
-				$desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
-
+			if ($description_is_rst) {
 				print "$desc\n\n";
+			} else {
+				$desc =~ s/^\s+//;
+
+				# Remove title markups from the description, as they won't work
+				$desc =~ s/\n[\-\*\=\^\~]+\n/\n\n/g;
+
+				if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
+					# put everything inside a code block
+					$desc =~ s/\n/\n /g;
+
+					print "::\n\n";
+					print " $desc\n\n";
+				} else {
+					# Escape any special chars from description
+					$desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
+					print "$desc\n\n";
+				}
 			}
 		} else {
 			print "DESCRIPTION MISSING for $what\n\n" if (!$data{$what}->{is_file});
@@ -382,7 +397,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--man] [--help] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--man] [--help] --[(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -405,6 +420,13 @@ B<validate>              - validate the ABI contents
 Changes the location of the ABI search. By default, it uses
 the Documentation/ABI directory.
 
+=item B<--rst-source> and B<--no-rst-source>
+
+The input file may be using ReST syntax or not. Those two options allow
+selecting between a rst-compliant source ABI (--rst-source), or a
+plain text that may be violating ReST spec, so it requres some escaping
+logic (--no-rst-source).
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
-- 
2.26.2

