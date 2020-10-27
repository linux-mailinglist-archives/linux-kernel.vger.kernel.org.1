Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4029C768
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828425AbgJ0ScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828382AbgJ0Sb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:31:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id a72so2311613wme.5;
        Tue, 27 Oct 2020 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyrgB1AwEElcU6uoJ2FqX5PMdFXQkCgXivSbRL5ep4E=;
        b=DNkj+Piz0Om+GlBXB1VmhimTuK/nSLowEHG2zWBgg3WSp6WoZYjj8lxB6MeqJxwLLK
         H9f44Pe3Qgm+GQQb53ymB9f3zFKJxuIWrkGDM12YXn3RLqHzTDPoD363A3fULoK5xPRt
         U39PLKCsU4BCqQkKxYnUdUjbAzodsCkdfyMr0FSpdMDZDzZ4UOFkK7+Hqx15+bf4lNg9
         2Ts8vi/G/ktxoS+PxSPNw3hFotL7a69jPTSjbh4Cb6zLT/RS1R46aouo4C8scKpaC2jT
         +fvo5BhsI7euEErtYqaYf0Ph0bCwizCeGr8VRlnrSvcnTQZxcOjN5r9LJxW3Qwjr8VBH
         +f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyrgB1AwEElcU6uoJ2FqX5PMdFXQkCgXivSbRL5ep4E=;
        b=JQU6cbUvLqfNO5RmA/mF4sgiRrkmWPWTRnfJOusnKwqbxUrz1xxxODWeaGaqRB3wxu
         XKBe612xV3Df3oS8I7PJM/G2L+I1IVi98EwmpJjM9yu5adfiMtCRPTB5r4dCcByS/pj4
         /DMYsfEQvk0RnhCil6hLKNmkzHM3yEFsQg5UKIhJ9AOOeQAfi55Zz7c4q5BHOWYKtXbs
         WtN0JNSkho4HWsr34GLLL0HgDLxbkk39UKkfT1JD2I3jqXmYOzDtkhh0ZupzpNpYdYqz
         HZdky95nFLgFRDBgTj57DpKZx6PP2MgclbSLA8Mn5FyqTCFcct0ceQfzryau8pfV1lct
         +mcw==
X-Gm-Message-State: AOAM531627kHCpoK9vXzzVz3lI8B3IPPgBT3HSlX9d24nFVKm5qtNnhS
        k5IJVz9qTV5PKkbgUZMCWAg=
X-Google-Smtp-Source: ABdhPJyF6ZdXaQzST5/s0N2Dhm9FeBiO3dYoy4glx6HJq/VUSfo5xXU9LEg9PIBhahO1EuL7oBl4GA==
X-Received: by 2002:a05:600c:214c:: with SMTP id v12mr3948227wml.23.1603823515538;
        Tue, 27 Oct 2020 11:31:55 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:54 -0700 (PDT)
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
Subject: [PATCH v9 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Tue, 27 Oct 2020 19:31:38 +0100
Message-Id: <20201027183149.145165-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9aa837d4fe99..073ee60da011 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
 	unsigned int			num_mclk_dividers;
 
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
-	s8	(*get_sr)(const struct sun4i_i2s *, int);
-	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*get_sr)(unsigned int width);
+	int	(*get_wss)(unsigned int width);
 
 	/*
 	 * In the set_chan_cfg() function pointer:
@@ -387,37 +387,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
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
+		return 0;
+	case 20:
+		return 1;
+	case 24:
+		return 2;
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
+		return 0;
+	case 20:
+		return 1;
+	case 24:
+		return 2;
+	case 32:
+		return 3;
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
+		return 1;
+	case 12:
+		return 2;
+	case 16:
+		return 3;
+	case 20:
+		return 4;
+	case 24:
+		return 5;
+	case 28:
+		return 6;
+	case 32:
+		return 7;
+	}
 
-	return (width - 8) / 4 + 1;
+	return -EINVAL;
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
@@ -582,11 +601,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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

