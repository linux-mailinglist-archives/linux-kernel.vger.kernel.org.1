Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB71E2E32CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgL0VOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgL0VOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuEkoy8risjXWW3C4tHd58C62AQQjBX95B2fmp+oAVw=;
        b=bJ8QbkKKa1kU9nF+CGVm4HOGEqKgsnK46Ko+ok7AJaTI/0x2t5zluAY7DLIUpsu2dwj6zW
        PVWJVR6uSfwodjIpbU4sEO2DmWh4wCgN0n3Z289H85EgFZLKOpLI37V9LT9Zri1YwLJLIT
        utXb9Gfh0x9chiH3SKilnjavpVcrTa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-4kPUDcs5OTa3Hf9uLhBJXw-1; Sun, 27 Dec 2020 16:13:03 -0500
X-MC-Unique: 4kPUDcs5OTa3Hf9uLhBJXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA2D801A9E;
        Sun, 27 Dec 2020 21:13:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EF901ACB9;
        Sun, 27 Dec 2020 21:12:59 +0000 (UTC)
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
Subject: [PATCH 10/14] extcon: arizona: Also report jack state through snd_soc_jack_report()
Date:   Sun, 27 Dec 2020 22:12:28 +0100
Message-Id: <20201227211232.117801-11-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Arizona driver uses the MFD framework to create several
sub-devices for the Arizona codec and then uses a driver per function.

The extcon-arizona driver handles jack-detect support and exports info
about the jack state to userspace through the standard extcon sysfs
class interface.

Standard Linux userspace does not monitor/use the extcon sysfs interface
for jack-detection, resulting in the jack-state not being taken into
account by userspace.

The ASoC machine-driver may have created a standard ASoC jack when
registering the card. In this case also report the jack-state through the
ASoC jack so that jack-detection works with standard Linux userspace.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index d5b3231744f9..931a7d239aea 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -20,6 +20,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/extcon-provider.h>
 
+#include <sound/jack.h>
 #include <sound/soc.h>
 
 #include <linux/mfd/arizona/core.h>
@@ -598,11 +599,19 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
 static void arizona_set_extcon_state(struct arizona_extcon_info *info,
 				     unsigned int id, bool state)
 {
-	int ret;
+	int ret, mask = 0;
 
 	ret = extcon_set_state_sync(info->edev, id, state);
 	if (ret)
 		dev_err(info->arizona->dev, "Failed to set extcon state: %d\n", ret);
+
+	switch (id) {
+	case EXTCON_JACK_HEADPHONE:	mask = SND_JACK_HEADPHONE;	break;
+	case EXTCON_JACK_MICROPHONE:	mask = SND_JACK_MICROPHONE;	break;
+	}
+
+	if (info->arizona->jack && mask)
+		snd_soc_jack_report(info->arizona->jack, state ? mask : 0, mask);
 }
 
 static irqreturn_t arizona_hpdet_irq(int irq, void *data)
-- 
2.28.0

