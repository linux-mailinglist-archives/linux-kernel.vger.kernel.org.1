Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375502720F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIUK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgIUK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860BC0613D5;
        Mon, 21 Sep 2020 03:27:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so12147753wrr.4;
        Mon, 21 Sep 2020 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjb20+qzG//QXYZPPH3YllTlMZ4wlxmmKse+Y7AgH+E=;
        b=Gt5MPgd+eGWukOpWw3gbzAbL/PMs4sfkNXWEj1w69UzlkmLKPkcHZeZasIzmb1EkoU
         8Wn3kISsGZC+6gp3TOi5DFPsEr2e0Hit+oIaKb+m+eDAlwXaEYwaygKvHnLhupgDSTEc
         zZEf1ju1cx0aEbHoIntF4ShFl04am+xCvdxE+zcsnMDTz6QGReRqugsf9gWC7+CRa/lX
         08XS3vFRbOTlVi7keYC/7pBxmphOJqYEmKIYPLA6fK25bTNF01GyqvkW33Wl0HsgpYFz
         3KCiWyXJUfeYNplFTh5xZpEglbWdi6JcV6JxZgggAvUbsafJXsTPD/4tsDO7dr1w7J7s
         nPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjb20+qzG//QXYZPPH3YllTlMZ4wlxmmKse+Y7AgH+E=;
        b=Fdd5OqsEK3739XmLiGwSDg+03hCVkXWUzHlEzEk2c4FK4R5RPsrT8FqOHFk02H222i
         uhIxZBi8DusD7/oSUBXeWVNsRsZ4CFrTqzIRT0lNu6ycLyh4ewxLq69D5V7skOVSp9pB
         ezSp4Ym1UIztpsmaOnopR1CTepgTR1ZtJJINyOAaicNmKVACw/hAzGC300MmyN9JL+lp
         wobkn5AuniyfAGqlsYJgZeLGMelQcR+Y7aW17gYmZLP/NMVWV/yOlVxJoZYduNh6vGC6
         IQHW8yJYEXLkilMIRe/2ao5Kk4XxNV+22AHoMKwqVSK/MNdSlyHrUVKcCXqXXimqjPhB
         Rbqw==
X-Gm-Message-State: AOAM532CO0MySMxSzIYQiMZ4KqhNFBRJSsgXjb1dthyVU2B7/HCge6bI
        s7ZWl+CESNPA93NNNcZmv4k=
X-Google-Smtp-Source: ABdhPJzA1z3pUFLEYQEpVnYpNBuM/NODfBo4WWIgEhPHBWxV0uyy/NRr5b+d/VxrtgC/ZJKR3iLlGw==
X-Received: by 2002:adf:e481:: with SMTP id i1mr51402018wrm.391.1600684070367;
        Mon, 21 Sep 2020 03:27:50 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:49 -0700 (PDT)
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
Subject: [PATCH v4 12/22] arm: dts: sunxi: h3/h5: Add HDMI audio
Date:   Mon, 21 Sep 2020 12:27:21 +0200
Message-Id: <20200921102731.747736-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add a simple-soundcard to link audio between HDMI and I2S.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3dca6d89cab9..7168e9412410 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,25 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "sun8i-h3-hdmi";
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,frame-inversion;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -806,6 +825,7 @@ csi: camera@1cb0000 {
 		};
 
 		hdmi: hdmi@1ee0000 {
+			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-h3-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
 			reg = <0x01ee0000 0x10000>;
-- 
2.25.1

