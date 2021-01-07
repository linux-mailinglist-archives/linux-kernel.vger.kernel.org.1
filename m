Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40802ECC1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAGJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:00:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DCC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:59:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so3141339plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3NaOaWtyXj/T2ptk32bEzgFjNq4o/HFyZv3dYGEEcI=;
        b=jGRRdH14K3aDVKXx595sg3CNZEVnLXEVL1uW7eWgv1MRfv8HAV1dEwfaGK6nTYzmZ7
         hD+JvAI//dEdPwfLoZ7SYh/MX5PAACUktO8REpO4hicl77QqW4BfOWvNQX8rQxvI6A2x
         /3+RKZhj3uWUAo1Qb5C35FS77lRTIRH9O52IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D3NaOaWtyXj/T2ptk32bEzgFjNq4o/HFyZv3dYGEEcI=;
        b=qzppmKGTD5QBPdHpg2w4mwhQbDjXZ7gOrt31mHF7CDmPYlgHOZDF9A/73spxcLHbtg
         zYJo8MEtgtLa4f2V+ktyBFgIimuVpuzBDGbeP+0RIlVlejakNAgeQzV0BjVlAnjo9/bo
         fEK9bHzM98bdskFKKPg8QBP/rhngF068anyg8dcNZhawnt01+/x3MknyVfBmJfwP06ft
         KOj75fokUeuxzo6kn9G50s1buBOHU//i2eezjVloTlmdDYzPppOavLcvUHSc6/e/Qq2a
         N9Do0EpxD3x4xFmBoMF8s5Gi/+fXaU8p7RAV0IoMrzHSjHkvwZdj3RqMGONQA19COpFr
         dUZQ==
X-Gm-Message-State: AOAM5326Q8zgB8Kpr52As74KCfhHlHZpgtnNd41xP5mDqgoSuJyZFyqD
        If8zk7Be0Y9QmUCMphIrNrRp0mTbQXaDUbcb
X-Google-Smtp-Source: ABdhPJyA0M2EA1aG9AE/yZzNcyq5SDQXjyuMgt6bdQxEssG6sOZsHJQebAGRuxERBk3E6lTOdfHkaA==
X-Received: by 2002:a17:902:7d94:b029:da:f673:18b9 with SMTP id a20-20020a1709027d94b02900daf67318b9mr8264217plm.37.1610009992592;
        Thu, 07 Jan 2021 00:59:52 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
        by smtp.gmail.com with ESMTPSA id w19sm5335474pgf.23.2021.01.07.00.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 00:59:51 -0800 (PST)
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
Subject: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Date:   Thu,  7 Jan 2021 16:59:41 +0800
Message-Id: <20210107085942.2891525-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
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
2.29.2.729.g45daf8777d-goog

