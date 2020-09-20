Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CEB2716B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgITSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgITSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D2C0613D1;
        Sun, 20 Sep 2020 11:08:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so10343813wmm.2;
        Sun, 20 Sep 2020 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufePw+jmujyM7bKS5oEc09TDH09iB+CFG7lQmMsfy8s=;
        b=fTiXttR4+SrMKv6pRz4j1hLVJNWbD3pjEezaDZ4Q7cU+HTfm/ceNNLOKA5zIxsErw1
         FZav675yawryyB5b6eUCOezng3zzDIKhPCgNwM05NjvamkYWryc3/OGtK8hdbwOSr6O/
         Wcy16e+QUFkQ5j9BjyxKphQOfRR/ZB+iPwmw/M8Ne9PMmHV/ayMCHRob83h/7VOXl1Qe
         IqEZbYxfvqHhhcF3RJ7sCXFA0XIuMkffFtEe4WNSykZZzLQaqM0ht8zvKSCjjSrxA3ez
         ZZIY9OtNObfqcqjFE9hXzdfmmvzyqyoy1mNpxuEnJ1c8gcytL5a7ppatvy0xlqctAX33
         5fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufePw+jmujyM7bKS5oEc09TDH09iB+CFG7lQmMsfy8s=;
        b=ZAnp+rGXoOr+9APKPdC0ZDMrbnyQVcMWbdQ0+mBUco/PYlmj1jtfudqq6h7+eAAkOn
         dxU/Fz9SLTSW0tQDLTgQv2kWGvrP+bjFgDSPmKfn/1wBMArkj7BF/H3RNY5vvq63LGMN
         3LhJKbdC+XBPynp09qzm4eUKS2QcseZiiDzkZ6NSsW+6Al043efPaE/FY6BEhVlMW6pX
         NV0mqxP7e81utP0B1IuQyGHfQPBJbW1wMdupR7edCY3WGA3y36WHIigwDjaKeKNLFCHO
         VQOdtWYISWNEl5uXv1mm6QYYgz5TXXtcDfxieYNLIfnkOHSbWNlr5FG9TmxnEEXDqOsq
         hGlg==
X-Gm-Message-State: AOAM530gqP+dqzHzKrGCU4fpEYco1NmJ0Qc0y5nWwIbBrVywTznIKSDt
        3UrMYoy+y3gj3JqyC446GYE=
X-Google-Smtp-Source: ABdhPJzp/vYgSbX8IaYek55tU+mUWlz1LUiQywqZE+Vlkk/Ja4yCmVqanVd1u0be8fXbakq7ZChGCg==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr25899273wme.136.1600625296778;
        Sun, 20 Sep 2020 11:08:16 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:16 -0700 (PDT)
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
Subject: [PATCH v3 06/19] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Sun, 20 Sep 2020 20:07:45 +0200
Message-Id: <20200920180758.592217-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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
index ce4913f0ffe4..a35be0e2baf5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1126,12 +1126,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
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

