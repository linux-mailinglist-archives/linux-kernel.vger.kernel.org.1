Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0151A2C45CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgKYQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:47:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbgKYQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:47:01 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB5121734;
        Wed, 25 Nov 2020 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322820;
        bh=LwuY+QphNSlol8EMRcR5P6MUxE335Jn/IU89vq73g8k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UEQiXGO1LiQRcZNYqqDzMMgbzYEaLvYuCvXYsllzOG4f5VpFTE0Q0rr3KaJUo5Qo2
         sJ/wEguzbUUZTyekvFqCmhaGzWJIXFxT5VQs5hNGxVrRPqVr0PALNx3483fb8Yl4E0
         HGsM5q/nn/W8M74o9RROCGHdvGickDon6rBNR6yY=
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
Subject: [PATCH v2 25/39] ASoC: max98925: skip of_device_id table when !CONFIG_OF
Date:   Wed, 25 Nov 2020 17:44:38 +0100
Message-Id: <20201125164452.89239-26-krzk@kernel.org>
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

  sound/soc/codecs/max98925.c:630:34: warning: ‘max98925_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98925.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index b3e1a54fff88..e18d0022c3f4 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -627,11 +627,13 @@ static const struct i2c_device_id max98925_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98925_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98925_of_match[] = {
 	{ .compatible = "maxim,max98925", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98925_of_match);
+#endif
 
 static struct i2c_driver max98925_i2c_driver = {
 	.driver = {
-- 
2.25.1

