Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B42720FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgIUK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIUK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:28:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9281C0613D5;
        Mon, 21 Sep 2020 03:28:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so12041036wmi.0;
        Mon, 21 Sep 2020 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFD9C0g02b1YD9AU5pxjflPT96QGvB/rE3rUqbHSeaU=;
        b=ORtkscd0LXX9BBsQWoDti2VIEBdPk1j0BioweaYSvogLI7XyjhrbEa0S8Q3EhImyLd
         autAKldCKjTSgMytfL9yrL380gPjhg12zqWF54dm6ab45cOmiwjDLENRAeAmXGWmlo17
         YtFUrXQtYJlfqDgnNPsbqZkBUhmHFugh3Wue9+gf3iUvfvl5GNC8gT+GCGIcQtDCBuj7
         SI1mH/+659xvSG5kzv8me/PADthp0yyy0thIt/aOJjMs2TewIpfqtYNdpCoM8g+DRkYE
         PKdvPseK/P5uiaBxZBp5vI6AKKMVkMw/gsp9tHiahnQj6WytdbizShPDJa+fRRTIwd1P
         wyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFD9C0g02b1YD9AU5pxjflPT96QGvB/rE3rUqbHSeaU=;
        b=sczUhwvA6BGz8TIuWbGx3FjwoeMkVP5tHyRo3G5niFJecOP8KS3RhisWomHHI4wY2G
         Ir7SxtvgmHiRbDLttzDtqB9C9eACjZDH6AR0CT1NKOEknkCrppUEpGlUUWQjelfE00Tx
         Cleoun2H+1ojkma0vnbdSEclUpadKX4ttqMznLggOanmEqUV5ygU/x742MvNU85mvrDW
         6Ymn0RFgN24uS2fm1rM4MeENhwanfjTIzFWiAzGWH9mX/+51h2oOlL/YZSr+Xyfe8aZk
         ctndNY1uox3qkk92JYeO/EjYnrdgSqP9MYK6DVGhtsRXtKAOhLewxiLiuk9vn1v76mZ1
         pFJA==
X-Gm-Message-State: AOAM531rxV7bxp+96ftFdyjB7d66J9hJEkD7JKPGbHxReDaCjRMP8BOO
        vGrAkorjefVNM1B+DiYjOUU=
X-Google-Smtp-Source: ABdhPJz61ZTvOsGpQ1BNxeZDj/564NynxcaEK8tRDKFFoaU7hqYG+epEVjy4USWxS1HtRGrdnJWDXw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr28111657wma.141.1600684082340;
        Mon, 21 Sep 2020 03:28:02 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:28:01 -0700 (PDT)
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
Subject: [PATCH v4 22/22] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Mon, 21 Sep 2020 12:27:31 +0200
Message-Id: <20200921102731.747736-23-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

