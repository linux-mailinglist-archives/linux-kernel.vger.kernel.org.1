Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32AC2E2EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLZQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 11:58:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:58930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgLZQ6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 11:58:31 -0500
IronPort-SDR: ejlLzO3fsECYKgJ43KYT8N4TLUzYMkPHVzkkFSCfwuCaytkIMMtnqiZitBEV+qxLp4nFNswKGW
 Z0QAjR6XLKwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="176366038"
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="176366038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 08:57:50 -0800
IronPort-SDR: yeVA8Jkk1HTu/QKswnhMcmhc3VJTYMvvPkorQbgZzomUAtsLS2joU97otEpI6M4wqFIo5SsVyX
 /vzG9e9gu0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="375042456"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Dec 2020 08:57:49 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktCt2-00026N-Tq; Sat, 26 Dec 2020 16:57:48 +0000
Date:   Sun, 27 Dec 2020 00:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH rcu] clocksource: clocksource_verify_one_cpu() can be
 static
Message-ID: <20201226165732.GA104990@9221b8c36732>
References: <202012270007.cWeTSzzT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012270007.cWeTSzzT-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 6a70298420b2 ("clocksource: Check per-CPU clock synchronization when marked unstable")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 clocksource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c455f84f130285..01b03d5f98a9cb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -217,7 +217,7 @@ static DEFINE_PER_CPU(u64, csnow_mid);
 static cpumask_t cpus_ahead;
 static cpumask_t cpus_behind;
 
-void clocksource_verify_one_cpu(void *csin)
+static void clocksource_verify_one_cpu(void *csin)
 {
 	struct clocksource *cs = (struct clocksource *)csin;
 
