Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07902DE742
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgLRQJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgLRQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:09:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6BC061285
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v1so1535002pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HILaepP1L4LkoXGwjGc6/8JBQvrDdhltwxNiKtQLYyE=;
        b=a8y/QEyVo+S8aK85CvirEM0AMNRs75MWjiQVcmcwXD6eKV5Mh1AQ3f128Hj447yKXX
         sApwzn+GpoWpXPMvvRm+NybbV5kfHRUri80bgjlUJrdPc9imbVr5ui1ytyfB9H0uDZnq
         OdwyIVnhlccLrpVDRfT8H4hsaidkVazfRWzwRChMVntthXcRt5ClKP4YTCo3WU22tCnG
         mnBT/nBZJPDz6LCxU5x31OkorCk8JfCTfqPlrf4s5KzkR6W04MbTkzsHfT027cLEzWuR
         LwEB7cN2TlSufEdKKNTzL3SRIedhR7jBl4hRMn98O8R9ljyEb0Jq3XP9Lh5K/NeqMIVl
         HYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HILaepP1L4LkoXGwjGc6/8JBQvrDdhltwxNiKtQLYyE=;
        b=MpJ4NuTaTkjSZc6Yuxo2CLphoVSu00Bv5GK6rYZGhPg5NuAZV8wegisnRCoRmby/4f
         9tiKlAGdADdAvzGI99X6A27CQSHWGgKxrWpqFFH4ca5G5e2MdGD6DzEkQ0wc/fhdEvHc
         mkLSDCbCIuJPvtEc85Xq9BAyWwY0YpwJTFELRUDJZmBNXLgwLPoKeVDunnSkcPcYuOBE
         TpB7PTpHBu8N40JXvt/LCVJqlsDDhEyCqh+qS2gb+XM9Dphz7nEf69gX+qNMT4lPCIGe
         zooX8tcyr4jFxJlu/0ZIAqTuzAUpv3Tt5lFNlL0MHKBO8jTtRCuQb4O7jlDmHKkHh9O7
         YGIA==
X-Gm-Message-State: AOAM532dksoPMOFCSQkdggtgBidA5t2Lf1Li4DA8McS+UeoREASKKB/s
        IyCLamh7IFE+fwz31kW9908el3tizHA=
X-Google-Smtp-Source: ABdhPJweZzlLDxl8M6kOxmpStgmtqZh/iRGCgjiUE3aMiAcJLBkT38JR3XDVyWlogphH65gTeb4DMA==
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4962949pjt.228.1608307748677;
        Fri, 18 Dec 2020 08:09:08 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id t5sm7956672pjr.22.2020.12.18.08.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:09:08 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH -tip V2 03/10] workqueue: Manually break affinity on pool detachment
Date:   Sat, 19 Dec 2020 01:09:12 +0800
Message-Id: <20201218170919.2950-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
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
index fa71520822f0..4d7575311198 100644
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

