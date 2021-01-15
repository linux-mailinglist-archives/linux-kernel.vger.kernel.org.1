Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC072F73E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbhAOHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbhAOHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:53:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A906C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:53:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d4so4288693plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbBZrDP4IrIPZxUvjAYid9N/Fa9d/bofmIE0flpsVB0=;
        b=Dmse58G/vKR25BWNNFJR75Iv5H2awuqE5/NF6KzNjEV+sQ0TtwrrDNUZ9dtpcBTOIi
         IHSQ7Uqlkr3OHOrWjHL0e17tkDBCrnj7zEj32Uh5tLtCJ8DLoCTj5yCtpVy2hQPKMo5G
         u9eSOHRju7b4ZwwQnSSPyWb3ltRx+vN/AjDIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbBZrDP4IrIPZxUvjAYid9N/Fa9d/bofmIE0flpsVB0=;
        b=GPE56jTKgLRMJAkUBcvKcb70r4mwsrmO6XAeGyhcNoUonjnIELgddipPb5cBYbwNUl
         +0P1WKkwDrNm30EwL5GcYVkFzPwQo49Nzm+PSD4fM05kqxlYmgUPrHGfnwauQEIwz/sT
         fIvWl9yhGvG4AyANPwy0UlJHHEU0vWBvC6SKaqK/4VvH/8OeiyI6sGQvcNBk9OIGLHZz
         hogHL/EEvfApYcp/7d6JacMp4hOXPLrWiUh2DKFxhKMOn6/VK6b5RsKZWP9ilDd3vN2b
         6GksrYV9OeK5Xu7RGAJDMgxZtzsgqAmzgEQRnfPD7Skwz77azZxqBZayWcCeVs69YqP/
         uZKQ==
X-Gm-Message-State: AOAM533WZkqIq5faer+sKwHqLEojD6B9DDXRIUZWBs4C9HNi7niqMQ9T
        ZkO5uSvP6KWspmCCa5Mxj906oyqevvZmaWch
X-Google-Smtp-Source: ABdhPJwwaXkf6UapnuX17hkLlro4eGY9ncbgFIiB2O6mEloQCt26637wgpmH7rEeVUtD0YWCLmTgGQ==
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr353390pjz.234.1610697196496;
        Thu, 14 Jan 2021 23:53:16 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id e5sm7531175pjs.0.2021.01.14.23.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 23:53:15 -0800 (PST)
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
Subject: [PATCH v7 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Fri, 15 Jan 2021 15:53:01 +0800
Message-Id: <20210115075301.47995-2-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
In-Reply-To: <20210115075301.47995-1-yuhsuan@chromium.org>
References: <20210115075301.47995-1-yuhsuan@chromium.org>
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
Updated the info message.

 sound/soc/codecs/cros_ec_codec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index f33a2a9654e7..c4772f82485a 100644
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
+			 "Missing reset command. Please update EC firmware.\n");
+	} else if (ret) {
+		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
-- 
2.30.0.296.g2bfb1c46d8-goog

