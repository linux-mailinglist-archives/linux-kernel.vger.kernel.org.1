Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA78924656A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHQLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 07:31:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgHQLam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A871212FC;
        Mon, 17 Aug 2020 04:30:36 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A62A3F66B;
        Mon, 17 Aug 2020 04:30:35 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 16/17] sched/topology: Mark SD_NUMA as SDF_NEEDS_GROUPS
Date:   Mon, 17 Aug 2020 12:30:02 +0100
Message-Id: <20200817113003.20802-17-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There would be no point in preserving a sched_domain with a single group
just because it has this flag set. Add it to SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 021b909d3941..71675afa55f0 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -151,5 +151,6 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  * Cross-node balancing
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
-SD_FLAG(SD_NUMA, SDF_SHARED_PARENT)
+SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
-- 
2.27.0

