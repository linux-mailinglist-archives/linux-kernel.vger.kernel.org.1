Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA972F5AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhANGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:55:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA8C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:54:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be12so2437035plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK5a6fUoK9laud59EzgY0vTTWUjabBhgf/iGUHSlr84=;
        b=ELrACYWWcAWsFy2a70XpkDWOptj8AcVg7qorcWvajv2AMwMhu3dLgvWlNWA9yAtUwO
         qlx/baQm1U69k//c82xgSZFc52lIJwL4VlkEYyTtng8kq2+dumA3ewtFUmIeLMKnCeTE
         0W46BiH6SQR8uOEeCX9cvgShgGmpS4fX6LwoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK5a6fUoK9laud59EzgY0vTTWUjabBhgf/iGUHSlr84=;
        b=JsEiA3v+s3TZ7bYE4u4bZv8F6GfLiVylBdK0aOY4mHN08zBkQJlQC4bN1///0izJuM
         hwKBBejONjLJ64VRMZWs3ZslfJu+jMVXG6wajiZXuQb5sB+i2L2XL/3v+KsYc46HSAo9
         eF5q/mIOcck8ci0ojohfs65ko8tCXBPVvJbkVRCVeDIOnd2yylqTIV4cv/uih5thUUqC
         ZFF9dengQzC8bweNrwGp4TR8HFFAXBG4/EJHFRbMVWMEKaIE3OsFuARPCQmCiTdYwBNR
         iYllV/0mpk3oNtsYqcM8PvgV0d7LrDc/5dchbzpRRRxBpc+3u6ZLCVniamoaBoiFW2g1
         9k7g==
X-Gm-Message-State: AOAM530QdDcwTchexozaD/1FPzv5QP7Np4OaA6ruBBYwKV7hX62JSzx2
        IAxLIsY2+YdDkGDrcoFdBU6i1v5kkLFSVs6b
X-Google-Smtp-Source: ABdhPJwGek4x/wN2BRK4FinpqyikVPDyQ39T9E6PbUP4yc13Tx1iATTT1z6JizyDQy/mmyJuFruMbw==
X-Received: by 2002:a17:903:22c2:b029:de:45c0:69f2 with SMTP id y2-20020a17090322c2b02900de45c069f2mr3473606plg.26.1610607264230;
        Wed, 13 Jan 2021 22:54:24 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id w9sm4182032pfj.128.2021.01.13.22.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 22:54:23 -0800 (PST)
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
Subject: [PATCH v6 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Thu, 14 Jan 2021 14:54:01 +0800
Message-Id: <20210114065401.3498725-2-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210114065401.3498725-1-yuhsuan@chromium.org>
References: <20210114065401.3498725-1-yuhsuan@chromium.org>
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
Returns the error code when it fails to reset.

 sound/soc/codecs/cros_ec_codec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index f33a2a9654e7..40e437aa1d55 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -1011,6 +1011,18 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
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
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

