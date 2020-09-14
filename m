Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB752688F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgINKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgINKDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:03:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC794C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so10606279wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yn91fSMQtXXjYzpCJGdxjGF0PHHpkI83zaEiMGJXXA4=;
        b=IkwZZXdnkvXTkx/m/OzeaKCgy4z/qyIBKB74zB7sY5Stw6rU7YNeTrNGJpOA1CmUFP
         0hLk4Kn4ulZwZ5xoahzqnlNW2qG+wbZGcb6vF1O1camCWtIiisCGVF6p9cwVa19k9REx
         xeUX2zWLNVtpujycnfYqxwAWVPc0f5iIh5oAeayTSwBBf+YUcSWneAuRKJ1Kgm2uU2Xg
         bRgIGkk1KRMJemQzo6VqQi71Icc3QwCzdR80zhDLB/dZX8RDFgOz+AYCdzvRBRUhQFO4
         LGJDLjszJ23/nNtl+uMbWPAK/IqNk0KY/uZd5xqyDI7XNI0prfzLHli9xSI1OzKJlZ/5
         uOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yn91fSMQtXXjYzpCJGdxjGF0PHHpkI83zaEiMGJXXA4=;
        b=tLPxCx7g0wOTGKXtqzsVzFvYbXhVB8gikCvV5sWBH4b5arEv8hqTqQFl3roWexrV2Z
         r9QeTIyHSlJ09LDMX/W6wY1Zcsm1X4/HYPgmuY4xjfg4XphafpR5NYfknuFqH54eC5Du
         F76TVxBxIgRSXBPO3JgDo/tTAc3n8ufiYw1neeTnq806eLBujoFhWgIBpaE/JGTeeawG
         hkDU0vC9unjnsPkcVn6Pe6aYWf7fd3MzVQnB6ojGVNH6RSkSAWoFE+t9KbW9yiY52rmk
         lU8ewXqm1w8G3pJdJe8QZAcVh1njzIuPta/LyIwZb0Ft4sR9rXtwmuRaAyXj7hlaoxRu
         Ef8w==
X-Gm-Message-State: AOAM532+xWevbuaOdkLF+2x96U+aKLAAopmwV4hrtI7xCw4Y8wQjstCf
        QxgYHQ/oPQxtigHEP8BmcMdcVw==
X-Google-Smtp-Source: ABdhPJyrWcEAmuqRFM/+Bm+l/dC1ESWarr/ndoyTHWW7Gn7GI+r5LQE71HnyLh5S527meF3DXMXPmw==
X-Received: by 2002:a05:600c:1293:: with SMTP id t19mr14641655wmd.34.1600077832406;
        Mon, 14 Sep 2020 03:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f815:527d:332f:d631])
        by smtp.gmail.com with ESMTPSA id v6sm19740795wrt.90.2020.09.14.03.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:03:51 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/4] sched/fair: reduce busy load balance interval
Date:   Mon, 14 Sep 2020 12:03:40 +0200
Message-Id: <20200914100340.17608-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914100340.17608-1-vincent.guittot@linaro.org>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The busy_factor, which increases load balance interval when a cpu is busy,
is set to 32 by default. This value generates some huge LB interval on
large system like the THX2 made of 2 node x 28 cores x 4 threads.
For such system, the interval increases from 112ms to 3584ms at MC level.
And from 228ms to 7168ms at NUMA level.

Even on smaller system, a lower busy factor has shown improvement on the
fair distribution of the running time so let reduce it for all.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1a84b778755d..a8477c9e8569 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1336,7 +1336,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
-		.busy_factor		= 32,
+		.busy_factor		= 16,
 		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
-- 
2.17.1

