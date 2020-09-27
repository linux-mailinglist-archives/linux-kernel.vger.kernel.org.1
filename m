Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C827A302
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgI0Tzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:55:46 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10039
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgI0Tzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:37 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169504"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:14 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] clocksource/drivers: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:26 +0200
Message-Id: <1601233948-11629-17-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/clocksource/timer-armada-370-xp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
index edf1a46269f1..e3acc3c631b7 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -181,12 +181,12 @@ static int armada_370_xp_timer_starting_cpu(unsigned int cpu)
 		clr = TIMER0_25MHZ;
 	local_timer_ctrl_clrset(clr, set);
 
-	evt->name		= "armada_370_xp_per_cpu_tick",
+	evt->name		= "armada_370_xp_per_cpu_tick";
 	evt->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_PERIODIC;
-	evt->shift		= 32,
-	evt->rating		= 300,
-	evt->set_next_event	= armada_370_xp_clkevt_next_event,
+	evt->shift		= 32;
+	evt->rating		= 300;
+	evt->set_next_event	= armada_370_xp_clkevt_next_event;
 	evt->set_state_shutdown	= armada_370_xp_clkevt_shutdown;
 	evt->set_state_periodic	= armada_370_xp_clkevt_set_periodic;
 	evt->set_state_oneshot	= armada_370_xp_clkevt_shutdown;

