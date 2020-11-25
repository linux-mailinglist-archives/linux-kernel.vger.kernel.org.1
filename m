Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98762C45C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgKYQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbgKYQqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:46:21 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E71721D1A;
        Wed, 25 Nov 2020 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322781;
        bh=iiT953SPfN8VyA44unfiNSwE/7K2fqWVO8986O34OFE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PLXDfCUEeeIg3AO2/Y6LGIv2LCcudhIgioULsFR1yF1jK6f59FAtYRCypwScAB1ms
         gJijCxqcPUBZmLpzSxrpOccKwLKsi7+xHm63HRMwwkgQceg8/a9SYyW7QwTiKlIuDQ
         UZbvny3nK86nJSU30TotsziEqjrxRutkyvPktYDA=
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
Subject: [PATCH v2 16/39] ASoC: alc5632: skip of_device_id table when !CONFIG_OF
Date:   Wed, 25 Nov 2020 17:44:29 +0100
Message-Id: <20201125164452.89239-17-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/alc5632.c:1170:34: warning: ‘alc5632_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/alc5632.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 9d6dcd3ffa57..bde5ded67754 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1167,11 +1167,13 @@ static const struct i2c_device_id alc5632_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
 
+#ifdef CONFIG_OF
 static const struct of_device_id alc5632_of_match[] = {
 	{ .compatible = "realtek,alc5632", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, alc5632_of_match);
+#endif
 
 /* i2c codec control layer */
 static struct i2c_driver alc5632_i2c_driver = {
-- 
2.25.1

