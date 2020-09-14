Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5474F2688F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgINKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgINKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:03:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF8AC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so4656938wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWWXll3P9hHXvqU4FkgVwouzkQOzLihPDIbWjsVtuvk=;
        b=f4NjnHtUjQ/1YLf23tEbvsbDx2orEKD5jrvR0zIXQfi+8sOZUhAZYMGb+UVY14jNT6
         Gi10cm8EEPcO8CKYnvSeXskqIAxjnpox4QVc8kPgpKLrIQUqoio48Or/aaiXJCFjHxDB
         zCoZSLzCnn902rwXHJSsHByBFIKNBzIFfQbv0IlfC6ueeprGtr4+FBl+WXeGRWGG03Ih
         dg6Rj65Acexon4SaOw25akpO8f50gupro0Jro0Dw2jPBjm5884g5nPR1/9LM4HNmvtWb
         74vcAxXBtM3dCeZrBHeI2GTRG/Sbk/QDfBhL5LnuOB+Xk9mR9Q5SPWuGEHe85MEj9nQa
         1qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWWXll3P9hHXvqU4FkgVwouzkQOzLihPDIbWjsVtuvk=;
        b=XcL61XrY63ESMNmBaHHKnfA2PqTHFgAZta/X2Br0R4Vg728FFcy46BhLn0i3QX50TU
         I6PhWVziqmnJ1VxmuTHtiJYjE3bpSWb0VsHMnPc0rjg0AIwP8aJP9rbttYm4DNitK1eF
         Yzqgr518Rz6cwaaqTR8AV5Rl9j5E2tQVg8pKayaDso34li5quUWoxMr54XM4J9ynwSRr
         Wtp1TbpLjVFHjZ0Xok+nmBLJzETKIkn4/SfhRe2Bjr791BsiCQ8RBmPytqs+pRdCA4XK
         hzNOm+gcNkjuXe8DvQj4LHo2MLyX/Vfz3SbJiO9Ak/7BhiV95cajvFWIbWKr1aq7LNf5
         xkWA==
X-Gm-Message-State: AOAM530072s3Q8tLuCk+h/LoiyhNHZGGXQ+8KdFgOItkSiQly1pH4ODd
        /k4dulgWYUFvJrGVPbHF+nyYzQ==
X-Google-Smtp-Source: ABdhPJxetsQTZLac3HZqagt5ecpzRl7dbs4bD6svOlDZAmZhfggPose3nZKa8lpx2WpXY6NK30Cv9w==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr14403165wma.18.1600077829255;
        Mon, 14 Sep 2020 03:03:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f815:527d:332f:d631])
        by smtp.gmail.com with ESMTPSA id v6sm19740795wrt.90.2020.09.14.03.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:03:48 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/4] sched/fair: reduce minimal imbalance threshold
Date:   Mon, 14 Sep 2020 12:03:38 +0200
Message-Id: <20200914100340.17608-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914100340.17608-1-vincent.guittot@linaro.org>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9079d865a935..1a84b778755d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1337,7 +1337,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
 		.busy_factor		= 32,
-		.imbalance_pct		= 125,
+		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
 
-- 
2.17.1

