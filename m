Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC042C78BF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 12:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgK2LJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 06:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgK2LJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 06:09:49 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED261C061A52
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 03:08:24 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so8042871pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Rwi6JrG1Bh8jLLcugHVfWoJr8ivQS6AwCC3H82H1b4=;
        b=Ty9oCilmE8NwmSmLvOfYQILMur+rnE1cbwhvpZ43RjMOm2PVKxqz9NZ3eptAmz+/s/
         e3GHuCGcqQdNlb9W7Y4ecVmWqokECnv9IUh9jzNb2jlh7X8VQj0ecIQOGOWItVqOc5M7
         /WHKM9N59j5iYDpspzSSFeGsgp52DzSz4JO60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Rwi6JrG1Bh8jLLcugHVfWoJr8ivQS6AwCC3H82H1b4=;
        b=BbTzYtWvjF+2S80RHD0fbGAljE/4Z81j3genMwHM6H+/Ft7+igzzPIb0uvSk746WBf
         8GefmpjRKULtIYU16SBtXfeLWVgrlaUrklsXNyNCgnmVAZl/ilqm8mzUB1nIkRH1hyzE
         dW5I9zNsGnWyUxzWszITyewmPRXecC0FIvbDylESajzTZCgU48YYQqVDHeeRdf/d0LVP
         TcTuL1dppGGlUUAxCeXkh6JPZ5RDxnYrXwwk2x4W/MGm6fsy/LYRielKijloW/KfdM0k
         2UW/CbYRugAaP71D3jK8Re5Zaf7TuoymPQI6gOZd41EtoYX/CTSltTKp1PDjl1Z/EjC0
         mxmQ==
X-Gm-Message-State: AOAM532BlxBVhrEhca5A0mspxpuvCG5Wa30frD4h1X0nf9IAlfeTpioT
        Pi7RKz4mEHBMF4gyrboZzovP7A==
X-Google-Smtp-Source: ABdhPJwdh85fkMA5+0fVUf32WCOFflhHqyFVX+Xj2BKoue3xfo/ozmIZwkGeQJHKEgE0r9y5ZYHklQ==
X-Received: by 2002:a17:90b:3591:: with SMTP id mm17mr20654240pjb.213.1606648104524;
        Sun, 29 Nov 2020 03:08:24 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id 21sm13095653pfw.105.2020.11.29.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 03:08:24 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v4 4/5] ARM: mstar: Add gpio controller to MStar base dtsi
Date:   Sun, 29 Nov 2020 20:08:01 +0900
Message-Id: <20201129110803.2461700-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129110803.2461700-1-daniel@0x0f.com>
References: <20201129110803.2461700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller is at the same address in all of the
currently known chips so create a node for it in the base
dtsi.

Some extra properties are needed to actually use it so
disable it by default.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index f07880561e11..81369bc07f78 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -109,6 +109,16 @@ l3bridge: l3bridge@204400 {
 				reg = <0x204400 0x200>;
 			};
 
+			gpio: gpio@207800 {
+				#gpio-cells = <2>;
+				reg = <0x207800 0x200>;
+				gpio-controller;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupt-parent = <&intc_fiq>;
+				status = "disabled";
+			};
+
 			pm_uart: uart@221000 {
 				compatible = "ns16550a";
 				reg = <0x221000 0x100>;
-- 
2.29.2

