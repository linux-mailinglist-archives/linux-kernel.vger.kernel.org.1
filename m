Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843832D9A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408281AbgLNOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407519AbgLNOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:14 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:34 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so8740485plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gr/OoPXaa+oMOOqoTeQgIX1kGl7nyIAZNwq/czVTG+c=;
        b=tBaDI1MeFA62gW+5BuVUZQbPX1LG/Aj/eHXk8LhZ+Tx28eGT0D9CUdSK45AWKgh+kG
         af7RUCPllH8EMOGXlJ4i4ETbhuI5pUCjhoHG0qvJxn6wojdpJcgaCkujNKkvalvhwgKb
         7kxsF99B7bsFW7hMBie9cpU1d/VWI+E37pVqiceS4mneW9gCUk/+zw4eyNnINyKpDkfa
         xoixOtsIOEKU4uKWO4VbOTn4n+56v5NSKW9OTc96Joa/54NOv9Fg9M+KOPMZGR+JojHr
         HmBB0l2NKC3S3hEMU5In1LEVQ8fGDz8uK19rAyZTA91tM4JMGlNelHPqRDjKz6/msJty
         YNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gr/OoPXaa+oMOOqoTeQgIX1kGl7nyIAZNwq/czVTG+c=;
        b=OJBF3RNvTAA1or/1flpWkFt7dPbp+TqAmswfw9p7bWoYKk1/TQqErnKA75LHA1IEnZ
         gZeg6bMLNUCa9r8nE/i0ml3wUO7iq7d3Ocm68cOriShR1LMClWL6mHMF4XK2e4WpMHdm
         awefEhIrGh1hzouzBihl+eXLKT1NHc7U8IG4ZJJZl/MTMBDzm7agO0Pu7b+oQqJroKVp
         KOalUFgepQWsCjyidD2PS4tYGRwCG4OlWFzk6AuLRbhIh1tP81TzP2o+5HrUs7ST+uox
         bnS3v0dnmAPbVi+4cV1KSpMo3iC2wXvldj7qPVlpaj+M8B2xaJw9/9VN+lOBVuXz1reo
         HDRw==
X-Gm-Message-State: AOAM531ewtdUzndoMOXGmA4DSgO3P5he3aNGVlC5+5j3tGIjs3Lc/Du4
        X9tlkbhvEgDhAY/mWYVIZfgRO0voYl7cPw==
X-Google-Smtp-Source: ABdhPJxywAfiBgwyQp4XWT62rjlQSDi/1okr6iF9BYhXyjdoGBMRAVMkSgA6rJkpIg/TriwaL2oYUg==
X-Received: by 2002:a17:90b:1918:: with SMTP id mp24mr24977047pjb.45.1607957674004;
        Mon, 14 Dec 2020 06:54:34 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 82sm20991092pfv.117.2020.12.14.06.54.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:33 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 03/10] workqueue: Manually break affinity on pool detachment
Date:   Mon, 14 Dec 2020 23:54:50 +0800
Message-Id: <20201214155457.3430-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Don't rely on the scheduler to force break affinity for us -- it will
stop doing that for per-cpu-kthreads.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1f5b8385c0cf..1f6cb83e0bc5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1885,6 +1885,16 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	if (list_empty(&pool->workers))
 		detach_completion = pool->detach_completion;
+
+	/*
+	 * The cpus of pool->attrs->cpumask might all go offline after
+	 * detachment, and the scheduler may not force break affinity
+	 * for us, so we do it on our own and unbind this worker which
+	 * can't be unbound by workqueue_offline_cpu() since it doesn't
+	 * belong to any pool after it.
+	 */
+	set_cpus_allowed_ptr(worker->task, cpu_possible_mask);
+
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
-- 
2.19.1.6.gb485710b

