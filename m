Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128CB2F5AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhANGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbhANGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:54:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8383C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:54:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my11so3483552pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 22:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYdrT8a6f0LVSrxXK4xev5Rwn6hJkcTFQFSmJHarTgc=;
        b=GPQmUe3tJSZOpSWj3nAIihyHt7k4kvtbsPU2joLTvlD2ckj0+FMJwIQQXmYl4Y0ApL
         nK5A/6/goVzYZk72RJ2l9KC1h1YLZ3G9op1AI/mHwsCm2VzGKXwkUxoSggXPNNmRP8aF
         diDUPjvT0etWQeNOwTAsQpnPeWgj6Xvt8PT+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYdrT8a6f0LVSrxXK4xev5Rwn6hJkcTFQFSmJHarTgc=;
        b=Ip34yjEdzDqvzckmARPwv14C/V6cWH15uzcr1nKpKUdUusKz0hbfDWT64dx5S9fUtA
         o/Zqo7li/sGD6FasbGltKrStxXj96uoOIHGybilE4FZ7hGalW6Paiyu1eAYmOqyGsA8J
         p/uHFhZjsl1C+w6F5tY9nqAcB+SLRPaU+VmUEUj+j+zbS7tz2A9GM8lghd83RuLhem8Z
         DEHCnpFz9+ksH483jOC0Q1TZFlT2zOjMzUrZVMofz1JGaT+5Qm9tc7LL0F5P7dzhYJnp
         0WfJaEqhTcXl0hND+iWRVF+T9PFdlZE26ApeXnvzhQyhUkVpCipYu+L6yp3ZwMhvw7kt
         DIEA==
X-Gm-Message-State: AOAM5336FeJ0QUTB4ileLziXxfE6BumeuiyZtbl7Fve/LUzozEBG62d1
        fWMifYxkD6rXF27DbaIw4Yh4m4dPa7oimmDN
X-Google-Smtp-Source: ABdhPJz5JZJR4nRH4Nfg1e1npHnVc4s7TRpx/+nEC/kJ4978coxtMnAOmGwm2zmQ1iW3USJMp89o5A==
X-Received: by 2002:a17:90b:31cc:: with SMTP id jv12mr617846pjb.213.1610607256940;
        Wed, 13 Jan 2021 22:54:16 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id a4sm4483186pgn.40.2021.01.13.22.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 22:54:16 -0800 (PST)
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
Subject: [PATCH v6 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Date:   Thu, 14 Jan 2021 14:54:00 +0800
Message-Id: <20210114065401.3498725-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
which is used for resetting the EC codec.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

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
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

