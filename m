Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584912ADEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgKJSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:44:44 -0500
Received: from foss.arm.com ([217.140.110.172]:59942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJSon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:44:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB8D61063;
        Tue, 10 Nov 2020 10:44:42 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 629383F7BB;
        Tue, 10 Nov 2020 10:44:41 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/topology: Warn when NUMA diameter > 2
Date:   Tue, 10 Nov 2020 18:43:00 +0000
Message-Id: <20201110184300.15673-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA topologies where the shortest path between some two nodes requires
three or more hops (i.e. diameter > 2) end up being misrepresented in the
scheduler topology structures.

This is currently detected when booting a kernel with CONFIG_SCHED_DEBUG=y
+ sched_debug on the cmdline, although this will only yield a warning about
sched_group spans not matching sched_domain spans:

  ERROR: groups don't span domain->span

Add an explicit warning for that case, triggered regardless of
CONFIG_SCHED_DEBUG, and decorate it with an appropriate comment.

The topology described in the comment can be booted up on QEMU by appending
the following to your usual QEMU incantation:

    -smp cores=4 \
    -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
    -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
    -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
    -numa dist,src=0,dst=3,val=40, -numa dist,src=1,dst=2,val=20, \
    -numa dist,src=1,dst=3,val=30, -numa dist,src=2,dst=3,val=20

A somewhat more realistic topology (6-node mesh) with the same affliction
can be conjured with:

    -smp cores=6 \
    -numa node,cpus=0,nodeid=0 -numa node,cpus=1,nodeid=1, \
    -numa node,cpus=2,nodeid=2, -numa node,cpus=3,nodeid=3, \
    -numa node,cpus=4,nodeid=4, -numa node,cpus=5,nodeid=5, \
    -numa dist,src=0,dst=1,val=20, -numa dist,src=0,dst=2,val=30, \
    -numa dist,src=0,dst=3,val=40, -numa dist,src=0,dst=4,val=30, \
    -numa dist,src=0,dst=5,val=20, \
    -numa dist,src=1,dst=2,val=20, -numa dist,src=1,dst=3,val=30, \
    -numa dist,src=1,dst=4,val=20, -numa dist,src=1,dst=5,val=30, \
    -numa dist,src=2,dst=3,val=20, -numa dist,src=2,dst=4,val=30, \
    -numa dist,src=2,dst=5,val=40, \
    -numa dist,src=3,dst=4,val=20, -numa dist,src=3,dst=5,val=30, \
    -numa dist,src=4,dst=5,val=20

Link: https://lore.kernel.org/lkml/jhjtux5edo2.mognet@arm.com
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 90f3e5558fa2..b296c1c6b961 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,6 +675,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
+	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -706,6 +707,38 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			sd->child = NULL;
 	}
 
+	for (tmp = sd; tmp; tmp = tmp->parent)
+		numa_distance += !!(tmp->flags & SD_NUMA);
+
+	/*
+	 * FIXME: Diameter >=3 is misrepresented.
+	 *
+	 * Smallest diameter=3 topology is:
+	 *
+	 *   node   0   1   2   3
+	 *     0:  10  20  30  40
+	 *     1:  20  10  20  30
+	 *     2:  30  20  10  20
+	 *     3:  40  30  20  10
+	 *
+	 *   0 --- 1 --- 2 --- 3
+	 *
+	 * NUMA-3	0-3		N/A		N/A		0-3
+	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
+	 *
+	 * NUMA-2	0-2		0-3		0-3		1-3
+	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
+	 *
+	 * NUMA-1	0-1		0-2		1-3		2-3
+	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
+	 *
+	 * NUMA-0	0		1		2		3
+	 *
+	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
+	 * group span isn't a subset of the domain span.
+	 */
+	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
+
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
-- 
2.27.0

