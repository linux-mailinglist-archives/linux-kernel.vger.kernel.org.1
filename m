Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B6277E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgIYDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73436C0613CE;
        Thu, 24 Sep 2020 20:31:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so1866279pfg.1;
        Thu, 24 Sep 2020 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jglU+SiV8elxQvgoZoXUgpLHzHrCYPUEqbgg3flvfsY=;
        b=iB17I5MLcDdqsBDIVXoalHHZmf4s0hqBLYOFb7z1/JXB0cC4/koovTv+KXIJyw5HrJ
         yXOlwstUH5EmOJbjHqiLmOaK8K+MdHOvjR1v89oW0vW/ysbBzm3kXXXaRsirh6Hn15CF
         DEa9DOj+awrpPEaAE4aM2cpvJn0Wz/UYVW3kN3UHOQd1/UIV4iqeJOmjxiTpWec7pgFr
         dMe06kD+DzUdYV9hrs7XbLVLccAm7fTrkZlYeMjeQrW30dNv0aRg83LTnZiX5sc52sa0
         NVQD9wPYdp5mL3bM+vF6pdQg4DIp2PCTdJziOF7XOXFob18qpvpRZ7yX4pMP+C+ACOQO
         LH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jglU+SiV8elxQvgoZoXUgpLHzHrCYPUEqbgg3flvfsY=;
        b=BLx9jp0/lvj4021oHBgB+/673PTaHn0x75A5dzvY2TFg8Xrin1sGOIeG8kaaW+KNx4
         u4FoVdXIP21Qrs03FNoy3oa/6fOXw/cGl8vBxAju9DILXGdAtmzWEfgDxhLDozqqs2JL
         EHeS6hdcTTbQWavCs6w46ojCKEdyNizyAM+jHy7uspuEpVQ6eBgN/46Vbv0imlHoflta
         qIDYvVPxUF38qbjVQdkvUD/hlgIPflYqFaKqtLngjdVy4QUsxw+9WwGzOW2FXePoGBrE
         yAsDoLA0maUuZh4dRPSKa963+DszBgtA10uDDkBhG3nTVRCIwc2KnI0p6RJy/NdSQym+
         J9BQ==
X-Gm-Message-State: AOAM531vZ3CiUhwgNilh3BVezTsoSuQZFQP6SMsoy0oQQfrvUv7RfuBX
        grsjWV4wSphy+6+fK1/6SMc=
X-Google-Smtp-Source: ABdhPJzcxkQg6DufM5JjGTDliP//FibPsdxMSHlOb2Es9/WTh6ggpKHnmtyKdCkSIrRX13SgvRlvsQ==
X-Received: by 2002:a17:902:b686:b029:d1:e5e7:bdd6 with SMTP id c6-20020a170902b686b02900d1e5e7bdd6mr2206488pls.54.1601004689057;
        Thu, 24 Sep 2020 20:31:29 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:28 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 8/8] arm64: dts: meson: enable RTC for VIM2 meson-gxm-khadas-vim2
Date:   Fri, 25 Sep 2020 11:30:17 +0800
Message-Id: <20200925033017.1790973-9-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable RTC for VIM2 meson-gxm-khadas-vim2

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 70343da2811..76b7e34a9a3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -229,7 +229,7 @@ &i2c_B {
 
 	rtc: rtc@51 {
 		/* has to be enabled manually when a battery is connected: */
-		status = "disabled";
+		status = "okay";
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-- 
2.25.1

