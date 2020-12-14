Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8562D9A81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408305AbgLNPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389638AbgLNOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:55:08 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DB2C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:28 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so12181398pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88PmQo8NcIxH0cEb7DDjp6VrwSLz61ucSUYapmRv2vk=;
        b=hAQP2+3gSVGsENC1Fgpt7OZ7H3ROGMe7KbqH9Gep+GoJs16gA+c8uzlAVhU8/VK0tH
         DdJQPl8pVqN2H53JBoZY3sIYTycGwrYQGEWmfoBMiKM9gEN0wvJTj1NgGa/HadQ1F3f5
         t7N+KZh/LIA9VbEyYtNS+d8zyeD3U4k6BX72IuOO6sH44m4LYmxhIDRy7uMfrXhvWD6d
         uuO4qzrfLYDeDEonYFJfSVSHzAvSYK4lXbf/TNzDvZURlo/NEWNYrkvEztd32huhIWtQ
         naAXnr++OZSEyeJATANjlPlfJj3gTrLiX0mCk5CH6oT2oQLX0CvYhz5qyChTxejpfpYJ
         uRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88PmQo8NcIxH0cEb7DDjp6VrwSLz61ucSUYapmRv2vk=;
        b=U/5og806lIDDadpLXx+mPBS4lTT5/fVAk4DiyjHd1XPzr4rQxj01wxkCxKOngwLHNm
         fnOTbp/Tgbevvq2ypMNMLTrIvO2yIrjBuFOeP8EORiD7YGXqTIYA+u4ZcFgZWE3rj0A/
         21g4bX8/ZEH2tGwejuLllBrpy6dR8AF6jJugC06Ki2PfpdzvM4TDb/CoIWqabLub45Bm
         9YxxYhJ7CUKrOTd9NPnTMRGXJ7FiveTvKAaJWHcpyoP8bAIbTY/urRuZLkSSVx8YhR42
         n2T+FVZJGxZ2jVXC7+d9aqNlqeuvebT+OXM1njhxr2nmklUvKEVWPr2szKh4arlezJMK
         48CA==
X-Gm-Message-State: AOAM530vzBFn8MIhXFd5VQsua9M0kVICBFe1NkQfovpLTVtJWX18i/QK
        q9Yn51iTHcchLlGWZXV3Q5dayfTss+IZqg==
X-Google-Smtp-Source: ABdhPJwCggYZoK6YjU0wp/DM2qRsk8LGRAezMQzFRcTZ2PT0NonAiAlA/APjE70oAsP+Z3Dbdl3gOQ==
X-Received: by 2002:a63:338e:: with SMTP id z136mr24351633pgz.204.1607957667722;
        Mon, 14 Dec 2020 06:54:27 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id x4sm19744086pgg.94.2020.12.14.06.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:54:27 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 01/10] workqueue: restore unbound_workers' cpumask correctly
Date:   Mon, 14 Dec 2020 23:54:48 +0800
Message-Id: <20201214155457.3430-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201214155457.3430-1-jiangshanlai@gmail.com>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When we restore workers' cpumask, we should restore them to the
designed pool->attrs->cpumask. And we need to only do it at
the first time.

Cc: Hillf Danton <hdanton@sina.com>
Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c71da2a59e12..aba71ab359dd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5031,9 +5031,13 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 
 	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
 
+	/* is @cpu the first one onlined for the @pool? */
+	if (cpumask_weight(&cpumask) > 1)
+		return;
+
 	/* as we're called from CPU_ONLINE, the following shouldn't fail */
 	for_each_pool_worker(worker, pool)
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
 }
 
 int workqueue_prepare_cpu(unsigned int cpu)
-- 
2.19.1.6.gb485710b

