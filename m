Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71D2CD979
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbgLCOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgLCOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:43:19 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D22BC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:42:39 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so1267568plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1uEb0a/fmwKssKVnSrBR+CZio6TfcFmqrf9Oztpt7Q=;
        b=cu6WnOczavFxEWRHaoPN6CUs+gLeJUD2zGzQ3oh9c5iR2hkaIo6eCLeAyCHQ9qVdX0
         +6SqEnDvIX/LnqDjW0+zKMgXHeqMrj2YmqvtaJ3HE60MqEt76xPz3BSyGBfWOJej6DhW
         UPjXJFKQyZMgNe39xyHKjMeRh+VZvK31FGCF3X85utpQgNj9/vp1DriMUOgLiWhNJsjo
         OacopigFvwkfVyVw4+I1Ma4/tlsJROvjRth0fPCx2wZgEvHmDiGMl48jSeL2cUqztsaA
         +hESuv1xIEks0908Xa58SvcYZu+xwvfcqAoZaHIGF53ISWQrW2Q65kfJMaOpVOi+CRGg
         ECnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X1uEb0a/fmwKssKVnSrBR+CZio6TfcFmqrf9Oztpt7Q=;
        b=OEH+IFuQrJPeB6BwsXLIomEzgfe4U6YuATz4u7dFrmQhShQ97PI3xyakUr8ODD/44H
         eOlRjLY+Sk57p7f0IeCCdHEZiU7uF1A0saH5p/C2+5RwoSRAXdPYqY2DXJBAe2zevUv4
         6Def/hbpcdGbQ3v+wD2B50IzB9EAksccqy0fTNFzjMoBoTeN4p6bT2XGqOe33aObRx1+
         Cscub1H7AmoDHwVBbC1oWyJoXzLxxl1GueVc/tFGzNfaEUd/punc6Okr6bwqfi+Ggavb
         geU4CEMwZO3HFbagtVGSmB+0GZv2qklo5Eb0q/5yOjKSHuh7oU/3rZOCFzrDQpptJeLq
         J6vA==
X-Gm-Message-State: AOAM531ZXGUq/iWKC8f4Z9LS+2NwG8OTQ73UsiXsFBAtMHUkNrHfqvZA
        fuk6PXf7wC4nM61/n8Dw3E0=
X-Google-Smtp-Source: ABdhPJxdHH4SAMRmQgv5v1Pp3rTzUgxcXuJOi/Qz3P0KNxhymGiQgf33YHqxGp+RmfcgepouNJlSXQ==
X-Received: by 2002:a17:902:860c:b029:da:1ba0:3979 with SMTP id f12-20020a170902860cb02900da1ba03979mr3490630plo.8.1607006558805;
        Thu, 03 Dec 2020 06:42:38 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id d2sm1689322pji.7.2020.12.03.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:42:38 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: jz4740-i2s: add missed checks for clk_get()
Date:   Thu,  3 Dec 2020 22:42:27 +0800
Message-Id: <20201203144227.418194-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jz4740_i2s_set_sysclk() does not check the return values of clk_get(),
while the file dereferences the pointers in clk_put().
Add the missed checks to fix it.

Fixes: 11bd3dd1b7c2 ("ASoC: Add JZ4740 ASoC support")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index c7bd20104b20..0793e284d0e7 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -312,10 +312,14 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	switch (clk_id) {
 	case JZ4740_I2S_CLKSRC_EXT:
 		parent = clk_get(NULL, "ext");
+		if (IS_ERR(parent))
+			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
 		break;
 	case JZ4740_I2S_CLKSRC_PLL:
 		parent = clk_get(NULL, "pll half");
+		if (IS_ERR(parent))
+			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
 		ret = clk_set_rate(i2s->clk_i2s, freq);
 		break;
-- 
2.26.2

