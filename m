Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9074F2CE1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgLCWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:39:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgLCWjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:39:00 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel: mchp-spdifrx needs COMMON_CLK
Date:   Thu,  3 Dec 2020 23:38:05 +0100
Message-Id: <20201203223815.1353451-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing this driver on an older platform without CONFIG_COMMON_CLK fails with

ERROR: modpost: "clk_set_min_rate" [sound/soc/atmel/snd-soc-mchp-spdifrx.ko] undefined!

Make this is a strict dependency.

Fixes: ef265c55c1ac ("ASoC: mchp-spdifrx: add driver for SPDIF RX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/atmel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index bd8854bfd2ee..142373ec411a 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -148,6 +148,7 @@ config SND_MCHP_SOC_SPDIFTX
 config SND_MCHP_SOC_SPDIFRX
 	tristate "Microchip ASoC driver for boards using S/PDIF RX"
 	depends on OF && (ARCH_AT91 || COMPILE_TEST)
+	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-- 
2.27.0

