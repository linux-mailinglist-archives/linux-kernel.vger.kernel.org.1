Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD1272102
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgIUK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgIUK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:28:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA47C0613D2;
        Mon, 21 Sep 2020 03:28:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so12040762wmk.1;
        Mon, 21 Sep 2020 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=ErItnf5+hg6S78MglnlJMCuvZHkmSchH5BDlqULqJN/7w+EuU0T+Fn59c4vmjj3t0p
         pGjN3xd8iQYOztbVjpI7mWuQppPuasNW76I9wwndH7vJ1sYYCKJ8aNSL564OnOHuU3Qi
         +7Oq7g7h6WQbFhJBsU6LNNe8IOXchAzMDAMzbyMX2aFfx+7jAmMHTvUKcHHMYas7saqp
         HJkxLLRC5sSZFPoeRLkkRQbl2s2OlQn5wZALFCRAkmxEYKG9SI0jrNSX7f/QEfSqndy7
         8otsIVNsGbWamN2IBsML28PZvEQLJa8ZJRzAKt0coXrMmzPVmE5Wbls5y+Xeo0NMXoSS
         Pzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=BOFQGo1t//xM+WkwpVXZ+hxPLk9c/vOWQMOt2VbqKH2T3uUPsImP2dHa7vgpZIdCzl
         y7l5EisYAHfm5EbDiimlrE2QSgXcCiuciWoCOfpxZbtixfTeAqfG32+CDGigJ0JLbtek
         AykGY6E9y6cIAeHO4/ocxDn9Kaq/mWDTXr8c7BKr/nSDcGbm9i0838B/XU5a2tCQqh7Q
         moZ9c+5yqOEXzGUTRQlrMa2kgDbyjsNpyKI2dEsa3ioJsXl7CogBHdrx9Uy/BJLm08Rz
         pDG3xHHFbSH1KzB8wMhnTzJv4Owt3WLKOHdNPKzXNaJ2yJaVyFCBQikrsWiRVlaSLLY1
         jwJw==
X-Gm-Message-State: AOAM530gYy25MmdIbuZyTqJJHRqDFiDGCL4U+p/fJIjWUbanuIcVGhwX
        +ddIlJwjGa985SMH9nU0jxcJL3oUUHbH0KBx
X-Google-Smtp-Source: ABdhPJxo9vVt1sr0+/0vHFfnTaHHlUc7W3oJFyDaZFZDbaKWKZlWwja3LVFhtmilANhiT1a8V2TSiw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr30635623wmm.102.1600684078758;
        Mon, 21 Sep 2020 03:27:58 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:57 -0700 (PDT)
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
Subject: [PATCH v4 19/22] ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
Date:   Mon, 21 Sep 2020 12:27:28 +0200
Message-Id: <20200921102731.747736-20-peron.clem@gmail.com>
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
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 8 ++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 4759ba3f2986..a5b45655fcf6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -146,6 +146,14 @@ hdmi_out_con: endpoint {
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
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 5aff8ecc66cb..ebb12a6f3a9f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -146,6 +146,14 @@ hdmi_out_con: endpoint {
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

