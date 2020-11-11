Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE32AF72E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKKRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:06:24 -0500
Received: from muru.com ([72.249.23.125]:48078 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKKRGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:06:23 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7DAF88126;
        Wed, 11 Nov 2020 17:06:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] mfd: cpcap: Fix interrupt regression with regmap clear_ack
Date:   Wed, 11 Nov 2020 19:06:13 +0200
Message-Id: <20201111170613.46057-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack
registers"), the cpcap interrupts are no longer getting acked properly
leading to a very unresponsive device with CPUs fully loaded spinning
in the threaded IRQ handlers.

To me it looks like the clear_ack commit above actually fixed a long
standing bug in regmap_irq_thread() where we unconditionally acked the
interrupts earlier without considering ack_invert. And the issue with
cpcap started happening as we now also consider ack_invert.

Tim Harvey <tharvey@gateworks.com> tried to fix this issue earlier with
"[PATCH v2] regmap: irq: fix ack-invert", but the reading of the ack
register was considered unnecessary for just ack_invert, and we did not
have clear_ack available yet. As the cpcap irqs worked both with and
without ack_invert earlier because of the unconditional ack, the
problem remained hidden until now.

Also, looks like the earlier v3.0.8 based Motorola Android Linux kernel
does clear_ack style read-clear-write with "ireg_val & ~mreg_val" instead
of just ack_invert style write. So let's switch cpcap to use clear_ack
to fix the issue.

Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Laxminath Kasam <lkasam@codeaurora.org>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -97,7 +97,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI1,
 		.mask_base = CPCAP_REG_MIM1,
 		.use_ack = true,
-		.ack_invert = true,
+		.clear_ack = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -106,7 +106,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI2,
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
-		.ack_invert = true,
+		.clear_ack = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -115,7 +115,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_INT1,
 		.mask_base = CPCAP_REG_INTM1,
 		.use_ack = true,
-		.ack_invert = true,
+		.clear_ack = true,
 	},
 };
 
-- 
2.29.2
