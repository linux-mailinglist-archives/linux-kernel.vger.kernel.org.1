Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71002D2754
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgLHJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgLHJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:18:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABBC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:17:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x15so6679868pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O23hLkgyH0AcKUIRz35EyTfrfmWRh12qepszTmHy6M0=;
        b=sWF3Oq7ZiWpR+RT9ltmHND+8KJzJEXMMUqH1WTlfcLyOxDkrlzOb1p1fMkmDb7kUE6
         Dl3y/wBXggGObriktKRjmBoHtJhR+qTva8p+CdfaLYSeJ5vW2AjcBzJt5yDQtpKxiQNf
         iV2MqEfo8DWmhDqjdOH/1YLo1xfijgQvSI1KmpGws99sPVoXRRXwI2sPgfxiZsSrvH78
         /nL5NywoJoE0+MF1G/yhibtSO7vyP44vi7+pYnnkKNZaZ9fkEbP0QKnORGuHuCC92Kng
         iisHFcHU1IzMmJuuj8BFuEWfV4ghgTeGCQSC83MxE2stQ+3a/5pJW9t2NM1ZHKoa132y
         agzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O23hLkgyH0AcKUIRz35EyTfrfmWRh12qepszTmHy6M0=;
        b=s4FyPn1zZez1DXnR1oK+UhjVytitWQYu0bfDnGTSkIAX5NZIuc170D5CvyluwPAjAH
         JF+8DtGO6w+NadlyeiuvEsvwebyZbFmP/p5gTV6kqmODFiLNk2B5xojJspzKI8Y/f8ni
         whTnpbDib/I0pd6IQgS5klwbIFYu+YdrfTAJshYCbLhajnqZKjxY5Il/7YPKObRlMhVv
         +hjtCvSI0YIr0QVefo3Kyx+TkdjB16z4PjkwgJQw45Fu2LX5gPhDusgv0ptYym2cSFev
         J1EU+mJSHNYskbdBGMjj02AHcy8EsEANB6tf+1t7O9Ovs2uQ3x9CL4JUwkH64nCMZHKk
         Nfhg==
X-Gm-Message-State: AOAM532rpgsQwmc5GblxcyU+rPiksMQjnhcJEAgqcFInOhQwTESwicV/
        RHGXsKT+4dBOn5piNznjg23etQ==
X-Google-Smtp-Source: ABdhPJzBJwYpLEgguIwpyagLjMIA0KtTmhV5jpPvnwVOSWeNBmEIlXJtUZVeoaxiths8I67hUfaIIw==
X-Received: by 2002:a17:902:6b02:b029:da:c6c0:d650 with SMTP id o2-20020a1709026b02b02900dac6c0d650mr20751147plk.74.1607419078949;
        Tue, 08 Dec 2020 01:17:58 -0800 (PST)
Received: from localhost ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id z65sm18357294pfz.126.2020.12.08.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:17:58 -0800 (PST)
From:   John Wang <wangzhiqiang.bj@bytedance.com>
To:     xuxiaohan@bytedance.com, yulei.sh@bytedance.com
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add LCLK to lpc-snoop
Date:   Tue,  8 Dec 2020 17:17:48 +0800
Message-Id: <20201208091748.1920-2-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d558ce0ff0730 (ARM: dts: aspeed: Add LPC Snoop device)
Fixes: 12ce8bd361c72 (ARM: dts: aspeed-g6: Add lpc devices)

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
v2:
  reword: Add fixes lines
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

