Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF362858B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgJGGdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgJGGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:33:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:33:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id x5so545573pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghveWhrhcR987K2j+v2KOBB59W/+/rKX3+mThnkvmCw=;
        b=lirKZNMdNW5tvLEOi3VqYeoxLOyyJ/V4xsBP30AZbf4FnvfmPTvAvgfglBAjRaCIrr
         wLVzM4VnWPOTHJnf0YOe0naj+xpmP4NOKKkOi0wJzjHZGejASZnLZjSJl+t8NdzrWkBG
         YI8+uBX6DkWg3YdsmRIFiK9AZa1bRLIkLjjjq9IyxyGw1h6/Fx2Td969Mojdr0t6tGyj
         m5Dud2XPEBym9OZ0/bInHUOFgzylFZUaLRlNy1Lcbjh8O8OG15AsWRlnKTKUKhzyIskW
         A2eNyYnJ9u3tLTO3H2PxBNXrfJKWDPrExmDT2kZ1rGq+jDlv/qgUXSUcHUJOtxXqf8uR
         /HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghveWhrhcR987K2j+v2KOBB59W/+/rKX3+mThnkvmCw=;
        b=CLAsxMo8Mos4sFT8De/kieojhhQQ99yW2lL9/DsxI0LsK/FPQ55wdLYc/j5XHvMLjg
         2DKRu3pU8nvKpNFjjETnInU8VGe1hLdES7Khzic+emzcGrMRxFm4NT5O//MtnfN+Ko32
         hPf79OZRPT2V7wlRJV3CqPHB6PlBEI+O0MCt0a1mTLZTvKYDL+sztNNu6iDg9RygenOu
         O9+NQwaI4rImiYWi3V8JQOxIQxcRJrPpBwW57mwN+HTyVp55sanj0wGJdK0+8V+a6CgC
         BIgiJYrn1VsfV0NvugwABWsFJklpAO39cZIGo48g1UhT65YDhMQKULHBcBeFYb8DCXpS
         setQ==
X-Gm-Message-State: AOAM5309yPOMpX9k1YcY9vs31Q/YLQNeKPb4a+NSg08mk0R/kH74vO7t
        /MBM1EQLUHfiq0ZQnTiCtMxoqnE+WHjvnJYbbj4=
X-Google-Smtp-Source: ABdhPJyXtzG3Jq5dW2h7hbty8BJzprUS2rdFW8I4eQbTjD8XyV8HW/+Q7srk1tFwgA8QJmlfDOnwNQ==
X-Received: by 2002:a17:902:5999:b029:d3:f00b:8ae3 with SMTP id p25-20020a1709025999b02900d3f00b8ae3mr1724819pli.36.1602052415393;
        Tue, 06 Oct 2020 23:33:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6078:3b0d:c364:bb32:6512])
        by smtp.gmail.com with ESMTPSA id ck21sm1040349pjb.56.2020.10.06.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 23:33:34 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com
Subject: [PATCH v5] checkpatch: add new warnings to author signoff checks.
Date:   Wed,  7 Oct 2020 12:03:15 +0530
Message-Id: <20201007063315.41585-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The author signed-off-by checks are currently very vague.
Cases like same name or same address are not handled separately.

For example, running checkpatch on commit be6577af0cef
("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
gives:

WARNING: Missing Signed-off-by: line by nominal patch author
'John David Anglin <dave.anglin@bell.net>'

The signoff line was:
"Signed-off-by: Dave Anglin <dave.anglin@bell.net>"

Clearly the author has signed off but with a slightly different version
of his name. A more appropriate warning would have been to point out
at the name mismatch instead.

Previously, the values assumed by $authorsignoff were either 0 or 1
to indicate whether a proper sign off by author is present.
Extended the checks to handle four new cases.

$authorsignoff values now denote the following:

0: Missing sign off by patch author.

1: Sign off present and identical.

2: Addresses and names match, but comments differ.
   "James Watson(JW) <james@gmail.com>", "James Watson <james@gmail.com>"

3: Addresses match, but names are different.
   "James Watson <james@gmail.com>", "James <james@gmail.com>"

4: Names match, but addresses are different.
   "James Watson <james@watson.com>", "James Watson <james@gmail.com>"

5: Names match, addresses excluding subaddress details (RFC 5233) match.
   "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 93 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31624bbb342e..6e0a0d4603d0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1163,10 +1163,10 @@ sub parse_email {
 		}
 	}
 
+	$comment = trim($comment);
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
-	$name =~ s/(\s*\([^\)]+\))\s*//;
-	if (defined($1)) {
+	if ($name =~ s/(\s*\([^\)]+\))\s*//) {
 		$name_comment = trim($1);
 	}
 	$address = trim($address);
@@ -1181,10 +1181,12 @@ sub parse_email {
 }
 
 sub format_email {
-	my ($name, $address) = @_;
+	my ($name, $name_comment, $address, $comment) = @_;
 
 	my $formatted_email;
 
+	$name_comment = trim($name_comment);
+	$comment = trim($comment);
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
 	$address = trim($address);
@@ -1197,9 +1199,9 @@ sub format_email {
 	if ("$name" eq "") {
 		$formatted_email = "$address";
 	} else {
-		$formatted_email = "$name <$address>";
+		$formatted_email = "$name$name_comment <$address>";
 	}
-
+	$formatted_email .= "$comment";
 	return $formatted_email;
 }
 
@@ -1207,17 +1209,23 @@ sub reformat_email {
 	my ($email) = @_;
 
 	my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
-	return format_email($email_name, $email_address);
+	return format_email($email_name, $name_comment, $email_address, $comment);
 }
 
 sub same_email_addresses {
-	my ($email1, $email2) = @_;
+	my ($email1, $email2, $match_comment) = @_;
 
 	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
 	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
 
+	if ($match_comment != 1) {
+		return $email1_name eq $email2_name &&
+		       $email1_address eq $email2_address;
+	}
 	return $email1_name eq $email2_name &&
-	       $email1_address eq $email2_address;
+	       $email1_address eq $email2_address &&
+	       $name1_comment eq $name2_comment &&
+	       $comment1 eq $comment2;
 }
 
 sub which {
@@ -2347,6 +2355,7 @@ sub process {
 	my $signoff = 0;
 	my $author = '';
 	my $authorsignoff = 0;
+	my $author_sob = '';
 	my $is_patch = 0;
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
@@ -2674,9 +2683,37 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
-			if ($author ne '') {
-				if (same_email_addresses($1, $author)) {
+			if ($author ne ''  && $authorsignoff != 1) {
+				if (same_email_addresses($1, $author, 1)) {
 					$authorsignoff = 1;
+				} else {
+					my $ctx = $1;
+					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
+					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
+
+					if ($email_address eq $author_address && $email_name eq $author_name) {
+						$author_sob = $ctx;
+						$authorsignoff = 2;
+					} elsif ($email_address eq $author_address) {
+						$author_sob = $ctx;
+						$authorsignoff = 3;
+					} elsif ($email_name eq $author_name) {
+						$author_sob = $ctx;
+						$authorsignoff = 4;
+
+						my $address1 = $email_address;
+						my $address2 = $author_address;
+
+						if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
+							$address1 = "$1$2";
+						}
+						if ($address2 =~ /(\S+)\+\S+(\@.*)/) {
+							$address2 = "$1$2";
+						}
+						if ($address1 eq $address2) {
+							$authorsignoff = 5;
+						}
+					}
 				}
 			}
 		}
@@ -2733,7 +2770,7 @@ sub process {
 			}
 
 			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
-			my $suggested_email = format_email(($email_name, $email_address));
+			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
 			if ($suggested_email eq "") {
 				ERROR("BAD_SIGN_OFF",
 				      "Unrecognized email address: '$email'\n" . $herecurr);
@@ -2743,9 +2780,9 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if (!same_email_addresses($email, $suggested_email)) {
+				if (!same_email_addresses($email, $suggested_email, 0)) {
 					WARN("BAD_SIGN_OFF",
-					     "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
+					     "email address '$email' might be better as '$suggested_email'\n" . $herecurr);
 				}
 			}
 
@@ -6891,9 +6928,33 @@ sub process {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
 			      "Missing Signed-off-by: line(s)\n");
-		} elsif (!$authorsignoff) {
-			WARN("NO_AUTHOR_SIGN_OFF",
-			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
+		} elsif ($authorsignoff != 1) {
+			# authorsignoff values:
+			# 0 -> missing sign off
+			# 1 -> sign off identical
+			# 2 -> names and addresses match, comments mismatch
+			# 3 -> addresses match, names different
+			# 4 -> names match, addresses different
+			# 5 -> names match, addresses excluding subaddress details (refer RFC 5233) match
+
+			my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
+
+			if ($authorsignoff == 0) {
+				ERROR("NO_AUTHOR_SIGN_OFF",
+				      "Missing Signed-off-by: line by nominal patch author '$author'\n");
+			} elsif ($authorsignoff == 2) {
+				CHK("NO_AUTHOR_SIGN_OFF",
+				    "From:/Signed-off-by: email comments mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 3) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email name mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 4) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email address mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 5) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email subaddress mismatch: $sob_msg\n");
+			}
 		}
 	}
 
-- 
2.27.0

