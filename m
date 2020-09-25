Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B89277E96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgIYDbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4CC0613CE;
        Thu, 24 Sep 2020 20:31:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so1832367pfn.9;
        Thu, 24 Sep 2020 20:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJuOLx72+92KqltwYqwVNl56PLsPiVCcbfEjspSLtf0=;
        b=Wh8JK4jEt5+7/CflyAiSgucZToaMllRql8LWZzAJDngHaMT/5hRNWMimrTE43KPke0
         yLrRa/FAMaNwchVbNQQVxBAfltMWeRmzwOw59XSyx9iDuJi+J6t6ZqJZQBv/A7Whx5ou
         5m7exthlnPdaOgoCIoIPQf2R4futG3/YV2mglKt+hqahvbX9lTyobKLCEl4r7ehfutoB
         04SJ7flauyEvA9bLNc81MmTdUMWZtC3UDDCmIkJOMd//R+Fc3BZwKclnc7DTYo5FuLFv
         2JfDu6TRKVggc9URGAzb9ERNKr3FmgLqnfoIRM6xWNRDUGBacHrVZOT0TtX08mRMYlE1
         O1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJuOLx72+92KqltwYqwVNl56PLsPiVCcbfEjspSLtf0=;
        b=KrKS61HYdFLwaS6NJSdiCygeVn3vihyW5+7vNae8jntgUZQAgsTuknwyTecQwo2Lsu
         9tIoX4MD1UCMJh3CTx24lO2NGv8LGw4WN/btMn+5VMsXAAexEEbfAWalzHT5Lmi7GZNE
         AZvGvRplG+d+ShOm67leez8d8GOIGQInkwR9h6H5z1w3lywu0Bc990HWJe5fcQ1OzGyI
         WWSUsBe80SmfMi84vAvK3G42PFRfsHC79HyoJCLY1bjiz4QQZ/eRHqfRAojdvguriZt2
         J0xpZysAYQGNhvCQnLhJDVDVlBZ2AGLaNxWQJ5iWA0kitYvUHlJ3b9lXRj6lkXHoRwJt
         TSUQ==
X-Gm-Message-State: AOAM532WProXajuH0xphIMuN6lsSF6BwiMYG8i2hiDvPNi73bFMY8v+b
        vu6qQolhtrApBUZKQaHopt96Yl1CSAajVtDw
X-Google-Smtp-Source: ABdhPJzbZJkwC+CtxMZqzP7KJm/AhFiLRJVm0zlxBBf6M3KWhAOZ2d+1frFvEwm5vseS5ug2NLDIvQ==
X-Received: by 2002:aa7:9986:0:b029:142:2501:35d0 with SMTP id k6-20020aa799860000b0290142250135d0mr2184228pfh.48.1601004678660;
        Thu, 24 Sep 2020 20:31:18 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:18 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 6/8] arm64: dts: meson: disable vrtc for VIM3L boards meson-khadas-vim3
Date:   Fri, 25 Sep 2020 11:30:15 +0800
Message-Id: <20200925033017.1790973-7-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vrtc not used for meson-khadas-vim3

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 3111bf35c0f..81bb88a76d5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -284,6 +284,10 @@ &pwm_ef {
         pinctrl-names = "default";
 };
 
+&vrtc {
+	status = "disabled";
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddao_1v8>;
-- 
2.25.1

