Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A518300917
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbhAVQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729238AbhAVQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORJXtXa88XQTcFvDJL2ttldQ8R5IGV9tOZ7MHLBYXsI=;
        b=XyMfiClaXga4BXQqSk6bWVbYYB5jMxClWw8iqr0vMiHlYk9q07DyVyQIlUZO+uoD5dgVeG
        d/w8l3gmuIqCmiVtoy105ShT0On5Vgn/Z65oSRZgRol1ZKQvV1L/lJDohAyxEGTzCIhhLv
        DS0Q3vNKieVMgwuo3JGsiu8C8NkskJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Wqn91X1XM-KqIb1776r96Q-1; Fri, 22 Jan 2021 11:41:50 -0500
X-MC-Unique: Wqn91X1XM-KqIb1776r96Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F32E8066E5;
        Fri, 22 Jan 2021 16:41:49 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7F36F12D;
        Fri, 22 Jan 2021 16:41:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 13/13] ASoC: Intel: bytcr_wm5102: Add jack detect support
Date:   Fri, 22 Jan 2021 17:41:07 +0100
Message-Id: <20210122164107.361939-14-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-1-hdegoede@redhat.com>
References: <20210122164107.361939-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jack detect support by creating a jack and calling
snd_soc_component_set_jack to register the created jack
with the codec.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index f38850eb2eaf..cdfe203ed9fa 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -31,6 +32,7 @@
 #define WM5102_MAX_SYSCLK_11025	45158400 /* max sysclk for 11.025K family */
 
 struct byt_wm5102_private {
+	struct snd_soc_jack jack;
 	struct clk *mclk;
 	struct gpio_desc *spkvdd_en_gpio;
 };
@@ -177,11 +179,23 @@ static const struct snd_kcontrol_new byt_wm5102_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static struct snd_soc_jack_pin byt_wm5102_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct byt_wm5102_private *priv = snd_soc_card_get_drvdata(card);
-	int ret;
+	struct snd_soc_component *component = asoc_rtd_to_codec(runtime, 0)->component;
+	int ret, jack_type;
 
 	card->dapm.idle_bias_off = true;
 
@@ -210,6 +224,18 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	jack_type = ARIZONA_JACK_MASK | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	ret = snd_soc_card_jack_new(card, "Headset", jack_type,
+				    &priv->jack, byt_wm5102_pins,
+				    ARRAY_SIZE(byt_wm5102_pins));
+	if (ret) {
+		dev_err(card->dev, "Error creating jack: %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_component_set_jack(component, &priv->jack, NULL);
+
 	return 0;
 }
 
-- 
2.28.0

