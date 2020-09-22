Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D13273D72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIVIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:39:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgIVIjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:39:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DE0113E;
        Tue, 22 Sep 2020 01:39:46 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3BF43F718;
        Tue, 22 Sep 2020 01:39:43 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched/cpupri: Cleanup cpu priority vector handling
Date:   Tue, 22 Sep 2020 10:39:32 +0200
Message-Id: <20200922083934.19275-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two of the 102 elements of the cpu priority vector, among them the one
for MAX_PRIO (140) representing the IDLE task, are never used.

Remove them and adapt the cpupri implementation accordingly.

Dietmar Eggemann (2):
  sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
  sched/cpupri: Remove pri_to_cpu[1]

 kernel/sched/cpupri.c | 10 ++++------
 kernel/sched/cpupri.h |  7 +++----
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.17.1

