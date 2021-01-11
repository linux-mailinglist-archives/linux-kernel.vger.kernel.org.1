Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1B2F1843
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbhAKO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbhAKO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ED9C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lj6so7894569pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdyKLfTCh3Xym0Uup/ThWZDD/W67Hk+8R3SOcImsVaw=;
        b=csXVsYUApfJVPJFgGRWbUivRKnbUZ3JwY9w41zB1tZb5RLOy/lLWXvSRjPukG7V5fi
         4imAX4Ull2VeuL0Q/JThp7ijtRruIaG/JjhG3nO585hHXJikn8LVwBynOph3fSlL6V1z
         ym/VvI8ZXkuvWjcZpfqxwIDB9h5OO4xx7FyOjqqyljb6mZXvTuaS66hDhIskhbJcW4EY
         Iiln5QetCG98szrUhQD35n4cXkcB3vxbR43r09WfS0GPMzeMv5TPhTTDTsKbQWjNhDAP
         +Mdfr+U6qTGYPibIC1OJCuavhKFe1043Dp6hmOuGQGY6GOnGHEaMdMjg71DyiZlyiaiS
         Mt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdyKLfTCh3Xym0Uup/ThWZDD/W67Hk+8R3SOcImsVaw=;
        b=DePt3MbhwhsSbXDwKtj9hJJVJzgrcMAx6/51kgRW0PNcnWS6h3rKihbFnfbuzX8kRY
         aK91ph4l4WsrrDbN8kBmZ4+RNmSR/MUutvMMks+SxelS367ELSfJxkq6xsDdJApUjesM
         DD+EAUQdsctThsTy+l9lHy3Pj+OEvUPrvo14H0IRjfZGr2oUMRHgySkGZnKYQcbeyP0z
         +WwIw4Xn7MOpNP1OpRYLbdaZ0CvznwKwY+fSC2IKx2oCrBPIlIuCGpD+N4SLPn9SPGXV
         OOy11m999X1qIWwPa7OavA4MQBlm8Kn5mbkNxVKcQzwK3AJrzOPXXlzTdZNti4jZG8qp
         qHkA==
X-Gm-Message-State: AOAM532wD6lJAdSvYLC5r/uUDX2zIlfodtBtLDIommGdw3bk1/N7l7Cu
        WWpOBJm4prwbTFGkwKzDRLsCSxsSRt0=
X-Google-Smtp-Source: ABdhPJzfDG6FHeBFQA+wUzWsYoFbEpFa8gWUcRqZDGwuOHBT7BLjo6Vad1OI+06MzPuKAHc85E1Npg==
X-Received: by 2002:a17:90a:e386:: with SMTP id b6mr18026129pjz.134.1610375183517;
        Mon, 11 Jan 2021 06:26:23 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s13sm20693932pfd.99.2021.01.11.06.26.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:23 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V4 3/8] workqueue: use cpu_possible_mask instead of cpu_active_mask to break affinity
Date:   Mon, 11 Jan 2021 23:26:33 +0800
Message-Id: <20210111152638.2417-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The scheduler won't break affinity for us any more, and we should
"emulate" the same behavior when the scheduler breaks affinity for
us.  The behavior is "changing the cpumask to cpu_possible_mask".

And there might be some other CPUs online later while the worker is
still running with the pending work items.  The worker should be allowed
to use the later online CPUs as before and process the work items ASAP.
If we use cpu_active_mask here, we can't achieve this goal but
using cpu_possible_mask can.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 38628e2a622c..3e92bc4f8a36 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4920,7 +4920,7 @@ static void unbind_workers(int cpu)
 		raw_spin_unlock_irq(&pool->lock);
 
 		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.19.1.6.gb485710b

