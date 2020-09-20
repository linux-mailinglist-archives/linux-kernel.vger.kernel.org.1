Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DFB2716BD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgITSIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EDC0613D3;
        Sun, 20 Sep 2020 11:08:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so9957375wmh.4;
        Sun, 20 Sep 2020 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=Zu2ABOn6ojEuxd2rsNQ4pw2PGOeYwVMTqlDqwgJMkNacmiIemvC7puK70NMNwZ0HBy
         9evI1CfGg/14kN3yGetKM/XXfhu56PAonM/V0dOdhxBzQ3P0kyBsNtALHwWV3WvVNG59
         PoRu9ybaJ6ER+ZhbVoVicmu97p3psxbZ0GMxjKAW8SufCH9UqMKc0xWSKCdDVlf+Tt5P
         NOrn+QlxlP2FzxcjN1txq+dBx1YYKYkG+N9U9tDqwpTt3Ck5ukBR871TXOB/7q6GuqVJ
         r+8m4uDhRcHN8npDNfaW3tUHG0Kj/2zZu9Tn0+fUw3W17vmPZW8do0OBmRWXXiSHMNRX
         V+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtKn0+o2ojoOITB0B8/ryvpv4K4vTdQg90PI/damrA4=;
        b=WSZU9s6bxzcdw+lwXoVKMXr4rvp0TaSMqquzBinL0RAIPsguXFU3XJHLNEljqXl0U7
         2S3KD7xLN0ZmGKvpLKiNKPhYk9YpXEKs2HbtJ7AxDDH6hP5YkyG72TshZfMRUq9kzDQg
         TLPiey6Le6WfiynlXWDKrwU2qTdGkV624q/6Ih7Zh9KERCeeWUe3WCb/L5g/l0gM943T
         1oK+0RVGXH0H+QME7YEzwGuor/buR9u3Du+S+9t2LZof2p5sM1oruWcWfmqzyVvcTx4M
         e7yaOLI9XN0CvR8dCefCYM8aomQKLR4PlwXFHCVcZ9Pdmqxo1MG17glAcvPWToCeVK1f
         Myog==
X-Gm-Message-State: AOAM533wc7hMDzBU0/fBWpu9AfdteTXtQ3GO5Av52YNWxnYr3iZFgkL8
        9/+N2uXoxglJhrsy5xMCi94=
X-Google-Smtp-Source: ABdhPJxcWofN+u6eoYjQGzo8bp4uLOAGpdgJZ2j6m8IVnWiCimUtyHJT8p9v6RyvFh6BVJDTU2l+xA==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr26268957wmc.123.1600625312686;
        Sun, 20 Sep 2020 11:08:32 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:32 -0700 (PDT)
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
Subject: [PATCH v3 17/19] ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
Date:   Sun, 20 Sep 2020 20:07:56 +0200
Message-Id: <20200920180758.592217-18-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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

