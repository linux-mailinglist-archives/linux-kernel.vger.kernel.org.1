Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779942D9A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408329AbgLNO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408266AbgLNOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:54 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B9C0617B0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:44 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x126so3377920pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfP/LgfIQ6Uc44WuS7ziThQ32InOHQM/5s7gWMF4IsI=;
        b=rgDPVAUxgeF4j5kW+Q0Fa2heLH5IfzX851TijHF/pBGMEhEjbF+oPDsIVqqsjvcOi5
         XbgcaImmhcutDWwDVRzW1HBEGTSix4cqvhbgozsAvINP7ffaAl4jswjVAO/MYP61idEL
         QIRXF1nUlWo9fFrQr0H4D84nx9fRAaNq6lubeloAEoHJq5rhQv2cNYO0pBZm62TCWIaM
         1vTRvr4KNALR5cTJaNWVLNaG3m5kDwC+0sIfj0Ps/rGTp7sT0svosh5PbyUWT5Fcxk+q
         ZOUqGL9QzMX/vARJuaNTjXrolQcm94Zlt0ddDLIgKMOqdYOYAaP218usqJ43pTvtEwNg
         Hn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfP/LgfIQ6Uc44WuS7ziThQ32InOHQM/5s7gWMF4IsI=;
        b=o6kCEbMOTsEp8V+rye4Dtbpbct35n8OgtKbVllQ2WpJJ9ShYDGga9DiasSyV/CQx0w
         U6w/NdzX8OEaQHS8oKS9HLwLF9g1w2I1SIZuOtvFpunBnKonNRzsIKkTEI62HxsmW6v0
         gaXdLz0TldO8254Jo5pJhRNhLVkHecWdEJRo23Jwf85BxDroy2FTT8WNk0GJxeKI5rrW
         zRkUMwywVQFtq2C0RFqYdM9HqHo85BunmYtHZDaDH0DbG3fuyu2C1/aVVz/vgCntKvbI
         WPcq8LmrrAMWGJ79wEtK8bStnHTkMvUtVLERsPm6tsuYC7AXe6axj/7qyMSWowHMaGW5
         EPnw==
X-Gm-Message-State: AOAM532NjUAEHGwC7AU9Ge0idrC1r6J6h2Q2kSm/5WhjOyAEq9MsX+cA
        XsxNOOFS4ngL33N9u8i0k+A7A4wrBHolOg==
X-Google-Smtp-Source: ABdhPJyqK15jLh4vPD/yjQqv2LhaIVlqb2QnJ5d9wc85jId5uhKiOMH8iLfWJQswA4XUiDgB/e+cWw==
X-Received: by 2002:a63:ea48:: with SMTP id l8mr25198732pgk.293.1607957683601;
        Mon, 14 Dec 2020 06:54:43 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id y24sm19595144pfe.42.2020.12.14.06.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:42 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 06/10] workqueue: use wq_online_cpumask in restore_unbound_workers_cpumask()
Date:   Mon, 14 Dec 2020 23:54:53 +0800
Message-Id: <20201214155457.3430-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

restore_unbound_workers_cpumask() is called when CPU_ONLINE, where
wq_online_cpumask equals to cpu_online_mask. So no fucntionality
changed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8aca3afc88aa..878ed83e5908 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5039,13 +5039,14 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
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

