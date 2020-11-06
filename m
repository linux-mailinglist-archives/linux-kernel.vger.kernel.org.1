Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961A12A8D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKFDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:22:19 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:22:19 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id x13so2868300pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MCR6fxf5dh6SK9Cu5TmCLk6YOZSSt4FotwiT2a01/Xo=;
        b=AfLjdy2FiymA8ZWx0aCLtMVHZk9NYJHWQRbcSiZ4i+HXu9hqI26Z7d3eJZAZmgjYBZ
         rGdfroGGG+M+Cgz8k7emJ1HdCJff0wR6Vchv/1PX/LItFTnS5c4s+4znIhOfYMQiaUGg
         M5iUtv49OnXAPLhaZ2Z7YXgUm+I2rc8lpxQYiYWIWCspGGBftMTXsmrDaqekxraoSBYX
         yZ9rxT+aGBtjyCRztX3O8J1RJslcuGS2+LTr2zLU1h51vEJp9+RvuscP1bmt1Jbcr+o/
         3PX5kPBlnkHxhD8NUK8FJm8LgKva2bmy0mKHwzfPMZPN5uh/b/KovvboP1nWbQXiAK+N
         bdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCR6fxf5dh6SK9Cu5TmCLk6YOZSSt4FotwiT2a01/Xo=;
        b=J34Z+Qa75jh4pvmIRQ1grxRH5NONTULlNUlEyDU9VlSAI0b384Yw3Gyab0xgkZ+vi4
         1yoq/lhdkILoQSsZqWkAx/pw/GOSwMDaMlV07msu4BxVgIVMjSRimxmAlg8ECuiecKTk
         +Sd0B3jqHaPaG9uKlW1SIZKQk7N4/7nWQNi41s8+IPRe0J7+VhF3ErHFI3IMU7uMRS+k
         kmD8ooJmeTtBxejdu5uk7ou6LCyzHKSlN3pfVepWGpnXEoKGXkuO9qwUegBuy5e0ujN5
         kKL94G+e1G5FVC+3ct4bYja10c03xCYkwX5ip+oU/ZxXaeEBCBmxTdXl/3SWaDTslFIB
         xfvw==
X-Gm-Message-State: AOAM530QsnzbyGe8PQtecj0QPBQoh8vpFzVMkWPl9aSxQO3QFIsSP/me
        PqmIEDugW2/YMH3lw/jeSnM=
X-Google-Smtp-Source: ABdhPJxa52DEc13eIomNEcSsrYkj6ExZK9o3vjdcMyCT+sVrkvPwev5RSdRzKA7e/dY3nrTEKPXz9w==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr4982523pgs.298.1604632939047;
        Thu, 05 Nov 2020 19:22:19 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c4sm24522pfo.62.2020.11.05.19.22.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 19:22:18 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
X-Google-Original-From: Xuewen Yan <xuewen.yan@unisoc.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, xuewyan@foxmail.com
Subject: [PATCH v3] sched: revise the initial value of the util_avg.
Date:   Fri,  6 Nov 2020 11:22:03 +0800
Message-Id: <1604632923-4243-1-git-send-email-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the original code logic:
		cfs_rq->avg.util_avg
sa->util_avg  = -------------------- * se->load.weight
		cfs_rq->avg.load_avg
but for fair_sched_class in 64bits platform:
se->load.weight = 1024 * sched_prio_to_weight[prio];
	cfs_rq->avg.util_avg
so the  -------------------- must be extremely small, the
	cfs_rq->avg.load_avg
judgment condition "sa->util_avg < cap" could be established.
It's not fair for those tasks who has smaller nice value.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
changes since V2:

*kernel/sched/fair.c | 6 +++++-
* 1 file changed, 5 insertions(+), 1 deletion(-)
*
*diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
*index 290f9e3..079760b 100644
*--- a/kernel/sched/fair.c
*+++ b/kernel/sched/fair.c
*@@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p)
*
*        if (cap > 0) {
*                if (cfs_rq->avg.util_avg != 0) {
*-                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
*+                       if (p->sched_class == &fair_sched_class)
*+                               sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
*+                       else
*+                               sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
*+
*                        sa->util_avg /= (cfs_rq->avg.load_avg + 1);
*
*                        if (sa->util_avg > cap)
*
---
comment from Vincent Guittot <vincent.guittot@linaro.org>:
>
> According to the original code logic:
>                 cfs_rq->avg.util_avg
> sa->util_avg  = -------------------- * se->load.weight
>                 cfs_rq->avg.load_avg

this should have been scale_load_down(se->load.weight) from the beginning

> but for fair_sched_class:
> se->load.weight = 1024 * sched_prio_to_weight[prio];

This is only true for 64bits platform otherwise scale_load and
scale_load_down are nop

>         cfs_rq->avg.util_avg
> so the  -------------------- must be extremely small, the
>         cfs_rq->avg.load_avg
> judgment condition "sa->util_avg < cap" could be established.
> It's not fair for those tasks who has smaller nice value.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e3..079760b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -794,7 +794,11 @@ void post_init_entity_util_avg(struct task_struct *p)
>
>         if (cap > 0) {
>                 if (cfs_rq->avg.util_avg != 0) {

We should now use cpu_util() instead of cfs_rq->avg.util_avg which
takes into account other classes

> -                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +                       if (p->sched_class == &fair_sched_class)
> +                               sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
> +                       else
> +                               sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;

Why this else keeps using se->load.weight ?

Either we uses sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
for all classes

Or we want a different init value for other classes. But in this case
se->load.weight is meaningless and we should simply set them to 0
although we could probably compute a value based on bandwidth for
deadline class.

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e3..c6186cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -794,7 +794,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
 			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
 
 			if (sa->util_avg > cap)
-- 
1.9.1

