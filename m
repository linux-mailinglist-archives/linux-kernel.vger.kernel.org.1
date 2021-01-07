Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2332ECC20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbhAGJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:00:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E43C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:00:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id r4so3138820pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgk0TCrbfrPPwCLQFrB7xrsoIfDGu1gFurEi0wsLYw0=;
        b=SVJKcvr9Izh4sNUSpK6YEtczrCVWRg6wTpG7q41qHhdCkeMm+Efzi6nwWrDDlZrzD2
         xV6UIRfzfTgjd+dQNkU9PQ9IO0xnXPiptG/pB442Ha2BDDWDopILjcKnm0cQ2FSwRmvG
         pEuPHdSbikE850NnUNOre/c2jNp6n7QVqELH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgk0TCrbfrPPwCLQFrB7xrsoIfDGu1gFurEi0wsLYw0=;
        b=mytz9Riw1B9ZJ72Uj5vFMGz0Xkzs1CmOuiQhm0iBxnQw0Z4qBFrL7ZH0kb5UU2oA3h
         7EGkGMFyYMRnVNuqaPtzTpuyp/iChRbHww0z6T2VKqUgx+oaiJrnImAslX8eSiF+qVBB
         Pyqvxg9Oh4zWYqTxvfc2dOGkRrcJ7jNnkIwuw8EvKkxKzpC8cwDKIC5UKd2fQTp0mipT
         8b/2JReKjUgBxha0Fi16Bw0pFZlSOcXJnvY3lkXYSRfQaCqvapw+zMibYAp8CYsX2NBF
         LVEiQQj132tr909rxjbIEKOldDFw0JzkBQ4SqU0DxazkcQSlGzF714nphIlsvfsMow3o
         LqAQ==
X-Gm-Message-State: AOAM533DfNc8sI5bWlZl1lVxiyLD4Hwpfx6Z6Cm9jZlB7wHsUre0TNDS
        eITeBoixiMy4yZAd97T0HA3pbiviaUjceX8x
X-Google-Smtp-Source: ABdhPJzpH4P9q/xGWMBgmLDqzAzIVGQPN/gilgSFIZSJyC2/avLxAiq63WQ/h8cZCBvxrHw4OgKCrg==
X-Received: by 2002:a17:90a:c396:: with SMTP id h22mr8438394pjt.84.1610010011464;
        Thu, 07 Jan 2021 01:00:11 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id v1sm5679450pga.63.2021.01.07.01.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 01:00:10 -0800 (PST)
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
Subject: [PATCH 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
Date:   Thu,  7 Jan 2021 16:59:42 +0800
Message-Id: <20210107085942.2891525-2-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107085942.2891525-1-yuhsuan@chromium.org>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
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
 sound/soc/codecs/cros_ec_codec.c | 7 +++++++
 1 file changed, 7 insertions(+)

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

