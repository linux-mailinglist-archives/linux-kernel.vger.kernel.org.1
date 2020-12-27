Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB12E32CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgL0VOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgL0VOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDDQy7dR4VqTjyGIkMJC0RXLYjJAx61UAPF+/eYLlXc=;
        b=WtE3whhcmx1tWXQ0GJ+bOyaN/oSC6m2UtVkSYdPwCGSUc49o6dkl3BhagJ57cwAWrVg6nN
        SxuF1NWurddR1Z/D0DNgWq6OCWeFIF1yALGiNPYiWpaU5EsUUg+jMjN08uEKmgFvaYDPXP
        siWW0uFUzFzAR4Cis3qgKwbSwIHQcDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-gg5Kz01nPueXO-Zkk8RM5A-1; Sun, 27 Dec 2020 16:13:06 -0500
X-MC-Unique: gg5Kz01nPueXO-Zkk8RM5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D71710051A2;
        Sun, 27 Dec 2020 21:13:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F403062A23;
        Sun, 27 Dec 2020 21:13:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 11/14] extcon: arizona: Use ASoC jack input-device when available
Date:   Sun, 27 Dec 2020 22:12:29 +0100
Message-Id: <20201227211232.117801-12-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the machine driver creates an ASoC jack for jack-detect and
CONFIG_SND_JACK_INPUT_DEV is enabled then this will also create an
input-device. In this case use the already created input-device
to report button presses instead of creating a second "Headset"
input-device for the same headset.

This relies on the machine-driver setting up the jack-input-device to
report the EV_KEY key-codes configured in arizona_pdata.micd_ranges,
before registering it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 46 +++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 931a7d239aea..292ca4088418 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1376,6 +1376,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct arizona_pdata *pdata = &arizona->pdata;
+	bool using_jack_input_dev = false;
 	struct arizona_extcon_info *info;
 	unsigned int val;
 	unsigned int clamp_mode;
@@ -1453,15 +1454,28 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	info->input = devm_input_allocate_device(&pdev->dev);
-	if (!info->input) {
-		dev_err(arizona->dev, "Can't allocate input dev\n");
-		ret = -ENOMEM;
-		return ret;
-	}
+#ifdef CONFIG_SND_JACK_INPUT_DEV
+	if (arizona->jack) {
+		info->input = input_get_device(arizona->jack->jack->input_dev);
+		using_jack_input_dev = true;
+	} else
+#endif
+	{
+		info->input = devm_input_allocate_device(&pdev->dev);
+		if (!info->input) {
+			dev_err(arizona->dev, "Can't allocate input dev\n");
+			ret = -ENOMEM;
+			return ret;
+		}
 
-	info->input->name = "Headset";
-	info->input->phys = "arizona/extcon";
+		/*
+		 * balance the put in arizona_extcon_remove, which is necessary
+		 * when re-using the jack-device's input-device.
+		 */
+		input_get_device(info->input);
+		info->input->name = "Headset";
+		info->input->phys = "arizona/extcon";
+	}
 
 	if (!pdata->micd_timeout)
 		pdata->micd_timeout = DEFAULT_MICD_TIMEOUT;
@@ -1603,8 +1617,9 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 			arizona_micd_levels[j], i);
 
 		arizona_micd_set_level(arizona, i, j);
-		input_set_capability(info->input, EV_KEY,
-				     info->micd_ranges[i].key);
+		if (!using_jack_input_dev)
+			input_set_capability(info->input, EV_KEY,
+					     info->micd_ranges[i].key);
 
 		/* Enable reporting of that range */
 		regmap_update_bits(arizona->regmap, ARIZONA_MIC_DETECT_2,
@@ -1718,10 +1733,12 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		dev_warn(arizona->dev, "Failed to set MICVDD to bypass: %d\n",
 			 ret);
 
-	ret = input_register_device(info->input);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
-		goto err_hpdet;
+	if (!using_jack_input_dev) {
+		ret = input_register_device(info->input);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't register input device: %d\n", ret);
+			goto err_hpdet;
+		}
 	}
 
 	pm_runtime_put(&pdev->dev);
@@ -1792,6 +1809,7 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 			   ARIZONA_JD1_ENA, 0);
 	arizona_clk32k_disable(arizona);
 
+	input_put_device(info->input);
 	gpiod_put(info->micd_pol_gpio);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.28.0

