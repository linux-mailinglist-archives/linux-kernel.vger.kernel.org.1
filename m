Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15D2F9064
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 05:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbhAQEKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 23:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbhAQEJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 23:09:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EDC061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 20:09:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cq1so7328506pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 20:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jgc7hnq0+dKK5zooJWjXMrxh/06xCnrlZqYzeV/kZok=;
        b=Zf1F/G9MXF0/U1mn5GQ/nvvaS6x7JBraz3nggUS9ki7LyDcSfoW078L9rXSou1ew+O
         ZFaOW2TmP6e5rYhYKH5uVN3emhh4g3xlvTEKZ7rS5pW1U2IBtluDhKdPPPMmAnUQLr6J
         EumIyoBJC1A0O00axKLAZqO+Vwi6/h6SC+Vy/97TWtuAeHRAEsP2JurkRQ9fEpb9dcgZ
         7iea4pJRKpI7PNHB6hAJzFI4/pcE7gjdz1YTy48PlEP4Z8GXR0bZ9sH0JNOod9F6n43X
         pQ++TFc3pb+3DJNwxHGND3fEiLEXoriIXxdqHowVldwki1IcVNTPfdBNiccODVaqI+vm
         IoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jgc7hnq0+dKK5zooJWjXMrxh/06xCnrlZqYzeV/kZok=;
        b=fKAT4plnuABGFWZ2HCxAndwTRfJRBba1z/gsotyzwRaPs7gmMIjF3xJsalt0qYQ8e0
         U3fX3BpHjo5X+tIl9UWlFngEeJvP3q4FhshiA84CSjxk1ohON2CObrWkhov/aQ5EBQ42
         DdRyB/SUq0LraZBjYmUNolb+puH0Ne1CD/8csiKvXXXftt9ptUBhfQCEKozNEHRKJFQw
         x+cNAPHWtKG2P5dLPTXhY6jMCBsXVor24i/jURcX9xydmN5mdWESqdXschXBZ6e4NXE+
         6xjCXjI8jaGhoh7WIYaCeoc+1NdgaCRQzkisJfaop71XqDk2k1ZDCBM6Ki+bzygza6/F
         DDgA==
X-Gm-Message-State: AOAM532PMXE0rmiy4nt2865cPPfKovMyQES5C4FbCHP660o90K4432XS
        MCmC2FP59AFgx9cBUahrv23Bunm6Y0y4Qg==
X-Google-Smtp-Source: ABdhPJwQ9sZ+7D3Xmmj4FbGJ9ueG2Y+IYR6OKyNL9GvYohyivzfxtKPyM+J1FbPyWLR7kZo78sXpLQ==
X-Received: by 2002:a17:902:6b84:b029:dc:3423:a24a with SMTP id p4-20020a1709026b84b02900dc3423a24amr20265097plk.31.1610856556398;
        Sat, 16 Jan 2021 20:09:16 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.53])
        by smtp.gmail.com with ESMTPSA id j82sm387800pfd.19.2021.01.16.20.09.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jan 2021 20:09:15 -0800 (PST)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: Trivial fix for comment of check_preempt_tick
Date:   Sun, 17 Jan 2021 12:08:47 +0800
Message-Id: <20210117040847.12217-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

check_preempt_tick() is not just for newly woken task preemption,
and check_preempt_wakeup() is instead.

The current comment of check_preempt_tick() is a little confusing.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..c0374c1152e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4360,7 +4360,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 /*
- * Preempt the current task with a newly woken task if needed:
+ * Preempt the current task with the leftmost task if needed:
  */
 static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-- 
2.21.0

