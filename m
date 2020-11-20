Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FBE2BAFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgKTQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgKTQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:04 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1332245D;
        Fri, 20 Nov 2020 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889084;
        bh=OO1qduGM7JZd4b8+D0eXiK7yf7RRkR84WlSSxJCGLLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jerVJXt91Ve0j/u3R5gM6PXnteJ0c2SEOMfap6QKqboL80lgydKCboqFtKEEQUT4y
         MDhVp9Gchsc5bG7w9yggKQoexWO/ZGNkuWGnZd9LiZT95OHw9hQUEOjAubGHXNQEeQ
         a+mt7+kmP6vnxQObRq+sZJQKcUPeyYamEKnIDmQI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Philipp Puschmann <p.puschmann@pironex.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/38] ASoC: tas571x: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:19 +0100
Message-Id: <20201120161653.445521-5-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/codecs/tas571x.c:892:34: warning: ‘tas571x_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/tas571x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 835a723ce5bc..1a87697eea16 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -912,7 +912,7 @@ MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
 static struct i2c_driver tas571x_i2c_driver = {
 	.driver = {
 		.name = "tas571x",
-		.of_match_table = of_match_ptr(tas571x_of_match),
+		.of_match_table = tas571x_of_match,
 	},
 	.probe = tas571x_i2c_probe,
 	.remove = tas571x_i2c_remove,
-- 
2.25.1

