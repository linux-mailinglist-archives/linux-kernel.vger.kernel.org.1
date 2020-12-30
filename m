Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A32E7A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgL3Pob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:44:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgL3Pob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:44:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4871021D1B;
        Wed, 30 Dec 2020 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343030;
        bh=Dr9mLOW7dfuWMVS7lwdbQQhz8bsyb9ZknSWmQdtAQ50=;
        h=From:To:Cc:Subject:Date:From;
        b=pBY3tylFQvxqVhAaPPVFQMbq7vsGkynLjJ2rQxOAB0mcU8ct4N5wvdsEVCAttFypy
         AGsSpDqAV1abFnbgf/XgfjTmDMsiJocZolFIeb7Pro1rrDYC+kbsDYeM/DdrwAGnIK
         2D6uD0J6nWDcWRKXoNsikkmhiHoq8/d8hGlsgerxei3aSMwH9oPNMVIiU3x4z/JcJa
         71rrsftnWPirApCsts7sp889RZg8H3VkWoSn3q727UQIqDeOkrnhQcEmUavGxM6eT6
         KATY5Cu2nnu03RLafpxYqiJPFbiiDe2sja1nLRpUSCK/k3hPHE3G1Mb8MLQBPqspjC
         R0SMwOgQppTdg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: add MTK_PMIC_WRAP dependency
Date:   Wed, 30 Dec 2020 16:43:34 +0100
Message-Id: <20201230154345.639122-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds often show harmless warnings like

WARNING: unmet direct dependencies detected for SND_SOC_MT6359
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
  Selected by [y]:
  - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y]

Add a dependency to avoid that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 8d3dcfb6a580..effdb76369e4 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -172,7 +172,7 @@ config SND_SOC_MT8192
 config SND_SOC_MT8192_MT6359_RT1015_RT5682
 	tristate "ASoC Audio driver for MT8192 with MT6359 RT1015 RT5682 codec"
 	depends on I2C
-	depends on SND_SOC_MT8192
+	depends on SND_SOC_MT8192 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
-- 
2.29.2

