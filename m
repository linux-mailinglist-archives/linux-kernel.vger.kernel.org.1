Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A32F1848
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbhAKO10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbhAKO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:27:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F75C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y12so3647543pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWXgt8F7suaFzPrtIUKSC2lnbkbaiZK9xomUf2x6iNI=;
        b=iT5Wh1XnU9z0ZdzjTxeOHkdN05D0LvDywaFeKGuQeOHOkuX+RxtuDs0mUpWGBRSp6H
         dXBI4PsWXGjpzOkD2SLXt67l4gjALw0z/k4myPuxaFF+z2Jzg9TeyhTQPRGAVEB5LdQj
         TftAaJ0CzMAKfTS4Ffe7CC4CfUhABGIX4sdE/z46NXTeg2vtwZZfj16mPZg5qxghTAlK
         jhK97grwvXgcHDwCokZRjSgFwKSd1dlTA/ht12wiKKvUprtuWQl6xCNEBFBoZot2BltE
         1DewlmOoNjhJ3SBJI2rOMK5OqmEgSKWmocG9vMrbT0sxJqq82Y4TeEP12t6ZEmCciRv2
         xvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWXgt8F7suaFzPrtIUKSC2lnbkbaiZK9xomUf2x6iNI=;
        b=EQUIuPv1zu/WC22LeYBe7mMXT03qqk+XkwBXiIaXhXBCaVGORNtZB0kFhNSVVQ+Ofy
         rHO3CC6wCtw16lIluHSa7bA732iNN51mVbvNwrLBgjnpsCFyP+8h3nX/wR+pA3OiWdpE
         5d2rgJtpilbrE0oJP/8/7RMPuPZuXhpuCxljlFmVEKMthoqrqPpI2xcPDRFl9JD35xUl
         R4Wx58HwH3YOnyJm5Wnr6pDhX+GqwHAXdJDp1KDxJ9Chum0TcpWnHNDuB6jrKYzUmXFv
         +Ltz2YXuNmp24Ra1Y9vX67W3BgdwuHSgGsrG8vwTbEwY4fsh99BgZOoZii6fAmqstbcK
         sT9w==
X-Gm-Message-State: AOAM531lcuhWkDOa6+DVd5zeQcV3qJB9xTVSFYcY07C7wlUfoVxKA0bc
        1fTDt9HPGBxP0E0MFv5hOdW19j51PwE=
X-Google-Smtp-Source: ABdhPJyKIrU4fCq08WIpgub4O9M5dsyu/wHJocEi4n+g6oeaiYZsHITEt/9q/LWvsodJD5q0Vmeffw==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr16749723plr.52.1610375202057;
        Mon, 11 Jan 2021 06:26:42 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id l2sm19459639pjz.27.2021.01.11.06.26.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:41 -0800 (PST)
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
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V4 6/8] workqueue: use wq_unbound_online_cpumask in restore_unbound_workers_cpumask()
Date:   Mon, 11 Jan 2021 23:26:36 +0800
Message-Id: <20210111152638.2417-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

restore_unbound_workers_cpumask() is called when CPU_ONLINE, where
wq_online_cpumask equals to cpu_online_mask.  So no fucntionality
changed.

Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d01cca8e51f9..f2793749bd97 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5043,6 +5043,7 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	static cpumask_t cpumask;
 	struct worker *worker;
 
+	lockdep_assert_held(&wq_pool_mutex);
 	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* is @cpu allowed for @pool? */
@@ -5050,7 +5051,7 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 		return;
 
 	/* is @cpu the only online CPU? */
-	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
+	cpumask_and(&cpumask, pool->attrs->cpumask, wq_unbound_online_cpumask);
 	if (cpumask_weight(&cpumask) != 1)
 		return;
 
-- 
2.19.1.6.gb485710b

