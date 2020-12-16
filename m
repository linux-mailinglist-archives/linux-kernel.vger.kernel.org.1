Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA312DBF57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgLPL1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:27:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:27:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpUwb-0003B8-76; Wed, 16 Dec 2020 11:26:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel: fix spelling mistake in Kconfig "programable" -> "programmable"
Date:   Wed, 16 Dec 2020 11:26:08 +0000
Message-Id: <20201216112608.11385-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in the Kconfig help text. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/atmel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 142373ec411a..9fe9471f4514 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -143,7 +143,7 @@ config SND_MCHP_SOC_SPDIFTX
 	  - sama7g5
 
 	  This S/PDIF TX driver is compliant with IEC-60958 standard and
-	  includes programable User Data and Channel Status fields.
+	  includes programmable User Data and Channel Status fields.
 
 config SND_MCHP_SOC_SPDIFRX
 	tristate "Microchip ASoC driver for boards using S/PDIF RX"
@@ -157,5 +157,5 @@ config SND_MCHP_SOC_SPDIFRX
 	  - sama7g5
 
 	  This S/PDIF RX driver is compliant with IEC-60958 standard and
-	  includes programable User Data and Channel Status fields.
+	  includes programmable User Data and Channel Status fields.
 endif
-- 
2.29.2

