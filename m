Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6352E2CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgLZBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:51:50 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC7C061786
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:10 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 15so3794494pgx.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4DO+xpC526tiXRBJpHLPvN9tw825DTR5gYRqb5rXSM=;
        b=qSe4aHOVyrIAU+g+stEkKARAS5YB+QqWGp4Ti1XmNixqfGPl2cffCFaJdKFroxy1VT
         sspf7KxYLh9Uz4d82g+NbbPscDAf+3RiYa5UDDP6XOyUIXc/HpB9zDOqBJpvtXc+BT22
         tjroCtv71JZAwoug1hqzdT6GFhGQElkOMPGgZ7rOrwwDarcrF7to0TCh5eAOTd6xJoKS
         5JYQeAa4Q9EAFeo9P8MDdWjFNdoPfHqBSAM02wwY4Ps+YryF85/prsgk2Znqb/Bp/dCE
         WbGE6vDIn+ohVvOVfM/7x/UyoxKSKyukdOa3CVZQ3czU5Xwr1hy/3YPjmCCXTffQHl5K
         q2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4DO+xpC526tiXRBJpHLPvN9tw825DTR5gYRqb5rXSM=;
        b=VpnzhYfn3uZkk1/i1GOqmwtQuJxwyFaGjXakHR6tjp8WvT3R3mfMu8InMpX0Kxo4XG
         6xWBMxAoh37wrwqJk7HJqc24UJP9vTLKuriUUEdjs1OVSzmjp2vjkeZxgk1EYpo3OX7Q
         8QMpTV8GoIRoND+adWYr6Ak46a8bs5jL2AoPVL43s2PEQys2CDZC+aHNkhkndx4+SHSC
         13a6MT8tvYFDezgA4sP0UhQnljcamfENZVOyENf1/o+Ltidw3cQyC/4ItNZh0UpFnUEa
         O3ouW+3eNqQOcQwYyz2CCDHAA4ukQ8mddmZ4M0f8NybVYYGcD8iWxl1urMEozSXW8CUg
         tSLA==
X-Gm-Message-State: AOAM533MK/HS3UcmwKlJxqA9I13lmtdWsVJyLU3ptJBwsUpXyVBZ+S/b
        7m2HsDRBG8Om2jxDL8If1k4mYMoF45w=
X-Google-Smtp-Source: ABdhPJz0GKlBockJxOZMk0qowqOZufJdON17hAr6LaKqTsZHut0A0N80Pd5SCY8hPWGPJK4ptTT9Cg==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr34007510pgb.332.1608947469604;
        Fri, 25 Dec 2020 17:51:09 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id z3sm10891220pgs.61.2020.12.25.17.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V3 4/8] workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
Date:   Sat, 26 Dec 2020 10:51:12 +0800
Message-Id: <20201226025117.2770-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

restore_unbound_workers_cpumask() is called when CPU_ONLINE, where
wq_online_cpumask equals to cpu_online_mask. So no fucntionality
changed.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6f75f7ebeb17..0a95ae14d46f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5033,13 +5033,14 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	static cpumask_t cpumask;
 	struct worker *worker;
 
+	lockdep_assert_held(&wq_pool_mutex);
 	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* is @cpu allowed for @pool? */
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
 		return;
 
-	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
+	cpumask_and(&cpumask, pool->attrs->cpumask, wq_online_cpumask);
 
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
-- 
2.19.1.6.gb485710b

