Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7C2E2CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 02:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgLZBva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 20:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgLZBv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 20:51:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED36C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so2945412plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 17:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GIoPmscZrRM/0tdf2E6abBmlGj1sba6MyrX80MZjSY=;
        b=HAMpS0Ivf62nEgg6Rn0048hkPtFnzEPvY18O/l9UWu1m+u9h2RPFiMo9rMaXGq+eqS
         rY2jlNE94VGH3OLr9OFRsoUfd3wSl8+qqGaZlgSNefG4A7LdQmU3yDIxMwzLn3IIPwdk
         McwhzUKHVY4M5M/jFSx3pyvDsx+GPgWBQ2Hruzw8a4i/ilEHVljJdVKWlzhqGf3BmM2N
         VkQXnV5vC2sQlIVaYGfJwX7gU9HhsURqP4ECDPgNVgdcdZGF0+rAg6L3BryPRUu2Jur3
         ct5f95eQld2K5nt4Qedewxg9IcJ5Fm5sYfSlFtHQmIOMoQ7NKct+XCaFf8C/Q+H5u5bH
         vzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GIoPmscZrRM/0tdf2E6abBmlGj1sba6MyrX80MZjSY=;
        b=kG+y7ZrXY6r+YEZuGSPAXEUoCV9qh0Xsmh9/CNtytKGG2bWlxijoUihC2IMkmyFKby
         6nbOAdfeVysTzaneuzj6rWmfpdlQnXv7XBdL+LV2JtOo1caKSjASOEF2jFXRHivHMgyd
         iiweETooDyaTcWbVAZNdD1YDdCJSEOLMuGOcBR4+KNn0m/ciYxR2A+SD2kG2Ojkm66zS
         /Q1Tfj7MkXSNs+d+bszag2JrnlULgPwT+DHzsiuMkeTjVIk93J8ouKnBT1nOt0Xw30IT
         wRjHm+LvFzMK3fM6d632BAPVgrvOt3FmA/vYVOvu72LZnYJ1k/38JRT6W114uRPAFbx7
         +ApA==
X-Gm-Message-State: AOAM533t8tXcVq2GNFMz3eOHitcUpzWWyKPITRsl/gOaLxDWhfWmWHqq
        5HXPxJfQyagMfXQ8lxUT8rUbQQ3lsGs=
X-Google-Smtp-Source: ABdhPJzK01gC5hA7aYOYl7z2+5lT8ZAj6R6vkq4z86uZdzDSCKelvNZP34UMQHz/xI1qKXR3RvlBUA==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr10973496pjs.124.1608947448820;
        Fri, 25 Dec 2020 17:50:48 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id w1sm29539754pfn.151.2020.12.25.17.50.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 17:50:48 -0800 (PST)
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
Subject: [PATCH -tip V3 1/8] workqueue: use cpu_possible_mask instead of cpu_active_mask to break affinity
Date:   Sat, 26 Dec 2020 10:51:09 +0800
Message-Id: <20201226025117.2770-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201226025117.2770-1-jiangshanlai@gmail.com>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
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
index c71da2a59e12..f2b8f3d458d1 100644
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

