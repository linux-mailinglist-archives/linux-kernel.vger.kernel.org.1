Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DD2C45CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgKYQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbgKYQqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:46:52 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BA821534;
        Wed, 25 Nov 2020 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322812;
        bh=+k60xKKTSOCYcdQsboL2M+3cBbm3IYtR2+dW8V1VbbU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PGnDsS7gMGeSJd29ZPtBL1COcOiVo5M6qrJkLCEmyhnGq1NZKdf0v6uFiQqqfVpP7
         jyaKeHsKTK0SFWIe8ttdpURvVMcxq4BBy2uGc3kGTJyW+5F1+kP6sACeC6m/zLhibu
         dU2hQ5dmH3KyjD89G++coRKfk6WrW51JnBWgBYTg=
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
Subject: [PATCH v2 23/39] ASoC: max98371: skip of_device_id table when !CONFIG_OF
Date:   Wed, 25 Nov 2020 17:44:36 +0100
Message-Id: <20201125164452.89239-24-krzk@kernel.org>
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

  sound/soc/codecs/max98371.c:411:34: warning: ‘max98371_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98371.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index dfee05f985bd..0b438303e1d5 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -408,11 +408,13 @@ static const struct i2c_device_id max98371_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max98371_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98371_of_match[] = {
 	{ .compatible = "maxim,max98371", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98371_of_match);
+#endif
 
 static struct i2c_driver max98371_i2c_driver = {
 	.driver = {
-- 
2.25.1

