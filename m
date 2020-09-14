Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A702688F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgINKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgINKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:03:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC477C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so18052884wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mN/9dfz0jI9nniCQh4UcqcHcKOyFhiNyFml80cJGG6U=;
        b=bKHbRKAfFnbE1ZwzswbukkTnwFCZMjK/KYdF2aRaQ2zyKVQtzs6M36UONaY06YP0sj
         Ueo36JWIEaDb+dLU3quo4KGjuI73bP1NChQ0NS9cks78zpkS3jFdu93xPAO+y8AhK3p2
         3ZKnX9+k/lAK9Fcpdl3ZIuaiUTOnmN7VzSYAT57hZyuUvyy00mS7H48OnIg7kelV0grP
         3cIZ6LU8XQApnx6l7FEamFkFGoeaB2/071o/JfN4LQuL3l562ujRZfQLrFXI/ps/mM9j
         wv/C1GS/eYfFN4u3fuHnfkDwxzqhPZ7Om1ZnhLWtYih9vPW30qA9v/mZs2xu5fgM5pRr
         uMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mN/9dfz0jI9nniCQh4UcqcHcKOyFhiNyFml80cJGG6U=;
        b=Sf+069rVU1xBJ06mZRERR0bNE4G2+3DQnvDjLr1sV9R/rofkWDACxxok++LAXYCrX2
         dMQyA/JDg8WBMTvKRvBGueiZHWJTRo0uAHQ9e0PRDu3tgfy63efgrNQW9jv6LWI5CIUl
         Y5u/vPj17IUgUhITMhrJkD9HK4FFFbdPUk13tUy/VhnCBaFLP/bqBQJuNBkPxhCVNIsG
         Knu+/7I0SHMrpTbM1adzlHoSLt6ZtziksAR043U1SPW73G/iFHetj511dH1vEM2rzrHM
         WNsBLWiRJr0XWtlrCMe7+KJnOTVBRLE088GpiYKoWOfy4wq/c8IR7HZKzZ/AT95nHM5X
         Onyg==
X-Gm-Message-State: AOAM5334nYUuqHJPQQMapqbsOUNzqJ2qYaa7YnzABmxBcxtEpK+aUI+y
        Cai+2SnOPQhVr3VYBJLMcqpUfpDiW3/VPQ==
X-Google-Smtp-Source: ABdhPJwhN35MU4oTi3LFfmwfBCgwCzUsZxTNSGI+lfQOrJ8bzBG8NO+tj6Efq5XdA/CXB5Ds5D9NqQ==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr15010373wrx.3.1600077824485;
        Mon, 14 Sep 2020 03:03:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f815:527d:332f:d631])
        by smtp.gmail.com with ESMTPSA id v6sm19740795wrt.90.2020.09.14.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:03:43 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
Date:   Mon, 14 Sep 2020 12:03:36 +0200
Message-Id: <20200914100340.17608-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system doesn't have enough cycles for all tasks, the scheduler
must ensure a fair split of those CPUs cycles between CFS tasks. The
fairness of some use cases can't be solved with a static distribution of
the tasks on the system and requires a periodic rebalancing of the system
but this dynamic behavior is not always optimal and the fair distribution
of the CPU's time is not always ensured.

The patchset improves the fairness by decreasing  the constraint for
selecting migratable tasks with the number of failed load balance. This
change enables then to decrease the imbalance threshold because 1st LB
will try to migrate tasks that fully match the imbalance.

Some tests results:

- small 2 x 4 cores arm64 system

hackbench -l (256000/#grp) -g #grp

grp    tip/sched/core         +patchset             improvement
1      1.420(+/- 11.72 %)     1.382(+/-10.50 %)     2.72 %
4      1.295(+/-  2.72 %)     1.218(+/- 2.97 %)     0.76 %
8      1.220(+/-  2.17 %)     1.218(+/- 1.60 %)     0.17 %
16     1.258(+/-  1.88 %)     1.250(+/- 1,78 %)     0.58 %


fairness tests: run always running rt-app threads
monitor the ratio between min/max work done by threads

                  v5.9-rc1             w/ patchset
9 threads  avg     78.3% (+/- 6.60%)   91.20% (+/- 2.44%)
           worst   68.6%               85.67%

11 threads avg     65.91% (+/- 8.26%)  91.34% (+/- 1.87%)
           worst   53.52%              87.26%

- large 2 nodes x 28 cores x 4 threads arm64 system

The hackbench tests that I usually run as well as the sp.C.x and lu.C.x
tests with 224 threads have not shown any difference with a mix of less
than 0.5% of improvements or regressions.

Vincent Guittot (4):
  sched/fair: relax constraint on task's load during load balance
  sched/fair: reduce minimal imbalance threshold
  sched/fair: minimize concurrent LBs between domain level
  sched/fair: reduce busy load balance interval

 kernel/sched/fair.c     | 7 +++++--
 kernel/sched/topology.c | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1

