Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871AC271BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIUHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIUHYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:24:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so11552206wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FOMwrUZnuRWKSPjfCSf6/ZqTpbFtCUBXMZ2Chn8u7eQ=;
        b=S8K6UThhWvYHqPJEmoHb7O9eNwj836Jc5/JrdU1I97oK+hLkNwBbJMwBjAKsM7uoZ+
         sScf8SZkg8HhGS/KEL4kLzNSgoS9wF0F6gNuB99tHaemBpXZcMhbm1oo2D31UuRIYLCL
         CjxWNDjy/pkf2pgLyE7FKgWXojWrx9Brqx3hTlFWQ3S9boZaurtBQNG9K4hFxAPJCbkX
         0BeEC45NEegziIvgtGasTY9do/tJ3+nRXdFZzR6g0pOclm8vNKpyQDLI7VFYjtgL5PXY
         9ojqg9kkqjeeDV5Do3adFdZ3F6sYHwBdyo+PoKZTeAYdAT5YMMjaJTmdG5P2PBF9kJ72
         vSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FOMwrUZnuRWKSPjfCSf6/ZqTpbFtCUBXMZ2Chn8u7eQ=;
        b=tqfGVtpU2cDjh45PU9OMoCHL3x321uQK64JHq9v+z7cHkAfkZNSAOeqYdI89nDK0xw
         K/CqYSpWcX1qYY93Jwn5/GKKaOchDNrpmeSWb2k34jphPE+v/i3JY6aeugGePWDszr9O
         ANYFVtSVn6IHWLMaUJZMGj3Wq71rXIQWEHIJSqcMW3OQYkBdOT3Qk+CFOu24Vpb4ezwY
         wOqNVnkkmZ6DAautB23DgVZ417UHiqam/8jLGDw22+RJkQOoKiCDwVj6Cuy2EnfnLUyd
         mHWjDgUBiNB/vGh1mvJMzas+1jW56TBDUTJc2YQfRYli3k32G6/jQAXNDzr++J3nn6Nr
         D0CA==
X-Gm-Message-State: AOAM530pZhcOXEprHvUVX5G+cRj49GjtLx1WJH2dLvdh6/5BVBkgi9tU
        o5qaPSLjqbhOObhbK9jhHBmW1A==
X-Google-Smtp-Source: ABdhPJxWDA1VnKf8KPia/oEcAMqogzeQEhjaEPCX3XEi5gBiTA2Gjsjy+tCkGL+Q/p4VJTHIpWgQ7A==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr54395733wrr.201.1600673074619;
        Mon, 21 Sep 2020 00:24:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id k6sm17888651wmi.1.2020.09.21.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:24:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4 v2] sched/fair: minimize concurrent LBs between domain level
Date:   Mon, 21 Sep 2020 09:24:23 +0200
Message-Id: <20200921072424.14813-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921072424.14813-1-vincent.guittot@linaro.org>
References: <20200921072424.14813-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched domains tend to trigger simultaneously the load balance loop but
the larger domains often need more time to collect statistics. This
slowness makes the larger domain trying to detach tasks from a rq whereas
tasks already migrated somewhere else at a sub-domain level. This is not
a real problem for idle LB because the period of smaller domains will
increase with its CPUs being busy and this will let time for higher ones
to pulled tasks. But this becomes a problem when all CPUs are already busy
because all domains stay synced when they trigger their LB.

A simple way to minimize simultaneous LB of all domains is to decrement the
the busy interval by 1 jiffies. Because of the busy_factor, the interval of
larger domain will not be a multiple of smaller ones anymore.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d8320dc9d014..458702062d3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9785,6 +9785,15 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
 
 	/* scale ms to jiffies */
 	interval = msecs_to_jiffies(interval);
+
+	/*
+	 * Reduce likelihood of busy balancing at higher domains racing with
+	 * balancing at lower domains by preventing their balancing periods
+	 * from being multiples of each other.
+	 */
+	if (cpu_busy)
+		interval -= 1;
+
 	interval = clamp(interval, 1UL, max_load_balance_interval);
 
 	return interval;
-- 
2.17.1

