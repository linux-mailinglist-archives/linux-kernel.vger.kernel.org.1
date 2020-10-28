Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48E529D9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbgJ1XE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbgJ1XEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:04:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:04:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a9so756668wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hM0rbzQPb+TSKGempjX+VBzQUrYZY3aGqxwljGgjo5M=;
        b=aZt+HicBEZUhf1884Lhve5iIj5FxIs951qs6/RcYAfsIlyP5AhUCCaZoNeXvkBvEW4
         mNIk49OTpJklyL9GuEQJEykqsB7a9Umm1Q21c+k5o+yhKaVwCaDDvtf9wAR5pF4L6tFY
         otg2wpYl1UIeDi3rjAee3iGsKLIDJ2oaWbTFterLidrD9oe8XiCC1r4QcYRgLjhM3QSc
         llBUCdWDd3GUFisPc33ejIwXT2iZlZQoDBiT7aI02haeudzhYoCSKH/WrAn0aCmasULn
         Vc2F6RkKIpePMAwHeUXoIhKJzeIv8MrPf+GyThYGAa/Xjd6nc5eTQKVBSUyZeHutfF3W
         j+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hM0rbzQPb+TSKGempjX+VBzQUrYZY3aGqxwljGgjo5M=;
        b=DujnSvkrFxDk/5jH8Al1kgGHicSqmjLVmzRG7jXr9nzdbC2iKE5REE3CZkSKH1lGZO
         SoVQ2u1mUCfWnIt/qWfoIEblxkda0KHcSl2Jik1Prw8YH2mg1CvmEogj8lthPzDyU3e9
         S2JHrBo22Gl+k3OPqmN4iTaZbI4Neor/HUDpds0ujbaZ5/fVvDVyn0eNNMs3OPV1pkKi
         FxQgbwEEMGHGMZX6/zw2hGR3lOwVtFLyetJ5suGQA9Do1BCBhxhiS9iFYVwPxx9ixpre
         iDOuP0XfT5lRNw7epKYB6nyhwtivK+QVw5IUBFapaYwjAj9O5IKyAcAWC26EX5/p2k7R
         9h3w==
X-Gm-Message-State: AOAM5335aexYEW4RjZHg1hgu8seHAMXr318VnRFZimqOrICdPiUNBS5m
        h4+Z5ssdWYYqUz2n8uBF0XuU/nKqChARrg==
X-Google-Smtp-Source: ABdhPJycIJUox/uaqmQGSJ7pkSXTWDzPXRxyvjjvCUryaByWL3GsvfoL65GxN9I7c103OaLskXKCZw==
X-Received: by 2002:a05:6000:18d:: with SMTP id p13mr9206720wrx.248.1603894807270;
        Wed, 28 Oct 2020 07:20:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o186sm6771380wmb.12.2020.10.28.07.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:20:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] ASoC: qcom: sm8250: Fix array out of bounds access
Date:   Wed, 28 Oct 2020 14:20:01 +0000
Message-Id: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis Coverity had detected a potential array out-of-bounds
write issue due to the fact that MAX AFE port Id was set to 16 instead
of using AFE_PORT_MAX macro.

Fix this by properly using AFE_PORT_MAX macro.

Fixes: aa2e2785545a ("ASoC: qcom: sm8250: add sound card qrb5165-rb5 support")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 7d43de6d909f..52c40512102f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -13,12 +13,11 @@
 
 #define DRIVER_NAME		"sm8250"
 #define MI2S_BCLK_RATE		1536000
-#define MAX_SDW_STREAMS		16
 
 struct sm8250_snd_data {
-	bool stream_prepared[MAX_SDW_STREAMS];
+	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
-	struct sdw_stream_runtime *sruntime[MAX_SDW_STREAMS];
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
2.21.0

