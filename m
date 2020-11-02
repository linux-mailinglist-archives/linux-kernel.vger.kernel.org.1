Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482602A282E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgKBKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgKBKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:25:03 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:25:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b3so8002073wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LccT21b8oHSdfBVYfrJ2538ilnsVhQhEKgEPP8Af9QI=;
        b=e6CC0DHj91kam2bMcbp9IrayZuE8nIjy0Z3Ez39mp5B973cKikekNrdRQWGKZ+XzKr
         x1Z8ZcqhMHcnqKsAkBF8d7SRyMqB8EniMZ1UeoIwsYVEmSJTQp4YTnTz1AusysEoIaai
         xWdeC9UmltCB3mbsKsu9qTDJGLyd5RibdO8H9Rq6gtp1jWlSgp/eCRns7IgGzLjT6o3o
         mQ+a1Bis9VlBgBQWZpdOKlPUuknhPngi2CBu9U61n7M4S7ZNxJl57gghUcxoM8YyqrVZ
         YhHmyBQjyq9W4nRaM4U/L0WA8c3j5hfOOn/CjiPoDi6ck2Sc4rD1cJBD5rxXWhIsDYa5
         nXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LccT21b8oHSdfBVYfrJ2538ilnsVhQhEKgEPP8Af9QI=;
        b=umo7aCeapoOlbhRjJma6RMDhYxpPt73un5gBRJ59tZsiHoWgGbauw6niz4ADOokqVt
         BFRKB66elkdLYnlCz7QLqsCdJNTWxVID13fxb0I28TuyQWJhKwZq7Q8yA+pUtNvZJ1c0
         Pz5X1mamZ/ita/qh8y+P1cwynS/YJDwSNHIVpivYvlUxQtofzSV1gh57merQ//gaQkg3
         H61diJJJvf8h7gyTQbMvoR47RMP+AHwaikteZ/jlMbsSN4vX0vr0cIvu2mkdBm4etmqt
         xbKNCEcrxQaAdvLTlfEyGZ1/cuovvqJCPj0Iqg6U5hX0v7PlRNxnabGQkduEORfG+Ywp
         t/ZA==
X-Gm-Message-State: AOAM531eK6Eq1H4ULX8uDhPMXSQYYbrHoW7vJnDBYGMz6skIdxT27y27
        xl8g7bJrWaq0hxSKFYAK+nALcg==
X-Google-Smtp-Source: ABdhPJzePWtMiy3DvbqfzdBhT3bMxRrcQu8Scn8eC4Q9XfrpVv/waTj8EYysh3UrMIhQJc3s2MZs7A==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19091890wrq.129.1604312702103;
        Mon, 02 Nov 2020 02:25:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b16a:2491:d72d:caf1])
        by smtp.gmail.com with ESMTPSA id r18sm23696698wrj.50.2020.11.02.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:25:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, riel@surriel.com,
        clm@fb.com
Cc:     hannes@cmpxchg.org, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: ensure tasks spreading in LLC during LB
Date:   Mon,  2 Nov 2020 11:24:57 +0100
Message-Id: <20201102102457.28808-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schbench shows latency increase for 95 percentile above since:
  commit 0b0695f2b34a ("sched/fair: Rework load_balance()")

Align the behavior of the load balancer with the wake up path, which tries
to select an idle CPU which belongs to the LLC for a waking task.

calculate_imbalance() will use nr_running instead of the spare
capacity when CPUs share resources (ie cache) at the domain level. This
will ensure a better spread of tasks on idle CPUs.

Running schbench on a hikey (8cores arm64) shows the problem:

tip/sched/core :
schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
Latency percentiles (usec)
	50.0th: 33
	75.0th: 45
	90.0th: 51
	95.0th: 4152
	*99.0th: 14288
	99.5th: 14288
	99.9th: 14288
	min=0, max=14276

tip/sched/core + patch :
schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
Latency percentiles (usec)
	50.0th: 34
	75.0th: 47
	90.0th: 52
	95.0th: 78
	*99.0th: 94
	99.5th: 94
	99.9th: 94
	min=0, max=94

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
Reported-by: Chris Mason <clm@fb.com>
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..210b15f068a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9031,7 +9031,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * emptying busiest.
 	 */
 	if (local->group_type == group_has_spare) {
-		if (busiest->group_type > group_fully_busy) {
+		if ((busiest->group_type > group_fully_busy) &&
+		    !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
 			/*
 			 * If busiest is overloaded, try to fill spare
 			 * capacity. This might end up creating spare capacity
-- 
2.17.1

