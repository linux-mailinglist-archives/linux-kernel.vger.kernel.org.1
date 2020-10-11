Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C734028AA40
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgJKUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgJKUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D48C0613D0;
        Sun, 11 Oct 2020 13:22:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so16037586qkd.9;
        Sun, 11 Oct 2020 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwVmd8q6/xF4Z/iHMmW565olMdZiqSSZzSQVJZEvMNY=;
        b=EDKH1w+PS9wgUBgnG0c+as4kzQfgC0b2YG2vs2aDcGRzieVlYK7mytge/Y3MduSU26
         3Su8uO457kYU1XSQUHt5UWkmV5p8TS2YHH/4o78R4oSNJXO5YDKoIH0TbqRuFvpD1yys
         kTvGH41n0Fp1mqMSwIoUyPS+u1AtJ0VfgT9d0JU29RZ/D6RdFs6PfzOCAwlhxMx2/Ip8
         tEUHdgWlSGncnaQxR/fcDlMwHr1MISd2TGniZnLY6wVDwCCUEVVRXytjcMfIG/4kfQdQ
         YWXmwG/Q9/5u2/yTRDHKhcaNFjpz9jlkRozeS8Pd4xyFlsjlFmXIq+Ld+S/0mVOVRhBH
         f1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwVmd8q6/xF4Z/iHMmW565olMdZiqSSZzSQVJZEvMNY=;
        b=l2EWSviOxgsf2BG0B+8Z8MBC0hVbnoAZeVVOuWREIXw0o90HnOOelhZKJazov5P8oP
         aJeLOW7S3pcoHNw6f+coaZ3qcE3AjcCrMP3OVRKRF1wzRHCUhs2JsKeAkzWUR+ysrMp2
         e+e1VNH2YhiZyxzl2gLSrrKFtw6f8iBk/CmdYCewAdxa4mrnyH+dp8l7+5So+fskYDIX
         wxCfUv0RGRxCA9NknJeKYCCXQ1OzClNLfi3HO2aVVbzsDvY7NE5fMIL/4SzhfDNP6b1T
         gdWAo7ULeA+Ycapz65E5MtlPZqabnlqhLLoDNgN0fnjeoOt0nSuoKXrZBGFSCy/tVav9
         4NrQ==
X-Gm-Message-State: AOAM533Zi2Z6OeqkGNPSIxOaxFgR+P6yUVK8D0tgeHbNoXQRW2y5QBul
        xMkkOizRWsxw2jjz97zJq0Q=
X-Google-Smtp-Source: ABdhPJwma7ATFj/LYHPNUv+5n9rjXATsJjvZSlxf7Dw7uRa+RqRYE9uSqoaU1C2eBCR3dxYMZttPuw==
X-Received: by 2002:a37:6285:: with SMTP id w127mr7282847qkb.454.1602447775138;
        Sun, 11 Oct 2020 13:22:55 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:54 -0700 (PDT)
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
Subject: [PATCH v7 08/14] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Sun, 11 Oct 2020 22:22:18 +0200
Message-Id: <20201011202224.47544-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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
index e7b9dcbf82db..b2923d4c03af 100644
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

