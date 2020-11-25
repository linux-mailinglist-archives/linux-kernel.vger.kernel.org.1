Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE192C45DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgKYQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgKYQrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:47:53 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C5D21527;
        Wed, 25 Nov 2020 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322873;
        bh=YKAPydPIWqqjvFa7UzQnBAAVi+TGKaJPKa4etHyS8xs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NVAjy6/FqX3hdOfsp6LjLiQRewiRTxl+t/fKzEOr8932MJTyn5vokPq1VKAcYIjgc
         DKeSBi8Cqonvm/fZJk9VcuEYH2QKn45WGRZmiprSuumaaBGgjQRio6kUE/hyQSyihM
         KG7D9Jg8GJ/Rn5/tpdkgV5EHQ2MDrnQI+mbB4gBI=
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
Subject: [PATCH v2 37/39] ASoC: max98925: drop driver pm=NULL assignment
Date:   Wed, 25 Nov 2020 17:44:50 +0100
Message-Id: <20201125164452.89239-38-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to explicitly set driver .pm field to NULL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98925.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index e18d0022c3f4..ddaccc24b0cb 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -639,7 +639,6 @@ static struct i2c_driver max98925_i2c_driver = {
 	.driver = {
 		.name = "max98925",
 		.of_match_table = of_match_ptr(max98925_of_match),
-		.pm = NULL,
 	},
 	.probe  = max98925_i2c_probe,
 	.id_table = max98925_i2c_id,
-- 
2.25.1

