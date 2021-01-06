Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D352EBEBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAFNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:35:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816BC06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:34:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q22so5106774eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwQuaJI3ITdUgkoUxk3v+wWUuHsfjS5NfNdaSZsMl/c=;
        b=yneh+vdUg+f1J/W/2eipY7rmKZZwlObVco12kfuDiPjmtPJz7O7tHhWlWLdB9rJWMy
         zcMh21Kn2WPckSp4QNcaA4IsIMLRGskDicCMxoxpI4MBaW8uJzZOZ9o7ek+a+bwZ6s+4
         otn+CTjBqrAvAtzTCWAK4aK/0L8m6YW21DsxxVpvTxG1VVuVnu6iJOz8VtfhyAgsTNr/
         uR+6guwROa4H9CSg+rtMxfwCgUp3t0wJCrVpVHRKOTp0mn9pcwiIQOz71kCZG6ViCz3d
         2+JcEF6FASv698nMiGgpe64skw6HW7b5dMUaD/eou0asfgNlI/Fv6vSPdREfEQJbxFQL
         hHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwQuaJI3ITdUgkoUxk3v+wWUuHsfjS5NfNdaSZsMl/c=;
        b=f/VPUNmnlkSCA6OugMdZQ9p3XClzjlrMn/SzQaHsxHMI+UxIJOzEM5IsOAfHAEERVp
         bQVq586C4Onz7J08r/Uw4VMNSnCgkY9Znpefab5JzWuje98jmXqWXm+kumQQcfynOKN7
         F5YynUmJtoGJHDW1HprMHnZ0lEcbYZnN+Ld3SORVJjgI/Jrj/Cf0PJFqpJvteuPUBdrN
         ckLoF1Syrc/5UE4Yb6hSwaMEG7YptHA8edP1rbLNaC61aJu9a5RXextrQLJLutYzMIDO
         vt+0x8FbDjNdHVpWf9UJW93txXQ+Z/lwpsB0uUStCJEYd2lIJ6CiIrT7K7t4fD0WPnKF
         Q0fA==
X-Gm-Message-State: AOAM531EpNU1WHCXIWNrVERbgSJhMNMveQr5L9NQtEHVqs3013eVm1hb
        AMfDTk0cXWx+MN2PxRg7RVQQbw==
X-Google-Smtp-Source: ABdhPJxGFbaVhIZXEf0Qllm4T6Yy0zbpSzGADPQNygD025nMWi4FISI6DGBYrOzJJ9dLSQuaPKBPOA==
X-Received: by 2002:a17:906:fb1a:: with SMTP id lz26mr2879077ejb.194.1609940084278;
        Wed, 06 Jan 2021 05:34:44 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b599:da0e:e83d:2b44])
        by smtp.gmail.com with ESMTPSA id u24sm1264081eje.71.2021.01.06.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:34:43 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/3] sched/fair: skip idle cfs_rq
Date:   Wed,  6 Jan 2021 14:34:17 +0100
Message-Id: <20210106133419.2971-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106133419.2971-1-vincent.guittot@linaro.org>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't waste time checking whether an idle cfs_rq could be the busiest
queue. Furthermore, this can end up selecting a cfs_rq with a high load
but being idle in case of migrate_load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..5428b8723e61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9389,8 +9389,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		capacity = capacity_of(i);
 		nr_running = rq->cfs.h_nr_running;
+		if (!nr_running)
+			continue;
+
+		capacity = capacity_of(i);
 
 		/*
 		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
-- 
2.17.1

