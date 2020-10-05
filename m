Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81B1283F94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgJETZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgJETZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:25:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA73C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:25:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so6640772pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUHzU994asFuDsR5vXXKO1RIre9z7+ihbRduDUcsWCM=;
        b=KTIo1bsJOi4gTjQ0hVp2YcFgyY8jzGe/b83zbBRsaEntaSmg1/eJnQ5DoIvKStRReR
         +/YSrAB2EqcLh0szDtcJfiI7rYu4IsL/7GC8AApQmKvbi+P3PgQVNUncvXcLbDy9C9z1
         fSjqmwllcL0+CuRpO0Iq31tyERLZgtT5uIohDneXALXagC/g66ZSaAOpep6qcd/rb/77
         K4b2Zcg3IV1IQ/VaGKukPA7vpjZU2S1xO0HKdLUPxfC7CnFybgzEDlfc6ysQL7WxcQcL
         nDGhDfCNA1Box0NKpb6nfUiCbwf53dAPpp2X6hdwDXtdKNgpqdGNWXvoIk7U5XQ63AZP
         aBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DUHzU994asFuDsR5vXXKO1RIre9z7+ihbRduDUcsWCM=;
        b=hi09j7NE7Gj3koS/fNnXJgOPb5945oUmRIaQ/W+6iyy6Unh/fnErCdao/rrKmw8sE5
         q6GMCRuNxi8ZjtpP6wnUqhy1y8m4+bGD8FwXZH2vxSRkFRw8wfON6BlmqpEgEDaNKIcV
         FZsv8irnSYBB8VJZFmc2Y4wQPXbs9O9bUoVbbLPtACDMJ+Cwl28RTVIQ60nURWsof8VO
         4UvDlgoIDiwNL50lryWZTty9ithOzrl8JlcCmWyYY7wkvMzyd/RLA/w1iTRpZsoLL6Qq
         K3rCq+h+NK1Q0RLuL7Hlon3gQcdrykeYcJNGrzI9n3pBTFx58R9xTHzCk9f1MJVV/cYk
         GJOw==
X-Gm-Message-State: AOAM5323wcTFddLc73VcfI3WOTM6Bf8RGqVbJi73FcgiHQlkfHstbdr/
        IUOH1JZBcL6IXaDVjOVoEfYr+k9LPsmlIb+/
X-Google-Smtp-Source: ABdhPJyHerIA1lW+acDgHBcvERRxWfkATPzD7fxYwZ2tKkdq+R0yY08S/elZlepol7zltjSNx94BEA==
X-Received: by 2002:a63:1061:: with SMTP id 33mr1069168pgq.204.1601925907522;
        Mon, 05 Oct 2020 12:25:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6930:697a:aab2:e913:9e57])
        by smtp.gmail.com with ESMTPSA id 138sm717388pfu.180.2020.10.05.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 12:25:06 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: add new warnings to author signoff checks.
Date:   Tue,  6 Oct 2020 00:54:09 +0530
Message-Id: <20201005192409.192317-1-dwaipayanray1@gmail.com>
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
Extended the checks to handle three new cases.

$authorsignoff values now denote the following:

0: Missing sign off by patch author.

1: Sign off present and identical.

2: Addresses match, but names are different.
   "James Watson <james@gmail.com>", "James <james@gmail.com>"

3: Names match, but addresses are different.
   "James Watson <james@watson.com>", "James Watson <james@gmail.com>"

4: Names match, addresses excluding subaddress details (RFC 5233) match.
   "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"

For case 4, a --strict check message is generated, and for the
other cases 0, 2 and 3, warnings are generated.

Link: https://lore.kernel.org/lkml/7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 54 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31624bbb342e..e81f0bebbeb9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2347,6 +2347,7 @@ sub process {
 	my $signoff = 0;
 	my $author = '';
 	my $authorsignoff = 0;
+	my $author_sob = '';
 	my $is_patch = 0;
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
@@ -2674,9 +2675,34 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
-			if ($author ne '') {
+			if ($author ne ''  && $authorsignoff != 1) {
 				if (same_email_addresses($1, $author)) {
 					$authorsignoff = 1;
+				} else {
+					my $ctx = $1;
+					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
+					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
+
+					if ($email_address eq $author_address) {
+						$author_sob = $ctx;
+						$authorsignoff = 2;
+					} elsif ($email_name eq $author_name) {
+						$author_sob = $ctx;
+						$authorsignoff = 3;
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
+							$authorsignoff = 4;
+						}
+					}
 				}
 			}
 		}
@@ -6891,9 +6917,29 @@ sub process {
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
+			# 2 -> addresses match, names different
+			# 3 -> names match, addresses different
+			# 4 -> names match, addresses excluding subaddress details (refer RFC 5233) match
+
+			my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
+
+			if ($authorsignoff == 0) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "Missing Signed-off-by: line by nominal patch author '$author'\n");
+			} elsif ($authorsignoff == 2) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email name mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 3) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email address mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 4) {
+				CHK("NO_AUTHOR_SIGN_OFF",
+				    "From:/Signed-off-by: email extension mismatch: $sob_msg\n");
+			}
 		}
 	}
 
-- 
2.27.0

