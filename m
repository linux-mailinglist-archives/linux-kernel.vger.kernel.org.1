Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B62B8567
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKRUO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgKRUO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:14:27 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0EC2072C;
        Wed, 18 Nov 2020 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605730467;
        bh=rGgZ3MoGNY9UK+eVuOskI3M8ailaNIyq3GU90gyYATo=;
        h=From:To:Cc:Subject:Date:From;
        b=NIk81SbyPDcxK6ihFCDoIbYBZlv42tCIj1sZ0V7LL897dWlhD/L6ilPRcE5QhLW0o
         +OcYh7U/cRoIy7HqZkemuj2vkbyN2D5Ya1Tc+7OWfeyrJg1iYtpL5mo9ccGIVPWqKT
         XZjDWMO1rfrgaWhkVfZ1TfH9OBRa0m86ZEMbQyBo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] ASoC: sunxi: do not select COMMON_CLK to fix builds
Date:   Wed, 18 Nov 2020 21:14:20 +0100
Message-Id: <20201118201420.4878-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

COMMON_CLK is a user-selectable option with its own dependencies.  The
most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
should not select COMMON_CLK because they will create a dependency cycle
and build failures.  For example on MIPS a configuration with COMMON_CLK
(selected by SND_SUN8I_CODEC) and HAVE_LEGACY_CLK (selected by
SOC_RT305X) is possible:

  WARNING: unmet direct dependencies detected for COMMON_CLK
    Depends on [n]: !HAVE_LEGACY_CLK [=y]
    Selected by [y]:
    - SND_SUN8I_CODEC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
      (ARCH_SUNXI || COMPILE_TEST [=y]) && OF [=y] && (MACH_SUN8I || ARM64 && ARCH_SUNXI || COMPILE_TEST [=y])

    /usr/bin/mips-linux-gnu-ld: drivers/clk/clk.o: in function `clk_set_rate':
    (.text+0xaeb4): multiple definition of `clk_set_rate'; arch/mips/ralink/clk.o:(.text+0x88): first defined here

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Acked-by: Maxime Ripard <mripard@kernel.org>

---

Changes since v2:
1. Fix title,
2. Add Maxime's ack.

Changes since v1:
1. Do not select COMMON_CLK in arch/arm/mach-sunxi/Kconfig,
2. Add Samuel's review.
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 69b9d8515335..ddcaaa98d3cb 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -14,7 +14,7 @@ config SND_SUN8I_CODEC
 	tristate "Allwinner SUN8I audio codec"
 	depends on OF
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select COMMON_CLK
+	depends on COMMON_CLK
 	select REGMAP_MMIO
 	help
 	  This option enables the digital part of the internal audio codec for
-- 
2.25.1

