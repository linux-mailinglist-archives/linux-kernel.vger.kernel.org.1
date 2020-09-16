Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F11F26C712
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIPSQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgIPSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:16:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5BEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:16:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so1939890pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiFIrPp4DQBnGtCxEmkSHjKyh1WtbAV+s1rsFBSqEIw=;
        b=RracI24PIbtqBZhGuaJPp3NPwyCDdn8AOd8rWRUPflnPHVdvry0MfFf+SKCCAu0xx2
         YAyqDtA/SxT67abUlFtL1i/GKuW1jLkErjQMQnuxtj72vPwz9IVeY1Hgom5wvFRoPpr3
         0wgMBHSnamI8JtH96vryAz1bVUm2LvoWFr+eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiFIrPp4DQBnGtCxEmkSHjKyh1WtbAV+s1rsFBSqEIw=;
        b=DFOoU2MNbJprnP0tkPCapXh3on8QcqlA22qdvnWOFHg5jy54Qt3Xau5mYh/SsGHuDz
         FbLXzCR+O0nEO+C7f77blNZ3EwqBDNAuEUlEuho/xkJ2+ZR7LS2mPg4lHyl7z/xEzkK8
         JSzZnobeySd8JoGmQGzkx41+hRMeQiR22DFCbHBvouEF0lXEkVpem42sM583qolqFUXH
         m2LRa8qWSCuZsdrQ83jbQ0r6Cl2S4Mc8Z5h+tdQqURTKlPNhtm4OIpEvdLVXDp+LEqoD
         hqB1DpPik9Iq3pmWA7X1ge8RGXWP2EJiJuJOCuN6PeftdzSgQRU0dnhture+d6Acdctj
         MN0A==
X-Gm-Message-State: AOAM532fNjz2Hvr+gUvWTbthl4v2ToFccqWFQ6Jf3po69KyvVido727y
        KPm3O8PGAOe+JkI+ZmbyfoN46g==
X-Google-Smtp-Source: ABdhPJxDCMtCerajjQla9DC9/rtMsEm7NoHMyC9ADXn3GWrc7JbhH40Mtb54++bGZ9palI5JY5xuIw==
X-Received: by 2002:a17:902:9697:b029:d1:e598:4001 with SMTP id n23-20020a1709029697b02900d1e5984001mr7574830plp.59.1600280182843;
        Wed, 16 Sep 2020 11:16:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id e207sm19091618pfh.171.2020.09.16.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:16:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     cychiang@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: lpass-sc7180: Add MODULE_DEVICE_TABLE
Date:   Wed, 16 Sep 2020 11:15:55 -0700
Message-Id: <20200916111545.1.I4c3758817d94c433bafeac344a395e21ea6657e3@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lpass-sc7180 driver can be built as a module but is lacking a
MODULE_DEVICE_TABLE.  This means it won't auto-load.  Fix this
oversight.

Fixes: 24caf8d9eb10 ("ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 sound/soc/qcom/lpass-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 167bf2cbc556..a8a3d8f8f567 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -200,6 +200,7 @@ static const struct of_device_id sc7180_lpass_cpu_device_id[] = {
 	{.compatible = "qcom,sc7180-lpass-cpu", .data = &sc7180_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, sc7180_lpass_cpu_device_id);
 
 static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	.driver = {
-- 
2.28.0.618.gf4bc123cb7-goog

