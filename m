Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89E2DE741
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgLRQJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgLRQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:09:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B71C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e2so1598845pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbphNThpMBkxGgNc7zAuFjFsnDtTe74/75ruhMTtlWA=;
        b=TrwsgWTFeIYHpaE92OK13QkzEiSSoPGh8SYTNr+hnoXgb3GyESoW1rfND/PUo1RFN9
         CMKOOr2ceuLeZDgSJda4Zzeo6VLgKVQwGeuXNlq5/1/ZdSOp7PhqDPg1b1cJJW8YqN2f
         mSzfV8yyWRbuuFYT7zO+gKA1kQUsg/1SfozDleofFbxxwO2OlxH3JOo5WbSnKnfr3eOm
         jCYLYOuMlvqNy7JG000wcRi/Url1YOnKBaDTnNQ5Di9UTtxPckcmrqZsuaJeomaa+ncE
         pKJ0k8iVnYMXfTwbpnJxepcxnS5XOs/OhIFSptkKyQ8CvmNg6EZ2ryUzaMNxL/OQTv5z
         CLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbphNThpMBkxGgNc7zAuFjFsnDtTe74/75ruhMTtlWA=;
        b=No6+WI1QSxIcULG2vd4XAnHhe59dZx973SdGL6B3W4SXQK10eHv5yqCAmTo9xXwhQp
         nuL+FjJPoT96mNHlMaQ+e4UwEqXUy5TbTP8EltBuXw60LWsqeJSxk6r5FgiEeCZI+3LV
         y9/YBn791aZ/oACJUDXboqlN6OfW/kD50Kh1uCmkrJkphB5OGXaByyp2YPClvZ/6SAgQ
         u1eqr9xCH0UybkZJMXA+WmFGocXE2RX5kkuO1ZtXZ7xFjFiR6P9jEHsBkOXgYVxti1EL
         aIKItxefRctrI+EVabFQ1lTKYfysnfUtW+VfRSj539U2WcAW9LATe5mVdbw5GLzv/07c
         AZ/Q==
X-Gm-Message-State: AOAM5325CW4NSzOVSeNySa6ID9epybzaZ/gcD8eb0h17ZEgOhrS2DHRI
        xzxA8rlnPZ8RxcYHKTTaVliK4oGGPmA=
X-Google-Smtp-Source: ABdhPJwaNlT9TRkHrl2F3O67M//Tc0MAvMcqIDHcNS7d9rnIj4broSv7ETXiWh8lGqrCNUbbbXJ0fg==
X-Received: by 2002:a65:67cf:: with SMTP id b15mr4690294pgs.429.1608307741721;
        Fri, 18 Dec 2020 08:09:01 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a12sm9366971pgq.5.2020.12.18.08.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:09:01 -0800 (PST)
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
Subject: [PATCH -tip V2 02/10] workqueue: use cpu_possible_mask instead of cpu_active_mask to break affinity
Date:   Sat, 19 Dec 2020 01:09:11 +0800
Message-Id: <20201218170919.2950-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
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
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aba71ab359dd..fa71520822f0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4910,7 +4910,7 @@ static void unbind_workers(int cpu)
 		raw_spin_unlock_irq(&pool->lock);
 
 		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.19.1.6.gb485710b

