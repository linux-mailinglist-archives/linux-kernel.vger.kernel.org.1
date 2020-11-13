Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B782B1B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKMMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:31:32 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBDCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:31:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so6996103pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6mQ9czDeNuZjqSI00ivo4f1F821Tujfsv0cKG8Lv8k=;
        b=PP5OGMCAcdjMBBeG0kkfSQv+y1gwugp1XUD7N8xJpgyjfq/wA5Y6uOIGkYIdwd63nR
         UlAnBrON3PZuoXC4OqrqdyCKQc2y2oUy4kPjygWG5gJgqEhKFIRRxubEO5DmCr2x7BnD
         XxJigFYrEHaW/YqQ/eD/RdgZhu09eDTTS3qaXZTs4m2Gx2RO7xu6vQrbkXRwEiEJta11
         4ZgO5XOWE9hMqlYd9J/aXGeNXilPfw93QQ8C0JDLyonu0wk1YB/x8hIR7XkSCD6SX0RW
         cyqmUFuXfC3JdhF4KQP86zkk4L0g9nsYRG1gpdhwx2+EHBXTEUnApUJjnicNB8V69Qr/
         jTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6mQ9czDeNuZjqSI00ivo4f1F821Tujfsv0cKG8Lv8k=;
        b=nb5+dq+evMCq5tVA8XwmZUuD5LL4udxpfbg435jiTDlkCukoR5GnNR9hftTTDcXXBM
         9Vwi7I3HGsUyP9tOzI8texr2aO+hA/8OeGRyIqTxfNbljubkv6Lv+7IP0/DUoLv9YE/x
         Gri8XvunsdHZGWlt6F4wnhFIblvz1Xk4GT/ASkalh2FeaqpM9QqyCiS/T6TauKjpCXD5
         DLbM0ZpSPbxBUCb++8YVklRrMYpH9EBH7ByDrSm/Kg1KoDqPay21dK/7j/tmrYwh7nel
         G5vFb4d/3wvlpDBlCMl+Gl4mRy6EI/XM6t3KwZu0Es4PAgio3X/2Smd0lb4gIyAiYJK6
         ORYw==
X-Gm-Message-State: AOAM531AO4iiB6m6ZQsGPVLCUJ1jWbSOXawOrZD+nTC4scaitBTZ46Nk
        TEcNtqSnKeUAAbVDceoYeUq9bCPSmimJ9pjo
X-Google-Smtp-Source: ABdhPJzHTscFdDbU+jgocb+g0TaFD9aR+gb4VoHte6gYYbnVNHFmu2e09HpnyWbiLFe5t1hXHlzqhQ==
X-Received: by 2002:aa7:8c4f:0:b029:18b:f361:4aa3 with SMTP id e15-20020aa78c4f0000b029018bf3614aa3mr1905564pfd.73.1605270691778;
        Fri, 13 Nov 2020 04:31:31 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6819:f451:9e0a:873f:ed68])
        by smtp.gmail.com with ESMTPSA id l17sm10627610pjy.29.2020.11.13.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:31:30 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH RFC] checkpatch: add new cases to commit handling
Date:   Fri, 13 Nov 2020 18:01:01 +0530
Message-Id: <20201113123101.29057-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit extraction in checkpatch fails in some cases.
One of the most common false positives is a split line
between "commit" and the git SHA of the commit.

Improve commit handling to reduce false positives.

Improvements:
- handle split line between commit and git SHA of commit.
- fix handling of split commit description.

A quick evaluation of 50k commits from v5.4 showed that
the GIT_COMMIT_ID errors dropped from 1032 to 897. Most
of these were split lines between commit and its hash.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 024514946bed..f5ba2beac008 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2990,6 +2990,16 @@ sub process {
 			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
+			} elsif ($line =~ /^\s*[0-9a-f]{5,}\s+\("([^"]+)"\)/i &&
+				 defined $rawlines[$linenr-2] &&
+				 $rawlines[$linenr-2] =~ /\bcommit\s*$/i) {
+				$line =~ /^\s*[0-9a-f]{5,}\s+\("([^"]+)"\)/i;
+				$orig_desc = $1;
+				$hasparens = 1;
+				$space = 0;
+				$short = 0 if ($line =~ /\b[0-9a-f]{12,40}/i);
+				$long = 1 if ($line =~ /\b[0-9a-f]{41,}/i);
+				$case = 0 if ($line =~ /\b[0-9a-f]{5,40}[^A-F]/ && $rawlines[$linenr-2] =~ /\b[Cc]ommit\s*$/);
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
@@ -3001,7 +3011,9 @@ sub process {
 				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
-				$orig_desc .= " " . $1;
+				my $split_desc = $1;
+				$split_desc = " $split_desc" if ($line =~ /[\w\,\.]$/);
+				$orig_desc .= $split_desc;
 				$hasparens = 1;
 			}
 
-- 
2.27.0

