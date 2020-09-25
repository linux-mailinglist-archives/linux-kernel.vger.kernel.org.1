Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C35277E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIYDa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:30:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5351C0613CE;
        Thu, 24 Sep 2020 20:30:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so1863990pfk.2;
        Thu, 24 Sep 2020 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KQTxZf0bfhyGYMi8KtzFD8YblRkrVomATGLrXDwnog=;
        b=YosSqy7cobotutcKgn4G0gQvn+0v2bwFE+G/DDsJi5aI883FCbg6wvlf1fguBzxGOZ
         cTmgwZoMMoT/Pk2Fx/HPlrT9Vo1P6zeJ2UcO/cQRiI5iWH1R2eacb2Ry8cUxVwO5dniL
         O7DAoEsOBGxQTJKNg6Kq6s9Y16A1xsTh1shQdZ8pJ0MZ3fcN06/N0qm1Wy+FFyvRY+z1
         TvsJcWxaE0G6GiyRygJ3+K4TETxJo9gr8KyM4xjAFUmkplOFI13WpeQXOj3pzkCclMZQ
         bLvhBVsOROeOuZokwHaRlSFwHNXaDVvQLOfIqJO4yCoAFj7N2tmEkt2LJrr3Iozc62tO
         WE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KQTxZf0bfhyGYMi8KtzFD8YblRkrVomATGLrXDwnog=;
        b=YB7zFjqtXeA23J6iz1R81jxm+D+Vdejmlor4DAmyZv7JUpvKINilOYY1a/ZJ9UpI7q
         O9DjQO5vZwrU9g2chC6fEuJf89vLCW2+F2PRgUqbd+JP9SNglNDntXZPx2gMh47ManQT
         QhN19TqvBv1F7dC25FFRUP11mc4wjc59CPfJHIP2YKTYUTkBwsM9dWcdHbD69cv86cua
         CmnanvsHewdmNGJoLbW0RCWs+acciM0J7QZu8X2vlcFCePeIxgNMdrbPTa4WJkCUiKx2
         1je+1XO19xutdhnHzMn+W5Kogg7xcmhvlBOVZ8S/Vg0a0yawnu56GbsCKmpfy8/MNSmz
         Kn7A==
X-Gm-Message-State: AOAM532qUKd+s09O/rCD4F0/XX50uc/jyhkGgoa6sNtLYqeqOI2ndHkr
        XDNFos1ABhM7aAiOA1ZZElQ=
X-Google-Smtp-Source: ABdhPJzcMyQu8E1h//EbcZIJYXFLs9rjclUB2aHrJuSyMd11IG71W8mAVetxRrNjR3weZMJAZxf4Dw==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr1765740pgm.82.1601004656271;
        Thu, 24 Sep 2020 20:30:56 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:30:55 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 2/8] arm64: dts: meson: update leds node on Khadas VIM3/VIM3L boards meson-khadas-vim3
Date:   Fri, 25 Sep 2020 11:30:11 +0800
Message-Id: <20200925033017.1790973-3-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_LOW replaced to GPIO_ACTIVE_HIGH for white and red leds

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 94f75b44650..73783692e30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -41,13 +41,13 @@ leds {
 
 		led-white {
 			label = "vim3:white:sys";
-			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-red {
 			label = "vim3:red";
-			gpios = <&gpio_expander 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio_expander 5 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.25.1

