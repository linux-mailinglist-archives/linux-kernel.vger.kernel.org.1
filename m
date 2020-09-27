Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2527A1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI0QLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgI0QLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 12:11:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1DAC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 09:11:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn7so2198845pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovlhZsWFZPQTrCZro69WC5buXFc9ezGOhnSX1p1upZ4=;
        b=gAi4S4k0nB7OSuwiuXf0Xf8d6SLcqL2ICHuNqi7xVtUjD4hLwrM4HyC6wXONIvbJ12
         qAsClUfcIWDiUiznhwlHablwVf3IaopjrBxaE5lPmVhdSLK0XbA9+e4Nv0t4DKMq2Uu+
         fSkPGonQlj5qdq9HvoEWphdrlmDikIwQR+WlGqb/n7v9Wi/3tyJczfLPDl0Yin+8I1Hy
         4HYyOar7tz6n3x/0lldYZALc2WQI+tWyrKC61G+XdvJGYebHnjGtBvjb87xlQ2jFJ3ob
         Xhl+rd+V7jGRjghcFJfv1WKzK1C3tjPWZ6IurvxtDyOEg4aXkFx4Mz1rljiu46k16O3W
         j9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovlhZsWFZPQTrCZro69WC5buXFc9ezGOhnSX1p1upZ4=;
        b=q4Qan5JKAWXr/M5jgZK46xgLO7awboMU6F1EXZsEtid04qBCop9CVmLnOYh3yuqwPq
         Kd8r2FREEuc1GyhvMu/4FwgcRRV4GdXuWm3/qb0AUxGVMvkMMnvx9ww37GlXBj+cq52v
         jCX96y7fbIF1fQKaeH6WDEaX+a9pDMVpaJcntdS/TYn9PZqOFu/znAVGzdHH1eEAquko
         Cmq1nmRAahoM9+hVqCeXMMtWJtzfiTnVqm8MGOilvGQ0SYuKeamGdQub/eg+XUhbs6ci
         ajVRcUvwrHK4fy9MAwWdn/+a1dxCF/VbLQvvKO3OKEe/4j49sDR4qlyyhW1bCFlFktGY
         iAfg==
X-Gm-Message-State: AOAM532BTEJaZV6LcjKf70EA4KJlpTQ4arBZxqvyvQosnzViDTR1XkDQ
        x0AnGYeGVMixO4d8FQR9nFrjXlEzTLZ8TQ==
X-Google-Smtp-Source: ABdhPJzzFGf3ea0dQ+SGuxATz2ZYqbvd3Tork6B94o+zB+s7A/6vmdl3p2yzbDm/Iq1gwhxISwdogg==
X-Received: by 2002:a17:902:7b93:b029:d2:172:7d9e with SMTP id w19-20020a1709027b93b02900d201727d9emr7982053pll.83.1601223104517;
        Sun, 27 Sep 2020 09:11:44 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.70])
        by smtp.gmail.com with ESMTPSA id l141sm8784844pfd.47.2020.09.27.09.11.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 09:11:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Cc:     zhouchengming@bytedance.com, songmuchun@bytedance.com
Subject: [PATCH 2/2] sched: mark PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Date:   Mon, 28 Sep 2020 00:11:30 +0800
Message-Id: <20200927161130.33172-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200927161130.33172-1-zhouchengming@bytedance.com>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
deadlock on rq lock in the printk path.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..81d8bf614225 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4444,6 +4444,7 @@ static void __sched notrace __schedule(bool preempt)
 	 */
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
+	printk_deferred_enter();
 
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
@@ -4530,6 +4531,7 @@ static void __sched notrace __schedule(bool preempt)
 		rq_unlock_irq(rq, &rf);
 	}
 
+	printk_deferred_exit();
 	balance_callback(rq);
 }
 
-- 
2.11.0

