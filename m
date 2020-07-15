Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A6220EED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGOONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 10:13:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49490 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGOONw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:13:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D21A1A01F3;
        Wed, 15 Jul 2020 16:13:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E43AF1A0461;
        Wed, 15 Jul 2020 16:13:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 31265402E4;
        Wed, 15 Jul 2020 22:13:38 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] ASoC: simple-card-utils: Support configure pin_name for asoc_simple_init_jack
Date:   Wed, 15 Jul 2020 22:09:37 +0800
Message-Id: <1594822179-1849-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pin_name is fixed in asoc_simple_init_jack, but some driver
may use a different pin_name. So add a new parameter in
asoc_simple_init_jack for configuring pin_name.

If this parameter is NULL, then the default pin_name is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/sound/simple_card_utils.h     | 6 +++---
 sound/soc/generic/simple-card-utils.c | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index bbdd1542d6f1..86a1e956991e 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -12,9 +12,9 @@
 #include <sound/soc.h>
 
 #define asoc_simple_init_hp(card, sjack, prefix) \
-	asoc_simple_init_jack(card, sjack, 1, prefix)
+	asoc_simple_init_jack(card, sjack, 1, prefix, NULL)
 #define asoc_simple_init_mic(card, sjack, prefix) \
-	asoc_simple_init_jack(card, sjack, 0, prefix)
+	asoc_simple_init_jack(card, sjack, 0, prefix, NULL)
 
 struct asoc_simple_dai {
 	const char *name;
@@ -131,7 +131,7 @@ int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
 
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
-			       int is_hp, char *prefix);
+			       int is_hp, char *prefix, char *pin);
 int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			       struct link_info *li);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 8c54dc6710fe..b408cb5ed644 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -540,7 +540,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_parse_pin_switches);
 
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			  struct asoc_simple_jack *sjack,
-			  int is_hp, char *prefix)
+			  int is_hp, char *prefix,
+			  char *pin)
 {
 	struct device *dev = card->dev;
 	enum of_gpio_flags flags;
@@ -557,12 +558,12 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
 
 	if (is_hp) {
 		snprintf(prop, sizeof(prop), "%shp-det-gpio", prefix);
-		pin_name	= "Headphones";
+		pin_name	= pin ? pin : "Headphones";
 		gpio_name	= "Headphone detection";
 		mask		= SND_JACK_HEADPHONE;
 	} else {
 		snprintf(prop, sizeof(prop), "%smic-det-gpio", prefix);
-		pin_name	= "Mic Jack";
+		pin_name	= pin ? pin : "Mic Jack";
 		gpio_name	= "Mic detection";
 		mask		= SND_JACK_MICROPHONE;
 	}
-- 
2.27.0

