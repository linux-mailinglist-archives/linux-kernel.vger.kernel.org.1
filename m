Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41A29DAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390625AbgJ1Xio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390547AbgJ1XhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:37:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821CC0613CF;
        Wed, 28 Oct 2020 16:37:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d24so1072987ljg.10;
        Wed, 28 Oct 2020 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blRKpHWKYllsC3fZsoBdHMYqC0YSHlFEixMlCc4fF1w=;
        b=uWoqSVv7/sXCFBs4uRVc7ZJnrRrLnXRL/+OZi80QKKTgvbfwumMUj5KjiHEfCDwRTT
         4l77Y7QqHNGwxkvw+86NlgbOJIbEGK4exb73CcG7bxXiIhUe0N903Cdh3FQo3A0tl3q2
         VVSy51o6KCEFVvO6WPGI4jxOMAYccyYb5zEX6DU9nVjW78QVsyJC3woh3PIjNjhr0gi7
         zA6Fm+EE9Jqof6qEe3uaZElg1mUFZEfpLNHtDSERMYtGr66mYG8lcT8onl0aY8Ew4dz/
         2ChThQ8iNbHXpa+VJlmskDf+WUndSWm2VHt4ifMPz4XZVW8mfQK3LdkpOO3eHP+1+v9D
         bUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blRKpHWKYllsC3fZsoBdHMYqC0YSHlFEixMlCc4fF1w=;
        b=SZ0x/bm17vHlQtN2fssnI9hEoh4hOqixAxx0DbC2U8Mpdda6gpvXO8A8XFjRdpf4Gb
         Wp6Yj4rO5mJWJbr56LrXtJeNH355+7kXeDea1QsQZeIe3GcFyBb1BawTYkyKbSdkwC1n
         U/3FL3XFoKb0LYRpM7+MBJVYOQLgm6dBWsR+puGw0KvHLveVAhdVxTllu0a2jvi9vqSP
         fjyJoC55DN88bLJGiDvUPNuE5/AJmu/DTbosX0hjduTkiSEITMuf7fOlfJrPFnrJ/Zav
         7Tn4utHqJhNx2CyxQmqAwvZbedIiGBJpXRNoPnshYvyIdZ/d4qA9eKfwZq4psDLDmxbP
         ZuWw==
X-Gm-Message-State: AOAM5313D9L/q4BSBvAq2pelBmRiQ7MDFb6za6okSd6Bn+Jl4uvkHxLm
        q2lifxehCXBZN1aVOAbLx0kzysp9MFXb7EW/
X-Google-Smtp-Source: ABdhPJz86BOoINx8fEi+KX53QXqf+HoCczR0skh70fOJrBPW6LQi7RmJY8byNi8zXcJRJpwKsL5dUw==
X-Received: by 2002:a17:906:3689:: with SMTP id a9mr7090398ejc.403.1603886320892;
        Wed, 28 Oct 2020 04:58:40 -0700 (PDT)
Received: from localhost.localdomain ([87.116.178.171])
        by smtp.googlemail.com with ESMTPSA id f13sm2817210ejf.42.2020.10.28.04.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 04:58:40 -0700 (PDT)
From:   Nenad Peric <nperic@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     Nenad Peric <nperic@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h5: OrangePi Prime: Fix ethernet node
Date:   Wed, 28 Oct 2020 12:58:17 +0100
Message-Id: <20201028115817.68113-1-nperic@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
node.

Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
Signed-off-by: Nenad Peric <nperic@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index cb44bfa5981f..33ab44072e6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -124,7 +124,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.29.1

