Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876A3216EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGGOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgGGOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so46803824wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeJNmc8Tyj+Q0twt9zY+vng7Jbsk0DhIYimyC4Uuyj0=;
        b=jXqgCo/xrVf3wccOvx8zSZXI+4BMW/Sxa9JnuReURq5CKjzu/p7Scdr4XGrE9TNNN+
         9fI1VvqahoInrASq2Evq+lKAJIcPXs74067opxQ++jtWGSJ4eq2iEbseCWXJ7qJsGsLR
         +Bgnk6U/P3g6XKgTnQ1jij1TCJF6yb1z9pUnQeWB3YC7D8IL06B4AOtvJVyKvTnMdj2j
         Z/pHNqfU3VeiF248cB4q/lHEOuY5rez80ebVMeMijOpZs/JJWSsFuS2/ee8OlasaVc7H
         S1Da87TMz5/HQwfNcl1QQl88zaV5Jd0SgMSaSIfTpmcOLam279PZtmLm2QrmwbOLz9hi
         H89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeJNmc8Tyj+Q0twt9zY+vng7Jbsk0DhIYimyC4Uuyj0=;
        b=o+wgc68nTinGbY3YvnmkCtqa6XmcMgyb8b1XsUTvnwRftnqi+v2nBcUTpvgB+FFKjX
         AFH+c8Kuf+KW9XQXewwldL++1hG/w3eT4sW66TQHaVYNdRSXdjvZEpC5bw7woIDlsnsv
         z60UDhTyNEiwP0R/YVCy5dMxa1Cc/ii/Fcd5Sr3e2zhU5GPRbEZ5s+B4mWwKc16Iw8bw
         QO7gpGv29vSD/nOOhu3HyRlXEZlRo9wmwUUMpIzKa0Fgd+OUK4KuT1RrulZtkx2T8XEg
         QuBn1kdJZB/rHI0TCGz3+G6Uo+sUt+BKOBAr8wQ8xaOF+/WqXXRSm+/EeVIGElhWjSb2
         U1OA==
X-Gm-Message-State: AOAM532XFc7FyUbg4DmBPUxisUaz7kg7gwog9dB1q9v421g3FsNkD40Z
        exMEc5PqMG04fr3zMbjjbzI9aQ==
X-Google-Smtp-Source: ABdhPJx4EGK+a98YUUNvZXG/6XzKwko1V/11TSzbBj53QSByas+d2hxb2ueuJBY/bfG6WSQIaQcvlA==
X-Received: by 2002:a1c:2ec7:: with SMTP id u190mr4463500wmu.48.1594132688648;
        Tue, 07 Jul 2020 07:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH v2 15/28] ASoC: samsung: spdif: Fix 3 misspelled struct properties
Date:   Tue,  7 Jul 2020 15:37:29 +0100
Message-Id: <20200707143742.2959960-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When documenting structure properties, they must match the names exactly.

Fixes the following W=1 kernel build warning(s):

 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_clkcon' not described in 'samsung_spdif_info'
 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_con' not described in 'samsung_spdif_info'
 sound/soc/samsung/spdif.c:89: warning: Function parameter or member 'saved_cstas' not described in 'samsung_spdif_info'

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/samsung/spdif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 759fc66443298..4ae7ff623b826 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -70,9 +70,9 @@
  * @clk_rate: Current clock rate for calcurate ratio.
  * @pclk: The peri-clock pointer for spdif master operation.
  * @sclk: The source clock pointer for making sync signals.
- * @save_clkcon: Backup clkcon reg. in suspend.
- * @save_con: Backup con reg. in suspend.
- * @save_cstas: Backup cstas reg. in suspend.
+ * @saved_clkcon: Backup clkcon reg. in suspend.
+ * @saved_con: Backup con reg. in suspend.
+ * @saved_cstas: Backup cstas reg. in suspend.
  * @dma_playback: DMA information for playback channel.
  */
 struct samsung_spdif_info {
-- 
2.25.1

