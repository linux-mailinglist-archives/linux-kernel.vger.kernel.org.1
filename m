Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EE2CBA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgLBKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgLBKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:15:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D04AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:15:18 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f14so314942pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWjb6zrEMy2J76Z4aT/3tobNbUFtkhliXqvzagYlv+E=;
        b=gxRccWuGGU41q3Km4iGrDQa3cvPUG5oPMlBZaKbiEeL6JhT9eqx8Ug47sHEh5QK77y
         XYn248vJZKhh/cxygPf5uxHUsYhvXDypHKjiwGeVyonRbHOlUgR10hnpT+UH9KBLbZGd
         PcX9vYxynhY0WDh3BANRcIm0br5+sTenJX2/DwSKWDD00Oi1fnaBJ7ZmBN+mQcDOzbw8
         b7d43HxvK4rPax8sLgHphgRA14Msw2uf7kGa6CkMm136YgqhjsjuXXyvvnsBmGs0VwjO
         UIFydasllGD0xAi70Hv13Y4nwuCSPxJrykNomFZJfAp99aJU0UfL9ND53oYasHO0ARp7
         OsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWjb6zrEMy2J76Z4aT/3tobNbUFtkhliXqvzagYlv+E=;
        b=Wq/NBc+limu7PXELXhqG9xIUpOxe04sjZSZ14I9sLV0/8UG6fLed/CzUENfrm23MTM
         TfQ05gEVbbJC4ZdTUotGFl276vWI9Wcd+qpJCGmGB7CN+ORXFNNyNFfxBwVnGtI55vgd
         as3+fSJVgJWzI0BRC+maCtrcQmdmI/u8uifyveq6OVLcEynGra1da/HpJPkdr7lDBKLo
         l7icNUkrFIhUNfV1N+pkmkZNdwVDoEgu8AqL0W0jSDJaK0CvsRL0KS7F9cGS4rDjUAKm
         O6DT+puVRH8kmg4UaE+WTDnykjgsjGZhlRb9NEuUPAx4rRXasbpLel25m5ypCjtlPWkt
         EmBg==
X-Gm-Message-State: AOAM532p1xH3eaLeG7sHOS33MglMSnrYRgb2h5zyTLKvDkPo1g5L9dTQ
        DkmCbKFpak9odW/c+GY88zx9yI28/Jo9qYDC
X-Google-Smtp-Source: ABdhPJyo+01CcdRYzhUvf15PRmTg1LbB5GaQeqEeQlewZHlpQ1Lj4hwkKG+6BwWDHvlhhA2raO8kxA==
X-Received: by 2002:a17:902:9b87:b029:d8:d123:2283 with SMTP id y7-20020a1709029b87b02900d8d1232283mr2064184plp.60.1606904117364;
        Wed, 02 Dec 2020 02:15:17 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6a1b:d60e:9bc5:1ecd:a6f8])
        by smtp.gmail.com with ESMTPSA id o11sm953936pjs.36.2020.12.02.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:15:16 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] checkpatch: add warning for lines starting with a '#' in commit log
Date:   Wed,  2 Dec 2020 15:44:48 +0530
Message-Id: <20201202101448.8494-1-dwaipayanray1@gmail.com>
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
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e8c1ed0b1fad..a12edcf4f63a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2966,6 +2966,15 @@ sub process {
 			$commit_log_possible_stack_dump = 0;
 		}
 
+# Check for lines starting with a #
+		if ($in_commit_log && $line =~ /^#/) {
+			if (WARN("POSSIBLE_IGNORED_LINE",
+				 "Commit log lines starting with a '#' might be dropped by git.\n" . $herecurr)
+			    && $fix) {
+				$fixed[$fixlinenr] =~ s/^#/\t#/;
+			}
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
-- 
2.27.0

