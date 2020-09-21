Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD73271BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIUHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUHYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:24:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so11419028wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NzwLMiUzYzS3E7CBWH0utuK3gZR9f3C9fHHMCBfyDJ8=;
        b=OwtK4iMhSWpCfHn1wsDgSoIr0TCudCm96U8jrQwM4Os1h9hjs5i8y99Lu3PhkN8BQ8
         YPokTYS2Fh7Qg65Xn0d1LPoea6T600eSLSUVTl89mR2evHa5t9bQl1M+gzRk5EB960Ry
         ZtwsozaZGhMztBY5l0KCLqcft34UbZntySYXD7RWz0j79BGtFgwbqFMhDDZ3urX8UwHB
         Yyfq6L6Q8v3Lx3mApt5ySO4Sh8+iAphFk+oi3P4xddQ7eLFwfSI5J42ArLtbmcwwdzXj
         fnylsbAI1Dsvu75+FC9+fwvU1AyydS+LgS8u3PvqtTVq/jiDMMQTmvOfwmSb1W8wKARF
         26wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NzwLMiUzYzS3E7CBWH0utuK3gZR9f3C9fHHMCBfyDJ8=;
        b=ANmIUPtOVLSDa88lTEVG+4NYQSDDHMNJwoZfoe528Zvx2lvcIjWCtfEiJPNkWQsCOR
         FdhraKIPKDG+HMUxNmDT0JX4F8wWoXmYOX1ZFsr1XLacaHg7Yj9T6WyiJ1lrA7BTIX0w
         Q2Ojdd7Y5/YXbOVcRR1yw8ftQwnHCh5tUTrtZyJXUwLJNHG35s8S09ssYE319bHcrM1L
         9qVlVjzVbYCddvyFCzfNPNCMOsda0Lfo0sAtqCx7Ou1S00rQTJja15l5YAyG2fORmElX
         WLPmKvhl34Aq4PVfReELmNNp8a8kSngmPbDpEGjNIq3NyqMGH67AbWpp8ECbNVexZCC9
         xnPg==
X-Gm-Message-State: AOAM531WCSe3twU5ySC+/T8uWMixBxvyjE73shsW5sO18OHfxNd6SsWB
        0HmbePlz1wQExaC9VG0cSyvtX4Ut7VjB1w==
X-Google-Smtp-Source: ABdhPJzUMxdDSNlcPP27tsUtJz+69GMwARBOY9bhYg6v8xeD15PraXimvipTr1pRvj2UfH6yLn3ycA==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25mr29781412wmj.4.1600673073036;
        Mon, 21 Sep 2020 00:24:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id k6sm17888651wmi.1.2020.09.21.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:24:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/4 v2] sched/fair: reduce minimal imbalance threshold
Date:   Mon, 21 Sep 2020 09:24:22 +0200
Message-Id: <20200921072424.14813-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921072424.14813-1-vincent.guittot@linaro.org>
References: <20200921072424.14813-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 25% default imbalance threshold for DIE and NUMA domain is large
enough to generate significant unfairness between threads. A typical
example is the case of 11 threads running on 2x4 CPUs. The imbalance of
20% between the 2 groups of 4 cores is just low enough to not trigger
the load balance between the 2 groups. We will have always the same 6
threads on one group of 4 CPUs and the other 5 threads on the other
group of CPUS. With a fair time sharing in each group, we ends up with
+20% running time for the group of 5 threads.

Consider decreasing the imbalance threshold for overloaded case where we
use the load to balance task and to ensure fair time sharing.

Acked-by: Hillf Danton <hdanton@sina.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 249bec7b0a4c..41df62884cea 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1349,7 +1349,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
 		.busy_factor		= 32,
-		.imbalance_pct		= 125,
+		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
 
-- 
2.17.1

