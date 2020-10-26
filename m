Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5132F2995CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790883AbgJZSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790503AbgJZSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id x7so13935329wrl.3;
        Mon, 26 Oct 2020 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h875RQWcCnQKEon1vZMSs7fd8QdIR1VwpoRUpUdOrgk=;
        b=FWVA9Dl6Oj8NfNYWfN2+EWXfUan70boVLG9BRrwZqRpsC0i1B8A937J5ZcF+/BXnL7
         OObwJKQ99Zd0EXLqZcBbJo+EKuBsgqFxWFiBliQPM9NMT0BFmgBJeSZfyBRWwnYMFjsL
         w1Rej3RC/ZqmlPJ5EWcwazpY3VDAytOpQ7r+qQXj/dw+zaJ9ujWus44x4fIZ9XieRwId
         XA5hdvrDFaFxVjJLEbXEIK/HkKpUIc96JQlQfUxnn4CHkvqsWUPVC5qNrnisYH06uPGy
         UrtwyC2ey3bgr063kjjxX2pDbkEUd0Wq4LfzW4Q6E4aolS0ehRjOH0GN1kRb7Vx0qTm/
         QNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h875RQWcCnQKEon1vZMSs7fd8QdIR1VwpoRUpUdOrgk=;
        b=TLwxOsb7Jbv15jGSIoQtNZvad6IhuuEbqucxU/XTYiz8typDhXH0/XtsAhUh8OEd/q
         oPElFb36tLi24YngFpo6P8pI10jpofwbzyQqfzzyF1g7YnQW2VFMFdsJxoTWf7aH+UD8
         Qn0zOvtTYOc6O1J25Y3JxG/UiPzFXcPdni+unLpmvw6Jth4wt0YsGjxGCgCtD64Wd2Xd
         zTC8mIlRtXp+QU0gGRVxBvLiHfv8FqBHxcoN7vfqu/jLZ2Per8a9PUntygyKr+2nLYAl
         vLVgncoo50NXGPf1IgoGQePOM6LfQksjKNafI/dc4BRD56sOsK+tpu8HuJmi8hL0pnQt
         iOfg==
X-Gm-Message-State: AOAM530Rouu3NJFDdKuoxjiX1Z60yEr3Wl7N+4AJf/c2AUW3tIRsVp0B
        gaEB+7JAJzmTFLP3aaKuIoo=
X-Google-Smtp-Source: ABdhPJypxi18UjO1yoMO6HQLdWad+3pWKFs2BpkRvBv/Ei72mwZ61uqV8oISGr4+IOKfHisiaPaYEQ==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr20814807wru.271.1603738369911;
        Mon, 26 Oct 2020 11:52:49 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:49 -0700 (PDT)
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
Subject: [PATCH v8 06/14] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Mon, 26 Oct 2020 19:52:31 +0100
Message-Id: <20201026185239.379417-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
index eee1e64cd8f4..dee8688f0d37 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1161,12 +1161,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
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

