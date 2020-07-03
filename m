Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58599213236
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGCDaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 23:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:30:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A335C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 20:30:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so14456172pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhHWKWz4+7rswG/cVf5u/2XBys3C/A1wtkJS52atwvM=;
        b=iaD8iCHT2tH5aaetOxDpmb+hp2NNKCSgqWir0PneWlfh4jPSqWmG3Fq/6hs0On7hGp
         gI0BLO0U6dRmbAGhJjcsNID08E0c6sOnvn+Y0TDwzf4kOTQ8/QUp/wdQzgZVNfTKxMpZ
         pED1PF+Nfrmmp0Zu8JYR/O0h5j4QoT8142OiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhHWKWz4+7rswG/cVf5u/2XBys3C/A1wtkJS52atwvM=;
        b=EV05ewFAcI5XPb9utm8rBBHjpSPVIlLwVoC8xmb/fqwD6PB1WwzKHuLlJ1UkVq0U43
         wVkyBi6XiTxCAmJgBsK7Xu4LkWwaAEx4zZiKvVTW5AxJdntveqXS8mlkKpXmZiTp/gjS
         vzzDiH6PkUrFpy5lKCJeF59+bbRLM2Y1miJ3IeWnKDLTyelHYoMKutPTxu6d0TlXotcX
         ijNaK2NXox318Z1RCUO33hjEkwgKqeRjf4TV0EJXJ0n16S8WWhjrv8aoV2ugFHX5X+6n
         l3948YrQL4pXU6iasdQ/+plrAl67QYFKe20hcLkoRK8919rmDCKMr4GLrGybCmgP/3gk
         +nEw==
X-Gm-Message-State: AOAM5324n7X3u//8ffTLP6H6a6wqbbMFqZ2g6GwuJ9jlJhovC5ziUhye
        u2aW0tekttu6yh9x5A3MhbGxjpV/CiToKQ==
X-Google-Smtp-Source: ABdhPJwOdorMAP4NfsHg8xE4MqSzD2/7knFWxWKzUNwHu1GYKFX+989l2/Yd0xXOGX/+GHWBW8hGOA==
X-Received: by 2002:a65:448c:: with SMTP id l12mr26586535pgq.234.1593747006589;
        Thu, 02 Jul 2020 20:30:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id 204sm10372466pfc.18.2020.07.02.20.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 20:30:05 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: cros_ec_codec: Log results when EC commands fail
Date:   Fri,  3 Jul 2020 11:29:48 +0800
Message-Id: <20200703032948.2185290-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log results of failed EC commands to identify a problem more easily.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8d45c628e988e..a4ab62f59efa6 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
 	if (outsize)
 		memcpy(msg->data, out, outsize);
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0)
 		goto error;
 
+	if (msg->result != EC_RES_SUCCESS) {
+		dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
+			msg->result);
+		ret = -EPROTO;
+		goto error;
+	}
+
 	if (insize)
 		memcpy(in, msg->data, insize);
 
-- 
2.27.0.212.ge8ba1cc988-goog

