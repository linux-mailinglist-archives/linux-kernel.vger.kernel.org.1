Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA02E32CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgL0VOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgL0VOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQxH9sfLP7XIGfK19mSlNx10DBn63OAUabiHWwiQZDU=;
        b=U/5BFl3cJogmwWFz5vmvu8ofQeY7J36p6FVNG8t/S8g5jq0tRjDqFvCFwPl8nQjt65mnCZ
        S7NCDLDfa8+d228poE0Z/3VPlChVSme0FHCI/007lfQHnZnRYqYcHENsOb/jldA7E5VdRN
        fS0LXcMY4/BITG3GZj7FZZomQqjqL/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Zx5DIo6UMRCFaw8hnoxYng-1; Sun, 27 Dec 2020 16:13:00 -0500
X-MC-Unique: Zx5DIo6UMRCFaw8hnoxYng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373811800D42;
        Sun, 27 Dec 2020 21:12:59 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08FFF1ACB9;
        Sun, 27 Dec 2020 21:12:56 +0000 (UTC)
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
Subject: [PATCH 09/14] extcon: arizona: Add arizona_set_extcon_state() helper
Date:   Sun, 27 Dec 2020 22:12:27 +0100
Message-Id: <20201227211232.117801-10-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the callers of extcon_set_state_sync() log an error on failure,
without doing any further error-handling (as there is nothing they
can do about the error).

Factor this out into a helper to remove some duplicate code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 47 ++++++++++++---------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 145ca5cd40d5..d5b3231744f9 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -595,6 +595,16 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
 	return 0;
 }
 
+static void arizona_set_extcon_state(struct arizona_extcon_info *info,
+				     unsigned int id, bool state)
+{
+	int ret;
+
+	ret = extcon_set_state_sync(info->edev, id, state);
+	if (ret)
+		dev_err(info->arizona->dev, "Failed to set extcon state: %d\n", ret);
+}
+
 static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 {
 	struct arizona_extcon_info *info = data;
@@ -648,11 +658,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	else
 		report = EXTCON_JACK_HEADPHONE;
 
-	ret = extcon_set_state_sync(info->edev, report, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report HP/line: %d\n",
-			ret);
-
+	arizona_set_extcon_state(info, report, true);
 done:
 	/* Reset back to starting range */
 	regmap_update_bits(arizona->regmap,
@@ -727,9 +733,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	pm_runtime_put_autosuspend(info->dev);
 
 	/* Just report headphone */
-	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report headphone: %d\n", ret);
+	arizona_set_extcon_state(info, EXTCON_JACK_HEADPHONE, true);
 
 	if (info->mic)
 		arizona_start_mic(info);
@@ -781,10 +785,7 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
 
 err:
 	/* Just report headphone */
-	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report headphone: %d\n", ret);
-
+	arizona_set_extcon_state(info, EXTCON_JACK_HEADPHONE, true);
 	info->hpdet_active = false;
 }
 
@@ -904,11 +905,7 @@ static int arizona_micdet_reading(void *priv)
 
 		arizona_identify_headphone(info);
 
-		ret = extcon_set_state_sync(info->edev,
-					      EXTCON_JACK_MICROPHONE, true);
-		if (ret != 0)
-			dev_err(arizona->dev, "Headset report failed: %d\n",
-				ret);
+		arizona_set_extcon_state(info, EXTCON_JACK_MICROPHONE, true);
 
 		/* Don't need to regulate for button detection */
 		ret = regulator_allow_bypass(info->micvdd, true);
@@ -1175,12 +1172,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 
 	if (info->last_jackdet == present) {
 		dev_dbg(arizona->dev, "Detected jack\n");
-		ret = extcon_set_state_sync(info->edev,
-					      EXTCON_MECHANICAL, true);
-
-		if (ret != 0)
-			dev_err(arizona->dev, "Mechanical report failed: %d\n",
-				ret);
+		arizona_set_extcon_state(info, EXTCON_MECHANICAL, true);
 
 		info->detecting = true;
 		info->mic = false;
@@ -1216,13 +1208,8 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 					 info->micd_ranges[i].key, 0);
 		input_sync(info->input);
 
-		for (i = 0; i < ARRAY_SIZE(arizona_cable) - 1; i++) {
-			ret = extcon_set_state_sync(info->edev,
-					arizona_cable[i], false);
-			if (ret != 0)
-				dev_err(arizona->dev,
-					"Removal report failed: %d\n", ret);
-		}
+		for (i = 0; i < ARRAY_SIZE(arizona_cable) - 1; i++)
+			arizona_set_extcon_state(info, arizona_cable[i], false);
 
 		/*
 		 * If the jack was removed during a headphone detection we
-- 
2.28.0

