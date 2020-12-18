Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DB2DE745
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgLRQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgLRQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:10:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF2C0611C5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so1575200pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SukD6HfUldmfQYaVv+P+34iP/zlxJtrYf13VOc2okqs=;
        b=I8YbtUlE6Moa+bvpKH1bTManUnCWfRlSAXz9x3omaOtn2rY3PP/dp2Upn9i3d3bdTf
         Fd5q6V2XsPV4AULaWeVOXuCOwX5w7EmD6ixEBxKkMHZ+jDzYbRA3OCwZQbUybbiaF49K
         o/xjYlscv6i73FkZZphlWq8t/ppadiYib5+MiS5L6typ1bkV1gRTZIpoFP3kOh2Y4+J0
         iHvRgX727hnk83PGrwyPHWYaP4pf5OtYdkV3GgkkaLZtIWemN8Rr9DQ304o2DA20tQjw
         JHM3Y+Ppa141fdfIb+Ck7dPTso2T8BLDwg99ZCZPtsOpJiVRILvzfgDmrX3nshvGMxWT
         vvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SukD6HfUldmfQYaVv+P+34iP/zlxJtrYf13VOc2okqs=;
        b=IThj3Za8ITsNTL5hczPXADg/EHY+TRAe1vCG5St7LNT0kL03Lt75E7u0wdXvLj2RGk
         XA47aJ1afNtl2LnbVv7Bjlx2ZlLveYccmZXPpfceuk5GsNNIZiN4e1TYVGYsA7u3q3/G
         OqHB4vrmfVeE1SqBqQnvX1b48jVhDUsYEhsrWX4Jg2xX5TpNxbHwY50cqZfTdWHTTLZO
         1ItnZ3fHRuldLN+Zyu7xFpmPpoqiJKcGYCJQK0JTKX+gtgzctu7gPypQ66K4WCt04Rxe
         F+XeQSxGWYdGrzBteCh6eTWkTQpZ+3g+6e4pnsVfFsX6czSxQ6mIW1fxiqePGypb+PO4
         YMJw==
X-Gm-Message-State: AOAM532AtPO815Ru/JpTo0C3AgEqap38FkKZgQyzJ/aS7pao2dLisK4j
        tZO5rB1LSuJByt1OcNULVpPeHOkRfTk=
X-Google-Smtp-Source: ABdhPJx1MfEXIiAkIE+lUeSgBY1wqc+BeoIGE9yjrNBUsAHEuZl7IFesC0eVkiDYblB1q0upz8pu9g==
X-Received: by 2002:a17:902:7887:b029:dc:20e:47ff with SMTP id q7-20020a1709027887b02900dc020e47ffmr4720892pll.65.1608307767760;
        Fri, 18 Dec 2020 08:09:27 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id y23sm9740886pfc.178.2020.12.18.08.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 08:09:27 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH -tip V2 06/10] workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
Date:   Sat, 19 Dec 2020 01:09:15 +0800
Message-Id: <20201218170919.2950-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201218170919.2950-1-jiangshanlai@gmail.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

restore_unbound_workers_cpumask() is called when CPU_ONLINE, where
wq_online_cpumask equals to cpu_online_mask. So no fucntionality
changed.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 84842f10e6a2..eda293097fe1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5041,13 +5041,14 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 	static cpumask_t cpumask;
 	struct worker *worker;
 
+	lockdep_assert_held(&wq_pool_mutex);
 	lockdep_assert_held(&wq_pool_attach_mutex);
 
 	/* is @cpu allowed for @pool? */
 	if (!cpumask_test_cpu(cpu, pool->attrs->cpumask))
 		return;
 
-	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
+	cpumask_and(&cpumask, pool->attrs->cpumask, wq_online_cpumask);
 
 	/* is @cpu the first one onlined for the @pool? */
 	if (cpumask_weight(&cpumask) > 1)
-- 
2.19.1.6.gb485710b

