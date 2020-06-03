Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF89A1ECAF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFCIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:03:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A36E31B;
        Wed,  3 Jun 2020 01:03:20 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D0973F52E;
        Wed,  3 Jun 2020 01:03:18 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sched: Remove some redundancy
Date:   Wed,  3 Jun 2020 10:03:00 +0200
Message-Id: <20200603080304.16548-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant functions, parameters and macros from the task
scheduler code.

Dietmar Eggemann (4):
  sched/pelt: Remove redundant cap_scale() definition
  sched/core: Remove redundant 'preempt' param from
    sched_class->yield_to_task()
  sched/idle,stop: Remove .get_rr_interval from sched_class
  sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()

 kernel/sched/core.c      | 2 +-
 kernel/sched/fair.c      | 6 +++---
 kernel/sched/idle.c      | 7 -------
 kernel/sched/pelt.c      | 2 --
 kernel/sched/sched.h     | 2 +-
 kernel/sched/stop_task.c | 8 --------
 6 files changed, 5 insertions(+), 22 deletions(-)

-- 
2.17.1

