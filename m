Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257FF27A29B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI0T3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI0T32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936FC0613D3;
        Sun, 27 Sep 2020 12:29:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so9571864wrr.4;
        Sun, 27 Sep 2020 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=403l/Us7aRgOIyQKfBkM8buNZnuotwhLbaKDtAVk4oo=;
        b=m2gdLZ+4J6yyiV2mG9DjdtecYFnEjhXB5woq2f3GfleRlGh8jgjTQR3nDIivt6V3qW
         VD0PFcB15gtUeUUkGjd6Gc/EfypLEHMqv5N/R4oJ+bBcgm9DG+OEQN+QVoNINrnxCp71
         0HTO2vcjA3Lfvib+TSY8pfelrJGmbccbnfVffPEhuS5nnMoZdRjf/OL70wPpNHqb/qQe
         R/oBdSeoqTIoRjpGDY2goKYIYtFaATFk9rDKACViL8JUvBEJbjVjTL2DyQuf7inhKPKg
         qqkGy2eFokq4BvcLhvvOILJogY/gqpYOcWS9CwHID94pF7AQA1V5IPyajuXvbrqboxaQ
         OLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=403l/Us7aRgOIyQKfBkM8buNZnuotwhLbaKDtAVk4oo=;
        b=IPLyx5SGTAixiXa5TfLBTEJA7e1WD2/IrH1CRseHkhkLf7CMnW9zRgZ4miBiAKlUmh
         oD5mVmV6+C+dcaEWOCHmw8mpqIfEXuFsChl/pQgkS69IvhgnVhJIQ6DiqaC7ikVIzAX3
         COyowtMywUd7xNAtomxIc9CKovpsNA8cqTG7DuQi45yC9g5ueNjB4P8ryP9wgP7QDfq9
         bmtEDKhNycCnWDaGj3NFMEegY/mgfoHeeEAhu+CEenJnc6xRycnRXkT4dbXpPH2ZVeTL
         CKmE8HXjJM8H/SPjVyIdqmC3EMZDztwXWZLj4X78qkXqBiX9IlgX7Fhp8jS5JBxDUSDE
         aw+A==
X-Gm-Message-State: AOAM531SAwTl24eLlyN44iJkN/7n928HnU48AVurDrRkPS2CeMGwj1kl
        D/T10KvLnykgnShm1hpBwko=
X-Google-Smtp-Source: ABdhPJynrgzzn25/R/NZnQ/YXW4o8ysWoCGC0ENp2ON7akwtDALLDl6r/2CUcfYpIj7vCIdBjc2e2w==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr15683819wru.374.1601234965951;
        Sun, 27 Sep 2020 12:29:25 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:25 -0700 (PDT)
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
Subject: [PATCH v5 07/20] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Sun, 27 Sep 2020 21:28:59 +0200
Message-Id: <20200927192912.46323-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

