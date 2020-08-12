Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9833E2429CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHLMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:53:38 -0400
Received: from foss.arm.com ([217.140.110.172]:44666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgHLMxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8C611B3;
        Wed, 12 Aug 2020 05:53:30 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10C8D3F70D;
        Wed, 12 Aug 2020 05:53:28 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v5 12/17] sched/topology: Mark SD_BALANCE_WAKE as SDF_NEEDS_GROUPS
Date:   Wed, 12 Aug 2020 13:52:55 +0100
Message-Id: <20200812125300.11889-13-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812125300.11889-1-valentin.schneider@arm.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if no mainline topology uses this flag, it is a load balancing flag
just like SD_BALANCE_FORK and requires 2+ groups to have any effect.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 75c9749a6e2d..9043d18ce418 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -70,8 +70,9 @@ SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
  * Balance on wakeup
  *
  * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Consider waking task on waking CPU.
-- 
2.27.0

