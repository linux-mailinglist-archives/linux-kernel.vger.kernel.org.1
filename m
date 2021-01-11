Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5E2F1846
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbhAKO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbhAKO1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0BC0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c79so18124pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrC6znsFjJ1ZkK49+74ePKe/iCLTRitzlWEVS5qBV0Y=;
        b=O/UANxMEnq2IJckhMQ5vxUk787v3bu9fDr+oFu4hC6vAU8df7vykWTToI6j1lwjAdM
         67nqvxC8juXxqyfaKPhI8y882q0CqCBZ7YTrBANVKPeU+EmS0wVj/cw2IPEXZpG1fAhe
         xRGwC4Qm4hSyANJHLQ8igWyXGCKQg4mQOWYFfZJXn/TvjV1Oi7IR7cLadY1jNb0q/8ml
         XgaSbewEp235WNGf7Vz9NL2n0z+oqmfbWq1HseQgZNrMRpBQa0FLX7cMXirdKBpamPlA
         cv4pUFp7qV0KHwaOZZ6wF+jTF8BBK9vFZIFaZ7bsES6TIMZJBAfOX1z7by31/LOJZwWJ
         mkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrC6znsFjJ1ZkK49+74ePKe/iCLTRitzlWEVS5qBV0Y=;
        b=ctKBJEmyH2zz0CWg2P9acXTpmf3RI2CPQT1IYBx7nNE95bPa+Lqb0dgsj071Yn4b6y
         obiRFz6nLIqgvMwZgP6w4WaSxcMUX1wiQa4QUMVP3gLVKPmrW9wacPamiAwlG8OAvOTC
         KivwtpgOhMhTQH89EIUSPnPTevVNod62tMMCaZHF6cR1d7w4VCOk8thhq6+zpltJTiRP
         dh9v6eYphYNqj+T7+LtD00vhALQsw/HWTUR1GMySWOOfja8G1v/8H3XPv+CJtBCmeI9I
         aFpv7pvhA10HdEKx/xrhGCtlNI183k/LmiURlo+93aZhyqBnk5KRZCF2CyR+UMl2qoIE
         2v4A==
X-Gm-Message-State: AOAM533Zpy9qX+8GSdVq87gpCG86bNGc0DLcbaGLetfNS6OD+uqcYv1S
        JWGUrYWBXi2EJnm8nTe4ThK9Rncf01c=
X-Google-Smtp-Source: ABdhPJz36DjvuO9JBrRf9iEvRQLu1Z7yWPQTR7p1DQswsSD9mi6XxlNEttYziVbSnWDU9ve7F9n14Q==
X-Received: by 2002:aa7:983c:0:b029:1ae:6c72:e0e3 with SMTP id q28-20020aa7983c0000b02901ae6c72e0e3mr16402813pfl.55.1610375189695;
        Mon, 11 Jan 2021 06:26:29 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id r20sm20509281pgb.3.2021.01.11.06.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:29 -0800 (PST)
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
Subject: [PATCH -tip V4 4/8] workqueue: Manually break affinity on pool detachment
Date:   Mon, 11 Jan 2021 23:26:34 +0800
Message-Id: <20210111152638.2417-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
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
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3e92bc4f8a36..aed08eddeb83 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1888,6 +1888,19 @@ static void worker_detach_from_pool(struct worker *worker)
 
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

