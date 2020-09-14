Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE52688F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgINKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgINKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:03:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so18003962wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=POuRZ6Ma1v/bNqRTfdqh4ySRNi4FLNcrdict4KERJBE=;
        b=S+uQEhWFa3Fnoc0LNvNm64uGJ8U8F0lFD1o2MqHsGeRKTeWoeAxGF3zGHvYYcU20Rw
         8kReqAemKjYSJomrGvnfL4IS49d4KQ5v68v0hBSZrNU5kQx8tfkQVKlOw9ckUwbRWZJy
         +VFTgs1GWc2CUlBrHN5oDIbNuvDWoiBZH/Xysvn2rvjqZqPS+2Ce3j2kk+KSEft/hGPe
         hleRNGrcjNnPYLU0xQvvoD92dvolBwYUaivjiiV1QlKeqyUl+O/E9W5t2ScxgL/5gAvE
         u9Ur9uwOL4FFbOL8IQa2yRY7+V/eLYj3a1PB+GBMXmfrVAiVejeN9iXS55kWdPNdaTij
         i6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=POuRZ6Ma1v/bNqRTfdqh4ySRNi4FLNcrdict4KERJBE=;
        b=nITZ5LSVNmEduEkCOG5GRQEPqyeoMSvLGOWAUFYe7Hafe/WnEttB7dpPA3DwFJMpDt
         fJ7hacRZXyMIOb0a9lt+5anc09oaJvKoMoSWM04v/EzUdgR5bZi4YC1AySPoOIIMRQDl
         ARodXikZWLgdOLdWGIxlkIu9TjZtMx9KsphUiPGcjFE7NMmpoc5Bzp84c3fBJUcrNkIe
         FzbqjA/UdxqPljcvyfzELgyo1gGBUIaBzX42dDSWOeAPhNs14W/+a6NW8maCFa61kXYi
         81yhWgWIqszer7DRTrfzaejpkPN2RZ4xFI4PIiDps8dVP2ajJDkqyzH7HcsxB46zeZw4
         epGQ==
X-Gm-Message-State: AOAM533og+zX2nAGrsU045HhTs0mafojCbiqmjY1uI33Mi8eASYU36Rv
        Dwd2M5j0RMIgdgiN3gQ8diBOCA==
X-Google-Smtp-Source: ABdhPJwnFjRY3SSdZHr1BtRr75CshvknuEox7Vwx6sqmquJ1ULdKVx+ZKLGCW9e0MuhaLGLsRA5PjQ==
X-Received: by 2002:adf:f245:: with SMTP id b5mr15697860wrp.288.1600077827423;
        Mon, 14 Sep 2020 03:03:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f815:527d:332f:d631])
        by smtp.gmail.com with ESMTPSA id v6sm19740795wrt.90.2020.09.14.03.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:03:46 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4] sched/fair: relax constraint on task's load during load balance
Date:   Mon, 14 Sep 2020 12:03:37 +0200
Message-Id: <20200914100340.17608-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914100340.17608-1-vincent.guittot@linaro.org>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some UCs like 9 always running tasks on 8 CPUs can't be balanced and the
load balancer currently migrates the waiting task between the CPUs in an
almost random manner. The success of a rq pulling a task depends of the
value of nr_balance_failed of its domains and its ability to be faster
than others to detach it. This behavior results in an unfair distribution
of the running time between tasks because some CPUs will run most of the
time, if not always, the same task whereas others will share their time
between several tasks.

Instead of using nr_balance_failed as a boolean to relax the condition
for detaching task, the LB will use nr_balanced_failed to relax the
threshold between the tasks'load and the imbalance. This mecanism
prevents the same rq or domain to always win the load balance fight.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..765be8273292 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7669,8 +7669,8 @@ static int detach_tasks(struct lb_env *env)
 			 * scheduler fails to find a good waiting task to
 			 * migrate.
 			 */
-			if (load/2 > env->imbalance &&
-			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
+
+			if ((load >> env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= load;
-- 
2.17.1

