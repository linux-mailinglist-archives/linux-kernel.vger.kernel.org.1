Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025D29C77E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828572AbgJ0Scy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828417AbgJ0ScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id c16so2476945wmd.2;
        Tue, 27 Oct 2020 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO+XgfqYhS1hWPZ5l+hsM+hp/BUXxbM/bDwLpUj+eH0=;
        b=cPyXQd8bpobuaTcZbflF+9ISJGHRfsusHYPfQhnJAlbApOn2LHLwmI/KUP8W41pMEH
         YhVaLV6hJL8RVHkO8xjOAEUDCMUg3XwW4FZfJaNDh/g56geus/uLQMfuXbWacVu7l58k
         Yp1DRySxAHwMS2ziQKrB5PiFluap3kCoSezNPsT4INGW8y8YAJ1Gd0B7+c+3ubZRLv+u
         Y50S9wzPWKWHEZbfl/trFf5287+SEMFkxNL9rRfsWgDzfC2VvX0AHsaOiM8SO4AIRVkr
         Xukph5Fl/ewvLAni+mLc3HTH1+1a9owNE8MJLDT9wZKijF7KhvyVycUQYIcHg9zjS+HF
         TxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO+XgfqYhS1hWPZ5l+hsM+hp/BUXxbM/bDwLpUj+eH0=;
        b=oGFQ2R+yqh7H9i6lFIfxeNVHgcSc2K2bzO/5ytk1xOKN9Ed+HaXEQMA1QPw/ZIKdQV
         u7evOn2BwNx6RF82FoRTEIOezyfICd04We3TlVz6U/TvsP/pRW0eXkbUHnLkzgp/nvjf
         l5h4oJcNovyOkQ/ICrDERRYXAbuODZ1vEy0T67BIqLHGr7hn/Y7JhcfKMENq+WAZjhHX
         2MlX+kALfAvUhCjCmsPCO1u1w9U17R2ejzMdDMmB8IZahG/ekwJWjYTjACGq9ossw+2B
         Gtao6Q1T8lhwZtb5PrvQo7IutmE85QElZM+xBQZCBKW40WdhtZJYClqdnaYtGSZ1/3KP
         X0uw==
X-Gm-Message-State: AOAM531Om26JqKfaUewYThmSqYeaq+eK0OknGeISRlwVhgqZ+OkyCTwV
        VuTlXW49E5g0a30E8bsn7Fk=
X-Google-Smtp-Source: ABdhPJz51xl2Ade7TO2COWem4gvbYEgstwB3/gSBh+1t+c45C6pZQU7QwS2H6fG7zZ5N/uwbbZayEw==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr4042645wmj.52.1603823519008;
        Tue, 27 Oct 2020 11:31:59 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:58 -0700 (PDT)
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
Subject: [PATCH v9 06/14] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Tue, 27 Oct 2020 19:31:41 +0100
Message-Id: <20201027183149.145165-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 39b56d0de1fd..83537538f8ee 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1162,12 +1162,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
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

