Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D657C2E6B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbgL1W4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:21 -0500
Received: from lists.gateworks.com ([108.161.130.12]:47122 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgL1Vqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:46:37 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1ku0S9-0005Zf-Nx; Mon, 28 Dec 2020 21:53:22 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH] regmap: irq: do not allow setting irq bits during ack
Date:   Mon, 28 Dec 2020 13:45:51 -0800
Message-Id: <1609191951-15590-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interrupt controllers may not de-assert their interrupt if
bits are set when acknowledging the bits that caused the interrupt.

Take care to not apply the mask to the status until we are done
acknowledging the interrupt and take care to mask the bits according
for the ack_invert state.

This is needed to avoid a stuck interrupt case for the Gateworks
System Controller which uses ack_invert. If the status has the mask
applied before clearing the bits it will end up setting bits that
are enabled but were not the cause the interrupt which will keep
the GSC from ever de-asserting its interrupt.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Laxminath Kasam <lkasam@codeaurora.org>
Cc: Robert Jones <rjones@gateworks.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/base/regmap/regmap-irq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ad5c2de..560c641 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -496,29 +496,29 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	 * doing a write per register.
 	 */
 	for (i = 0; i < data->chip->num_regs; i++) {
-		data->status_buf[i] &= ~data->mask_buf[i];
-
-		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
+		if ((data->status_buf[i] && ~data->mask_buf[i]) &&
+		    (chip->ack_base || chip->use_ack)) {
 			reg = chip->ack_base +
 				(i * map->reg_stride * data->irq_reg_stride);
 			if (chip->ack_invert)
 				ret = regmap_write(map, reg,
-						~data->status_buf[i]);
+						~data->status_buf[i] & data->mask_buf[i]);
 			else
 				ret = regmap_write(map, reg,
-						data->status_buf[i]);
+						data->status_buf[i] & ~data->mask_buf[i]);
 			if (chip->clear_ack) {
 				if (chip->ack_invert && !ret)
 					ret = regmap_write(map, reg,
-							data->status_buf[i]);
+							data->status_buf[i] & ~data->mask_buf[i]);
 				else if (!ret)
 					ret = regmap_write(map, reg,
-							~data->status_buf[i]);
+							~data->status_buf[i] & data->mask_buf[i]);
 			}
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
 		}
+		data->status_buf[i] &= ~data->mask_buf[i];
 	}
 
 	for (i = 0; i < chip->num_irqs; i++) {
-- 
2.7.4

