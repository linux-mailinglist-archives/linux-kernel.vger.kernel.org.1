Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FE2A082F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJ3OrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgJ3OrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB9C0613D5;
        Fri, 30 Oct 2020 07:46:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x203so6847572oia.10;
        Fri, 30 Oct 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qfHTl4VFh+ziVF8DZnZZxGvPiZ3kXKnx8+g/Z/rsTU=;
        b=Y2jToFx4AU4O8l6MTP1yj9T4elz5vBsHBjtqe1vd3QFHWL77In8VjsEzfP3I9Pso/e
         fCOKMPBOFqUWmuBJ8dMHE66athLBWQjlF/x1pLjV1/cIl2SagQ4rWpotjPeopAqdlUNq
         i79GbMe0/Pz5I8ELPNrEZMynblgiPRZirosjXMPA7TmyUDBIZ8RAFzo1t0zMOXkMNt8T
         CI/D6gwN3DeJH8B+xWYc22vRKg43yyAIFWayUuqvy2o/o5sb6EHe4twl+ugCF2l6H/us
         elkEQVvYHiobuIi6FwCfG7bvsHfPg1/SlzTkpHG+BAXuU46N9W0hK0LN604FvjUA2UmO
         LQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qfHTl4VFh+ziVF8DZnZZxGvPiZ3kXKnx8+g/Z/rsTU=;
        b=eZ+ctIZN8PPRl2Yhb4y1LcF+XpTgkxufPEcc2vuFCdr9OqmCwyGoRJCdWq5fijj+Hj
         9FtTyM9g4vT2YVI3AmWYVVqtg8CDzJYMLLrwRWL+59XufUIAQbfeloa+50iRVYF4I0LO
         oO7dMuaopuhBg7EQuulGFQ7cx4KKS+91HIwBpaHkiEy4AkpDnesHLxwRGU5uxhsvbazw
         +N+e6OsEFeSiJNJ+ryFObAslCnKwsz/cOoGWIHPKh2c6xWw2rJRii4GcKwlC9Ncf2Mnq
         ExsPwLKlVoFuAZoMZcQOHCqS6h3RmXSsx9KN6U1XKpi9Ttk6iLPBVQLgHEk6SVy+bZnK
         TlYg==
X-Gm-Message-State: AOAM532oojcSKr2m3TowOsLHnF6V2im2kGUOg9i0e/6FNcAfY7oOtMDU
        TQer7S+Yjc/9TlBx7PLeGNQ=
X-Google-Smtp-Source: ABdhPJyfZf1kd87pRrrExCJ+b3xLcL62oEsjZJ75v2VM8njyu9n+24QvJpIVGE41DcP5awZPD7qr/A==
X-Received: by 2002:aca:3806:: with SMTP id f6mr1826285oia.66.1604069218304;
        Fri, 30 Oct 2020 07:46:58 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:46:57 -0700 (PDT)
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
Subject: [PATCH v10 01/15] ASoC: sun4i-i2s: Fix lrck_period computation for I2S justified mode
Date:   Fri, 30 Oct 2020 15:46:34 +0100
Message-Id: <20201030144648.397824-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Left and Right justified mode are computed using the same formula
as DSP_A and DSP_B mode.
Which is wrong and the user manual explicitly says:

LRCK_PERDIOD:
PCM Mode: Number of BCLKs within (Left + Right) channel width.
I2S/Left-Justified/Right-Justified Mode: Number of BCLKs within each
individual channel width(Left or Right)

Fix this by using the same formula as the I2S mode.

Fixes: 7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f23ff29e7c1d..a994b5cf87b3 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -450,11 +450,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
 	case SND_SOC_DAIFMT_DSP_B:
-	case SND_SOC_DAIFMT_LEFT_J:
-	case SND_SOC_DAIFMT_RIGHT_J:
 		lrck_period = params_physical_width(params) * slots;
 		break;
 
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_I2S:
 		lrck_period = params_physical_width(params);
 		break;
-- 
2.25.1

