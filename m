Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B801C2EAC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgECTDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 15:03:34 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:35679 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729010AbgECTDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 15:03:33 -0400
Received: from localhost.localdomain ([93.22.151.175])
        by mwinf5d76 with ME
        id aK3U2200V3nJVaM03K3Vc7; Sun, 03 May 2020 21:03:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 May 2020 21:03:30 +0200
X-ME-IP: 93.22.151.175
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: clk-xgene: Fix a typo in Kconfig
Date:   Sun,  3 May 2020 21:03:27 +0200
Message-Id: <20200503190327.153249-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Sypport/Support

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index bcb257baed06..99ddc1478493 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -252,7 +252,7 @@ config COMMON_CLK_XGENE
 	default ARCH_XGENE
 	depends on ARM64 || COMPILE_TEST
 	---help---
-	  Sypport for the APM X-Gene SoC reference, PLL, and device clocks.
+	  Support for the APM X-Gene SoC reference, PLL, and device clocks.
 
 config COMMON_CLK_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar clock driver"
-- 
2.25.1

