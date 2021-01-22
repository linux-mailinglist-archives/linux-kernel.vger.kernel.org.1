Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF3300930
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbhAVRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbhAVQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4IPvmJ7NDAIhhcWdSSNDV0Nl4JGvTfe0EqE+Qj6CHE=;
        b=EB2t+WR6y4AMH29pK9Tsk+q2GiP7HowQFqKAr4uqxs7/6g+Gn9GZzKqe3UrTVfdNTghF/B
        e4Sbx3te5ZZzWYnKI2jtEipy1e7jSNLYIAOfjLv2zLdL9h9YqXAi89JVlCBOzqNUml8o1Y
        /sL/nmnwGVDSpcPu4k3cgtll1Qpz1go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-uhbGG3n2P3SQ8pDMCmo2iw-1; Fri, 22 Jan 2021 11:41:21 -0500
X-MC-Unique: uhbGG3n2P3SQ8pDMCmo2iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7541559;
        Fri, 22 Jan 2021 16:41:19 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35F686EF46;
        Fri, 22 Jan 2021 16:41:17 +0000 (UTC)
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
Subject: [PATCH v3 03/13] extcon: arizona: Fix various races on driver unbind
Date:   Fri, 22 Jan 2021 17:40:57 +0100
Message-Id: <20210122164107.361939-4-hdegoede@redhat.com>
In-Reply-To: <20210122164107.361939-1-hdegoede@redhat.com>
References: <20210122164107.361939-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must free/disable all interrupts and cancel all pending works
before doing further cleanup.

Before this commit arizona_extcon_remove() was doing several
register writes to shut things down before disabling the IRQs
and it was cancelling only 1 of the 3 different works used.

Move all the register-writes shutting things down to after
the disabling of the IRQs and add the 2 missing
cancel_delayed_work_sync() calls.

This fixes various possible races on driver unbind. One of which
would always trigger on devices using the mic-clamp feature for
jack detection. The ARIZONA_MICD_CLAMP_MODE_MASK update was
done before disabling the IRQs, causing:
1. arizona_jackdet() to run
2. detect a jack being inserted (clamp disabled means jack inserted)
3. call arizona_start_mic() which:
3.1 Enables the MICVDD regulator
3.2 takes a pm_runtime_reference

And this was all happening after the ARIZONA_MICD_ENA bit clearing,
which would undo 3.1 and 3.2 because the ARIZONA_MICD_CLAMP_MODE_MASK
update was being done after the ARIZONA_MICD_ENA bit clearing.

So this means that arizona_extcon_remove() would exit with
1. MICVDD enabled and 2. The pm_runtime_reference being unbalanced.

MICVDD still being enabled caused the following oops when the
regulator is released by the devm framework:

[ 2850.745757] ------------[ cut here ]------------
[ 2850.745827] WARNING: CPU: 2 PID: 2098 at drivers/regulator/core.c:2123 _regulator_put.part.0+0x19f/0x1b0
[ 2850.745835] Modules linked in: extcon_arizona ...
...
[ 2850.746909] Call Trace:
[ 2850.746932]  regulator_put+0x2d/0x40
[ 2850.746946]  release_nodes+0x22a/0x260
[ 2850.746984]  __device_release_driver+0x190/0x240
[ 2850.747002]  driver_detach+0xd4/0x120
...
[ 2850.747337] ---[ end trace f455dfd7abd9781f ]---

Note this oops is just one of various theoretically possible races caused
by the wrong ordering inside arizona_extcon_remove(), this fixes the
ordering fixing all possible races, including the reported oops.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-arizona.c | 40 +++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index f7ef247de46a..76aacbac5869 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1760,25 +1760,6 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 	bool change;
 	int ret;
 
-	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				       ARIZONA_MICD_ENA, 0,
-				       &change);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to disable micd on remove: %d\n",
-			ret);
-	} else if (change) {
-		regulator_disable(info->micvdd);
-		pm_runtime_put(info->dev);
-	}
-
-	gpiod_put(info->micd_pol_gpio);
-
-	pm_runtime_disable(&pdev->dev);
-
-	regmap_update_bits(arizona->regmap,
-			   ARIZONA_MICD_CLAMP_CONTROL,
-			   ARIZONA_MICD_CLAMP_MODE_MASK, 0);
-
 	if (info->micd_clamp) {
 		jack_irq_rise = ARIZONA_IRQ_MICD_CLAMP_RISE;
 		jack_irq_fall = ARIZONA_IRQ_MICD_CLAMP_FALL;
@@ -1794,10 +1775,31 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 	arizona_free_irq(arizona, jack_irq_rise, info);
 	arizona_free_irq(arizona, jack_irq_fall, info);
 	cancel_delayed_work_sync(&info->hpdet_work);
+	cancel_delayed_work_sync(&info->micd_detect_work);
+	cancel_delayed_work_sync(&info->micd_timeout_work);
+
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, 0,
+				       &change);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to disable micd on remove: %d\n",
+			ret);
+	} else if (change) {
+		regulator_disable(info->micvdd);
+		pm_runtime_put(info->dev);
+	}
+
+	regmap_update_bits(arizona->regmap,
+			   ARIZONA_MICD_CLAMP_CONTROL,
+			   ARIZONA_MICD_CLAMP_MODE_MASK, 0);
 	regmap_update_bits(arizona->regmap, ARIZONA_JACK_DETECT_ANALOGUE,
 			   ARIZONA_JD1_ENA, 0);
 	arizona_clk32k_disable(arizona);
 
+	gpiod_put(info->micd_pol_gpio);
+
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.28.0

