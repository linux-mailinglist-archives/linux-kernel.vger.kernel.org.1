Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F33B27A315
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgI0T4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:56:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10061
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgI0TzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:25 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169499"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:13 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/18] clocksource/drivers/mps2-timer: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:21 +0200
Message-Id: <1601233948-11629-12-git-send-email-Julia.Lawall@inria.fr>
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
 drivers/clocksource/mps2-timer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index 2e64d984c83a..efe8cad8f2a5 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -149,9 +149,9 @@ static int __init mps2_clockevent_init(struct device_node *np)
 	ce->clkevt.rating = 200;
 	ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.cpumask = cpu_possible_mask;
-	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown,
-	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic,
-	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown,
+	ce->clkevt.set_state_shutdown	= mps2_timer_shutdown;
+	ce->clkevt.set_state_periodic	= mps2_timer_set_periodic;
+	ce->clkevt.set_state_oneshot	= mps2_timer_shutdown;
 	ce->clkevt.set_next_event	= mps2_timer_set_next_event;
 
 	/* Ensure timer is disabled */

