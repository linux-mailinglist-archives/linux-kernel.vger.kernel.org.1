Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEC328AA4D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgJKUXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgJKUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:23:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8404C0613CE;
        Sun, 11 Oct 2020 13:23:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z33so8367436qth.8;
        Sun, 11 Oct 2020 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=Dtd8EF3HlfRs4MWa79LdCfJPJtUWqor9o0qiwofUy20/ORQGpQR3CoJUFr9p/A7v2z
         zPvQvVJyt2qvBwncJvzqdVGCtOv00Buc9jPUd4mI1b1QxYD0P9W1A9J2kLIsz6WbjKAl
         o4Z7/qzj7k1A4XAF5IOots4VKRPz7dwVOPJKBvNa57qe83uctt7jhI7J4pv4kIwuy282
         iAaAVtl/e2drs19Vlap3WYuJMIp6mshZV12RL3dvI0+7zfL+RZtGuLPlsEIM5LebDYO/
         0UZRyPh0diQFxaPHHDdvt1Rror0wcjrrQ1R+vGf2qA9kigcq1LZGRgDieSxsC2XCbDUx
         Kd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Id6RP1VS5hXJUMhUzwY34yVBORZ0nCdjPMNOwgBnW8=;
        b=rUTENh1oln6axDOWaVYDJApAa666cigTovmhfjiFmh51eDsAGuCOIApQbhtfpBKMeB
         +pNwmeKDYiQBeL9EssoVima/V5mhufsCfdUJGQ/YWzz9WBcomPbE6nVjt7BtUTs6cU5p
         BFqb6qkQKi/calCfjcw2Mm2R+vR+gyiui5UsoyaW1FDOwESoWfcNabObrKup5l0wBoGY
         MPJjdxUz2/r7MU7VQZODYdPXk8999lmb9w6drNUZfZwAskOVx1rvexQemz9fgnUPfoJq
         xNFyISSxD0rZ8sqndnawW8Y9vvdWiY59qDn6xvJaj2ar/wmf6s0/jZcLd2zaCzuVc2GM
         UM0A==
X-Gm-Message-State: AOAM531rCgtylO4NrzBNZ8t487Lit1P4B/bA+UeKJrmPd8oDHL/WbNyF
        5ck6FseOFNq77TcvtxbwiS1N7hgDIPQXPQ==
X-Google-Smtp-Source: ABdhPJxSEC9EpSHrro+wVXZqDV6OF6pY8xh6pzPC7pTckykvjI3LVHpwb+CsEvR7xNuEo/WfmLQEIg==
X-Received: by 2002:ac8:4808:: with SMTP id g8mr7039187qtq.18.1602447784085;
        Sun, 11 Oct 2020 13:23:04 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:23:03 -0700 (PDT)
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
Subject: [PATCH v7 11/14] arm64: dts: allwinner: a64: Add I2S2 node
Date:   Sun, 11 Oct 2020 22:22:21 +0200
Message-Id: <20201011202224.47544-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Add the I2S2 node connected to the HDMI interface.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..51cc30e84e26 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -846,6 +846,20 @@ i2s1: i2s@1c22400 {
 			status = "disabled";
 		};
 
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dma-names = "rx", "tx";
+			dmas = <&dma 27>, <&dma 27>;
+			status = "disabled";
+		};
+
 		dai: dai@1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun50i-a64-codec-i2s";
-- 
2.25.1

