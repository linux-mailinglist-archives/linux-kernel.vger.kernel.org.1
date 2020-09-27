Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37F227A2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgI0TaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI0T3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872BC0613D5;
        Sun, 27 Sep 2020 12:29:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so9538043wrs.5;
        Sun, 27 Sep 2020 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFD9C0g02b1YD9AU5pxjflPT96QGvB/rE3rUqbHSeaU=;
        b=NdxKLIksYEYWvMIxygmJ/wOgbIokpUYXQ7/7+hNB0bJwQlliFTMJsi+7U8PR+mhGQP
         iy5VoMPACrRlx1sa6Psyr2JTvGxd7ZB47r4LXI17QtvgX315RzmxdiLz8aL2EnCdzTBb
         wFbexHzCi9QbrV6d2Kr3RGTsApudPoWR/eAjRYdvIVqGavIYdFe8jdBctGSUCFdBuXoK
         gMYHF30+idE7QvS/yFF9WogbwiOWCmB8vQVBligf48+Sd0FmFLaXJUa0PfJGnFKh86DW
         kkVut1zRfkW8VNezqQRGOwq1RS7JF6VjlmhXhHxQZbKgZCo/r5rIBQck1cUSeMELkYWZ
         fD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFD9C0g02b1YD9AU5pxjflPT96QGvB/rE3rUqbHSeaU=;
        b=Ofk4arOVU8rs46Gs1ChoMu6ZRlWqrlgpq9f/Xl+qoEfdL3/8rR31UmuARfRCu4DT2l
         71M70nmiNeiAZkaralhO61W7rU2a9CnMPk1CDv3e4F2yYM1GIdc/9X4SZjlzB8PJoWVO
         UuL+raj/TJT8U1X7ha0G7F90zVZu7B6STvWofTkK9ziPCD90vhqcao4sETbEB/jtWJcu
         OQzqhkaB6n6ng78xe6GYtnTobAuvX5XPh9kYEJH5LqzayplnKej5f02mLnBPkWV2fdto
         q3jnKnzRI6gjCVoaAN0gPfw8QcWwDjXzkmqz7RBGNX1URb4A+shdJACyZQEq8O3t56Ls
         1nNQ==
X-Gm-Message-State: AOAM531FFVPvPdetE8fzbyDaf6vboQuBxuR8f0JGt7xBgR6X1NlpWgLG
        svZhXpRTDOhRdHPKaaNP5JU=
X-Google-Smtp-Source: ABdhPJwDIz/p54l7LU0V8+Pe13zDL0f4KhqMgsxnx1wJvc48DpYxuBX17S9t8cH1n0Cmz7B5+bFTmQ==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr16140367wru.363.1601234980231;
        Sun, 27 Sep 2020 12:29:40 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:39 -0700 (PDT)
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
Subject: [PATCH v5 20/20] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Sun, 27 Sep 2020 21:29:12 +0200
Message-Id: <20200927192912.46323-21-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9cd6cd1cd284..a6fd9bef30d1 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -180,13 +180,13 @@ struct sun4i_i2s_quirks {
 	const struct sun4i_i2s_clk_div	*mclk_dividers;
 	unsigned int			num_mclk_dividers;
 
-	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *i2s);
 	int	(*get_sr)(unsigned int width);
 	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(const struct sun4i_i2s *i2s, unsigned int fmt);
 };
 
 struct sun4i_i2s {
-- 
2.25.1

