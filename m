Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77EC2EB933
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 06:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAFFGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 00:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbhAFFGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 00:06:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CAC06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 21:06:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lj6so970179pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 21:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+jp8aijiy58DxcPOl4wMV4A6IsbTlkbWpcRF+h39no=;
        b=n6ErXUBc9DzTkG9itHjGJ+eQztJ4nFXJ0bEjylysEqFfyomIYNiuZEeopa9+2QrQFb
         dgXajEXrK3vArf7eJM0inY9jm4f6O+quKZZWNf8KY7Mu4te/M+crpoedpBfQjeo0sn2j
         W7DWx2Msdwgc239HhH7U79VtA9+bjoAJG+nBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+jp8aijiy58DxcPOl4wMV4A6IsbTlkbWpcRF+h39no=;
        b=oYMCgaD3RcGHxSAE/9bupePxN6iLSrGR3pcNj8xb9NYDLQ/me4lr+rWIpOl5REh39P
         giyxKlHA5pTNK3jugwBNvq5hxA8MOJNQc9bv7B69bwG6Oz7fi36BP1ErGcK+NyBqwqOI
         YnfUELjfuuc4oNtQCCP5iHQmIyQObmYupqwTc8Y6z8Ba0DzthxHy6yRJtZ1b/JuHqMAG
         vHccMedJfLKr4AzqvIrJ7HKfouczRvr6vW/kcUwck1Gyx/dnup4xIKBeDBmwFidGjTIm
         5RnxnMsO8I7Cee+efaSWOEg1NgKCAnIdVP0gH49TOYSJY08E5lJEHxTr8UhxY9b6n7sJ
         GClg==
X-Gm-Message-State: AOAM533fTSCwqNoTO55wsLjrbcKSdWtTD7/P0v+8Kmy4/a9Dljo/AlyU
        yTf2lYuRPNiPLz4QiV4dKLsllJL6IJp+EsUs
X-Google-Smtp-Source: ABdhPJyCbhXlMX97B3jAUFrMxSj9rBddxh5FIX/r5Xx2XIEuyf28wNRiNg+HEbpL3MWu6IcVctaf8w==
X-Received: by 2002:a17:90b:1983:: with SMTP id mv3mr2580134pjb.211.1609909567741;
        Tue, 05 Jan 2021 21:06:07 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id h16sm931002pgd.62.2021.01.05.21.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 21:06:07 -0800 (PST)
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
Subject: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Wed,  6 Jan 2021 13:05:59 +0800
Message-Id: <20210106050559.1459027-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
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
 include/linux/platform_data/cros_ec_commands.h | 1 +
 sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
 2 files changed, 8 insertions(+)

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
index f33a2a9654e7..28b3e2c48c86 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1011,6 +1011,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	}
 	priv->ec_capabilities = r.capabilities;
 
+	/* Reset EC codec i2s rx. */
+	p.cmd = EC_CODEC_I2S_RX_RESET;
+	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	if (ret)
+		dev_warn(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.29.2.729.g45daf8777d-goog

