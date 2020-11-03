Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A82A3C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKCFsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:48:40 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C83C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 21:48:40 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so8044160plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR1QkDyPTyXg0sfV86lfe9Sb5xsrO/S7r01fQ+mnp6Q=;
        b=T1/EcaPJZSf64kQx/eeiXOxrDxi5NedAfCmLUzI68doU3cKMYX0i/pynTGah3jEmWp
         qtIayvkROX6ldtNFhSZAqyth4RKR1zCduetEhHg0HOJVXqA6MC3DPR5Tf/Rkvg3EDEI4
         h/a4LCEbLVqHmkyetn4hhHOdUSn4hShI9ubdeGt8KjiduGFFYkR1SsoHXUdhnXvNPlo/
         8HcxpoCH0SGvGPDq63VTou77H0WrWZ7MTl7GOSEAamqtnvpQq8zoMDAL9EW/wwMz/RTt
         FYGEqRUMFtv/GGXrjIuaodgS4169EJN2wkg+yRXYdEg6k9n8e9CpJeB/ypaEyHSAa0yC
         CPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR1QkDyPTyXg0sfV86lfe9Sb5xsrO/S7r01fQ+mnp6Q=;
        b=Ws01eImNc8dNZhcK922VP5k3lRoeezZohowcLaNG5VHcvsPgVRsXIybqodaYZXwkgk
         7eZau+3yWydmiFTazfu7hj9pbHM4oc/GDfHcJ1KhVrInx64dyN3L9dFeOQtcURJfwjJZ
         nG4M2HKDGb4GHbe/XW0bJg9BzSvfJUfG0kBoJcTn8wnYzGFNYmjQp49ndOgnIekSKxDz
         NVmbkKRvBgki5aL2nA5gWgGXAmos6o1E/H4+JuT8OyLFRgXSAlAAjj06CM4pw8LLAZf7
         dZUUlV2f9xRqdEAY9H1IDbDrCE9399NdcJUCj2xC4LKfvRJ78U+qFudalaxrmSQuNaj0
         11JA==
X-Gm-Message-State: AOAM531YO4S+Byqc6l6sC1F4Pj92ei4qVXwp9mCUxpCXURSeyDrjXJuW
        JS63/UAtdSkYxXyeKNHC4g8uJEeA3ztKZi/X
X-Google-Smtp-Source: ABdhPJwJ+t8XYHF2C4S4h0qHAV86mWJWEsbuLFK4FUIT6TKEv05JsmNehBIFFWQ49btQwLKp3NaErg==
X-Received: by 2002:a17:902:7408:b029:d6:8208:bc7 with SMTP id g8-20020a1709027408b02900d682080bc7mr23942194pll.82.1604382519915;
        Mon, 02 Nov 2020 21:48:39 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:605e:3f8e:a675:34b8:3ea1])
        by smtp.gmail.com with ESMTPSA id s18sm14023643pgh.60.2020.11.02.21.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 21:48:39 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, yashsri421@gmail.com
Subject: [PATCH v2] checkpatch: improve email parsing
Date:   Tue,  3 Nov 2020 11:18:10 +0530
Message-Id: <20201103054810.21978-1-dwaipayanray1@gmail.com>
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

Improve email parsing mechanism in checkpatch.

What is added:

- Support for multiple name/address comments.
- Improved handling of quoted names.
- Sanitize improperly formatted comments.
- Sanitize trailing semicolon or dot after email.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 44 +++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..9a9049480077 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1152,6 +1152,7 @@ sub parse_email {
 	my ($formatted_email) = @_;
 
 	my $name = "";
+	my $quoted = "";
 	my $name_comment = "";
 	my $address = "";
 	my $comment = "";
@@ -1183,14 +1184,25 @@ sub parse_email {
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
+	}
+	$name =~ s/^[ \"]|[ \"]$//g;
+	$name = trim("$quoted $name");
+
+	# Extract comments from address
+	# <john(his mail)@doe.com>
+	while ($address =~ s/\s*($balanced_parens)\s*//) {
+		$comment .= trim($1);
 	}
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
+	$comment = trim($comment);
 
 	if ($name =~ /[^\w \-]/i) { ##has "must quote" chars
 		$name =~ s/(?<!\\)"/\\"/g; ##escape quotes
@@ -1205,17 +1217,25 @@ sub format_email {
 
 	my $formatted_email;
 
-	$name_comment = trim($name_comment);
-	$comment = trim($comment);
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
 	$address = trim($address);
+	$address =~ s/(?:\.|\,)*$//; ##trailing commas or dots
 
 	if ($name =~ /[^\w \-]/i) { ##has "must quote" chars
 		$name =~ s/(?<!\\)"/\\"/g; ##escape quotes
 		$name = "\"$name\"";
 	}
 
+	$name_comment = trim($name_comment);
+	$name_comment =~ s/(.+)/ $1/;
+
+	# Sanitize comment
+	$comment = trim($comment);
+	if ($comment ne "" && $comment !~ s/^\s*((?:\#|\(|\/|\[).*)/ $1/) {
+		$comment = "";
+	}
+
 	if ("$name" eq "") {
 		$formatted_email = "$address";
 	} else {
@@ -1233,15 +1253,11 @@ sub reformat_email {
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
@@ -2704,7 +2720,7 @@ sub process {
 			$signoff++;
 			$in_commit_log = 0;
 			if ($author ne ''  && $authorsignoff != 1) {
-				if (same_email_addresses($1, $author, 1)) {
+				if (same_email_addresses($1, $author)) {
 					$authorsignoff = 1;
 				} else {
 					my $ctx = $1;
@@ -2800,7 +2816,7 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if (!same_email_addresses($email, $suggested_email, 0)) {
+				if (!same_email_addresses($email, $suggested_email)) {
 					WARN("BAD_SIGN_OFF",
 					     "email address '$email' might be better as '$suggested_email'\n" . $herecurr);
 				}
-- 
2.27.0

