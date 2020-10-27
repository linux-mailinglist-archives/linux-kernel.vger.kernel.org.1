Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8429C76B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828448AbgJ0ScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39078 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828424AbgJ0ScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id y12so3033309wrp.6;
        Tue, 27 Oct 2020 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gt3AZ0hX1jExXQvct5PeSssH0eAYOD3HBZ6+o5mysMA=;
        b=hTp0/C5QqU8sGft7gs+VKYluyNQdjzqWgZZh3pTwmFWeYye1IhomVJiHNIygIcMqGF
         3JyEzn8ks79yZ7mUPgkZJ4QdHgJM+JSlwrgXtjVBC6cMZkiSr/gUj/CZCJBPVDPK++Pc
         2M899v1JBFuVKa4zBRvRcBeOdQIczJyaWkK2bxsPg3LJqh8Q4G+ta/Qi0yrLdRmvpMm+
         ESobrLYqLEMZkMnHE3hYWLwhKEZftWOqm8L7w6aRy7m66I+jM+WCfFqB3vmSjDi4Ct00
         LJbtTS5mgqbTY+YJgkq4YRI8JVQlRw+PP1Hv+sWB52MGqHJIFXo4h/t52Y/Rvy/Eujlx
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gt3AZ0hX1jExXQvct5PeSssH0eAYOD3HBZ6+o5mysMA=;
        b=BELvsPZBZQCMmgjKWBMSxYrvz6qEyDcTqkyPVEGK0st4UCIIzjfwy0HrI2wVIzqNnN
         2ec+34llgS3jZzetEtrG1UTAuqtnJ2Hc3xcuQtYDaMMuNNncdefDel2+nZG805egEab0
         G0Y8hpSKNQAW/MKQMeKazFG34F0I8wiibR4y+TGcTzwGxqdx5NLuWBGt5hXAonfyaOjd
         opq+HOF8C9byZ/0pVQeaLb1nNinj1XkonhEZQhcEcmlkDL+Rew5lNqFdJJ6uJtCft3E1
         XHqwneDbkHb1igAEugn9mkPfd+G8s9gtzZiNrOdB1fmFhs+53X43y82J8822r+lPQC8Q
         M3fQ==
X-Gm-Message-State: AOAM532B1QdtDyU91ff5Shb8+PAFq9iLgXkiN/zGAeVsTNaKrOATJH/g
        6IdDJfbruCfZEL2R64ehW14=
X-Google-Smtp-Source: ABdhPJxKySdExdQpdchzKr5y+uxq5+4d+zLWKNcwipKrO/nMsTtpM3Hkjs5/cvYGG9bJ1egUEF7Y+A==
X-Received: by 2002:adf:b787:: with SMTP id s7mr4637129wre.390.1603823520965;
        Tue, 27 Oct 2020 11:32:00 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:00 -0700 (PDT)
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
Subject: [PATCH v9 08/14] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Tue, 27 Oct 2020 19:31:43 +0100
Message-Id: <20201027183149.145165-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch script produces warning:
WARNING: function definition argument 'const struct sun4i_i2s *'
should also have an identifier name.

Let's fix this by adding identifier name to get_bclk_parent_rate()
and set_fmt() callback definition.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 6a3207245ae2..4cf8a67efa4f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,7 +180,7 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 
@@ -192,7 +192,7 @@ struct sun4i_i2s_quirks {
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1

