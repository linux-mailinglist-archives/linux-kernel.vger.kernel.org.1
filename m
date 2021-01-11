Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6E2F184C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbhAKO07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbhAKO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176DC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id h186so24084pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYaotrkJ9GWz9HcVxQ85G6lbaUv108utYr6j0utTxOY=;
        b=JZ31gUo3wbSvlxiPJS3CXd3WwYuueDWtWYRAA4eF1IuXaDLL8XqpAJu7rWYwdx4Kxa
         DENehRMeZfz2zDooVSKUcOe3fD3p8ZiSalirHTLB0QaaaP0/mUBxtf+n8RZrGjLwJI0v
         XXITQa5CvlhWHSKFNayue8b3DFEip15PJkiuIhOGuteBprImyy8lnoj+tAmcgCrTmDNV
         xhPdKabdH8JS7S9dAqmCZLCRuzfYCps+Sg7QFxSE35Ra5d/q9fN8fG9HIh3aWW8QzLIN
         55e5ToTc6ZOGRVBS6kW3TcOohC4KLbENsx5yzELMSUHj1U224RW0aCsQgBXIrEIkgI60
         TdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYaotrkJ9GWz9HcVxQ85G6lbaUv108utYr6j0utTxOY=;
        b=qE8DXaFuzhkCtMVwSKYm4RRngKrsRxyfJqqUsifH7YmtiAk9xNCkIBl0E8Gr5EyYer
         uU31m0WOMLGpE7b+L4P0Cl8DM7zZkMEe9okOfR2DUiAJK1HnQfJhIxH2uhVmrySvlEW0
         MMXS2oqlOJAzrVvthh//CNsfYenZmxvVA2/cMYif7vWEEJyXDA6T4tNHT+ECKAkPz90y
         5ex8Xjs9XJYWQzGNKaAtKX7ZUgkCzd9DT573bNZvjvifJ1iZzqjLPQlfWrSM84pzLtaB
         H7qcHJudGghBLpOZxsrsLDu3Pgvgr6QWiTTcTBfuDZ+jzomsdkdgmylttf9IJhL9YPrR
         v/gw==
X-Gm-Message-State: AOAM530H7Qm40m1E7X+xEdPJfI9NdbqyoX43ixISyGuEuoxf7JESTXL2
        93fsOzNhObW1bjkWdvdWzmorFJTIvEQ=
X-Google-Smtp-Source: ABdhPJxpQ4S6oYwWgdIFGvi8oGUuZX1eOlxf8MPxVy/WnvfHqoragV237+Kll7MYiEUrr+Oe2dlsPQ==
X-Received: by 2002:a62:25c1:0:b029:1a9:ee40:3fd3 with SMTP id l184-20020a6225c10000b02901a9ee403fd3mr16192880pfl.58.1610375177358;
        Mon, 11 Jan 2021 06:26:17 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id t18sm18890429pfl.138.2021.01.11.06.26.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:16 -0800 (PST)
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
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V4 2/8] workqueue: set pool->attr->cpumask to workers when cpu online
Date:   Mon, 11 Jan 2021 23:26:32 +0800
Message-Id: <20210111152638.2417-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit d945b5e9f0e("workqueue: Fix setting affinity of unbound worker
threads") fixed a problem of set_cpus_allowed_ptr() with online&!active
cpumasks (more than one CPUs) when restore_unbound_workers_cpumask() in
online callback.

But now the new online callback for unbound workqueue is called later
than sched_cpu_activate().  So the cpu is set in cpu_active_mask and
set_cpus_allowed_ptr() with pool->attrs->cpumask in the code won't
cause such warning any more.

The said commit also left comments outdated and causes confusing.
It is better to change the code back.

Cc: Hillf Danton <hdanton@sina.com>
Reported-by: Hillf Danton <hdanton@sina.com>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d7bdb7885e55..38628e2a622c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5039,11 +5039,15 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
 		return;
 
+	/* is @cpu the only online CPU? */
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
+	if (cpumask_weight(&cpumask) != 1)
+		return;
 
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
+						  pool->attrs->cpumask) < 0);
 }
 
 int workqueue_prepare_cpu(unsigned int cpu)
-- 
2.19.1.6.gb485710b

