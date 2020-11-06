Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC02A9F50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgKFVqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgKFVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:46:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:46:00 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i26so1975164pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQd258nAXtkhBpfrjQtJmjO7+TGrIP+ES5n2twCl6tA=;
        b=JZmP0ONhTyrQEcVUI+jx7+Z+WvLToeoecviiEqdPZum3UOtb+R/brE78oo3G4JxlCm
         J7hrFtXvqd0Vn4mskAyGy+v1egvzI5N/0Kp410tlJaur1+B/KNGrKJBu4I/1vJn/eW+Z
         HrmjgxqL7xBsQJgDK1By1vCsZk1TybGOzfArLHKew1XXxYNZIQBKSrjiPBpKc1v/9GBL
         9o4g77rWuZxmvmynbGebtfkVmvI9s16PTPb26yPR3SN0lAoS3hF7o27JYbYHJG9Xj1EW
         RzusZYogtmNAA9aNRtVCdwhxpxwZkAXljAtHsocOzfnHbeUuDCanrUcLTwv1dYhinkQh
         eowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQd258nAXtkhBpfrjQtJmjO7+TGrIP+ES5n2twCl6tA=;
        b=EAyP1gNx7vZDVsIDqg1SMk3PC/phpTtjr46rXvCfJIHK+z5yLVK8hmSCO51/M2YM06
         yw10M9UmxkiS5SUfDnZc0IFslTKwwvwHjFLNhGZSrhU8Pf50CqTefY8tvc07lPpIL7xC
         S79oVc4ejVQOVFJgS4e6fqTApuVPjtS7pzrjePgpyPPcXclivZpOi+1n5GzTDiQOG9dy
         w68XueNtIRrcZe/9Am53pK9SiUs8MuyktuA7bQ6d3UGEgKTVYIptT8Ml3twkX0xOZh/u
         X2Pc/zBDvPbkUYPq3G08tZH30wDDcxHpiiez0cfBe27l1yPyuFwk3VEYAvJ6oFcqGQ2u
         kMsg==
X-Gm-Message-State: AOAM531XjJYjWPRVjz/zQu7IW9RwOWOX2Rdn/jEpGy8Sdx5CoYHhQzRw
        TmwAC1ptiFe4YWu57nQdF14=
X-Google-Smtp-Source: ABdhPJx4ffbvc4iL7gdpnXvyWDpJzQEMdMNsuTqK06B4RuLmreUlNRWJrv/kwXLgR3XLNooBDyENkQ==
X-Received: by 2002:a17:90b:2343:: with SMTP id ms3mr1652613pjb.130.1604699160051;
        Fri, 06 Nov 2020 13:46:00 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60c3:15ce:d78:bdc8:182f])
        by smtp.gmail.com with ESMTPSA id i123sm3273075pfc.13.2020.11.06.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:45:59 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, yashsri421@gmail.com
Subject: [PATCH v4] checkpatch: improve email parsing
Date:   Sat,  7 Nov 2020 03:15:30 +0530
Message-Id: <20201106214530.367247-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch doesn't report warnings for many common mistakes
in emails. Some of which are trailing commas and incorrect
use of email comments.

At the same time several false positives are reported due to
incorrect handling of mail comments. The most common of which
is due to the pattern:

<stable@vger.kernel.org> # X.X

Improve email parsing in checkpatch.

Some general email rules are defined:

- Multiple name comments should not be allowed.
- Comments inside address should not be allowed.
- In general comments should be enclosed within parentheses.
  Relaxation is given to comments beginning with #.
- Stable addresses should not begin with a name.
- Comments in stable addresses should begin only
  with a #.

Improvements to parsing:

- Detect and report unexpected content after email.
- Quoted names are excluded from comment parsing.
- Trailing dots, commas or quotes in email are removed during
  formatting. Correspondingly a BAD_SIGN_OFF warning
  is emitted.
- Improperly quoted email like '"name <address>"' are now
  warned about.

In addition, added fixes for all the possible rules.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 97 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..d866c4321182 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1152,6 +1152,7 @@ sub parse_email {
 	my ($formatted_email) = @_;
 
 	my $name = "";
+	my $quoted = "";
 	my $name_comment = "";
 	my $address = "";
 	my $comment = "";
@@ -1183,14 +1184,20 @@ sub parse_email {
 		}
 	}
 
-	$comment = trim($comment);
-	$name = trim($name);
-	$name =~ s/^\"|\"$//g;
-	if ($name =~ s/(\s*\([^\)]+\))\s*//) {
-		$name_comment = trim($1);
+	# Extract comments from names excluding quoted parts
+	# "John A. (Kennedy)" - Do not extract
+	if ($name =~ s/\"(.+)\"//) {
+		$quoted = $1;
+	}
+	while ($name =~ s/\s*($balanced_parens)\s*/ /) {
+		$name_comment .= trim($1);
 	}
+	$name =~ s/^[ \"]+|[ \"]+$//g;
+	$name = trim("$quoted $name");
+
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
+	$comment = trim($comment);
 
 	if ($name =~ /[^\w \-]/i) { ##has "must quote" chars
 		$name =~ s/(?<!\\)"/\\"/g; ##escape quotes
@@ -1205,17 +1212,20 @@ sub format_email {
 
 	my $formatted_email;
 
-	$name_comment = trim($name_comment);
-	$comment = trim($comment);
-	$name = trim($name);
-	$name =~ s/^\"|\"$//g;
+	$name =~ s/^[ \"]+|[ \"]+$//g;
 	$address = trim($address);
+	$address =~ s/(?:\.|\,|\")+$//; ##trailing commas, dots or quotes
 
 	if ($name =~ /[^\w \-]/i) { ##has "must quote" chars
 		$name =~ s/(?<!\\)"/\\"/g; ##escape quotes
 		$name = "\"$name\"";
 	}
 
+	$name_comment = trim($name_comment);
+	$name_comment = " $name_comment" if length($name_comment) > 0;
+	$comment = trim($comment);
+	$comment = " $comment" if length($comment) > 0;
+
 	if ("$name" eq "") {
 		$formatted_email = "$address";
 	} else {
@@ -1233,15 +1243,11 @@ sub reformat_email {
 }
 
 sub same_email_addresses {
-	my ($email1, $email2, $match_comment) = @_;
+	my ($email1, $email2) = @_;
 
 	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
 	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
 
-	if ($match_comment != 1) {
-		return $email1_name eq $email2_name &&
-		       $email1_address eq $email2_address;
-	}
 	return $email1_name eq $email2_name &&
 	       $email1_address eq $email2_address &&
 	       $name1_comment eq $name2_comment &&
@@ -2704,7 +2710,7 @@ sub process {
 			$signoff++;
 			$in_commit_log = 0;
 			if ($author ne ''  && $authorsignoff != 1) {
-				if (same_email_addresses($1, $author, 1)) {
+				if (same_email_addresses($1, $author)) {
 					$authorsignoff = 1;
 				} else {
 					my $ctx = $1;
@@ -2800,9 +2806,66 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if (!same_email_addresses($email, $suggested_email, 0)) {
+				if (!same_email_addresses($email, $suggested_email)) {
+					if (WARN("BAD_SIGN_OFF",
+					    "email address '$email' might be better as '$suggested_email'\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/\Q$email\E/$suggested_email/;
+					}
+				}
+
+				# Address part shouldn't have comments
+				my $stripped_address = $email_address;
+				$stripped_address =~ s/\([^\(\)]*\)//g;
+				if ($email_address ne $stripped_address) {
+					if (WARN("BAD_SIGN_OFF",
+					    "address part of email should not have comments: '$email_address'\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/\Q$email_address\E/$stripped_address/;
+					}
+				}
+
+				# Only one name comment should be allowed
+				my $comment_count = () = $name_comment =~ /\([^\)]+\)/g;
+				if ($comment_count > 1) {
 					WARN("BAD_SIGN_OFF",
-					     "email address '$email' might be better as '$suggested_email'\n" . $herecurr);
+					     "Use a single name comment in email: '$email'\n" . $herecurr);
+				}
+
+
+				# stable@vger.kernel.org or stable@kernel.org shouldn't
+				# have an email name. In addition commments should strictly
+				# begin with a #
+				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/) {
+					if ($sign_off =~ /cc:$/i && (($comment ne "" && $comment !~ /^#.+/) ||
+					    ($email_name ne ""))) {
+						my $cur_name = $email_name;
+						my $new_comment = $comment;
+
+						$cur_name =~ s/[a-zA-Z\s\-\"]+//g;
+						$new_comment =~ s/^[\s\#\(\[]+|[\s\)\]]+$//g;
+						$new_comment = trim("$new_comment $cur_name") if $cur_name ne $new_comment;
+						$new_comment = " # $new_comment" if length($new_comment) > 0;
+						my $new_email = "$email_address$new_comment";
+
+						if (WARN("BAD_SIGN_OFF",
+						    "Invalid email format for stable: '$email', prefer '$new_email'\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =~ s/\Q$email\E/$new_email/;
+						}
+					}
+				} else {
+					if ($comment ne "" && $comment !~ /^(?:#.+|\(.+\))$/) {
+						if (WARN("BAD_SIGN_OFF",
+						    "Unexpected content after email: '$email'\n" . $herecurr) &&
+						    $fix) {
+							my $new_comment = $comment;
+							$new_comment =~ s/^(?:\/\*|\.|\,)//g;
+							$new_comment =~ s/^[\s\{\[]+|[\s\}\]]+$//g;
+							$new_comment = " ($new_comment)" if length($new_comment) > 0;
+							$fixed[$fixlinenr] =~ s/\s*\Q$comment\E$/$new_comment/;
+						}
+					}
 				}
 			}
 
-- 
2.27.0

