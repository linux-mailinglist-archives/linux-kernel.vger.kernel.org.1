Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8629AC56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900168AbgJ0Mlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:41:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37784 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900150AbgJ0MlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:41:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id j30so2139440lfp.4;
        Tue, 27 Oct 2020 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5MHF+GS//NLoxtDdJvGf+EKzs5shXRufRzejDPH6Ww=;
        b=bQmlgGWaAj6ONZe7lIbtUhAeMgidNVhcGFgIP1nEGtudEb+k4VAK6dPj15Mf+gC3v5
         XJZTewE9/lJ59NFEe4YZ2vk0WMq7fy9dWUqG8L8afW7P9zTWNGQldAsKEBrdfgSyoZJP
         X4wBuEphxxj++zNFlcOFG3/UEyTbUpPiJiE+wBm6qlvpcjTVEAUD1ATN11kmjHfRvE9y
         WG7QrQlvcgAwwwJMDUajTKtVGBX9LwVqWBNK8LQa5/chLj4kY6LxmvcvZJ4IPwtvpt8x
         9xcf4FsogsSceGLFIRd72yr4hbDBGQIXBBM0traMyIzz13Dv+ruUjhyCz0SM1hn3He1r
         SEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5MHF+GS//NLoxtDdJvGf+EKzs5shXRufRzejDPH6Ww=;
        b=QxNK5CrMn5CfR9whRav+P6kiDda3LRMGHivX46rYjVhwOpEstcY0ROd4KqJjP8cbNc
         9i1myfDUbnh1LJFGZGesxazLjhDOPswAJlvABFyYwnvQfrweRh61lNNDnGyas4qgJ8XI
         aZung7RD75xuOgZXRbTgswTGHAIQo1XHu20uEX4H4b6rSo/dw1oBhV532Gf5rUawPpzZ
         am3oIJUqb8ZjFvPvJHlGh+r9Q0lbY6bemcXXtgVHZLrAnWxWiam7/tVVmLoyrtoY2pVj
         5Hr/vwydSVlP34Ict2rhUJfpHfzhW4adjypBltDSHv61OWvAEDaIjnqG7/1VK6yOuqnt
         rnqQ==
X-Gm-Message-State: AOAM530sldTyD1AZYt3ZVMdNEBzDNFHGuO76grAi+cU+VBP6V92KJs/G
        lq2WPscm94NjotnShL3nxQU7sMCdKoY5eoep
X-Google-Smtp-Source: ABdhPJwL7ovGKGXskH6rRkXZBnc//Bv8sl5bhQwi8/HtQ1VqxOKNaST2YV/nEhhIHFbBLWbnBKQqWw==
X-Received: by 2002:a05:6512:322d:: with SMTP id f13mr744638lfe.571.1603802476481;
        Tue, 27 Oct 2020 05:41:16 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-8-148.ip.moscow.rt.ru. [46.242.8.148])
        by smtp.gmail.com with ESMTPSA id e15sm49132ljj.60.2020.10.27.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:41:15 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: aspeed: amd-ethanolx: Enable devices for the iKVM functionality
Date:   Tue, 27 Oct 2020 15:37:22 +0300
Message-Id: <20201027123722.2935-3-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027123722.2935-1-aladyshev22@gmail.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB 2.0 Virtual Hub Controller and
the Video Engine with it's reserved memory region for the implementation
of the iKVM functionality in the BMC.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 2a86bda8afd8..b93ed44eba0c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -13,6 +13,21 @@
 	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+
 	aliases {
 		serial0 = &uart1;
 		serial4 = &uart5;
@@ -220,5 +235,12 @@
 	};
 };
 
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
 
+&vhub {
+	status = "okay";
+};
 
-- 
2.17.1

