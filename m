Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071B12429CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHLMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:53:46 -0400
Received: from foss.arm.com ([217.140.110.172]:44704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHLMxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:53:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02891045;
        Wed, 12 Aug 2020 05:53:34 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70E713F70D;
        Wed, 12 Aug 2020 05:53:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v5 15/17] sched/topology: Mark SD_OVERLAP as SDF_NEEDS_GROUPS
Date:   Wed, 12 Aug 2020 13:52:58 +0100
Message-Id: <20200812125300.11889-16-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812125300.11889-1-valentin.schneider@arm.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sched_domain can only have overlapping sched_groups if it has more than
one group.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index f855f80f0052..021b909d3941 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -143,8 +143,9 @@ SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
  * sched_groups of this level overlap
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: Overlaps can only exist with more than one group.
  */
-SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT)
+SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Cross-node balancing
-- 
2.27.0

