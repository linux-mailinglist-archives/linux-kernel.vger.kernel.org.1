Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8872C45DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbgKYQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbgKYQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:47:58 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C1F21534;
        Wed, 25 Nov 2020 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322877;
        bh=1fhDXmO08NfkJQ4t+guUAX1qFIWAvOwnwGfYMJfpCc4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UdcJYlbGXiWnAPhUZVp2zFrfDsH4wYkNaHZ8xo/+hDAjGCI/35yb77546bg5fyx6O
         QdzC+HH6ndDBzmvob9ht8o77OLKaQBjcTVhFLjxE70YQ9ytwHNPy6knTXsCFLTZUN+
         8/G8uXx9LMlmDuCYvRPfTCgK5+WWvyOaPAjXLEuQ=
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
Subject: [PATCH v2 38/39] ASoC: max98926: drop driver pm=NULL assignment
Date:   Wed, 25 Nov 2020 17:44:51 +0100
Message-Id: <20201125164452.89239-39-krzk@kernel.org>
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
 sound/soc/codecs/max98926.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 0977e541326d..f286e572263e 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -583,7 +583,6 @@ static struct i2c_driver max98926_i2c_driver = {
 	.driver = {
 		.name = "max98926",
 		.of_match_table = of_match_ptr(max98926_of_match),
-		.pm = NULL,
 	},
 	.probe	= max98926_i2c_probe,
 	.id_table = max98926_i2c_id,
-- 
2.25.1

