Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77449271BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIUHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIUHYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:24:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769FDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so11438509wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gWiFhI616Gv0UGMaJARBw+hEmLqCOpzhidiizbQ+Cjg=;
        b=aoqSmS5BtXFngmD0yze+xUGnzS8N3IRwIGhgc5h2AdxdxdOqBqgimNHib5bDHbN7OZ
         LSHE1JW8tJ6Ds8pQyMq9/IW4oeq6VfNc1aucZqSwchTOKP6cRc6n/9nxOe1/PiH00IUe
         hNHUuIUPXx97h3ta2qm2yv63oG8lQB1/8cInntmi09nKs/vQuPkcBdiGVSQ/iBpMcubq
         1XJ43TYht/+ip9oXBHR+maGC7p7ig3cveAlPH4yAJCplsU83wi3YZp1lrO5HThdBACdq
         xZJEnjhwWhlPGshFG58IeSuvxBi4l/YlQi+h2dbpgqZA+nLYfrOwGBOdZwXaei8hxRdW
         1gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gWiFhI616Gv0UGMaJARBw+hEmLqCOpzhidiizbQ+Cjg=;
        b=jmcpU5qzNQBnwnpyuXOk7H4PlmO3cvE16QMQJikCRVq+i4rbYgGLSuGCQyobm9PG4u
         URJ3SooC/0UpU7Ix9z1xnCeUlgHjApTalNJXnixj9iVUCGR4XR8KFvcvFrr52bxBeqq9
         vqKMerCObLxlKG7Mlm6ks9Q9frde1u+r4MkK8HDu8kWE8GiYhnuWsE7U/yTuhAk3Kdsq
         xPNAmv4KAmtITge8Kx57+2qhvbIktE9kEWjiNFAVH+jUCi8RfseHO4HXK0bkwQhj7M0y
         SfObUo6oDSwaU7bLSnBqyFzxoqcFDKM/JI7rM6mOEyNT5qe1pS27DbcA8XCw2bYEH8M8
         sdwQ==
X-Gm-Message-State: AOAM5322nnylZXrq/x7SVqcXnEL2FVYfVDfozkkdal55mfSfE7G7rfXN
        Wn8D02HUcAN1ZJILZRZ3JN0Dn3DFgNX0uQ==
X-Google-Smtp-Source: ABdhPJw8bWjKSy8Ae9IQ2lOKQuyaxaj36rqV52F3WaMxjAIJ6WIpywjRKpJePRW6WQjg1Inr5yTssQ==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr29728231wmt.92.1600673069901;
        Mon, 21 Sep 2020 00:24:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:157d:a871:1ab2:f67c])
        by smtp.gmail.com with ESMTPSA id k6sm17888651wmi.1.2020.09.21.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:24:28 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4 v2] sched/fair: Improve fairness between cfs tasks
Date:   Mon, 21 Sep 2020 09:24:20 +0200
Message-Id: <20200921072424.14813-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
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

Changes for v2:
- rebased on tip/sched/core
- added comment for patch 3
- added acked and reviewed tags

Vincent Guittot (4):
  sched/fair: relax constraint on task's load during load balance
  sched/fair: reduce minimal imbalance threshold
  sched/fair: minimize concurrent LBs between domain level
  sched/fair: reduce busy load balance interval

 kernel/sched/fair.c     | 13 +++++++++++--
 kernel/sched/topology.c |  4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.17.1

