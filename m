Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F42AD7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgKJNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgKJNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:41:16 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6FC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:41:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so11472962pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQfunjrgL76uBRcSvfp0hiZgyGWtLS38BjNvSb/rmHU=;
        b=ry+6q39E+MCi+DidJnllI7SR60cy7IqdcUnNTx4B83AnECr38TLP4o6ihmggX49gMe
         maXNXqC1VIBmZ+RvRUv6lzYqTKwkgCLRZxIDs1erKA/PtgP6f+XVRPWXGHlzr+3y7D68
         H4DJKcwXsaPpjbQO7miBlbYO/+atEnSQFYAcFtum6PpCZ5NKxdIiry31hudBM7zmaNGK
         s8U/FW0zO/uhACXBXIm3/dX/za4uQAv7dYFmkwCBj7n/jFpBSCW8+Kdv/KQ1gzGGMvGJ
         OUHoHcY5j2UouBfZN0Vf0EuvkfUpLKNP0VE9CIO3xzgTMYY46Nbt5CwMZuhtHA2Qj+jy
         9pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQfunjrgL76uBRcSvfp0hiZgyGWtLS38BjNvSb/rmHU=;
        b=NpL42rQquIceBTHATyj1Z9fsnAOuaUPGodDKYppShkHF3s7dwXJVbWNm6dt2sI3Vxn
         bXU466OhLNaeW+RhVWGN7Hri6+4ZeLrfPXOY0aqUWjjlaEz6Nw8EyjndrK7n0JMEKI4d
         jVp9TBbdNHitZrjrBFCkStNEIspk0FTf/9W1ZDnB6iJYdRPE2atG5sgEiOS4VOJX+ZE/
         a/P18krpiBMChUanwefvk8ihGKm+dn+MzQTJfX6sqSX0HdXfjlp/gtfxOdwSNordm4kA
         5H07qN6cjdpm0qkNgT+WjDeebioWrYlTe5cthECt5X9nzLQJUAE8pCBEVLKRBP4Bv/uu
         xn4A==
X-Gm-Message-State: AOAM5308MTkbQFf09g9t76PZzYDaMEyQOj2oYvNUrBcY9tkKgx0rVcTo
        e8DiVpTdaH6Ig0fQoKW0MVs=
X-Google-Smtp-Source: ABdhPJyxRcP8j3iFvakhIlyv1OnS7WMZhL0FbshXihydK5repm8sBncCYdE4NxNTXwSDDTUGPajyEg==
X-Received: by 2002:a17:90a:a08f:: with SMTP id r15mr3247342pjp.118.1605015674061;
        Tue, 10 Nov 2020 05:41:14 -0800 (PST)
Received: from XiaoXinPro-13.hytera.com (ec2-3-112-75-61.ap-northeast-1.compute.amazonaws.com. [3.112.75.61])
        by smtp.gmail.com with ESMTPSA id r2sm3169273pji.55.2020.11.10.05.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:41:13 -0800 (PST)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/fair: Remove the redundant critical section
Date:   Tue, 10 Nov 2020 21:41:01 +0800
Message-Id: <20201110134101.434928-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is nothing in the critical section, so remove it.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52cacfc62922..06c4f3430e95 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5114,9 +5114,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 
 	distribute_cfs_runtime(cfs_b);
-
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
-- 
2.25.1

