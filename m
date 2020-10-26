Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C882995E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790510AbgJZSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:52:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790496AbgJZSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id n6so13872168wrm.13;
        Mon, 26 Oct 2020 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmEJBdHb8VsDTUc8zqykHFK0yjqq1TH3D9eWn2/3Qmw=;
        b=EZ3OY1dkf31OorA609trYpGLeyIew6esjS9e8BQHbpcZuUwVGTriDEjpCi1Zk+LEkJ
         1A18WVYBtHmS7RsvUewv3EQfcuySD5/k+59Zbj1RE86+yY3zZTTCaA1CtaaMCNT81YJ+
         9+DgZR6qq+wGoVBgql1u2KasVdZymdkWNwERujKYhqXU/Dd5YKOX9xvBBPykW8ZwPzjL
         YUAxHghmvuelssUfQdbIMB+y2SchA3fl6uSibg8T6EUtS9KJZ6V+Q4eIHZ52X+w8CgwA
         OoRXYBrzdEdAokD1CXQjdRGy3ljDJzWseJ+IbmboKhWJtdipl1fzQE1RInpSx8/Cg+X2
         nw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmEJBdHb8VsDTUc8zqykHFK0yjqq1TH3D9eWn2/3Qmw=;
        b=Zqq+Z1yfJq0LuzeXUqybXR6ebWGhh4fzVV0Gjm1QIl9qRjbHyPzk8l52hRPsxRMwq4
         dzt67J6HoPp7Xa3VH1bZmOpqtYjDFTYEis4btYiyQYKRG1NivSFaE6HvrOK3Y3rbflqn
         +yt/J5vpudliZGmRUatTjIZpWYQ+HtIXu69pQRPiUCY7zKYN73d54Y6YPjGGDL99BLE9
         T7MACbeEODc19k/hDH7Ow9TiFAWwZK8EO515U12tRONqL19weBxdcd/FTOoSRw2SOq4x
         en+7QPwyLPTRF4NrclYqtansQlbBua0c4U8tld70+sAQ2yCJtBlzifF+OOLaCSESR92T
         6KXQ==
X-Gm-Message-State: AOAM531rI7VZSYI1A0YzE3fYleleC3qpEIicK5fjL6N78W56A5BT2tw0
        pmKfY5QrWCyUmEgB9yOe0jk=
X-Google-Smtp-Source: ABdhPJyml266Cz1fL8lVFciN70lXZHCur+b3U/JH6rFPzhIRH+rKMR3EO1e1BMWSPUXHB/RGAFJ2qQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr19196554wrx.76.1603738366350;
        Mon, 26 Oct 2020 11:52:46 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:45 -0700 (PDT)
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
Subject: [PATCH v8 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Mon, 26 Oct 2020 19:52:28 +0100
Message-Id: <20201026185239.379417-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
index 5bec7fbd0b30..70a2ec99f444 100644
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
@@ -581,11 +600,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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

