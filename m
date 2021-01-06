Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B342EBEBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAFNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:35:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABAC061359
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:34:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ce23so5010806ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JVRbPe9i1rVb+6sTMWw6N0jgtW7qeKIxzc06ExpEnEc=;
        b=VfeHN0octOxjv/CQzGlnLnFbAVrij3uMEeWCtD0kuKnVTvBq5TN2ikURXZEC0BnFVv
         aasOTHQ5YYdMs7+HvVlbVHrEVf3CSZGl073llef8BWjY7e6nbXmM1Tv44NCEShSixAYt
         rZsSUbA2uMQu9Gx7p9MDhpbINNTR73g2Q7yE0zlpnF6do/s32Qgj04FyKm8x0hrMhUea
         JLy/3uid+p7z0c3Wh0ICfKgZduGPbF3UP9UdKEKi07QfXQUKpvkXDGEfrnxOQToraA5L
         PAH3KjfWcrXIFWxnB2pLw/5Do0WSa3x+9EFbE8CiRo3aiPCIUq5H3fEJkn1BsOxHhwg4
         Nhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JVRbPe9i1rVb+6sTMWw6N0jgtW7qeKIxzc06ExpEnEc=;
        b=KzVbzFEnPZYqOHR6XLVvtMzIuihlaOx/FXmKzvR1GJzYqueaOT6GBPfbtKXJboJVw0
         AXH8rhY3ZrB0Tl3WwdMsZYneblQvGkF0RXfjRZQInZBAUK8TFRweAUPn2TgeeYja7w3M
         AMlpKweQZN9YaV34OJ6JDrLGUrfD0oXkvHOwB+9CuZV/twNKya2bp58Szzetg6kayojD
         Fq+v0uIqy92OTsZQ9aHCiZcTm21SIUfjKzBrdgG1UUTJfvMkEn7Wej95RL7ZNt0zxhoe
         sR12BJY/XL6HsvHLZPBzGKX6H74i8jIdkqqAcaihBMTKwoqEAgbJE5k2uSrcMCqsOoy1
         VJAg==
X-Gm-Message-State: AOAM533QRa1yTLKGiuzkdgsc9qiKJAk5FK00iLt79RepEaKS/R4EFM35
        bVchA7PBp0g9PWlcd/pLo3huUw==
X-Google-Smtp-Source: ABdhPJwuGYk5OKSL/yTuFnWEVvNbJBD1WA5sYe1fMAa1H5/BJ37GeI3YCmg4DWmX2S/uPxLaY3Q1og==
X-Received: by 2002:a17:906:c097:: with SMTP id f23mr2982355ejz.136.1609940086099;
        Wed, 06 Jan 2021 05:34:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b599:da0e:e83d:2b44])
        by smtp.gmail.com with ESMTPSA id u24sm1264081eje.71.2021.01.06.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:34:44 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
Date:   Wed,  6 Jan 2021 14:34:18 +0100
Message-Id: <20210106133419.2971-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106133419.2971-1-vincent.guittot@linaro.org>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting LBF_ALL_PINNED during active load balance is only valid when there
is only 1 running task on the rq otherwise this ends up increasing the
balance interval whereas other tasks could migrate after the next interval
once they become cache-cold as an example.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5428b8723e61..69a455113b10 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9759,7 +9759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
-				env.flags |= LBF_ALL_PINNED;
+				if (busiest->nr_running == 1)
+					env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
 			}
 
-- 
2.17.1

