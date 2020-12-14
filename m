Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42242D9A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLNO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408269AbgLNOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:54 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0646C061282
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so12182015pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSGNazt1g/mx7u3VL4y7PuEAi5ZB152rsA0ixRvqoLw=;
        b=qKx4YKZQSO/24VvjrhLx6h2AClqGdmd1cn8RmQHsI3s9+FirRyOJjxz84IgGGphAlx
         0mAMzepGhH1nehLumUZC20Tt6csw2wUsZcbRx/wjy72Cy5Qs3/s/gG4pCFRV81XGiNPJ
         RLpK6B817u0AXhKEDPNjks+/jNtcDDx7oRJ8El6ZvM05hkUGP+C8sdchvy8hZy8yr42z
         upChJ5I+5yoqsV/C4JOJX2bwU8rerN5rcBEYL8dumygwbcjbTcmi2ILeMKFaJ8zJ0TGM
         YTmw5KL/8ChVt5mhiRiL1Tk5bGlpTEp8RfLo8H7t/D5mGtol7GdgwAxw9vaXlRWpbRfz
         Pruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSGNazt1g/mx7u3VL4y7PuEAi5ZB152rsA0ixRvqoLw=;
        b=nh5MQJ4cxgmYKCYjWq5CLqcDpB9mxZFZirhI18SHMVIboFrI+RlmL5xeVTqzhr3Dvz
         K9gDl8U49CPK1Wc1XxoXv6jXz65bKL/zSZ1KKgKk219zXALC/OxDgxS/aQmZxPbIp7YP
         OU6CvSB6r7n9bDZpxivewXjRDrKYfg/Y9p2p+BYOrish676p7/bmtbPVufa7uMEJ7E47
         iTDK9xtNb/1YmB0mjrVHMsbxj89PyXhjgjUyYPSyIMWqDmXIDxrC3UombEVnzekGz1NK
         29kcpciyjJ0rNJ4GqFKVfN2FBnvHBDGOLHa8uSd+K/lY8jO8d2BoiZtnQlX9layEAQdf
         jqfA==
X-Gm-Message-State: AOAM530AhzM+SKy67VD1gqy9HML6d6rXufF59lGP0wZyUk4PJKmkuJl/
        f+KM8TK8BC/lC18Wai6EjEhTWuoYu0LMzQ==
X-Google-Smtp-Source: ABdhPJxdxPMDVdwtmvGMfjSUtHz6erVdLVc2x94mttxpQcoROVWbqtY2+oO9BDeaVeEU3Qx5aacVTg==
X-Received: by 2002:a63:4852:: with SMTP id x18mr24754944pgk.89.1607957690191;
        Mon, 14 Dec 2020 06:54:50 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id ft19sm9787302pjb.44.2020.12.14.06.54.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:49 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 08/10] workqueue: reorganize workqueue_online_cpu()
Date:   Mon, 14 Dec 2020 23:54:55 +0800
Message-Id: <20201214155457.3430-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Just move around the code, no functionality changed.

It prepares for later patch protecting wq_online_cpumask
in wq_pool_attach_mutex.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index eea58f77a37b..fa29b7a083a6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5085,12 +5085,17 @@ int workqueue_online_cpu(unsigned int cpu)
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

