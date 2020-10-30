Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CC2A0853
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJ3OsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgJ3OrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D67C0613D2;
        Fri, 30 Oct 2020 07:47:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d9so889657oib.3;
        Fri, 30 Oct 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seaaLxuXC47KqE088aencrRQLeI5ux80vm71afqUdyA=;
        b=JDTfsx/667GOIoeFYPL8+ATV+JIP+HyQlZpIUdUyROlnl1laFM3ZrgazcxvxZ7z95C
         clBppZn1oOmwlHvERhmWPK9avsBm33h3wus6BFLujMt1WqDwO0UcENp8WkpCXHPJES6E
         gX3L6jK8L1QXL2AY8gagEA5kxWf26n0Hye3RM50qOy/LoyV7RoQ055PVTT6kqU+Arf14
         E3gQ1UfR5p4ZS+kK+WdnAaxFXwri6m02swS5DPntXxrbWWZXIuoVQRJAjTFz05OozT7h
         +U5qggs/lDF8JmRVaO34plp1RY4RThzD4g4vt1mjvTnwEywxeQfGCjOrog15NPa7D7jD
         GbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seaaLxuXC47KqE088aencrRQLeI5ux80vm71afqUdyA=;
        b=te+HOLreht/w0ROmZ1pKXN5cy/tWWWE8C3zjRiWtOG/dvjilrOXWJFnTfdlxKrZNam
         t5VpKVxgaKB7LJimYYEmvkJF8FJYU+uRmppjvfz9NqvKgWDaKj4OGNC0ZF39OwWRkOXd
         xsUQBzmf6YSCdsR5Fkvdvh725g72L/CI3i/xXBapk3jwxeskW7YQPer5cdT6smWKKRvE
         xsdKHcMB/vC79VUj/xabhFGgxP3WhaEwu4Y2twHfkyMuca21ZKpAUl8W44l9QBI7ILot
         3rcaK69H4IE52uH8ObQiMsfgVzea/+B60607279uFLnsXe8Ex/qubsurwaXkR1GOzSey
         APLw==
X-Gm-Message-State: AOAM531prvRCoFbgPSKFVoUgyIEZM89Pc/IzKfI9r4PACaDaYYT341+1
        pr2f/C3wq+htlgPimjeD7Rc=
X-Google-Smtp-Source: ABdhPJxb0Rgt0hrFUpPy/a6TWm63vy8fvs1PgpicFO1L/F9gNYJzJ+657M8+wq2gDmHjFHbdDHfXzQ==
X-Received: by 2002:aca:ec92:: with SMTP id k140mr1933772oih.173.1604069237021;
        Fri, 30 Oct 2020 07:47:17 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:16 -0700 (PDT)
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
Subject: [PATCH v10 07/15] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Fri, 30 Oct 2020 15:46:40 +0100
Message-Id: <20201030144648.397824-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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
index 786731191d90..003610c0badf 100644
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

