Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7312CB447
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgLBFR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgLBFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:17:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:16:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h7so230939pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMf+qfonJLf7vMl0DnttrDvVmDvqtmkJr/AXdH4GU4s=;
        b=hrM1U8VbENPacYn1U4AEgrTpRajM5sT3t43YDQBM/Mhiz3nSNes8G8wM0MLqhGSgiI
         bQgsY/YW273VGAxqtuGompMiSNz8t6rLxXFP6i7L0LljLK9T/rY3hJgncGo/Zx4Q40Na
         OwKm/I1rn6L7NplNlomaG5C13Shg+GMrDrAH95FxeVv57cBjGP/SFp4y0JOrmAfYzYcw
         7VCDemlO7NH6HG6TIeLtqK70mKT7u1N0m5ig+xdvIrpTxG295LrLqnqyJVP4t0aOnXfz
         jpYC80w2pJvJtJhstNbv603DQuYlbnLUj7oPigSIb3arvi0kymjxfBzo1YEJ1tmGyCtN
         7X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMf+qfonJLf7vMl0DnttrDvVmDvqtmkJr/AXdH4GU4s=;
        b=nzq7cm6NiHpXf0MgPlnKsJGBfuY6FOH2zn2w02pCZ83fsKDuDry6y/rjVFMbEMb2aG
         Oh+wQwvwvkmBgXRf1SrQokQoiRFYG3y8bSauQaYExls5DhrDnsycYJVjTlUtnMar9Tjy
         ankBVaNGWiUKEz1EqYOGrUue7wTT5RvDBMRn28jrZm0D0Xf1arIFgSPOBz+DGREFRT87
         T/wlg5nyPdyCU/w8t7/DARjUNiMOqHxvEsswsD5mZyqjcJxXYbtJE3QGsaHp4sbAxzIB
         WQblR5qgnlA+kT4thiCBLJlnrQpiyvr0wig4CD2JH2ehEUn1SYKNRl0gnyWStFkLGhHr
         i3/A==
X-Gm-Message-State: AOAM532JsG7pLVpdagx5IqWTw8H6MOBRAw5lerZ/xgflbMPLRWmGbzBB
        WLvHJQe6BQ6rif2APow2XxvS/g==
X-Google-Smtp-Source: ABdhPJxuNTwTCv2D3U6L3rbi3cQrrCSLTTNwlSwTJWS+yvZfGvkhW5AL6ItOg8ULKPp2ctl9IZCOgQ==
X-Received: by 2002:a17:902:469:b029:da:17d0:e755 with SMTP id 96-20020a1709020469b02900da17d0e755mr1149263ple.53.1606886202007;
        Tue, 01 Dec 2020 21:16:42 -0800 (PST)
Received: from localhost ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id c20sm582116pgc.25.2020.12.01.21.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:16:41 -0800 (PST)
From:   John Wang <wangzhiqiang.bj@bytedance.com>
To:     xuxiaohan@bytedance.com, yulei.sh@bytedance.com
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ARM: dts: aspeed: Add LCLK to lpc-snoop
Date:   Wed,  2 Dec 2020 13:16:34 +0800
Message-Id: <20201202051634.490-2-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
References: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g6.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index f606fc01ff13..2364b660f2e4 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -370,6 +370,7 @@ lpc_snoop: lpc-snoop@10 {
 						compatible = "aspeed,ast2400-lpc-snoop";
 						reg = <0x10 0x8>;
 						interrupts = <8>;
+						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 19288495f41a..30bbf7452b90 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -496,6 +496,7 @@ lpc_snoop: lpc-snoop@10 {
 						compatible = "aspeed,ast2500-lpc-snoop";
 						reg = <0x10 0x8>;
 						interrupts = <8>;
+						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 97ca743363d7..4b1013870fb1 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -520,6 +520,7 @@ lpc_snoop: lpc-snoop@0 {
 						compatible = "aspeed,ast2600-lpc-snoop";
 						reg = <0x0 0x80>;
 						interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-- 
2.25.1

