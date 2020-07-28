Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FBE230732
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgG1KDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgG1KDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688C8C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so9612655pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLsnjIcx6O7hBUqO+ly4gJ/BT4WlJTFqju/5sXIimIg=;
        b=SKCdPVmLWJF2bLrtZU3g+eZO6Jvjk2z4+jmQXQol4BWOQK4BYolKrUCLan1cceEyYJ
         XlJqjlKhsQsOGcSuJzmzVXGgYVOY7CIXKyo+2t8BH0Pw8yXqgL4huJaNbNEl34vjn/Zs
         3o67Tt6q5uqH889AcUvizaQWxtfULuH9wC+SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLsnjIcx6O7hBUqO+ly4gJ/BT4WlJTFqju/5sXIimIg=;
        b=mx5WfYyA4as+zxWqqJQt0ohHlUlqA088htW9MbxxRrMw9YH8hRbnLI4pWzGed6DZme
         ofh4u1vmbM0G/47EsLqPKUjo6vyKZSqdoNiN5kZQVARg02KqU3z8WtJG67HD6LuGABk9
         qh94i0yBbqIs3OaQhRTAUe1cq5OdCG5eCqJeNwa9zeQxEscnIvxp007y7gXngX1ZCfim
         6SfNXIcRT2Vvic+EHaNopk8KWBm+jPk33Li92SwdbiW6eieT9DghWhcIxsTWc82e80gZ
         djvraMqMwQ+dEG1crvmqzgZSbUPig4/HZjrhm51Rk/a+bewG8UDQg4V+6nyAFgaix1s9
         fRPg==
X-Gm-Message-State: AOAM533gkVupIDoLJ0Bm4BFTZ4rm2u3boLfItCA5x+psbd1ftBWXWdhJ
        /dEOxAifRMQBrPwSA5BSccm9cA==
X-Google-Smtp-Source: ABdhPJxSjatle00lO8xbMWFh3tR143iGH9zfFmSLzFijKNfxg6ikjSpg1obUHnDL0D8z4jadb44Zfg==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr3828042pju.19.1595930619871;
        Tue, 28 Jul 2020 03:03:39 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:39 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 3/9] ARM: mstar: Add IMI SRAM region
Date:   Tue, 28 Jul 2020 19:03:15 +0900
Message-Id: <20200728100321.1691745-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All MStar v7 SoCs have an internal SRAM region that is between 64KB
(infinity2m) and 128KB(infinity3, mercury5).

The region is always at the same base address and is used for the
second stage loader (MStar IPL or u-boot SPL) and will be used for
the DDR self-refresh entry code within the kernel eventually.

This patch adds a 128KB region to the SoC and the minimum 64KB SRAM
region to the base dtsi. Families with more SRAM will override the
size in their family level dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 3b99bb435bb5..1941f88a69a5 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -45,7 +45,8 @@ soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x16001000 0x16001000 0x00007000>,
-			 <0x1f000000 0x1f000000 0x00400000>;
+			 <0x1f000000 0x1f000000 0x00400000>,
+			 <0xa0000000 0xa0000000 0x20000>;
 
 		gic: interrupt-controller@16001000 {
 			compatible = "arm,cortex-a7-gic";
@@ -79,5 +80,10 @@ pm_uart: uart@221000 {
 				status = "disabled";
 			};
 		};
+
+		imi: sram@a0000000 {
+			compatible = "mmio-sram";
+			reg = <0xa0000000 0x10000>;
+		};
 	};
 };
-- 
2.27.0

