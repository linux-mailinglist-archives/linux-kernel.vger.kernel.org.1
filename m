Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5582A7DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgKEMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:00:23 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:00:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so721327pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQk5IDsyENH45uUiFTC8E+OCQhtMayPZ2ZBICZ3zfiQ=;
        b=glh87jI7JEK8SbroZkpgj9MLIxH7Hhf2ORAL82JO/VmmDR+eOEwOFVlpv0ry2RZamh
         7IJMRIZGy1W7aJP+4IICzL4uan0CPPEINGWYV68o6ofDfCmyqerZ5P5ouJGVHPhqX/zX
         ZktsOM+Fm0dUL/DamBK3kT4ode0c+1wLAu0w1O8fSMu/zHGx/KvTHQ6onIttovrBAnMa
         0eIRrJQQsIjOb11zQZN8jW9hp0gCSvB8TvhLfVf8EG4sb1qULZ0RiNRM1HYJxBFmzhzL
         Kg5SjoXaOS3u4Wj9Y0xHcXY4rYxSVVlDj2+1/750M24F1qHEnq2LSxgrT2egfgladDsd
         JSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQk5IDsyENH45uUiFTC8E+OCQhtMayPZ2ZBICZ3zfiQ=;
        b=e8M0+X5KTUDar4e/1ajA//49Q2FKsLH7vOn3PKiYi27gCSyeIFru4RiMkRZME5YsYN
         24zWh4XOEv8KrodG9ADuh0ORu4n51Et6eAvQYIRLIIs7kEDwyaRnCXue/V0eT2sM42FH
         hyaImFaNge04y5K+vRKU9qGrBIK6NvgGKftVodlSaNb+npw9bzYTBJ/fHdnL7BeK0Qvc
         YqIlX3QsdPpnDXslt3WDAKBpTJ30B+sTUhFHccZfQ71Bky5yRRQGGcZ/469Xm6AB2jCz
         +hS20iiijdEUoj6eCB2Yll2N0GH8jj1/LCiFdWpFqXPrQKjJisJ/0AVGa/IMBbLGB0tW
         RgGQ==
X-Gm-Message-State: AOAM531p3Jip8kse9q+zNrDlTORTjPIFmuTWDe1Vg2QhVT2R65M99oqH
        SHFjSUg0pAYIU7cIjoFWpZ4=
X-Google-Smtp-Source: ABdhPJwq6e/UuOZ7WnMVHfJsilv7l3DPaK1ZkYyhQ7AU+wVTcBIgFoM+3YZXsCKqHyhEvYhkr37Hng==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr2133405pju.88.1604577622527;
        Thu, 05 Nov 2020 04:00:22 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:60c1:275b:c814:aca3:d7c6])
        by smtp.gmail.com with ESMTPSA id k5sm2198768pjs.14.2020.11.05.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 04:00:20 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, yashsri421@gmail.com
Subject: [PATCH v3] checkpatch: improve email parsing
Date:   Thu,  5 Nov 2020 17:29:49 +0530
Message-Id: <20201105115949.39474-1-dwaipayanray1@gmail.com>
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

Some general comment rules are defined:

- Multiple name comments should not be allowed.
- Comments inside address should not be allowed.
- In general comments should be enclosed within parentheses.
  Exception for stable@vger.kernel.org # X.X

Improvements to parsing:

- Detect and report unexpected content after email.
- Quoted names are excluded from comment parsing.
- Trailing dots or commas in email are removed during
  formatting. Correspondingly a BAD_SIGN_OFF warning
  is emitted.
- Improperly quoted email like '"name <address>"' are now
  warned about.

In addition, added fixes for all the possible rules.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 88 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..dc8b664b7de1 100755
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
+	$address =~ s/(?:\.|\,)+$//; ##trailing commas or dots
 
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
@@ -2800,9 +2806,57 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if (!same_email_addresses($email, $suggested_email, 0)) {
+				if (!same_email_addresses($email, $suggested_email)) {
+					if (WARN("BAD_SIGN_OFF",
+					    "email address '$email' might be better as '$suggested_email'\n" . $herecurr) &&
+						$fix) {
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
+						$fix) {
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
+				# Comments must begin only with (
+				# or # in case of stable@vger.kernel.org
+				if ($email =~ /^.*stable\@vger/) {
+					if ($comment ne "" && $comment !~ /^#.+/) {
+						if (WARN("BAD_SIGN_OFF",
+						    "Invalid comment format for stable: '$email', prefer parentheses\n" . $herecurr) &&
+							$fix) {
+							my $new_comment = $comment;
+							$new_comment =~ s/^[ \(\[]+|[ \)\]]+$//g;
+							$new_comment = " # $new_comment" if length($new_comment) > 0;
+							$fixed[$fixlinenr] =~ s/\s*\Q$comment\E$/$new_comment/;
+						}
+					}
+				} else {
+					if ($comment ne "" && $comment !~ /^\(.+\)$/) {
+						if (WARN("BAD_SIGN_OFF",
+						    "Unexpected content after email: '$email'\n" . $herecurr) &&
+							$fix) {
+							my $new_comment = $comment;
+							$new_comment =~ s/^(?:\#|\/\*|\.|\,)//g;
+							$new_comment =~ s/^[ \{\[]+|[ \}\]]+$//g;
+							$new_comment = " ($new_comment)" if length($new_comment) > 0;
+							$fixed[$fixlinenr] =~ s/\s*\Q$comment\E$/$new_comment/;
+						}
+					}
 				}
 			}
 
-- 
2.27.0

