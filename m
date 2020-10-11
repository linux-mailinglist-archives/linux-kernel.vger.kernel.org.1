Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D509728AA3E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgJKUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgJKUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBEEC0613CE;
        Sun, 11 Oct 2020 13:22:50 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b10so5261092qvf.0;
        Sun, 11 Oct 2020 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qc7Gl1pDl54reD6hY+CiR+N1U9m+7coVho5OHQ+G7Yo=;
        b=huxRfQy1nVMvnp7b6tJdyCptvLU/nlZoB4Y54X8r9LvWMldLOYTlBfEwzRu6sYIxis
         vW7fgNZmOgEoK4/sZtcJjcOkDV+45rgPmtghqzSdv1YnF0SzkrwRAxpxRE0WszBpUIuJ
         pk3TMt0Il8Crua4I5YrahTiUZlcXOzQE2iZBaEPsfR42vu3O+4qIFXTx9TkQsg8w2PHY
         C32A/UXRIsmtwXtMxCFDkp2Vaj5MymUL0TRyK/G2dCCyMaPdurQM+C+9Ehi2DzPftZuu
         D7Mzl41zNAKomwG+5V6QQsJmODTNlZE3snaP7iYDVTQSUhv/nL0vWFdIdNwt98SmpIBX
         y4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qc7Gl1pDl54reD6hY+CiR+N1U9m+7coVho5OHQ+G7Yo=;
        b=nOQZLIC2BCm0PSZYfCH2ewpc4wV5MSoZJUxAhfkgXM4LceL+qADc8e4R+YJRpI5s5c
         wZTZ5IUrbCxkw5/CisYjGvNvyV6Kl4BwOjaAFow7Xp59V/8rBd+dg+th6gmOa900snAW
         MJEkgSAbcgNsTJ9We2i9equK2oVcFXhWNsPGOYqxEgo3sBlg9LXX1IikVsHSJAeWkL3U
         TLx9hWYtwDWjT2Z946vNzpqF7oAsU7glXhIJlzsiauv2vRk6Fkxk09F0/+K//0/e4NtS
         Tx6JbH+uw5v2QATYBI38unVpwQBKaYTTQjd/Qop1DoNGRBZ162mtNgcYIqvzYlHuhUhb
         IM8A==
X-Gm-Message-State: AOAM5334lHE29IoVOn2J/e8zkWo2ZWQ9dADG1Y7WQn3+Xelv5LCbHNNy
        CwjJkUhXXvHQKix1WCOUrGs=
X-Google-Smtp-Source: ABdhPJwt/1LkDKNRn2qBy0MTm6ZGT2I7f49RSR1PoNRrozMbVyyczsSoLMl4C5nqm3BaMjH3bC2K/Q==
X-Received: by 2002:a0c:cc0d:: with SMTP id r13mr16175026qvk.6.1602447769387;
        Sun, 11 Oct 2020 13:22:49 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:48 -0700 (PDT)
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
Subject: [PATCH v7 06/14] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Sun, 11 Oct 2020 22:22:16 +0200
Message-Id: <20201011202224.47544-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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
index d5eba58ff207..3fc0bd818539 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1154,12 +1154,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
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

