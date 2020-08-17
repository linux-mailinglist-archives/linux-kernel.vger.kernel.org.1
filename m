Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E643246566
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHQLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 07:30:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbgHQLa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E3A1063;
        Mon, 17 Aug 2020 04:30:26 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C60E3F66B;
        Mon, 17 Aug 2020 04:30:25 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 09/17] sched/topology: Remove SD_SERIALIZE degeneration special case
Date:   Mon, 17 Aug 2020 12:29:55 +0100
Message-Id: <20200817113003.20802-10-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is only a single NUMA node in the system, the only NUMA topology
level that will be generated will be NODE (identity distance), which
doesn't have SD_SERIALIZE.

This means we don't need this special case in sd_parent_degenerate(), as
having the NODE level "naturally" covers it. Thus, remove it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5f2bc99ff659..00ad7cef2ec1 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -183,11 +183,9 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 		return 0;
 
 	/* Flags needing groups don't count if only 1 group in parent */
-	if (parent->groups == parent->groups->next) {
+	if (parent->groups == parent->groups->next)
 		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
-		if (nr_node_ids == 1)
-			pflags &= ~SD_SERIALIZE;
-	}
+
 	if (~cflags & pflags)
 		return 0;
 
-- 
2.27.0

