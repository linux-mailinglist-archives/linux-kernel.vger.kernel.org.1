Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0E2F73E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbhAOHxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbhAOHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:53:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F468C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:53:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y8so4285718plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5rUWYQ53xu61NYNf2N+FFBOArG/WXlQJYbUH9t64RY=;
        b=QY5+gDN5VQmgj0lztLbKDumIK/YeAPPVjlWdL/rFU1w9qbzynU4Vphn6xB1iU6o8wW
         d5IoDMDjioobQNWqXJWuFc0WOog6d4CPrd4GdV2y738jlOKlp9d9/pGHaR3ZFLYx3KR2
         3y/AL+XvPl8lMkWBbmTwBNeNuPnSHeoVHt+Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5rUWYQ53xu61NYNf2N+FFBOArG/WXlQJYbUH9t64RY=;
        b=VfdQJcUvgMom8pyH4nfg8lpCRxmRyxhdD8Wkhg+LT3UNVI/6PuIAwdMnAIeEz0h6y7
         GRNIv+2yCIWNQ7vyFay81uWM2zl2cTuPhLzL27+LA7bcJDTlKuxoAlWCSavW9CZBgDN6
         ab0VcAVGH1Ou1ieiOIhggPwmKEQPgMMPBO4CJ0N6CADmFrx14/dt6y9ZAEzHWWwQDws3
         E7kuGZWGFTDKo9DT1Qj508G4reF+Ntt+chP7/IksXaxEKZ5jee/J+km6ISUQez5qlX74
         Y3uEwOUZWgCtUlEhE2DK6dd35qzzW3mS3Uk7EbhtQXEXyU8JybcsekBboIFAzcpQJtHP
         +o3w==
X-Gm-Message-State: AOAM532+wdDX+wnwvAQv0Q2SiYBU1ZAboS/cPvPPJoBPWjsBI5a8oPOq
        IJ3wrIg/Mtb4CBjVrsuhp2ftfoNzR3i5bokk
X-Google-Smtp-Source: ABdhPJzhirIDFWw+9irQUOwF9CKpaqpYnbavJoyZQgwKjRnVwoHcOgNCZOjMIBDbKCCCuYIQTE4C8w==
X-Received: by 2002:a17:902:c155:b029:da:9460:99a0 with SMTP id 21-20020a170902c155b02900da946099a0mr11443829plj.20.1610697189811;
        Thu, 14 Jan 2021 23:53:09 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id p3sm7113402pjg.53.2021.01.14.23.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 23:53:09 -0800 (PST)
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
Subject: [PATCH v7 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Date:   Fri, 15 Jan 2021 15:53:00 +0800
Message-Id: <20210115075301.47995-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
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
2.30.0.296.g2bfb1c46d8-goog

