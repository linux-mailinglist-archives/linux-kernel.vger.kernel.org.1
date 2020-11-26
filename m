Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CA2C5245
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgKZKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbgKZKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:45:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DAC0613D4;
        Thu, 26 Nov 2020 02:45:58 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z5so1312563iob.11;
        Thu, 26 Nov 2020 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+toeeYi8DQw0/gPDX9PxOAus96It9Tzv5UuE2R5wlY=;
        b=nkK8img4nofkjSmb+XBzG4Nwqt3dg08RcQxzLTLOu0jacpNmnIO4SyViVuv/SqB5Bv
         ru+i04YdAC4HJlKMWA2lixO96k5YNrhAXFs8hjFn6RmY9h7H4TJMVW2ApohRU3+ZLFee
         oY7Owfrx8Dp8Wizu5AxqKBEf4rSv22NXfSX6Zy+AM34g8sqMmqsCtHVUbzo//SihB0lo
         EHBERDHfXczfRx+rUkUwdBiqvIHBpNarHyz9AvjTB1ds+iqUctQJwjYVk3ZTbsMnjHEz
         MkXbgFaoO6PpFwtHbW9YRVU+tNwopp7+vKLXJFKGVszOj9zLl1odNwA9zG9mQs1O9ohj
         Idpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+toeeYi8DQw0/gPDX9PxOAus96It9Tzv5UuE2R5wlY=;
        b=hVafIVwRFfRlqLXE1WOtyAML2W0LBI+DlZU9pZ3vI+kNGHua1Lk6gBQO66SNKpwLhB
         B05L1onI6YPXs9S718WUv/fGF3llXTt9YAJI/MZYyJRI8XLQLAOrzP1LWrBNkhc3taDJ
         7V9qnx4j7q6pCaxLESLiTt2n9hfOGeEeXEU5Rh7EucFz5bNphr1a8CwASpKQxz3EgLJp
         TlG6IeBt53yVHP1062lRUz+3M0J14vXGVyBrjGuFJ2UQTkTywvYgG6z/w+9scnr06954
         c+QEBLL5q7yR/UIuFSqy5rCO0umcn0YkaDDrNg9RA36MS3d7WJeBCmxKWvkhLRLeFQxZ
         d9oA==
X-Gm-Message-State: AOAM531oXYY8KsQeIIPhIzeUn5/RmfpeB8T4Kfi2/r8PpTTQc9rlDIy2
        ZZ1kkBc49S+CTzZqx0RoCkc=
X-Google-Smtp-Source: ABdhPJxsaAv5QRlafRhiwwr2Hbp3YEB4FoPW+S22K1dCCtGQH7noHTQAJizgbts4rSiA5qjvb9ks5Q==
X-Received: by 2002:a02:930e:: with SMTP id d14mr2562096jah.92.1606387557484;
        Thu, 26 Nov 2020 02:45:57 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8da2:e979:8d1:eddb])
        by smtp.gmail.com with ESMTPSA id u11sm2366189iol.51.2020.11.26.02.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:45:56 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] arm64: dts: imx8mm-beacon-som: Assign PMIC clock
Date:   Thu, 26 Nov 2020 04:45:35 -0600
Message-Id: <20201126104535.1075658-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104535.1075658-1-aford173@gmail.com>
References: <20201126104535.1075658-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC throws an errors because the clock isn't assigned to it.
Fix this by assigning the clocks info.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Remove fixes tag

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 9bdefbba9e90..d897913537ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -111,6 +111,10 @@ pmic@4b {
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
+		#clock-cells = <0>;
+		clocks = <&osc_32k 0>;
+		clock-output-names = "clk-32k-out";
+
 		regulators {
 			buck1_reg: BUCK1 {
 				regulator-name = "buck1";
-- 
2.25.1

