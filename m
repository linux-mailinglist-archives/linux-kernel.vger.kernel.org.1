Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD62851E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgJFSvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:51:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0223C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 11:51:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y20so1656537pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjPkM53PpC7kPlO6DeFftljyccx+GJzIyJhLBwe7Yo8=;
        b=JT+We4U5LY9eWnluzXC6g9nu4Rp/DmPuFgXojmo1OvR7RP8lxSIsjH5l7Phu3CKDiJ
         wBu4WEnAm75p5Fh3SV0P3MtifQ7yuTppTK7Vx9qZOYlSnLsHgmomXiF8fh61p0XUH+k9
         X0yMuIqYJHhQzdvRgJ8fQqWRAk9FMyISaJuC5oERXdk2rEXsd6OufrJHXd45K/Db2jMY
         P6+1W8t0W5tGqfaFo97CFhxsg4CevJp5sQARL6BQrv4UQ0HnBkovdDgEyRXml2WZqXlc
         HQbBhhpLUBxalwWOPRwgB1MExoVnrMv7whxkdouzcU354lqJVR+P/Z0Ok0sCHNTvpZ30
         IQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjPkM53PpC7kPlO6DeFftljyccx+GJzIyJhLBwe7Yo8=;
        b=qcXltgJ/Q8ip1fkdgtU3GRnXA69PW1f8gA8eHuIU3y9H6F1tPEl2fkF1WbSKNcqL0h
         lBhdzgQoVTrlwQsLpP3ERqECqDdQNuunaMsxGn6FsAKDlSTd2vKopSmYAGidhSwzAG3q
         8FDhDhSi5+KK0dArBptXmKdpgi6jdmIpxjpOjs7xqsqCraim8zjAjBin8AhpkKogCbea
         PkuFMbR3ypFGyDDzPjGFBkLG0nKVL7es7earQKH7WIbrViGy4XVgf/nxQFMYXW4MnYKk
         e/tZx88EzqZR66yQSw49ScWLEHp+YG7IQ5LU7i8jXC9QC8dGmccTaJYXXVPNumHqQIOl
         gfbQ==
X-Gm-Message-State: AOAM531E/a1xLVbeLgs//I8RCan/wX7pFTSLI1syt6bsws6Q1v2c6k+9
        SwHSEPaPwnXisySCk6oxnjBTiT15PE+hxZMIrIQ=
X-Google-Smtp-Source: ABdhPJy7JSjbC092lZGYGNyGH5P7NzyjRy11jri/wnELKsm0/P8GtK/L2NXHmzXtKTl/wJ7COJwEuw==
X-Received: by 2002:a17:902:424:b029:d2:8cdd:dc00 with SMTP id 33-20020a1709020424b02900d28cdddc00mr4581819ple.7.1602010297856;
        Tue, 06 Oct 2020 11:51:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:60b7:b4c7:8a32:f7cb:8bc0])
        by smtp.gmail.com with ESMTPSA id a1sm3409041pjh.2.2020.10.06.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:51:37 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add new warnings to author signoff checks.
Date:   Wed,  7 Oct 2020 00:21:14 +0530
Message-Id: <20201006185114.168358-1-dwaipayanray1@gmail.com>
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

For case 0, an error is generated and for the
other cases 2, 3 and 4, warnings are generated.

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
+				ERROR("NO_AUTHOR_SIGN_OFF",
+				      "Missing Signed-off-by: line by nominal patch author '$author'\n");
+			} elsif ($authorsignoff == 2) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email name mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 3) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email address mismatch: $sob_msg\n");
+			} elsif ($authorsignoff == 4) {
+				WARN("NO_AUTHOR_SIGN_OFF",
+				     "From:/Signed-off-by: email extension mismatch: $sob_msg\n");
+			}
 		}
 	}
 
-- 
2.27.0

