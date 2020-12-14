Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513422D9A63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407802AbgLNOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407315AbgLNOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:11 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64054C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:31 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id c12so12117441pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fnnjpbrm3QQ9IKRlXqDITqND51Ls+ew6oVlb9ckEF0k=;
        b=W99bBguiEXSoUswik79XhBkkUG+NWC6x2FddD4TD+tmWMK+dnMSBRfZsVzzHZLlyTA
         kZzj8SZ0BjRFjYQwHvLdx84KubjmMgaZlRmV6JGDblJ/SJ+nt9PjAkC1fbl5RI0LvfAf
         7PfNU2ybj82lYK3uJL+nIHoURdHkWQaRquKyc+PxdGV5darsG+74/h7bfVVBf3Du+jF+
         jMyN0yWZObcQO3rQbn6KDsI7gy1Gu3IteBm8/9NQFTpdZP397c2s1pL5zjUlu5nmZFzU
         cOQCZz9/+/KLEBE6noF/fGhLsP07xGlg8TMWnzv6oJ/ECSNMRwaLT+DQXwIhQ4GeroFo
         PxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fnnjpbrm3QQ9IKRlXqDITqND51Ls+ew6oVlb9ckEF0k=;
        b=Fep92ch3EVVlJ+wmzMvvVUmEiJt0vGwPAKTSpL9dnr0k+PyCkDYHakxpN94PovxOf+
         baPs6Xu4uIYW3FoRQq3vFlWtDM8Jq++99QXe8O2JrEMzln8+hK9nj4t10UTf5Fb+BTIB
         jd2TMMaffMxtnPyEyTB0PfA6K6SQDBiOAu8X1vnvzVEq/UhTeUymgLuaAkkpHYc7lvVX
         yF5+2X1h/uhnffBZTDRSnCSPZivveGGkd+0ICTEMvTGr5qIOt7GuSqT5El2jQ+p/eeLG
         6igZdNQTvovAr1Q9oZBRChXq4jcEYLYw7VgCbRG2sG6WnqL8w2tHJdjf9PHlUQUEM0FQ
         wE3g==
X-Gm-Message-State: AOAM532ocPshAJxg2RRrC6bd1KbBbz1GPqS1hJQYqlUl0q0FVKXsYTmU
        K48SM3bEiLY5Iy1JVjZWSnN2VG9ie0Hw7A==
X-Google-Smtp-Source: ABdhPJxHioJnRZpqZLePRZw/xrp9qrR3BkhX39xJyjHg6fdLh8j3kG9j5pWSLE3FN90s/SbdSw0zqw==
X-Received: by 2002:a05:6a00:1716:b029:19e:11b0:7804 with SMTP id h22-20020a056a001716b029019e11b07804mr24149541pfc.57.1607957670832;
        Mon, 14 Dec 2020 06:54:30 -0800 (PST)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id t7sm20513099pgs.5.2020.12.14.06.54.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:30 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 02/10] workqueue: use cpu_possible_mask instead of cpu_active_mask to break affinity
Date:   Mon, 14 Dec 2020 23:54:49 +0800
Message-Id: <20201214155457.3430-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There might be other CPU online. The workers losing binding on its CPU
should have chance to work on those later onlined CPUs.

Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aba71ab359dd..1f5b8385c0cf 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4909,8 +4909,9 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
+		/* don't rely on the scheduler to force break affinity for us. */
 		for_each_pool_worker(worker, pool)
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.19.1.6.gb485710b

