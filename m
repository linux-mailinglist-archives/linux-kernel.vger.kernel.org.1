Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4F2BAFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgKTQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbgKTQS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:29 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E096223BE;
        Fri, 20 Nov 2020 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889108;
        bh=vBYEDxeWGr2WVDsaU9JoHxXG3Ni9B9eteSqn4Twg9jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuKRxDVHHqiDSgK3K+Q8DYu5DLZ23VYVwsKqijAZV4F0MQPBYnPWMKLvy/qbQxSWb
         MhwdfJAmbIh0wj5AraHRC0GcSEVUC68KnzKd+m2/9S2rWQDion/q/Y1jvDelQW7hqT
         UvzffEYzltPZ4R64ly17nm/PIMP2nPh5tw1WNJtw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/38] ASoC: uniphier: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:26 +0100
Message-Id: <20201120161653.445521-12-krzk@kernel.org>
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

  sound/soc/uniphier/aio-ld11.c:375:34: warning: ‘uniphier_aio_of_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/uniphier/evea.c:554:34: warning: ‘evea_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/uniphier/aio-ld11.c | 2 +-
 sound/soc/uniphier/aio-pxs2.c | 2 +-
 sound/soc/uniphier/evea.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 8b44f8dc4970..107dd8c15a0a 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -388,7 +388,7 @@ MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
 static struct platform_driver uniphier_aio_driver = {
 	.driver = {
 		.name = "snd-uniphier-aio-ld11",
-		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+		.of_match_table = uniphier_aio_of_match,
 	},
 	.probe    = uniphier_aio_probe,
 	.remove   = uniphier_aio_remove,
diff --git a/sound/soc/uniphier/aio-pxs2.c b/sound/soc/uniphier/aio-pxs2.c
index a1d05fe9d3c2..66e983d80c5e 100644
--- a/sound/soc/uniphier/aio-pxs2.c
+++ b/sound/soc/uniphier/aio-pxs2.c
@@ -294,7 +294,7 @@ MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
 static struct platform_driver uniphier_aio_driver = {
 	.driver = {
 		.name = "snd-uniphier-aio-pxs2",
-		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+		.of_match_table = uniphier_aio_of_match,
 	},
 	.probe    = uniphier_aio_probe,
 	.remove   = uniphier_aio_remove,
diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index d27e9ca07856..b14d52052439 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -560,7 +560,7 @@ MODULE_DEVICE_TABLE(of, evea_of_match);
 static struct platform_driver evea_codec_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(evea_of_match),
+		.of_match_table = evea_of_match,
 	},
 	.probe  = evea_probe,
 	.remove = evea_remove,
-- 
2.25.1

