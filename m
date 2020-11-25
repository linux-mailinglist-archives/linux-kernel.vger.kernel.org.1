Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8022C45C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgKYQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbgKYQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:46:17 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9DB21D46;
        Wed, 25 Nov 2020 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322776;
        bh=C3hkFsDb3sE4GUFvIjYxN4SbnZ/Y/EW4EfgcLWyYLN4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WmN1WHi1nG3w9yaKinT5fZCMqNfy4vgk4lVRuuwhUNITqjEo9aYq4hxay1cmKef8z
         ozshdjWi3rwuSSW4AIxOQM0SePFsiRD1Idu0zv2/L8ek/6woXW17/HleOmJVXpA/+K
         dnzqMNqC7fplFZKcK+omCxT7g6ItDjTGZbKgOyHo=
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
Subject: [PATCH v2 15/39] ASoC: alc5623: skip of_device_id table when !CONFIG_OF
Date:   Wed, 25 Nov 2020 17:44:28 +0100
Message-Id: <20201125164452.89239-16-krzk@kernel.org>
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

  sound/soc/codecs/alc5623.c:1071:34: warning: ‘alc5623_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/alc5623.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 3d1761a531f5..54f489837162 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1068,11 +1068,13 @@ static const struct i2c_device_id alc5623_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);
 
+#ifdef CONFIG_OF
 static const struct of_device_id alc5623_of_match[] = {
 	{ .compatible = "realtek,alc5623", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, alc5623_of_match);
+#endif
 
 /*  i2c codec control layer */
 static struct i2c_driver alc5623_i2c_driver = {
-- 
2.25.1

