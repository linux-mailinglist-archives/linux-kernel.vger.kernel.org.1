Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D901C282496
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJCOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJCOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5E4C0613D0;
        Sat,  3 Oct 2020 07:20:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so4556642wmj.5;
        Sat, 03 Oct 2020 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thQQBJj76MhEuX5Tt0i/5sseClgqnX9X6XcbKMHRJzc=;
        b=F2TFCYeIys22C9qCWsQVck5SDTwcsuRKNUROIwQPgs/P23wWrzWcya6KPy1FO39g3T
         EEjrlUijYgwzDObj8VMo0UNwwg4EroC7BUJgRYfS1Fvl6o8yY6NEu1x2AWh5Sl++sMfv
         447DvEM9hCYvk1pDJ+gOZxdDlWD8MntvsmSHGwZkZBjk17gdpek6cSvcm8wDD+hY2GFa
         aQqAOuw9MVFT3pJLO9e7tOqQmy6wo8gK8yFTjyh8ZYMBVLqxiR0TyT9GT4etyke6kcDm
         E28l6Jv99pQDFt34J7EZ+BSRElson/esVDvAEYyveJShexBfpRYWLYW0M57d9NchXsKa
         To+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thQQBJj76MhEuX5Tt0i/5sseClgqnX9X6XcbKMHRJzc=;
        b=Xx3kD1zO5lKGawNOSrGxtUd+sCB1iy0trwpW8enURytiJJVgfYtHschMG7wKSevYNz
         qHESZRqR02zsuU4B8qcEck/sxQ/chHRcwgcAjEXUZE0fmDb15dwJoKZbHMMO8yHFp8ZX
         eCycDOCx/++3CvvkHlRYUV6svWft1w9+i/6q9+6exK7gSxa6HO+BEe+1qxI0J5uhiDNT
         uV7H2CjovGQZ2l6KzyyBiVBszNmlMO7utmGlUOC2CtvK7+deDhAXuX+0YT6NblsdT5wf
         mWl5ZPrQ1LI9T409Pp9/E1ZmAgM/0OaDRLZULH7+UFQxvM1r0gRO22Bp6P0jGfXsqkNX
         iVDA==
X-Gm-Message-State: AOAM532WOZolw/8tyHyjB8057aWqDh5viRaRyYI/Sd2YgxxLI8ueIOPk
        XhlixTGme30oMv+q2u/w5vg=
X-Google-Smtp-Source: ABdhPJys2xA+7HuhKJbLBRXH4kRbXqCL6sepPemBIzAL7+UsDe7QuuEBLqMP/SztPL7kOdnYW3/i1g==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr2303045wmk.43.1601734800684;
        Sat, 03 Oct 2020 07:20:00 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:19:59 -0700 (PDT)
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
Subject: [PATCH v6 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Sat,  3 Oct 2020 16:19:39 +0200
Message-Id: <20201003141950.455829-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are actually using a complex formula to just return a bunch of
simple values. Also this formula is wrong for sun4i when calling
get_wss() the function return 4 instead of 3.

Replace this with a simpler switch case.

Also drop the i2s params which is unused and return a simple int as
returning an error code could be out of range for an s8 and there is
no optim to return a s8 here.

Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 1f577dbc20a6..8e497fb3de09 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
 	unsigned int			num_mclk_dividers;
 
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
-	s8	(*get_sr)(const struct sun4i_i2s *, int);
-	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*get_sr)(unsigned int width);
+	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
@@ -381,37 +381,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
+static int sun4i_i2s_get_sr(unsigned int width)
 {
-	if (width < 16 || width > 24)
-		return -EINVAL;
-
-	if (width % 4)
-		return -EINVAL;
+	switch (width) {
+	case 16:
+		return 0x0;
+	case 20:
+		return 0x1;
+	case 24:
+		return 0x2;
+	}
 
-	return (width - 16) / 4;
+	return -EINVAL;
 }
 
-static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
+static int sun4i_i2s_get_wss(unsigned int width)
 {
-	if (width < 16 || width > 32)
-		return -EINVAL;
-
-	if (width % 4)
-		return -EINVAL;
+	switch (width) {
+	case 16:
+		return 0x0;
+	case 20:
+		return 0x1;
+	case 24:
+		return 0x2;
+	case 32:
+		return 0x3;
+	}
 
-	return (width - 16) / 4;
+	return -EINVAL;
 }
 
-static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
+static int sun8i_i2s_get_sr_wss(unsigned int width)
 {
-	if (width % 4)
-		return -EINVAL;
-
-	if (width < 8 || width > 32)
-		return -EINVAL;
+	switch (width) {
+	case 8:
+		return 0x1;
+	case 12:
+		return 0x2;
+	case 16:
+		return 0x3;
+	case 20:
+		return 0x4;
+	case 24:
+		return 0x5;
+	case 28:
+		return 0x6;
+	case 32:
+		return 0x7;
+	}
 
-	return (width - 8) / 4 + 1;
+	return -EINVAL;
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
@@ -574,11 +593,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	sr = i2s->variant->get_sr(i2s, word_size);
+	sr = i2s->variant->get_sr(word_size);
 	if (sr < 0)
 		return -EINVAL;
 
-	wss = i2s->variant->get_wss(i2s, slot_width);
+	wss = i2s->variant->get_wss(slot_width);
 	if (wss < 0)
 		return -EINVAL;
 
-- 
2.25.1

