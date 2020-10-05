Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68820283071
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgJEGtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgJEGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:49:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE019C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 23:49:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so6156212pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2YMJKUBQWqe4WrdZzvyob/7srqhjh6V2uGdYps13OMc=;
        b=bR5GZlm4spcHgHFQPhgbb0PKQkZ5ASSTLKS2SBi2sqm6fFuVWmBOk5K6rIyULXNxb2
         JjmYP8bALPvX1zyXDs9oZF+5uyjg8agP+twwGIDCaP8VDdEeocApU62C9nMa3Wm9R3tf
         qA+Dq0MI5MZSGgYshe8rwpnuGkwGtxI+bo9RSu/zqN37rIHUUaW4BLeLjhVHbw60UzfN
         alujfyFt6C0I9t6Rg44HTICNf0tGrQwBWOVJdKeLAHcx12nnGUp4+fgpxQZZ2p1k2L+7
         /g3ZRn/WCzsRFXZlETXMHN1iAqRL2cJ3klNPiKrPyDcEvXG0lilnUsuIsnZIkw4v3756
         Q9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2YMJKUBQWqe4WrdZzvyob/7srqhjh6V2uGdYps13OMc=;
        b=pTRQHgNaZUx/jcDVhqKrT3bW9v3l/M2W+NNk20uQ61ThAOnmzIpPiwGy7uhgGrqZbx
         CRYYxk8w7gu4FrCrRij4pWwuv5diSC6iwPNYys6oh8ue7/0bbSUxPxM/kM601hWzgfpq
         +2ZeYimEfAt6gXCCKbTpHq5J2Zm9Dx5O6/lE5FjnFl6hzxvDPiL1DJkjFngBHZ4TwIfA
         BJCvRI7Twzv4QQXSTd+6/86oX3NNEyu1NeF/sc7BFH2mTzoq6lg+rTi11xmGAYOQnddu
         SvLVK6JBm0SXNbvyfbPipN/iec9P/+k+xlPlAefw7OuMVL8w3yd7nnjucxFfxbQnQVE5
         57nw==
X-Gm-Message-State: AOAM5322jOux2po3KztL0UDYck+w/LTyZqJk1hMg0jI08KTIrvpe0CUG
        d6JDHSEhxR1lUu/LB2YVAw7Z5R3lWMLj+Svs
X-Google-Smtp-Source: ABdhPJyFQ4Ao+3lxLWtfEGldHrrbYHfOBU2VSqBcc1zBT2DMiHP3+4rt2h8BfyJAFXuENzEFgtN8bg==
X-Received: by 2002:aa7:9492:0:b029:152:545f:90d with SMTP id z18-20020aa794920000b0290152545f090dmr8886157pfk.9.1601880556125;
        Sun, 04 Oct 2020 23:49:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6930:697a:aab2:e913:9e57])
        by smtp.gmail.com with ESMTPSA id 8sm7865411pfn.54.2020.10.04.23.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 23:49:15 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] checkpatch: add new warnings to author signoff checks.
Date:   Mon,  5 Oct 2020 12:18:42 +0530
Message-Id: <20201005064842.33495-1-dwaipayanray1@gmail.com>
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

Introduced three new types of warnings:

1) Address matches, but names are different.
   "James Watson <james@gmail.com>", "James <james@gmail.com>"

2) Name matches, but addresses are different.
   "James Watson <james@watson.com>", "James Watson <james@gmail.com>"

3) Name matches, but addresses without mail extensions are same.
   "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"

For the 3rd class, a --strict check message is generated, and for the
other two, warnings are generated.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 57 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 31624bbb342e..80feb15f93cb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2347,6 +2347,7 @@ sub process {
 	my $signoff = 0;
 	my $author = '';
 	my $authorsignoff = 0;
+	my $authorsignoff_ctx = '';
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
+					if($email_address eq $author_address) {
+						$authorsignoff_ctx = $ctx;
+						$authorsignoff = 2;
+					} elsif ($email_name eq $author_name) {
+						$authorsignoff_ctx = $ctx;
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
+						if($address1 eq $address2) {
+							$authorsignoff = 4;
+						}
+					}
 				}
 			}
 		}
@@ -6891,9 +6917,32 @@ sub process {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
 			      "Missing Signed-off-by: line(s)\n");
-		} elsif (!$authorsignoff) {
-			WARN("NO_AUTHOR_SIGN_OFF",
-			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
+		} elsif ($authorsignoff != 1) {
+			# authorsignoff values:
+			# 0 -> missing sign off
+			# 1 -> sign off present
+			# 2 -> address matches, name different
+			# 3 -> name matches, address different
+			# 4 -> name matches, address matches without extension
+
+			my $ctx_msg = "'Signed-off-by: $authorsignoff_ctx' should be:\n'Signed-off-by: $author'";
+
+			if($authorsignoff == 0) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+					"Missing Signed-off-by: line by nominal patch author '$author'\n");
+			}
+			elsif($authorsignoff == 2) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+					"Author name mismatch:\n$ctx_msg\n");
+			}
+			elsif($authorsignoff == 3) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+					"Author address mismatch:\n$ctx_msg\n");
+			}
+			elsif($authorsignoff == 4) {
+				CHK("NO_AUTHOR_SIGN_OFF",
+					"Author mail extension mismatch:\n$ctx_msg\n");
+			}
 		}
 	}
 
-- 
2.27.0

