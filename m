Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999952DE748
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgLRQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgLRQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:10:59 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCBC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so1619172plt.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BFwltcKlarcNHsBQ5fgE4su5DLlDyOnN0mFp9s/OfE=;
        b=kEE7/p0/QAn00j6CWJWn2gHbuV1R4kpLbppkOh+h8mj5aENaIREaKFcIUTcvnAIjZ8
         hCpm/7u5VI76cwqCf8kbZjM4gk0knb+aGqYCcTyvPTJM6yIjhWWWjdVkKjwEXMNwJBz8
         0IgTdGd1opASadJxYsmhl6dDTgZwvZkNpJpdY0m2Z3g9V7wx0NuAk9wNuIVOV+/tfoKK
         XhUnqaOuB5JRBSf3/WN2WaJc3OUCwASCiz2CqsMaR3MPa3PajN3XjdkWGkyJ4AQ0fXjd
         +NBfAGjJUz/0Nagq/bNjz69AFfoc5QcgFuO+00pVDOsWB5BRpP9AhejsehqB2KJ1NS+p
         JGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BFwltcKlarcNHsBQ5fgE4su5DLlDyOnN0mFp9s/OfE=;
        b=U38SsiRVhSSaqdCtDr3pzlgOOyF0+lbg+y9plxe+0Vx/NruwxdXu7CHACgLyAk9gSt
         Io7cBISKpEEP1IfQUPMvNnMcSeSQKmKv+rU9q5JJsaXc74C8FdERcFqR5/LQ2BxnDv7w
         2dTpucxRocFbOEyJUKezGPvsPhze5dGLPlr0QafOESW2Ip1AeiOKZvn0jFZ70CW84qdx
         w+jpUrrkqB15RcP5fHcR/Y4bKmfTKiZAyyyEeCbDHuZeISiS6RmGnHSUrgMTOUv8cnkC
         eoTdxvrCBGjHTmpoC7QW4Y1iMEFmr+yROlynxXy3JPleWKbKdRDdh0vTgn+/6IZhCIkK
         oA/w==
X-Gm-Message-State: AOAM531GyeFNinZKHbxth1Qf+VZHdq+CFG2TWjUrNp1YSqIVu8O8UOs6
        +wTXmA5bJAtnx3wk00cUkrC8qGfSq4o=
X-Google-Smtp-Source: ABdhPJwOITWCV3FkazPgJP3WCfffLdQ6hkDhPq+ZMDRbLdX9T/5/EQ71V9f2rmX4D5TAaKQQTn4mqg==
X-Received: by 2002:a17:902:ac90:b029:da:fd0c:53ba with SMTP id h16-20020a170902ac90b02900dafd0c53bamr4882275plr.23.1608307816773;
        Fri, 18 Dec 2020 08:10:16 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id m26sm9622047pfo.123.2020.12.18.08.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:10:16 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 08/10] workqueue: reorganize workqueue_online_cpu()
Date:   Sat, 19 Dec 2020 01:09:17 +0800
Message-Id: <20201218170919.2950-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Just move around the code, no functionality changed.

It prepares for later patch protecting wq_online_cpumask
in wq_pool_attach_mutex.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c2b66679c0aa..dc891b5c0868 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5087,12 +5087,17 @@ int workqueue_online_cpu(unsigned int cpu)
 	mutex_lock(&wq_pool_mutex);
 	cpumask_set_cpu(cpu, wq_online_cpumask);
 
+	for_each_cpu_worker_pool(pool, cpu) {
+		mutex_lock(&wq_pool_attach_mutex);
+		rebind_workers(pool);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
+
+	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
 		mutex_lock(&wq_pool_attach_mutex);
 
-		if (pool->cpu == cpu)
-			rebind_workers(pool);
-		else if (pool->cpu < 0)
+		if (pool->cpu < 0)
 			update_unbound_workers_cpumask(pool, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
-- 
2.19.1.6.gb485710b

