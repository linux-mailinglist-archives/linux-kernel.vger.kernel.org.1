Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA12A9389
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgKFKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFKBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:01:03 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066432068E;
        Fri,  6 Nov 2020 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604656862;
        bh=KR21MC6tQ4ubi4Qt7pF1HSPbjyztwSH2K7rMVU0dpQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=tikqPYjpCTF4GHIxKiLV+fcwVjTFapIF7IGGTqqToPxtgNfOgxQ/HGQAjXV+wEHYW
         OZtgge12qScPa8t5WO5f5Cgrd2maVp4WlXfa4vEVPOhwFlmPUklhwazN5Ei/bRrqDJ
         0Z6TMx2FwgB+DLa1FC3ZStQ2Qd6fi2JU9e0SUcRo=
Received: by pali.im (Postfix)
        id 1EADD732; Fri,  6 Nov 2020 11:00:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek Behun <marek.behun@nic.cz>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Terry Zhou <bjzhou@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH] clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9
Date:   Fri,  6 Nov 2020 11:00:39 +0100
Message-Id: <20201106100039.11385-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Terry Zhou <bjzhou@marvell.com>

There is an error in the current code that the XTAL MODE
pin was set to NB MPP1_31 which should be NB MPP1_9.
The latch register of NB MPP1_9 has different offset of 0x8.

Signed-off-by: Terry Zhou <bjzhou@marvell.com>
[pali: Fix pin name in commit message]
Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 7ea8250406a6 ("clk: mvebu: Add the xtal clock for Armada 3700 SoC")
Cc: stable@vger.kernel.org

---
This patch is present in Marvell SDK and also in Marvell's kernel fork:
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/80d4cec4cef8282e5ac3aaf98ce3e68fb299a134

Konstantin Porotchkin wrote on Github that Gregory Clement was notified
about this patch, but as this patch is still not in mainline kernel I'm
sending it again for review.

In original commit message (only in commit message, not code) was
specified MPP9 pin on South Bridge, but correct is North Bridge.
---
 drivers/clk/mvebu/armada-37xx-xtal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
index e9e306d4e9af..41271351cf1f 100644
--- a/drivers/clk/mvebu/armada-37xx-xtal.c
+++ b/drivers/clk/mvebu/armada-37xx-xtal.c
@@ -13,8 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-#define NB_GPIO1_LATCH	0xC
-#define XTAL_MODE	    BIT(31)
+#define NB_GPIO1_LATCH	0x8
+#define XTAL_MODE	    BIT(9)
 
 static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
 {
-- 
2.20.1

