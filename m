Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8092629D302
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgJ1VkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:40:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:20242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgJ1Vjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:55 -0400
IronPort-SDR: p2WUY5FPsoN25hinGtUeMPoFWAEKYu3Woztumyb5lSwESUCWLItsVihjQWG4Dzq4ChbAf77mON
 y/Lcm5K8K+uA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168419825"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="168419825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 09:36:37 -0700
IronPort-SDR: LZhFjjw25+kkY6CGc2ulC8/eDKOVTfYwDAsxRWElLzW0zg4SPfNlHNsPb7UedPU/uguEvbrToZ
 U8eY81cBV2/w==
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="536299538"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 09:36:36 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] entry: Fixup irqentry_enter() comment
Date:   Wed, 28 Oct 2020 09:36:32 -0700
Message-Id: <20201028163632.965518-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

irq_enter_from_user_mode() was changed to
irqentry_enter_from_user_mode().  Update the comment within
irqentry_enter() to reflect this change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Resend due to mail being dropped on it's way to LKML

 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0a1e20f8d4e8..ba4732b657bd 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -320,7 +320,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
-		 * as in irq_enter_from_user_mode().
+		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
-- 
2.28.0.rc0.12.gb6a658bd00c9

