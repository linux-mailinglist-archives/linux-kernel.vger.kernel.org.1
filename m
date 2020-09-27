Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E153D27A2B4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgI0TaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgI0T3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC0C0613CE;
        Sun, 27 Sep 2020 12:29:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so9492202wrn.10;
        Sun, 27 Sep 2020 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=ec/nBSVtLqLm+8O5jvfkUt2ne2fgh2Pk7OHZtZoDFquzebrPCcyATT6JqYLYlyliK5
         pQpn9fx/rYEWCTTDg3ABoUNCrFLyG9OCP0cxSbI8GLXWHd/U9srHGzgmLsn8JvG+Zv62
         mpBkNGhfXP2W5l0w+8du1hSmGOSd7MdzJ3oPe8t3rjKsWl4RoFTWEvT7ebcxiv0rLx/N
         PLNnXFZ8jdvXBXUvhWWef3EgGAYQQYKQbV3NqcVEYq6UevOczWn0sTqZ+rCgpXSzxep0
         KApD6YdLTkEVOC2PLuOg18iOnhexv39YyzHEAKLbZ36OUYxo7LVITGJsruW3wmmQjnxk
         mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=AKU8gkkMTxKfBJ2l1RIu7GIM1Tcj/l0ntnApn36BwPFrY8pkJB8DYt1JEvldQNZxPM
         Tr5nWg//6zMwepixXBqf5sMks6y7YfvYWqFjAcwiXKQBe7aiNGRosciWVUtm94srNV2c
         /E8tQVDA3U97kYg7cXjNM3aDrjkH8rv44yqS81he7RK4hyJiQ9FePz8o4FuJB2zU8oeN
         c9B5c9lBEO125bhXwqSlt7UAfcHtmRxAL0DsdcOwSdN513Ucal3N9zHtZI7z4fvD0ZRL
         0kgmJXkdmhjBpmWAC4Sz/905fKNN56SHOFa/UVLh9kiNYnDk9XqOSSNUYa0Gs4T3eOzW
         bRTg==
X-Gm-Message-State: AOAM530z+qv7c9TCkGsMFJZJWRL5Sjb2pMjhg6jn1m9Duwe5f9Qn9wrZ
        CVnwAqTKgRXS8Ln6uDdc9IP/jgp7hKjFTQ==
X-Google-Smtp-Source: ABdhPJyv0D+mC53gVQf7mF2GADpU37fvw6wJOGa0nM/DxKoV/zqI5cE4prxkH89c1SvMhlQMw/SmsA==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr16570978wrr.149.1601234976814;
        Sun, 27 Sep 2020 12:29:36 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:36 -0700 (PDT)
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
Subject: [PATCH v5 17/20] ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
Date:   Sun, 27 Sep 2020 21:29:09 +0200
Message-Id: <20200927192912.46323-18-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

