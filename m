Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3512995D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790891AbgJZSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790511AbgJZSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id v5so12730250wmh.1;
        Mon, 26 Oct 2020 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXcJWmCyjE4JV7N+koe+BuRsgR3wUYxT5G2C2Eoj1hs=;
        b=dg6m0j7IUyaxxSU6zNyRyN05sgSBqfSaFqDhCqqDDd8ZXK4r1qkDMD/Iff0QYusv3n
         6O3W79QMEsHQcYuCGB66HkmD4L4AAypNqleJiN32juSxrrpX85xI09ot4GCHdVAUQIeM
         NNTh7Q+qQhGnd20oPBqhsJeBYZJBKlLfXBdA4YL/AhH5tG6UBJSYx33P6qjPOhBiC2Yi
         I2mE4NvyHhSKXRdfZotWWEgpAA4qfZHmil75ENxyaDhLbaMpA2QFq71bg9+8FWRVNm/D
         TSvAZ5ceIaAM8JqX3Xs0r4eIOKrwb4zOFA2ZHyUHAMLA2Eu5GRwMK0upd3YXcRMI9x9B
         4CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXcJWmCyjE4JV7N+koe+BuRsgR3wUYxT5G2C2Eoj1hs=;
        b=NvIICuM2s3zjoEvSe2WIQsK8kiQMHTz88tcggg1bBe0fhaLT0ch+87cARiiPuFEyVq
         Ti+fd2FuFQkxWxDgWW7vWAduWlQ2OKeViWVDu7cjPpW9HymNZDRfiqpj5ZszLhK9vfLC
         bKcS/cXXlhsPsi6hNn/0wUMZ17a6gHDl4CAsOiExnOFq+7d025ykN4KVMfju2JJ2EpQg
         OCt9a7PWxHfl2/Fx0jd4ng3dFusFFh6iskEgdrkpjLXVt1JNZcg39LxqrQ1WMJusPnu8
         G3BlQWn62c6xsNqwOY2MS4Gg9N1z3SfD1WEA19Ye09WjXr7YR3w3JY3C0afGZzvH3GlM
         CTyQ==
X-Gm-Message-State: AOAM531xKJQ5cT65ulQ/nk8eEt5v57NcXONo43ZrnkcoDu/UM0n4WPkP
        kJMBGw9W1qRU5cctIse25x8=
X-Google-Smtp-Source: ABdhPJxBlv541/Lf2h0pguCkcd6pss2YPC6xpTPtHEpX6NnwTD5nRe155Ai0OS1IncDdwxDMq3iWVg==
X-Received: by 2002:a05:600c:2217:: with SMTP id z23mr18338599wml.133.1603738372270;
        Mon, 26 Oct 2020 11:52:52 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:51 -0700 (PDT)
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
Subject: [PATCH v8 08/14] ASoC: sun4i-i2s: fix coding-style for callback definition
Date:   Mon, 26 Oct 2020 19:52:33 +0100
Message-Id: <20201026185239.379417-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
index 703327dc8606..08e9e71f455f 100644
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

