Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080942E2CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgLZBwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgLZBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:52:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67AC061795
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id lb18so2941662pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysY1OuF2jagcXiFgCVCRcVlNUjswHBzR6HlIWvQ5HlQ=;
        b=eAJCbeDguTA+h35AgEYOJdk3VPpIHAKXdMBycs2wmHp1vsB+dRigD2RRHWSYbVmErq
         ClY0t7o8AvGnduetWrtOZJX78zw38AP7uln0ogaStu9f49MzfyKi109epR7VCC0EiUiO
         x+kiu0XYRwqwd4Yzcx0KGnbSXWdrpTpgn4Fc2SDBUwyGA/NsOIJ2SG/DsVvG/KWZ9bGc
         BvNnueDutZkeH5Opmg+rEgFoC1lWAl0ACrZIvrkiFA1rpmoAEXBwyrDUIL7sCukfeg9o
         +Xf8qqTe+D8x/kyZBnUt7IyIxT9GRHYCoE6+1PRzbJEgbLgO2YZEAl5Vm07P+g76FtiW
         u62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysY1OuF2jagcXiFgCVCRcVlNUjswHBzR6HlIWvQ5HlQ=;
        b=nD8AOSZnY+0WgJTR9AHUBWrEphd8izbErbUjOk/NwLLmUUwz8O/8udTaAIUS8ssj9e
         I56eE6g/GGAp1Nfp5jhAVjaeCywoz6DRz9prVinUgTJwvlVW46Dgk5YtZ0guCtx6WhqZ
         G3HWy2r7TclLAfKyBj4sSaWPeRm3mYU6CX+ABclF4QE+dXtzNyn1WIS2hdxi2Ku+uHOc
         oiDXfTZ3XRtRoloHpLoOlPq4faypnKlp2SFIfJf0WiNeDgVEtKDNJtslQRv3g+KfSZZn
         pryioaGOUOfz2mKil4aTxQwOZ9EL5J14cbUxtEEbcGsqx//ErCjdtOgjy540v68fUksy
         r15A==
X-Gm-Message-State: AOAM5320w99LEBkC2HFbIYN/eah+3YrHTnhykYwxfTCDuPX5KMzvjTLP
        HxsdqwWUpZ43n518HtG/NSULZwCqxFM=
X-Google-Smtp-Source: ABdhPJzxt9EKJknI3oTWtzHi6G9FkRJDB5fYC1Amc/tgu1zs/I5X+Jd9zB+VSH9RwsSr5rHKzuvHkQ==
X-Received: by 2002:a17:90a:1196:: with SMTP id e22mr10661793pja.189.1608947482766;
        Fri, 25 Dec 2020 17:51:22 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id v11sm3093640pju.40.2020.12.25.17.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:51:22 -0800 (PST)
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
Subject: [PATCH -tip V3 6/8] workqueue: reorganize workqueue_online_cpu()
Date:   Sat, 26 Dec 2020 10:51:14 +0800
Message-Id: <20201226025117.2770-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
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
index 79cc87df0cda..94545e6feda5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5088,12 +5088,17 @@ int workqueue_online_cpu(unsigned int cpu)
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
 			update_unbound_workers_cpumask(pool, true, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
-- 
2.19.1.6.gb485710b

