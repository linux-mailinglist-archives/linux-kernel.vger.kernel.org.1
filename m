Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840D2C45DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgKYQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgKYQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:47:45 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526542158C;
        Wed, 25 Nov 2020 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322864;
        bh=aJ5DCE3a/F2CE/pLLWpj1Y5grILcoc2Inrrstm95hBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYlX/PafMEt3VgLEVAFz0P25RrNHjUgEdABl3WtA2Ds496EJJKB3dD7DyxCDHHivm
         cQJR7pkxx3aOLjdfFrEsJPzjTPBybQTT1iNp9yMcypN6apYRhdYsBtq+P+cKavLXCz
         MZQ5doBRyK7VOanmEOzyikpc8z81Osji/4Uk87Vc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 35/39] ASoC: samsung: i2s: mark OF related data as maybe unused
Date:   Wed, 25 Nov 2020 17:44:48 +0100
Message-Id: <20201125164452.89239-36-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/samsung/i2s.c:1646:42: warning: ‘i2sv5_dai_type_i2s1’ defined but not used [-Wunused-const-variable=]
  sound/soc/samsung/i2s.c:1639:42: warning: ‘i2sv7_dai_type’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
---
 sound/soc/samsung/i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index df53d4ea808f..1e89f2a285a9 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1622,28 +1622,28 @@ static const struct samsung_i2s_dai_data i2sv3_dai_type = {
 	.i2s_variant_regs = &i2sv3_regs,
 };
 
-static const struct samsung_i2s_dai_data i2sv5_dai_type = {
+static const struct samsung_i2s_dai_data i2sv5_dai_type __maybe_unused = {
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
 			QUIRK_SUPPORTS_IDMA,
 	.pcm_rates = SNDRV_PCM_RATE_8000_96000,
 	.i2s_variant_regs = &i2sv3_regs,
 };
 
-static const struct samsung_i2s_dai_data i2sv6_dai_type = {
+static const struct samsung_i2s_dai_data i2sv6_dai_type __maybe_unused = {
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
 			QUIRK_SUPPORTS_TDM | QUIRK_SUPPORTS_IDMA,
 	.pcm_rates = SNDRV_PCM_RATE_8000_96000,
 	.i2s_variant_regs = &i2sv6_regs,
 };
 
-static const struct samsung_i2s_dai_data i2sv7_dai_type = {
+static const struct samsung_i2s_dai_data i2sv7_dai_type __maybe_unused = {
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR |
 			QUIRK_SUPPORTS_TDM,
 	.pcm_rates = SNDRV_PCM_RATE_8000_192000,
 	.i2s_variant_regs = &i2sv7_regs,
 };
 
-static const struct samsung_i2s_dai_data i2sv5_dai_type_i2s1 = {
+static const struct samsung_i2s_dai_data i2sv5_dai_type_i2s1 __maybe_unused = {
 	.quirks = QUIRK_PRI_6CHAN | QUIRK_NEED_RSTCLR,
 	.pcm_rates = SNDRV_PCM_RATE_8000_96000,
 	.i2s_variant_regs = &i2sv5_i2s1_regs,
-- 
2.25.1

