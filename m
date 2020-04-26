Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED11B8EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZKlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 06:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDZKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DCC061A0C;
        Sun, 26 Apr 2020 03:41:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so16965111wrg.11;
        Sun, 26 Apr 2020 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=GVicEZ765w25hm0QJA+jwt0ntOUVHGzU9apsShWdCViWNo+JW8gkmx1xPtwvshP74j
         VYqJhWwIC0eV71oza4ntOhdpqsMRu+orFdBftGB25Etp3vpE/9ii/nu++7U7F2J8k2zK
         l/GzHn5k7vhwEcM0qfL0mJRJb71V83bYw1ZEBudc5ldbv4G+B3iNdrGZDFkxyFMsbDag
         r0qbzmpTLzDzzEeqPMfRXsW7ITVB5wAbd6arZYfDCVZbjOLQrpxNbr/4chxw2EwjKUkT
         mce++iqxtrMy4UApTygqhmi5QSGuyRMKiy/hphzs9uYIblE5yGqcHgnDnIq/9YW4QBx5
         NvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DEFjpIBB2sTg55bEJY9HmamuD/w0H5V9QfSFLKTLl8=;
        b=r7MijpT0pL4gzX3SI0KNSCq+5BBDWaZ51N+oUpRXQF9sqU/4xv3PQbKCKo0rhMqBwS
         9T8sXLvnj5mQn4HOMbtPEyy2BpgWlw25NpzhNwLIIsMrVbf00SqY8DP2gaTorOy5vhny
         +BVeHjYQHBOec8TMvvqmJruXYfhkLb6SR8pJQh5vY0n3vgdL9UeBgmM6783m4rUhkF6z
         okIG9CBQIZ3VRQwhf+AIg0mBGXne01vH1olX3AYqkav1YXNz9SHxYZf6apPW0URtA1ty
         kSerdoHpXtTs8MnVWBf1gNNHCYNcwm9wDD295TuQtsBdPaeH97CqsD6zdFbpF5JYFeb3
         Y4fw==
X-Gm-Message-State: AGi0Pubb+gZnS+EqDSboAo8XGqynOmnx63Gj6kC0DRMhGCgz8gC8ZhAm
        /Whg3NC4jt3KR4wKE/ES4AY=
X-Google-Smtp-Source: APiQypKL+/Zpp7aS/3Z23c8bef82x/2zXan/kO9l+XrOWepY6IjRW6LLnp9w9zsWrcTRH1NOiBrWxg==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr21760639wrw.228.1587897679839;
        Sun, 26 Apr 2020 03:41:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:19 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 1/7] ASoC: sun4i-i2s: Adjust LRCLK width
Date:   Sun, 26 Apr 2020 12:41:09 +0200
Message-Id: <20200426104115.22630-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Some codecs such as i2s based HDMI audio and the Pine64 DAC require
a different amount of bit clocks per frame than what is calculated
by the sample width. Use the values obtained by the tdm slot bindings
to adjust the LRCLK width accordingly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a..4198a5410bf9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -455,6 +455,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		return -EINVAL;
 	}
 
+	if (i2s->slot_width)
+		lrck_period = i2s->slot_width;
+
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
-- 
2.20.1

