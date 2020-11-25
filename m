Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B032C45DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgKYQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbgKYQsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:48:02 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76822145D;
        Wed, 25 Nov 2020 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322882;
        bh=rHhaaDvCI3oNFGE1+QHFB0i3vECs+/DgQ7hv/ctlhEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzW8twxNCk4GeJkwWlA0WbI44EVFTsn9/JGdItKXKkSISPUy9hwSZkj7od1gd+tqn
         5nnfDAmhOPCpjp4ThF+MqZebT+Yf4AF+V3FVtA5rXo4RuDw1aIRUVYGbgCSva491+n
         +P7xU1JYWVt1eS99Ln1PmVJssVsW/RwxqDHLlUQ4=
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
Subject: [PATCH v2 39/39] ASoC: samsung: smdk_wm8994: remove redundant of_match_ptr()
Date:   Wed, 25 Nov 2020 17:44:52 +0100
Message-Id: <20201125164452.89239-40-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() already handles properly !CONFIG_OF case, so passing
the argument via of_match_ptr() is not needed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 28d6eb14d7db..681b244d5312 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -170,7 +170,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
 	}
 
-	id = of_match_device(of_match_ptr(samsung_wm8994_of_match), &pdev->dev);
+	id = of_match_device(samsung_wm8994_of_match, &pdev->dev);
 	if (id)
 		*board = *((struct smdk_wm8994_data *)id->data);
 
-- 
2.25.1

