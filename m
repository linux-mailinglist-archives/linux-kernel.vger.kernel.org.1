Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A905A2E2CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgLZBvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:51:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C13FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t6so2956479plq.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KeFih4MTBIL/G6+GX/5b1Bj376aPNpZ/6ClQ33D9BkI=;
        b=frogcNXKsAY2YbN+7JDxcCr8mY8dTV8OwH+OQ/7e/siAIdrDcoCFA54EbyZ5H2km3m
         ucbTa6IsKGgkW6t+VXhzcln8MXHcG8ffB83THEfm8+b4h94WFN57Mb9hSC45v7indhUR
         DWEiNG9SXAvm+rmc5CD2QRjxiG9KROaYSNF9+4z1NeM1v32DiogPdSTrPx2HkdEkjxCF
         cSLkwRs/BjkHIeTkXziBf9GQx3GTSrhGActmd2Sj5gAqLE1ZxX1EcxrUy5VMVHZ0xgIS
         kWwBEpoOvOWU/M1Jbr/H2/kg0Hyu9r4mkbSIf9cJ3/JfI3VAzFVjx4w3TW+JjZ9LWQ47
         XjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeFih4MTBIL/G6+GX/5b1Bj376aPNpZ/6ClQ33D9BkI=;
        b=NmeELz+yi34t3cDNrMM4iimg6ySg6XQZ2BaQDpEn7EIOvihKJ0kT2ogxYsUW5Ajcmd
         nsQdb2VEitwKr4YOQ84vkr5UtSN1Bik39b+xFlUXXiarereIAEcVdRrwu9Gsrm9vuSTr
         kB4m9/K5xs2HTFCXeEkAs6Q5NPkYXE+g1c/kWsasBux/ygv+NhXomONfd0zRnonxaAaR
         Z+ieCWFyYtl2HDjMY+PMKj6W4jzjHVtEHcTX2u5ptpcC79uThpcZsE1IrNxwUKGlrz05
         xJK+UjDY9mxDUIlvBA1CQOCpf309KSb0KStwxt8FBNAZ+DUHZrNRmSLx9HTtKzr2ZbyH
         IjWg==
X-Gm-Message-State: AOAM5316ON3RZF2HWLwiviw0fMici5lB6J45VBvgPfuuZLH552SYbIhz
        3a6BjLr049kGG9CZxrd9p/bWke4yOhU=
X-Google-Smtp-Source: ABdhPJxghyKpbHGf+UiYTjG4ornBqf1HBn3Qy7E7Exop4nuSNd0azsCh/gQPZS7cDmpK0DQFLgXeEg==
X-Received: by 2002:a17:90a:eac5:: with SMTP id ev5mr10710088pjb.65.1608947455692;
        Fri, 25 Dec 2020 17:50:55 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id r68sm29376769pfr.113.2020.12.25.17.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:50:55 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V3 2/8] workqueue: Manually break affinity on pool detachment
Date:   Sat, 26 Dec 2020 10:51:10 +0800
Message-Id: <20201226025117.2770-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The pool->attrs->cpumask might be a single CPU and it may go
down after detachment, and the scheduler won't force to break
affinity for us since it is a per-cpu-ktrhead.  So we have to
do it on our own and unbind this worker which can't be unbound
by workqueue_offline_cpu() since it doesn't belong to any pool
after detachment.  Do it unconditionally for there is no harm
to break affinity for non-per-cpu-ktrhead and we don't need to
rely on the scheduler's policy on when to break affinity.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f2b8f3d458d1..ccbceacaea1b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1885,6 +1885,19 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	if (list_empty(&pool->workers))
 		detach_completion = pool->detach_completion;
+
+	/*
+	 * The pool->attrs->cpumask might be a single CPU and it may go
+	 * down after detachment, and the scheduler won't force to break
+	 * affinity for us since it is a per-cpu-ktrhead.  So we have to
+	 * do it on our own and unbind this worker which can't be unbound
+	 * by workqueue_offline_cpu() since it doesn't belong to any pool
+	 * after detachment.  Do it unconditionally for there is no harm
+	 * to break affinity for non-per-cpu-ktrhead and we don't need to
+	 * rely on the scheduler's policy on when to break affinity.
+	 */
+	set_cpus_allowed_ptr(worker->task, cpu_possible_mask);
+
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
-- 
2.19.1.6.gb485710b

