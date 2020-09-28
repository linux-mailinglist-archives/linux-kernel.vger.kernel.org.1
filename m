Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31327B195
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgI1QOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgI1QOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:14:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so1743630wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ablR3knQp8V4Xus5gSWFEPKLooYQFHbeiNIFj+RtYYY=;
        b=KntFXjgD2m18dkgK66tvFC4NL+CIMRmAh9CUk377MLEQ/WTyC1lyFWb7bkzcD4vIK+
         uBNUqPJCtqMBM38BUEpYIgutrA3ErU+xmV8KzMl5TgOGSFRmF/PNwxHEaaW4j2Kv+LBN
         kNER1mcLg++pXJQBJxr7/8TVEPMvBQRW3kvy1zHLpLWke4ZOZWuFCozTFh4/4IE878T3
         ddOqHQf64ToPzd1wOg0dFyjPNw52jEryzRshdnVg3iWCmGd1jPUtrFvPz8R1SpFTaZ58
         UEvfHtZtRutCXIYnvWbzzTp9W9XmxYkChJ70SAXII4eFeSeyualRe1oar1mmql5yV2Dz
         jQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ablR3knQp8V4Xus5gSWFEPKLooYQFHbeiNIFj+RtYYY=;
        b=T5YLab3AvJkLvtOH3zh0zyCBbbNogySRDKT7nEXbTba/Hbjm+ml2pJfuI9LuPlrw7r
         EtZVq/JSh0fWSETGwKPvjwZLBqHaTDX2pVMgNSCslUkJbZRl/R3qz86LWgDDLHazJp3w
         KwegOHsKh12AIN8gNtU4Kk9UqDGdGe1opMnGoZ6q6k0ybxaze0FzfI48+nuCDCcMAp/C
         AE+wnN4LcHNOCJ89/uxTNbl+aocd+cKlmtFGut50VtNeNJ8bmFsyJ3JJbTZOBfcdQpud
         gNlGkTFMjif07UAnoNFlPwYip7+ixwDsu5DUzgEe5wJjd7BR4r1ZB3GqJccuRCwUFYfB
         HsNQ==
X-Gm-Message-State: AOAM533aWThy685OUTipQUlfaOx9mPSmcjsRv4ygpS7cqoDdJDE7wDQQ
        1JM2cNBXza0fD5s+gP9JuDgGLPcYLTuhoBem
X-Google-Smtp-Source: ABdhPJysuvPAxMmaEYUNYctclsXfDWSH9kSRmm+jOZyFHfsdftrc8VmKXkmBX+B1Zm9Y9XBuyoy2gw==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr2527408wmh.133.1601309662206;
        Mon, 28 Sep 2020 09:14:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:19c2:a71d:5af8:dbf6])
        by smtp.gmail.com with ESMTPSA id n4sm2004867wrp.61.2020.09.28.09.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:14:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil-cisco@xs4all.nl, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: meson-axg: add GE2D node
Date:   Mon, 28 Sep 2020 18:14:11 +0200
Message-Id: <20200928161411.323581-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928161411.323581-1-narmstrong@baylibre.com>
References: <20200928161411.323581-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the node for the GE2D accelerator unit.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 4559f2173065..5cce5540cec0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1647,6 +1647,15 @@ dpi_out: endpoint {
 			};
 		};
 
+		ge2d: ge2d@ff940000 {
+			compatible = "amlogic,axg-ge2d";
+			reg = <0x0 0xff940000 0x0 0x10000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc CLKID_VAPB>;
+			resets = <&reset RESET_GE2D>;
+			reset-names = "core";
+		};
+
 		gic: interrupt-controller@ffc01000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xffc01000 0 0x1000>,
-- 
2.25.1

