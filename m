Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491312DE743
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgLRQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgLRQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:10:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032E6C061248
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so1654227plx.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dv4qsAZq0NVt8ihexcJ0G5D/6QCcdEgC6hpzBgclBI=;
        b=etUvUffr06ResPuSGoBODV1995kzRu5AWkkxGd0MA1LR8H06NaItmkSAZXQE275Q1r
         fupdhhK/f6HXzetycrNJz2K8Bl8+bnwLGqitNXqjCEJxre7+4Wmw4ziXoGdI583wXV48
         taLJCBYQte06uOAkyvqMRfxUPTFGKNgXYGT/kX0PH+rWI/adS8VrCbCzdsKAyg2k92Wm
         k5UAOZhKO25ciOhZLFRexJVoVpZsVWmXMFr4pPoPqLZ9m+cGErZyNwjg9eUQfDBJ07P0
         BpBFwqS+ELZsx4ucXx19Fe1zVaZ+Ew+N0JwCkHAXqwX6m6r3O5eBdU6PjAWX551Zr42+
         9skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dv4qsAZq0NVt8ihexcJ0G5D/6QCcdEgC6hpzBgclBI=;
        b=hLgw6K+YHIKtg09kI+cbrCnwBN3SwzNyEXEhELMJG8NaEidEcOrQE5GwuW+dXgHjyw
         68yP72gMB0gUuhgXf+WcR/5flzoTAhHk2im5R62tIzT9YUJKx6r8QUwbVJZgDVGQaJYs
         meKcdj3AtR3+o33d2xCUsIdo3A6fe2bpa40bKYrga76vHpTosLZvnkLOG9/3CaAPRATf
         bSPJL8+BQ71tHWFOZVT6EP+XYcr4SGoTNYFCVyUL8/6ukE7ZgUOAzPr6MHHNEq/s3ri1
         SGe8Ss869OWSBo/vAEyoOKpBUKhDiL+1xCJNxR6moq89yR060vkDFyfpxVoxmWVhQbZZ
         7eQg==
X-Gm-Message-State: AOAM532EEWVUYijdPlqgUj8QVP5om1StdMsbPXJJ/tbmYyZCfzHIbQJH
        KIzFfsJGymMy/YcU/lUpJfY5XwMuies=
X-Google-Smtp-Source: ABdhPJxmUG8J0W6Akadi3fLnKSSulB1WKQ+IIP0AHAh+FEk3AumTuQ+vwPO4MQlv2kR/YB2ZCqosTQ==
X-Received: by 2002:a17:902:228:b029:da:6be8:ee22 with SMTP id 37-20020a1709020228b02900da6be8ee22mr5138794plc.44.1608307755408;
        Fri, 18 Dec 2020 08:09:15 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id r20sm2040743pgb.3.2020.12.18.08.09.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:09:14 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 04/10] workqueue: don't set the worker's cpumask when kthread_bind_mask()
Date:   Sat, 19 Dec 2020 01:09:13 +0800
Message-Id: <20201218170919.2950-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There might be no online cpu in the pool->attrs->cpumask.
We will set the worker's cpumask later in worker_attach_to_pool().

Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4d7575311198..5f3c86eaed7a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1948,7 +1948,15 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+
+	/*
+	 * Set PF_NO_SETAFFINITY via kthread_bind_mask().  We use
+	 * cpu_possible_mask instead of pool->attrs->cpumask, because
+	 * there might not be any online cpu in the pool->attrs->cpumask.
+	 * The cpumask of the worker will be set properly later in
+	 * worker_attach_to_pool().
+	 */
+	kthread_bind_mask(worker->task, cpu_possible_mask);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
-- 
2.19.1.6.gb485710b

