Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C743B272111
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgIUK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIUK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2EC0613D0;
        Mon, 21 Sep 2020 03:27:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so11584844wmi.1;
        Mon, 21 Sep 2020 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=403l/Us7aRgOIyQKfBkM8buNZnuotwhLbaKDtAVk4oo=;
        b=GQrVMr02cQ1BeZlZeb2WVDwVRAOjy0EPLcpnRVoxLErUQ8L8BbXzAgcou4DBLILshT
         voB4HL19k+K58pZ9bWoiXJcWXcWdo4aTCYu8xUzFOIbsFPR1zHQXm2G7WqGccB8DtNKL
         GFUo276bbhz+KJWMWgKxOTcYQJKeRVpyTG4A+1AxMAWukIh/cDo1CPBA9oH1DE7LReQ2
         J5nNNz0F2YJsVRKfKgl/sXXvpnPkFxsHI5HGyED3UkulTOrGyx85O52YBiuqzeZzDZPK
         0UBMepEcvgqiP0vW1f8hWTuvUbQ54SPeh3/qTspCZfjP+qEvLo1FAuJry9vXmYnLzZoM
         FSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=403l/Us7aRgOIyQKfBkM8buNZnuotwhLbaKDtAVk4oo=;
        b=LFAyZaHnaBgwjqw1QL1s7ajGexH27sAmPp2rcfalkWXObRAsvr7TErjE3yPQOlzy7X
         ynzCIOEc2/1tkn+pt9vXOCXeMoFPSEJeI3Gymne1KtqCMhuzeqcRdAQW8kxvePDVre5C
         miOsKwQeblnNNu+e6ZOFP/qSNm/Pj4iJwke/s2XTXxfmwEOKMcEjHsTIDyo1LrOiLH5x
         JJh+Ys2R5NyPtfoWJ/cIY3IMeb54NH+7CDFVVj6HVBVIoMPaGq8dpmhK5MLuLAdURyDC
         t0DWcSbtHCGJglOTMB/UYcx2u/1HmUjlhbxwuw4StGSBxbWR3sXzDHZAxbzYSA2m29eC
         3Wkw==
X-Gm-Message-State: AOAM533k2keXfqt/PjcW7WPkM4wrelHHvCDZM/Zbxj53X+35OUBKqosV
        Z94Mc7A/s/KL8FZXuoTBC0JNn2Nq4taAOTrZ
X-Google-Smtp-Source: ABdhPJwUf0cjcKP8Yw3D8f2JCJ2cf8UwK0nPxw2utggNBtLI1lebBlr4qIJnkeYxSyYALo3fFnCvLw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr30634579wmm.102.1600684064389;
        Mon, 21 Sep 2020 03:27:44 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 07/22] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Mon, 21 Sep 2020 12:27:16 +0200
Message-Id: <20200921102731.747736-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 60b2fec1bbe9..3f9110d70941 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1152,12 +1152,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

