Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB736283DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgJERkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJERkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:40:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A29C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 10:40:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so6461517pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0x+JZOoXwFLYRCqH3tH4GfIK1OTrgLVrqW6+u8GPgMo=;
        b=irSjnc1l6aN2/LNmSd1JVQw+Pso5loUUuwnYOT5ko3rX9CEg8BLfNqk/3iECwR1a0f
         iVurChZAt30/5UULBHgtbIqhzDCsoR3WiL/CB27KkcsIjVJV2QxFwBwESCwEXRxF+igU
         hbjkAazeIxAoEb2viMZFtPdA2UfQtt0z92GiYPOb6DyXU85MB0ZBWcY0xjyiGvsOgmtL
         iTlDaxiQn0mY/vTiS5q5X/bIVODeb9yqV8BBu4sfFtZLIJoDp/VsD0mQP9+SmDDR8npd
         mqQ4L1+e4G62EfOkyxEozW6Tv/c8PQ6spG1j8M2u32ZS2E08sjTYRa4KDPanfYDPEt52
         6aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0x+JZOoXwFLYRCqH3tH4GfIK1OTrgLVrqW6+u8GPgMo=;
        b=W4SHUxULjitpl6y864rg4wNR96LerWQXpseZqbT43SLgvnXGrROJeYlS8JSAb4WqQ/
         ZDNDr4+OcEwIQXBGyGRnYeyIy4hlDm9rtRXd//3THeFer12gAGWegNILidmXc4ZSdhA0
         ZRnzz/QmkiFUuqqiTSbQ1taXV0Bx8aoPr07L9FeHky+7/AUsIADVNYyJEo6X9dL8+LXC
         XOqePASLp4vFfWZ6dn6NL3M1oB6xWY+Ujb3WAqbqTDgil4Eyl49NuEDRJnNRyHmhmbDL
         AWa8Csq296kCaotBQQpqIaLusXLqmKWByjLIxq1LykVGIKSk+lwk+yFKQT+fVZRMwMAW
         MCLg==
X-Gm-Message-State: AOAM53152gBUlWLrecBvfTdyXHuQD0wiROew3Kvmrq7qDX4AC7cywuMx
        tbZJOBJZnG25Nd284RAVzJg=
X-Google-Smtp-Source: ABdhPJzkqmmJhqBPqom6ZC7Q1Qspohey6g6VVt+GSew2RCk4ZccNWRfsSGVUMkOkAcaWeuHv78NLbA==
X-Received: by 2002:a62:3815:0:b029:152:80d4:2a6f with SMTP id f21-20020a6238150000b029015280d42a6fmr619899pfa.72.1601919623413;
        Mon, 05 Oct 2020 10:40:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6930:697a:aab2:e913:9e57])
        by smtp.gmail.com with ESMTPSA id l21sm163689pjq.54.2020.10.05.10.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:40:22 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: add new warnings to author signoff checks.
Date:   Mon,  5 Oct 2020 23:09:33 +0530
Message-Id: <20201005173933.171074-1-dwaipayanray1@gmail.com>
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

4: Names match, but addresses excluding mail extensions are same.
   "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"

For case 4, a --strict check message is generated, and for the
other cases 0, 2 and 3, warnings are generated.

Link: https://lore.kernel.org/lkml/7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com/
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 54 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31624bbb342e..62c83e9715ab 100755
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
+							$address1 = $1.$2;
+						}
+						if ($address2 =~ /(\S+)\+\S+(\@.*)/) {
+							$address2 = $1.$2;
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
+			# 4 -> names match, addresses excuding mail extensions (subaddresses) match
+
+			my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
+
+			if ($authorsignoff == 0) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "Missing Signed-off-by: line by nominal patch author '$author'\n");
+			} elsif ($authorsignoff == 2) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email name mismatch:\n$sob_msg\n");
+			} elsif ($authorsignoff == 3) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email address mismatch:\n$sob_msg\n");
+			} elsif ($authorsignoff == 4) {
+				CHK("NO_AUTHOR_SIGN_OFF",
+				    "From:/Signed-off-by: email extension mismatch:\n$sob_msg\n");
+			}
 		}
 	}
 
-- 
2.27.0

