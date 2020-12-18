Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60CD2DE740
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgLRQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgLRQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:09:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC7C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:08:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so1653724plx.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQkfrtPeXc260InGjwMNznNT9/J1SFZddvHqSK+AnGo=;
        b=DFfFAvWxbJMnSOByZf+y48cQ7XedkmD5ePQvYlKzMUBhtPBNF88i9UNQshaJYVKuT8
         gEHaV99lAqpZfoCqXcpIwLGINJvEOCCjCa61omsLKgqILhc7B3oooRWfvyvqOn4h7d3n
         aHSKye/CiJcjyq3OF0sBCzmof1TQj3LEoTyAjgGqg9zMJSjDWGLY86fXxVzDgAdx5P+c
         ArvjTT8MEQdEIXzHV+/Ay+mVd8u6A2B7+lcvpj2iFhgaA5aleXi05DG6nf2gD3GaBYYn
         UU4o3UguokkePDzAsCbhglM8gHsDr6RHcMd9X4xw5pRNFu6vn4B5wNmEnl8UXA/mXSDo
         c3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQkfrtPeXc260InGjwMNznNT9/J1SFZddvHqSK+AnGo=;
        b=KtfiISjqE+0ReymQ7EycbClgJIUPzQxTrHVw2WMW5g/nLTw42SDxQoSSAgE8x6jgS5
         ExALJRsEhtGa5+66eI7X6PlOw9IttiTwTeyg8qFGa7mxsy4rwJa1VQVNwMKMeleSy7rg
         JKApmn/M5rK4E9mwwmtuk8H7O9Z3GLLQylCJX+Dg4SBHJt4WotyJMUBjuxjlXOeRxLhx
         vjpr8xalf78blDp2h/4cRIPvxHNedxmT1WcdwKwnydlcxm/MsZlG/q5HvA8IniPl6xT5
         /qTfNmNchYV1XjlXyU8CI8iOGtULBrxIyww8qx+2mADjMiEEx6ILMu4bvKd2eWCQgcx/
         pYBg==
X-Gm-Message-State: AOAM530PcyKu7Ci6bLtZXsn5f/Y/0c7hp3V5Ybdcg7qqcCT6EUPaWa2a
        cJhpTo91Y4opzBNWqIRNubDcG1DMVqc=
X-Google-Smtp-Source: ABdhPJyO8W5mAvcRZkZnsERLjC3j+TlL23JYYcIlvS4klekPpjW7IRfipu3g0rw6AabCgCuasA60WQ==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr5050066pjs.47.1608307735720;
        Fri, 18 Dec 2020 08:08:55 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k11sm9955332pgt.83.2020.12.18.08.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:08:55 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 01/10] workqueue: restore unbound_workers' cpumask correctly
Date:   Sat, 19 Dec 2020 01:09:10 +0800
Message-Id: <20201218170919.2950-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When we restore workers' cpumask, we should restore them to the
designed pool->attrs->cpumask. And we need to only do it at
the first time.

Cc: Hillf Danton <hdanton@sina.com>
Reported-by: Hillf Danton <hdanton@sina.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c71da2a59e12..aba71ab359dd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5031,9 +5031,13 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
 
+	/* is @cpu the first one onlined for the @pool? */
+	if (cpumask_weight(&cpumask) > 1)
+		return;
+
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
 }
 
 int workqueue_prepare_cpu(unsigned int cpu)
-- 
2.19.1.6.gb485710b

