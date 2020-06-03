Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30B01ECAF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFCIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:03:32 -0400
Received: from foss.arm.com ([217.140.110.172]:58224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEF3D6E;
        Wed,  3 Jun 2020 01:03:22 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E0B3F52E;
        Wed,  3 Jun 2020 01:03:20 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched/pelt: Remove redundant cap_scale() definition
Date:   Wed,  3 Jun 2020 10:03:01 +0200
Message-Id: <20200603080304.16548-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080304.16548-1-dietmar.eggemann@arm.com>
References: <20200603080304.16548-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides in PELT cap_scale() is used in the Deadline scheduler class for
scale-invariant bandwidth enforcement.
Remove the cap_scale() definition in kernel/sched/pelt.c and keep the
one in kernel/sched/sched.h.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/pelt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b4b1ff96642f..dea5567e4f72 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -83,8 +83,6 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 	return c1 + c2 + c3;
 }
 
-#define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
-
 /*
  * Accumulate the three separate parts of the sum; d1 the remainder
  * of the last (incomplete) period, d2 the span of full periods and d3
-- 
2.17.1

