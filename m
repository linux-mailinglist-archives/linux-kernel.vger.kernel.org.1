Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1520D29E4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgJ2Hph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgJ2Hp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:45:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x23so906299plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rg5J52NuyGCmmE1mtIcXPCwKs4Dspg6yOxJ+mqzq0jI=;
        b=GcBbyaVpviEKwJ5P+78y2ZosN9hkzhWGP4CYU5Eqo4qFc1b8GP0n1pmTj9W600GgYd
         +lp3Ubkqsyd7xVHssjHeZSkLaI/ap1lvsq6kOvDp5HchCO6sn1WsiXjqvwXEgpCySx7u
         AiT9YMXUmTzjGKZ1udDSXYBtk0lVmSH3/96Kx4fhDb737u+lduYuqqmDUZ/q40lvbrxZ
         vuKBGhRM3OhoB8+V3WF7+Jbh3BGT/dnx4H6LaJOPMNcWi9agRtfU4Hj9fLhiCI7u1Xiw
         cvQV4awVQzrUTcQ2HpV5calW5w0js2lzWvwwLjFAQCHLEA6RRfAmGNqLmWUYZWiETZms
         Umig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rg5J52NuyGCmmE1mtIcXPCwKs4Dspg6yOxJ+mqzq0jI=;
        b=QwRQUUYXQJogqNHlVLXY0/UaXKkD/v2MYM52XBDHTczBejhoKU+QlQJPkAeRDE1Wb7
         H5ownJb41Wa0CQ2gy2q+lMUlRkDINYriB5qy3O/9sRFUGdDmya+zQ3GM8QBAEVhbARLp
         y5c0Gn169JXTPhbe/FOe5048IyZqDje0zL+nr3Giuq54Wz29GxWEDbi3c82+XhZHAvPY
         m403rfNTaEdG8ndX8IpHmD3AEZKMzBXn9JRhRgJ6M0ume2EW4rPi6E9nE1inSp43xcU1
         IaQMXylVj1XpJfOQUkDemA75SUeu2yK3dAUaaA3V+QruHSQtt9MNs3efYZbnmL6f603a
         FVHw==
X-Gm-Message-State: AOAM530/Ilw0EPKGOBIhaS1gOAEO4/o0gvFGdbLBu/bXaEypPt9xX5TY
        sA2zlHdWkjam74lJAwswW9c=
X-Google-Smtp-Source: ABdhPJxyHGcIIytk0HselO54m4ginY9+7Q4ekyHRdxzBx8YVFup8tCHFE3TtzL04LqRyU9DN8M3ICA==
X-Received: by 2002:a17:902:7882:b029:d6:38a2:8dee with SMTP id q2-20020a1709027882b02900d638a28deemr2791341pll.58.1603957527452;
        Thu, 29 Oct 2020 00:45:27 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id v3sm1709965pju.38.2020.10.29.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:45:27 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/25] ASoC: hdac_hdmi: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:53 +0800
Message-Id: <20201029074301.226644-17-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2c1305bf0572..92111561a041 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2026,7 +2026,6 @@ static void hdmi_codec_remove(struct snd_soc_component *component)
 	pm_runtime_disable(&hdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int hdmi_codec_resume(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
@@ -2049,9 +2048,6 @@ static int hdmi_codec_resume(struct device *dev)
 	hdac_hdmi_present_sense_all_pins(hdev, hdmi, false);
 	return 0;
 }
-#else
-#define hdmi_codec_resume NULL
-#endif
 
 static const struct snd_soc_component_driver hdmi_hda_codec = {
 	.probe			= hdmi_codec_probe,
-- 
2.28.0

