Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96AA2F4649
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhAMISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbhAMISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:18:36 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDCC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:17:56 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x126so766012pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSwrQDNKHkzE/dLDIoYSI3CUIjVfpzTys6BbyA061tg=;
        b=XWuA0GqQJlv9CPO1QVW/xD81wP6jUTcdIxtE7xUYoRhYAFViBwsw3vxHmiEJp6kUms
         Zf2iphER7VLdMPL9ISdkGh8XyH5marNYSPFcGwGlonvueHUD7FO2n9T/soP/jRTH1h1h
         F54mfyb5irhszfs0p/byYQnbDl6d8dXcoFyY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSwrQDNKHkzE/dLDIoYSI3CUIjVfpzTys6BbyA061tg=;
        b=DUzVzTihjJ1XmDVr3Xz5P3UpLaKaBqfla8YPHG8C7fiaXklEwbAZxzk2GmCi8ewBtx
         XzhvAphybuLfOt+B7L2/wWEzlXlsAQwcCCJhYi0Kv+/HgaRd0HaDX4w6BenTBLZAc4CF
         x0f8xLWjE4bzXHfKBCfFAWn4coDPrl2cTtaSfIqmxxXqUlui7yq5lGn472lD3mCQo7xe
         TmmEuXLMdbyle8mHV31bTjflKTnVl757M98I7uhYh5nXeU4IWE8laiO4A9dCngIrK8ot
         3lPQ77EzGkP6taU1ZUgucczRbZpLMICS2oLoj2+2wZ1auntKpeKrD5Bx+EPBePHF3Sn6
         0mFA==
X-Gm-Message-State: AOAM5334LeDM5x3YZaSRZhJ6lqhYWfqzjwOQAi8NDz0qC/mEm/7f9WAD
        m1SGUzJYeSmu0AM3JGyxHFKCGDeZa8sOf1SD
X-Google-Smtp-Source: ABdhPJwhI66piFVQyHBpPG6KmSS1fIvEVrO+IxPb3NcF8YnYVW5iAr4z92ZPdkY5o3LV+5JWa5aYzQ==
X-Received: by 2002:a63:9dc1:: with SMTP id i184mr1010816pgd.409.1610525875259;
        Wed, 13 Jan 2021 00:17:55 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id i67sm1675487pfc.153.2021.01.13.00.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:17:54 -0800 (PST)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v5] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Wed, 13 Jan 2021 16:17:45 +0800
Message-Id: <20210113081745.2543882-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not guaranteed that I2S RX is disabled when the kernel booting.
For example, if the kernel crashes while it is enabled, it will keep
enabled until the next time EC reboots. Reset I2S RX when probing to
fix this issue.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
This patch checks the return value. If it is -ENOPROTOOPT
(EC_RES_INVALID_VERSION), it will ask clients to update EC firmware.

Previous patches

v1: https://patchwork.kernel.org/project/alsa-devel/patch/20200708071117.3070707-1-yuhsuan@chromium.org/

v2: https://patchwork.kernel.org/project/alsa-devel/patch/20200716170914.3623060-1-yuhsuan@chromium.org/

v3: https://patchwork.kernel.org/project/alsa-devel/patch/20210106050559.1459027-1-yuhsuan@chromium.org/

v4: https://patchwork.kernel.org/project/alsa-devel/patch/20210107085942.2891525-2-yuhsuan@chromium.org/

 include/linux/platform_data/cros_ec_commands.h |  1 +
 sound/soc/codecs/cros_ec_codec.c               | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 86376779ab31..95889ada83a3 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4600,6 +4600,7 @@ enum ec_codec_i2s_rx_subcmd {
 	EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
 	EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
 	EC_CODEC_I2S_RX_SET_BCLK = 0x4,
+	EC_CODEC_I2S_RX_RESET = 0x5,
 	EC_CODEC_I2S_RX_SUBCMD_COUNT,
 };
 
diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index f33a2a9654e7..d35c57724b45 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1011,6 +1011,17 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	}
 	priv->ec_capabilities = r.capabilities;
 
+	/* Reset EC codec i2s rx. */
+	p.cmd = EC_CODEC_I2S_RX_RESET;
+	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	if (ret == -ENOPROTOOPT) {
+		dev_info(dev,
+			 "Command not found. Please update the EC firmware.\n");
+	} else if (ret) {
+		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
+	}
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

