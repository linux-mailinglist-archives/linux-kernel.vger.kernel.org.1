Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6E2FDC37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbhATWFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:05:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:42461 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbhATWD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:03:27 -0500
IronPort-SDR: YpRaqPnH6Awni8J8qGHiJTSMU281t09eGFikBdTC9WDbUe8V/jgRSb4QY0PM9Io0J9o67S5XMg
 7AaBJAZBy1aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158362791"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="158362791"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 14:02:50 -0800
IronPort-SDR: EYKkP5ZOITRDSV++u72NJfM6ECXa5z9c5+lRxuJyv+pWlkYqSMnDPwB/LizzSCKm8bjjBV7Jd/
 vdlZXF/5/TzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="351241629"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2021 14:02:47 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2LYs-00061Q-Gz; Wed, 20 Jan 2021 22:02:46 +0000
Date:   Thu, 21 Jan 2021 06:01:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org
Subject: [RFC PATCH] sched/fair: __refill_cfs_bandwidth_runtime() can be
 static
Message-ID: <20210120220158.GA48439@379ff2649fda>
References: <20210120122715.29493-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120122715.29493-3-changhuaixin@linux.alibaba.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8be4651ae482dc..bf2259494136b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4620,7 +4620,7 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  *
  * requires cfs_b->lock
  */
-void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
+static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
 {
 	u64 refill;
 
