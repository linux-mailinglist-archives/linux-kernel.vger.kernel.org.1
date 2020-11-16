Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637012B4E87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbgKPRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgKPRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:51:50 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4599121527;
        Mon, 16 Nov 2020 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605549109;
        bh=U3gPdvUKBY4tT+mqMZ48wnhnjs8kcjcv1bwERY/jLCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBAUnKX4FWEczGUOTPVmRGx364XSwixdowHViT4Ta3zeqZ/sfFoz4dNBf01M2ZOCp
         1KE+32MMNXLQUXELs0xQ5l+uxlXeowtX8xnMNA1m3qun1hk92Y5vitWZQ+1fCPQ+hc
         8NhcVRS3/7uZUeMITlDWhUe9mGB3V+LF6G7MlwVU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/4] ASoC: stm: depend on COMMON_CLK to fix compile tests
Date:   Mon, 16 Nov 2020 18:51:32 +0100
Message-Id: <20201116175133.402553-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116175133.402553-1-krzk@kernel.org>
References: <20201116175133.402553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 I2S drivers use Common Clock Framework thus they cannot be
built on platforms without it (e.g. compile test on MIPS with RALINK and
SOC_RT305X):

    /usr/bin/mips-linux-gnu-ld: sound/soc/stm/stm32_i2s.o: in function `stm32_i2s_hw_params':
    stm32_i2s.c:(.text+0x1870): undefined reference to `clk_set_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/stm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index bbade257fe89..da1f7a16605b 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -15,6 +15,7 @@ config SND_SOC_STM32_SAI
 config SND_SOC_STM32_I2S
 	tristate "STM32 I2S interface (SPI/I2S block) support"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on COMMON_CLK
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
-- 
2.25.1

