Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053772C45A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgKYQpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbgKYQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:45:42 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A70221973;
        Wed, 25 Nov 2020 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322741;
        bh=1EoeOU1HdN3bYTNow0bWtkQGItTZBUyVz0dyrz8aCbY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dBUnr1cADQ7AtUpsu8Sixmgan9lv5nsS3af2svJgeQ/q4XlrIQ9TCNndwGMAbn5II
         iltp+YDRQQKKQnul+GxBknQRNQWSm88TJWGCYa3XdFjz5OsyHQxlbmN5fe23aGbjQ0
         WtL3FsYIjgvHZWLRKI6u0HzjgQQlPu1Whqr7IPQU=
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
Subject: [PATCH v2 07/39] ASoC: kirkwood: armada-370-db: mark OF related data as maybe unused
Date:   Wed, 25 Nov 2020 17:44:20 +0100
Message-Id: <20201125164452.89239-8-krzk@kernel.org>
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

  sound/soc/kirkwood/armada-370-db.c:137:34: warning: ‘a370db_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/kirkwood/armada-370-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index 8e44ae37ad1e..81326426da33 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -134,7 +134,7 @@ static int a370db_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(card->dev, card);
 }
 
-static const struct of_device_id a370db_dt_ids[] = {
+static const struct of_device_id a370db_dt_ids[] __maybe_unused = {
 	{ .compatible = "marvell,a370db-audio" },
 	{ },
 };
-- 
2.25.1

