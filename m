Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D82A083C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgJ3Orb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgJ3OrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF4C0613D2;
        Fri, 30 Oct 2020 07:47:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 9so6883499oir.5;
        Fri, 30 Oct 2020 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4cYQuVx6gToZbO7mEsQDDx46mIAsBCsMKfd9g+RrIE=;
        b=OZyMXC1ef5lE3Xj7EkCUy6rsYPbkXx5xYWfAEIIo5YWaZAjyY0ty+oL5VPwh+frYps
         bzoeey07n25DE9sLmK504tbhohR3dQ8NeDAEgqizrIBpVrk+oCyzQj23E1jwWtBGSFrB
         96KJbb6Lf33uIZz0UUcgn0SXcTCD35x4ztoIxmHOPxya7IdwaqIcLi57zhwJ+dKo+mbU
         q8FiHpds5Uc7osGJ7DmnZFjhhryHJjvP/vzC2EycnbcCbBYRA9PgNrdnUCpqu+WK3KfF
         2WItQzButAY+kednd5Ps2Ac5lplYO8BG9NSzvdxVTchu/t4ch/SBc69DvQThQC8Kdtmr
         TRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4cYQuVx6gToZbO7mEsQDDx46mIAsBCsMKfd9g+RrIE=;
        b=ugDnMeqDdC3rAjCJsa0VY5ZQJ7Y7U21oIZu6NzEPYjq9Lk1zkb+IQ1eN273/YtYfFL
         U3qZKExLPYqJziJamMzQpIuDXU2cn5KCfOlkdZXh1ZW0i8V71vhhJ7TZohXanBloCpRE
         PVS+V/CJWrrBdYfxb+4a4NNz1rQDKtkjw33dxNzZPMvKKzBwht5x6AgGxow/T9irwTZX
         6GpXftiCUKEeaYYF3+dDNWx1rVeNi15QQG4hW/zdNJbsZk0q+mq6RAMFkX0nPo6cmh3w
         frEw6Jt6bLgB4PfeNICOSXUgSNtA5vU7PWbqTNlhwc31uyrF4+jhGH5OJ05t5zatIqAR
         kU5g==
X-Gm-Message-State: AOAM531DnwQVIbWdb1oYmCRx1RBXb2nCSxNuRyUlJMaJiYBQrAh+zzgE
        UdpICWJYDmYmmYxfXX+Frmk=
X-Google-Smtp-Source: ABdhPJzrOWnh3LX5MzGR+X7zGa6JPDHD+fQTH83s8TF39Z3LXslaoMt/hLpsPrl7NryxcUkW3CpMOQ==
X-Received: by 2002:a05:6808:915:: with SMTP id w21mr1236071oih.124.1604069243013;
        Fri, 30 Oct 2020 07:47:23 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:22 -0700 (PDT)
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
Subject: [PATCH v10 09/15] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Fri, 30 Oct 2020 15:46:42 +0100
Message-Id: <20201030144648.397824-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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
index 4f5cd850752d..4b8ca5be0a29 100644
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

