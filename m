Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22282AAA7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgKHKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgKHKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:07:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD89C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 02:07:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f27so1026433pgl.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ad1WQa8ln8fqmJEMI++EgB7/ogu0ixy+FUkMF3j+aiE=;
        b=RVhR63ztPLCMmfkik7sJFikU9TYM5S9QqKqwS2TfHvVZ4Jykx9CGfz2gZVYgrxM5MX
         rxsrrFXsjJ/BB1Xj4yxtnkzxlfIcRNXj81D8TdZx1yM0mzut0zrCC3qRByEUJPukowzL
         AR/N8pw32Ugayo55H9M1AU1DH+oiv/9ywubXDRVPvFb7J6adYHI5CNQMt5CQXj3MjpZc
         GjZq0U6RLYAFJUvMhlPUBlK+X2MK9z7bV6lHON98aSs0PewadJpdgkWNBMDPmMzfNS+i
         CGwZ3WFl7vwSHu70N5mi1iettS7Iod0Vn0pM9OSGCvqVXqLyAVSZk0sgXFU9RTbf2BTM
         xpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ad1WQa8ln8fqmJEMI++EgB7/ogu0ixy+FUkMF3j+aiE=;
        b=iclaF4MeMjQdQGEy7NB+DeXOg6ysqIiFnKgPJ9LB+2ucGy7Bmb4H1lAp6ybNNh+dzq
         IbVa1J8Xtgmdc8UGx2brZEf0YkooeldFg9PShUmXudm6DkcUhGw1m1Xt5FXGokCMnHTA
         i3BfpTyi7pgQgnLMz79H+SX5DBVMQ5pG1p9HXyVKvngObxld5x3zIMMxRasB96NaBqzS
         jiM4ujAHDcN72xcEOCykckhcczwzZ+LUjzNgdcTY1Cy+qfsuLw1FlA53zyIxwWh2J70w
         5VabZb+RVb1s2b6UiTbCfexmMvvxtDUC4kKaBbLX6zVJuHLXAuWCUiksLX8S7fh/+8zu
         D0hg==
X-Gm-Message-State: AOAM530NckttA1JVQub0hRvXu5dDD1TzGkp76kVQZyNMeNmxdOg75cqg
        sKhEA0CWK8z5SbmD+CuJ194=
X-Google-Smtp-Source: ABdhPJysPH3v9IWbQ7zqMqDEP4bTLoTY8uiPaXHYf0G7MvdYW8Pf5chtFx22Q5dTWIrv1M9Z8kip9w==
X-Received: by 2002:aa7:8d05:0:b029:18b:6f5f:1ea with SMTP id j5-20020aa78d050000b029018b6f5f01eamr9451540pfe.38.1604830029171;
        Sun, 08 Nov 2020 02:07:09 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6086:c6ff:8523:6d2b:2dc7])
        by smtp.gmail.com with ESMTPSA id c19sm7866572pfp.1.2020.11.08.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 02:07:08 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, yashsri421@gmail.com
Subject: [PATCH v5] checkpatch: improve email parsing
Date:   Sun,  8 Nov 2020 15:36:32 +0530
Message-Id: <20201108100632.75340-1-dwaipayanray1@gmail.com>
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

Link: https://lore.kernel.org/linux-kernel-mentees/6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com/
Link: https://lore.kernel.org/linux-kernel-mentees/20201105200857.GC1333458@kroah.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 108 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 17 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..52d355387c44 100755
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
+	# "John D. (Doe)" - Do not extract
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
+	$name_comment = " $name_comment" if ($name_comment ne "");
+	$comment = trim($comment);
+	$comment = " $comment" if ($comment ne "");
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
@@ -2800,9 +2806,77 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if (!same_email_addresses($email, $suggested_email, 0)) {
+				if (!same_email_addresses($email, $suggested_email)) {
+					if (WARN("BAD_SIGN_OFF",
+						 "email address '$email' might be better as '$suggested_email'\n" . $herecurr) &&
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
+						 "address part of email should not have comments: '$email_address'\n" . $herecurr) &&
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
+				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/i) {
+					if (($comment ne "" && $comment !~ /^#.+/) ||
+					    ($email_name ne "")) {
+						my $cur_name = $email_name;
+						my $new_comment = $comment;
+						$cur_name =~ s/[a-zA-Z\s\-\"]+//g;
+
+						# Remove brackets enclosing comment text
+						# and # from start of comments to get comment text
+						$new_comment =~ s/^\((.*)\)$/$1/;
+						$new_comment =~ s/^\[(.*)\]$/$1/;
+						$new_comment =~ s/^[\s\#]+|\s+$//g;
+
+						$new_comment = trim("$new_comment $cur_name") if ($cur_name ne $new_comment);
+						$new_comment = " # $new_comment" if ($new_comment ne "");
+						my $new_email = "$email_address$new_comment";
+
+						if (WARN("BAD_STABLE_ADDRESS_STYLE",
+							 "Invalid email format for stable: '$email', prefer '$new_email'\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =~ s/\Q$email\E/$new_email/;
+						}
+					}
+				} elsif ($comment ne "" && $comment !~ /^(?:#.+|\(.+\))$/) {
+					my $new_comment = $comment;
+
+					# Extract comment text from within brackets or
+					# c89 style /*...*/ comments
+					$new_comment =~ s/^\[(.*)\]$/$1/;
+					$new_comment =~ s/^\/\*(.*)\*\/$/$1/;
+
+					$new_comment = trim($new_comment);
+					$new_comment =~ s/^[^\w]$//; # Single lettered comment with non word character is usually a typo
+					$new_comment = "($new_comment)" if ($new_comment ne "");
+					my $new_email = format_email($email_name, $name_comment, $email_address, $new_comment);
+
+					if (WARN("BAD_SIGN_OFF",
+						 "Unexpected content after email: '$email', should be: '$new_email'\n" . $herecurr) &&
+					    $fix) {
+						$fixed[$fixlinenr] =~ s/\Q$email\E/$new_email/;
+					}
 				}
 			}
 
-- 
2.27.0

