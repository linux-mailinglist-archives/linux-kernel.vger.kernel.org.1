Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB012BA574
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKTJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:06:35 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:54223 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgKTJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:06:34 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 2CF9D1C404D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:06:32 +0000 (GMT)
Received: (qmail 11172 invoked from network); 20 Nov 2020 09:06:32 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 20 Nov 2020 09:06:31 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 0/4] Revisit NUMA imbalance tolerance and fork balancing
Date:   Fri, 20 Nov 2020 09:06:26 +0000
Message-Id: <20201120090630.3286-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v2
o Build fix for !NUMA_BALANCING configurations

Changelog since v1
o Split out patch that moves imbalance calculation
o Strongly connect fork imbalance considerations with adjust_numa_imbalance

When NUMA and CPU balancing were reconciled, there was an attempt to allow
a degree of imbalance but it caused more problems than it solved. Instead,
imbalance was only allowed with an almost idle NUMA domain. A lot of the
problems have since been addressed so it's time for a revisit. There is
also an issue with how fork is balanced across threads. It's mentioned
in this context as patch 3 and 4 should share similar behaviour in terms
of a nodes utilisation.

Patch 1 is just a cosmetic rename

Patch 2 moves an imbalance calculation. It is both a micro-optimisation
	and avoids confusing what imbalance means for different group
	types.

Patch 3 allows a "floating" imbalance to exist so communicating tasks can
	remain on the same domain until utilisation is higher. It aims
	to balance compute availability with memory bandwidth.

Patch 4 is the interesting one. Currently fork can allow a NUMA node
	to be completely utilised as long as there are idle CPUs until
	the load balancer gets involved. This caused serious problems
	with a real workload that unfortunately I cannot share many
	details about but there is a proxy reproducer.

-- 
2.26.2

Mel Gorman (4):
  sched/numa: Rename nr_running and break out the magic number
  sched: Avoid unnecessary calculation of load imbalance at clone time
  sched/numa: Allow a floating imbalance between NUMA nodes
  sched: Limit the amount of NUMA imbalance that can exist at fork time

 kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
2.26.2

