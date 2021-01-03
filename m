Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267322E8C5E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhACNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbhACNyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:54:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C417208C7;
        Sun,  3 Jan 2021 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609682012;
        bh=RfD85uyAyXiT/UWv6+Zq6MnRrDYD8p+2jEiLShXKqnw=;
        h=From:To:Cc:Subject:Date:From;
        b=b5xNoNt2oqW1nFjz0hNJWeaDU9FkDI+xCSEveh9Ofia7TDzsKLy/X3gdXqadTSyc3
         Z/v2pTuOzJqCnR6ZMPIE6B8ua+Zyti8cg3cEsWPseKwnW/oA/vfnPRflcFgm60Xlj7
         qeCDI4W5KX1qAcUI6+JJcM6PmxRw8AHPcOhZWeNxgOl8adr0Vn6V2BR+hv3TDEK+36
         iDZpS2kzPPlS8aPjVEB+zdS/wcxKQhbbtfK7Ugn+SP5KOXgKctsCGlKldqIp9SHM9y
         EXMw2VtnmXFjG/tNDEO6NII6kUXfEI+UIfqRgaZe/wTShVOxsaBoRNM037Do4HNl2E
         +VFo/3wdW3TZA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_aud2htx: select SND_SOC_IMX_PCM_DMA
Date:   Sun,  3 Jan 2021 14:53:17 +0100
Message-Id: <20210103135327.3630973-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver requires DMA support and fails to build
when that is disabled:

aarch64-linux-ld: sound/soc/fsl/fsl_aud2htx.o: in function `fsl_aud2htx_probe':
fsl_aud2htx.c:(.text+0x3e0): undefined reference to `imx_pcm_dma_init'

Fixes: 8a24c834c053 ("ASoC: fsl_aud2htx: Add aud2htx module driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 84db0b7b9d59..d7f30036d434 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -108,6 +108,7 @@ config SND_SOC_FSL_XCVR
 config SND_SOC_FSL_AUD2HTX
 	tristate "AUDIO TO HDMI TX module support"
 	depends on ARCH_MXC || COMPILE_TEST
+	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
 	help
 	  Say Y if you want to add AUDIO TO HDMI TX support for NXP.
 
-- 
2.29.2

