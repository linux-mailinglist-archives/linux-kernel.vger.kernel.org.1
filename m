Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A8272103
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIUK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgIUK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF67C0613D1;
        Mon, 21 Sep 2020 03:27:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so12137868wrn.10;
        Mon, 21 Sep 2020 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=ZW6wrgSMfYxgif33Kz/lroDpkdiTU4iuIn2PtCRXxOXVMe2ksDUa/8wIT1o4s3n+f2
         zQPk6E8LgsYiBzCwK3R5cUF6xsltrWBtsSR4Mi+S21+B6eMDu5+T0ZbBahPWy7u32YSW
         uHap/BiQx53V0PuL+V0zmtgETiMK3WGdjlYG9g3sTxHKkkej/QHS3nDDofkhTn6NBH2u
         sdKRoJMZ2dKz6jJA2+lsYvOqhTa37GFAHT/9qOwDl2GJcXJh9CfzGYM+pT67o3qNDTyO
         ls1w2x4+9ER1E2F88TsMT+RiItGA4ykcmrP/WktLLGM2SK8TnRZR6C+hdEeR8yTMA+sb
         6PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=Bkfx62Ej+3cXRxLiyFEWfESLTE9l2pwGCN+Olu4ndwpSX3wAH16C39pUEcddWeytjL
         PFJPcwsL/g8e30NcWu4TGhg6eo88DZup3n5qTJiRig8HIAS0pyUiSTszXmTls8CCwY5+
         DIfrbKhVBiICQCVSiCBX/3uWQK55F1OWAT+IgwGN19gC+8U+2x69AoJ3sMy3ODRQFWjI
         kOXW9c3ofrjVpUxLCrpQh+ArW+7PRXCSUY+s8paCgehwomCUvJGLUPk+5aBR5hTwaiut
         lB7lRed7RLE2yW/LsBWBWnJvHOS5OcF0AXcnOkbvv+l+gXT7Z0HEKoHGQ3iG7o7tkU2D
         jGmQ==
X-Gm-Message-State: AOAM530SSfEyMcQRCw8SN8ckcoUt/ZOOf2V7pFm7iXbjvEXi7MmFMj7w
        LYnioe/+VlDBZPO3Z6b1fno=
X-Google-Smtp-Source: ABdhPJw+N0hl60ai0XxfnZRrWPsVOUbJi8FOQfoxT8jn/Ckk1g2vrSblyPH5uY/eNBzU3OU62x1ZXA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr55330946wro.152.1600684077678;
        Mon, 21 Sep 2020 03:27:57 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:56 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 18/22] arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
Date:   Mon, 21 Sep 2020 12:27:27 +0200
Message-Id: <20200921102731.747736-19-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..e6ed8774a17f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

