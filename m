Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF82E6B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgL1W4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:10 -0500
Received: from lists.gateworks.com ([108.161.130.12]:47069 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbgL1VKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:10:48 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1ktztW-0005XF-9V; Mon, 28 Dec 2020 21:17:34 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>, stable@vger.kernel.org
Subject: [PATCH] mfd: gateworks-gsc: fix interrupt type
Date:   Mon, 28 Dec 2020 13:10:04 -0800
Message-Id: <1609189804-10039-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks System Controller has an active-low interrupt.
Fix the interrupt request type.

Fixes: d85234994b2f ("mfd: Add Gateworks System Controller core driver")

Cc: <stable@vger.kernel.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/mfd/gateworks-gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index 576da62..d878767 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -234,7 +234,7 @@ static int gsc_probe(struct i2c_client *client)
 
 	ret = devm_regmap_add_irq_chip(dev, gsc->regmap, client->irq,
 				       IRQF_ONESHOT | IRQF_SHARED |
-				       IRQF_TRIGGER_FALLING, 0,
+				       IRQF_TRIGGER_LOW, 0,
 				       &gsc_irq_chip, &irq_data);
 	if (ret)
 		return ret;
-- 
2.7.4

