Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC22D9A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408354AbgLNO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404621AbgLNOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:17 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C0C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:37 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id p18so1003642pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70DmXMFO8WtEsHFOyCOXvT+D0jJZ3ogxX44fJ4QAe5w=;
        b=SYP8sxemV3XRo4qiF+Nf2xj9Mbsk4Lp9TcBrYqoOOFNQptxNipSffAXFYx0n641gpK
         vFf9QjRp5v6blzfq28g1EKtBQY5PQLkY5RiX35NXtxOXYVTEP0PLBdM7Rmv/KVkI0Ci5
         hly2zQQudRqaTw+fmmDXXsF8/8Iov7SQhUs2pORaa/UvqDyFFNK6WwydNBlVySV/AV6M
         Cqr9nJtL8EpfPxU7uicM2VJjuJxNEQ12wxpCl4rBopodpJgOaI9Hs3TKGwc5ROD49wvU
         IbE1/LT7cqtqGpMwaQkQWQoMWSj+ArzOw4tFDvCkqX1RFpoGQawJg29L0NhXFZAiBoAZ
         swHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70DmXMFO8WtEsHFOyCOXvT+D0jJZ3ogxX44fJ4QAe5w=;
        b=DRL0w+nGT8aUgfzGYy1N8auj+PwONJNVEK3/CWeCc5Ap6sW4d5/Q7M4as426LcULZc
         uXFytpVbDUukvmSv28rZbi7uaubmIppv2UxyUle6dS9GjtpA5+jgsXKCwwwkzEJoYGO7
         PyfzSgAB1OVnyV2A9zpyYqKoiqZxSBI8HoKGepdaK3z0b3y+Mazg4WhI2M3FeexYsoT1
         WxZR736Ie/X9+U+TGrnDVPcqdhG2wEE3u8ISpC4awg21SwtJrLdAR8eG4Wy9p387z0hg
         DWtuujs42hZlVx4fd+sGoq+7VCrw1KLBj427Vwu6MzVvJ3c9TeWJKfV+Z7ecKofsnSn4
         0DvA==
X-Gm-Message-State: AOAM530VW8bfVtqLmlMFgsecQnSLulAgaIu/mRjRQBQLnw2jaYy/2SD4
        B6PyRuMy8CEiEvDDS3u1JRSZJXlan+PF8w==
X-Google-Smtp-Source: ABdhPJxfCv3x2k3xLGn5iBOODuJQMUhyXxBtOCWchPMEfPXEDSlwvVgigpxjMza7TNjMnc5AmFYn9A==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr23986777pgl.310.1607957676988;
        Mon, 14 Dec 2020 06:54:36 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id x15sm15281752pfi.184.2020.12.14.06.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:36 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 04/10] workqueue: don't set the worker's cpumask when kthread_bind_mask()
Date:   Mon, 14 Dec 2020 23:54:51 +0800
Message-Id: <20201214155457.3430-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There might be no online cpu in the pool->attrs->cpumask.
We will set the worker's cpumask later in worker_attach_to_pool().

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1f6cb83e0bc5..f679c599a70b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1945,7 +1945,15 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+
+	/*
+	 * Set PF_NO_SETAFFINITY via kthread_bind_mask().  We use
+	 * cpu_possible_mask other than pool->attrs->cpumask, because
+	 * there might be no online cpu in the pool->attrs->cpumask.
+	 * The cpumask of the worker will be set properly later in
+	 * worker_attach_to_pool().
+	 */
+	kthread_bind_mask(worker->task, cpu_possible_mask);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
-- 
2.19.1.6.gb485710b

