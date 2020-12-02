Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF52CC7AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgLBUXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbgLBUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:23:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CFC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:23:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s21so1950988pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7/0OydT0uaoKYqJ+NWnjPhTlLAtk0+KpXs9CvRvSLU=;
        b=jIPucXykd5bAsFogVVKpB1pET0yIvCcmDDjrr76g4Se3CUszOfn9CbPtJs0tySu7sw
         2GZ8HjdBttEvChQhF9hie5D4kx2USsos9waRFNr4IZpLikx9e7NazeT4M5H3DgQovFz2
         m3AqJnyq3IdTFRYSx5vjpueByrZSDCoAx08cIGvArLWJ5PRarNYbpbtbczqLbvsZ2TJ7
         bBKzSQt/w8240ECmB06r4j7l/oInGxWbno/WDIwrOz6iCPNNTZo9z/MJ6+y3zPJzIxEx
         O4/jj4CkTPsUQmSf7/v4UrZLBZbTf5HXrPrxQgpoErr3NL2YoWaQMzHVaBFqpZ8vVhFG
         tDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7/0OydT0uaoKYqJ+NWnjPhTlLAtk0+KpXs9CvRvSLU=;
        b=NLpysY+zHXd7NKS/xXsgSpaigDOdXx+NdbeEoY+CUgue45AQq04DQVjDFc+G8JrA8+
         Bq3UBWiOJH+VlrLqWe5QyVb6nAuGRUbXdJc3TQ4UxpqMeCF54/UjAvPYTmPCI29Q1AND
         v7fs3c+wDqY+9+uGGDe61535ug2pC0B9vybl8REbdAXmDZyqVzqqgo5FPnrqpcj1wE8e
         kmrZcqdKdVRdLvl1QzPiEjQ6OtV60Mf6q/Rs1d6SKCCMHTzkEtinAICSU0N5IMfeXdLU
         7B9v9cJJ89bXVg7t4MNBU9rFSoz3HsNkB2FaZjmr+OwP8rD+mPlLWWUADb7MLwN5IKj7
         XJvw==
X-Gm-Message-State: AOAM530ZtFcMCJLe6Vx7p+6NJuML5Ts4mF+zJWSxhcrjL27xqHzUAeYD
        rRGgK2r0DfXKX/xIktt7PLYoy+snxHRPW9ti
X-Google-Smtp-Source: ABdhPJxnM3PfBxHyTdB5T6wf7+ddR2b23jX5a1d21P3ZQFZ9p+p/OzrUhOHyDXHmS2FdmOP9NC5BMQ==
X-Received: by 2002:a05:6a00:2302:b029:198:4459:e6c9 with SMTP id h2-20020a056a002302b02901984459e6c9mr4453093pfh.33.1606940587058;
        Wed, 02 Dec 2020 12:23:07 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6a1b:d60e:9bc5:1ecd:a6f8])
        by smtp.gmail.com with ESMTPSA id i11sm398894pjl.53.2020.12.02.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:23:06 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v2] checkpatch: add warning for lines starting with a '#' in commit log
Date:   Thu,  3 Dec 2020 01:52:29 +0530
Message-Id: <20201202202229.120898-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit log lines starting with a '#' can be dropped by git if
the corresponding commit message is reworded by a maintainer.
This minor error can be easily avoided if checkpatch warns
for the same.

Add a new check which emits a warning on finding lines starting
with a '#'. Also add a quick fix by adding a tab in front of
such lines.

Suggested-by: Peilin Ye <yepeilin.cs@gmail.com>
Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v2:
- Modify warning message and type
- Style fixes

 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e8c1ed0b1fad..eb8b13cf3f40 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2966,6 +2966,15 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for lines starting with a #
+		if ($in_commit_log && $line =~ /^#/) {
+			if (WARN("COMMIT_COMMENT_SYMBOL",
+				 "Commit log lines starting with a '#' will be dropped by git as a comment\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/^#/\t#/;
+			}
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
-- 
2.27.0

