Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7435E2B4E85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbgKPRvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgKPRvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:51:42 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C562B206A1;
        Mon, 16 Nov 2020 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605549102;
        bh=tRaOz8oIAnb8ap7gOwWei+nyulQb7y67ExoivBhnKY0=;
        h=From:To:Cc:Subject:Date:From;
        b=BiOBDcmMNEC9wbBi7/e48JI42AaobEbTpFfonGI3DzD8rcrI76uns59eemyjobca0
         EKcH+VgUpsaIntiqVP6PVxYKAPFrCAIuS1lE6BlLgfw4Ymv8aqmpolCDF8asII26eB
         LqYVcT+MGoHg1wRMusFlUAX4U9KkWXayjMf+ytoI=
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
Subject: [PATCH 1/4] ASoC: meson: depend on COMMON_CLK to fix compile tests
Date:   Mon, 16 Nov 2020 18:51:30 +0100
Message-Id: <20201116175133.402553-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson SoC sound drivers use Common Clock Framework thus they cannot
be built on platforms without it (e.g. compile test on MIPS with RALINK
and SOC_RT305X):

    /usr/bin/mips-linux-gnu-ld: sound/soc/meson/aiu-encoder-spdif.o: in function `aiu_encoder_spdif_startup':
    aiu-encoder-spdif.c:(.text+0x3a0): undefined reference to `clk_set_parent'
    /usr/bin/mips-linux-gnu-ld: sound/soc/meson/axg-tdm-formatter.o: in function `axg_tdm_formatter_event':
    (.text+0x7ec): undefined reference to `clk_set_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 363dc3b1bbe4..dd8a05e61f58 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "ASoC support for Amlogic platforms"
-	depends on ARCH_MESON || COMPILE_TEST
+	depends on ARCH_MESON || COMPILE_TEST && COMMON_CLK
 
 config SND_MESON_AIU
 	tristate "Amlogic AIU"
-- 
2.25.1

