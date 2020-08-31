Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB025726E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 05:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHaDtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 23:49:47 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53991 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgHaDs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44ADB58055B;
        Sun, 30 Aug 2020 23:48:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7CWxrO6xNUhIK
        /C5Oja7RYJCP9GppzvCcosOoPA19Mc=; b=YisBLVkB9UDkvdPp5J4DFa3sh2GDE
        gfJQFzNaU8B+F0P9O3cwFUPtkd9+bgjPZC0EmyyZB7MzkLTFESyE01bQhTHxppeO
        BYbNDvaAh6BCRIU24sf4tsqlu3UTg58qrS43WSYQvyjkfvcNT1BqJLIcQYgq+2i+
        8D6r22oJENhqMQQ/OiH1JIMLTHLPtvg2jtQcwVs87Ivtgc17niu5NRliA4TRNr4J
        FRfIqkTZPAuLgD419kx94QizpxnV/s4xnMw+8op4NrfIKrmQAas8XONhLI+O3cUp
        TGQesfgyxpaNCZHABQRF7KPaBNiA1Tj7aaDiUUrzMdzGvlPNOsZz4DrcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=7CWxrO6xNUhIK/C5Oja7RYJCP9GppzvCcosOoPA19Mc=; b=IkQVEbgY
        8QOtBuZU1CuOmXgSKUDtOPcwRXL5HLUD7LxZ4+LtQyW24Ofpoc+IhSbnSQNhvZXh
        CiJY//d0LYzR9yJukQw66fFXiiuq++AnkdpZ3u/YjSS5WVIHXlq0pPTOCzjndkmj
        IAb7ZfT8Ky4cuQgGoM7JHBD96x8jrwNuD0G7A/Zx+Rec6lK81qK2M3GWcuN0tsQK
        ryCCpVyr2zOwDZHLQUNrdqVzMEsQz+ujiydvitm2q6t5LimWsaZMJJwLqN0AZ+jq
        C44RvokeliPu4uPXTO4GYLoCY/6TJ18K43P1Su6YzxkbmIhhqqAj0lVj5pminhCb
        7mViLeGAnjVLYw==
X-ME-Sender: <xms:KXNMXz5Q1sPzHvlT50FAeWx_cT9wB9EDILvNT9Q8JbybYP3rC4H73A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:KXNMX476dfN0udxnRqQhwu8cxp9AOD7TRmuC1GGQQnJ0G29DiEavtA>
    <xmx:KXNMX6ean75SWk6Q3Bmd9wqm5XmexRVC6y5OkktsV3KbuBLkA1eaQQ>
    <xmx:KXNMX0JPvjf7OOh2ufzBJB4oUr34Ov-pvpijQWs1jnEj86hXfMHrCA>
    <xmx:KXNMX0pEq3eHuAEItbR_yHdmXidOAaJpZEelUB7QyudumU5qb4XAEQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9D743280060;
        Sun, 30 Aug 2020 23:48:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/9] ASoC: sun8i-codec: Fix field bit number indentation
Date:   Sun, 30 Aug 2020 22:48:49 -0500
Message-Id: <20200831034852.18841-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several fields have inconsistent indentation, presumably because the
patch "looked correct" due to the additional "+" character at the
beginning of the line.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 4218a00a9aba..62d4b1b44e76 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -68,15 +68,15 @@
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
 #define SUN8I_DAC_DIG_CTRL				0x120
-#define SUN8I_DAC_DIG_CTRL_ENDA			15
+#define SUN8I_DAC_DIG_CTRL_ENDA				15
 #define SUN8I_DAC_MXR_SRC				0x130
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L	15
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L	14
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL	13
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L		15
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L		14
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL		13
 #define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL		12
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R	11
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R	10
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR	9
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R		11
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
-- 
2.26.2

