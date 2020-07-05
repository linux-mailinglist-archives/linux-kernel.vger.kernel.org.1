Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466AA214987
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 03:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGEBkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 21:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGEBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:40:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30318C061794;
        Sat,  4 Jul 2020 18:40:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h16so6820221ilj.11;
        Sat, 04 Jul 2020 18:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BSbqW4Q0Vp0UicjPh/vrPwied9AbFRWk5NIFX7HIKA8=;
        b=VfkOa4a7J8SlGrFxbkjgWAVnFBJZv33QHpLRv3J7QoOanhz+0/UIDCZGE+4vd4FIRl
         q9N8L8yaz/qhN2cXmyaHti4jANyldD+W44TBc0QxYitevVjMr4Ohux6S08xQvhhIg0Tv
         j91NrPm4BLsNbpJ1avaYfdtXFTxzk1QR0WZI0HKjfzi3KsYsg+tDtR2WeVLNFUlM/mvs
         BWyDCnBxXyXmrz6IksZT5BnBgGu/WBnIU+IqgaAjq2G0vY+YV2Bw+H5ZWnffD8ptv67T
         KKZTWkAuMaR7mvhQ90KBTwM/CWUAkL0DSoLRnShoYacrTqgErDQKeeneY9OHPcjV7CtT
         1p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BSbqW4Q0Vp0UicjPh/vrPwied9AbFRWk5NIFX7HIKA8=;
        b=cA28JS5m+jzDZg+WxxwrDLYdiL75OE0ICaxrhhOwGSb8uD5Nu03UBJu3YBpkl/bwhZ
         UJaWxyxh9UHZpX7l/DDlL4RopVHdNL8VjchlZgDsECFvwYuftHcrP8hF55bToWatRDIp
         UsNdzSDgsG03ujQN4V6bCjL7+n/tmKzTJuHr40qxEmkkoiCCZrGfz0huBQ4PkTj/BKMF
         9ZIUoo7lKVfKv8HVw/69hhrDq7njCF0Dy01PneMS+RhMHwoWCwbKy7P9whXdK4oyTl9M
         rZlThbcI9aWzNMxPLeBs3tKscL6ls9CoNWHhUtis2pGOA6hmHUoqlbIi8yLW5oKQcTuk
         4CRQ==
X-Gm-Message-State: AOAM533cKxUJ/ty/d2bRB9i7J+ieU+VoZi5CnpL4AdesoUH24sboa1ze
        hBmzEOMvIssbLcPzindFxEy124PIynMexx1F5CixJ93N
X-Google-Smtp-Source: ABdhPJz4vhcHSZA4BbOgZngkrj61PkFQYalh7/0gfR6DiprWgIhIjSNTvDZ36IJt7DV6Gj4v/vGpNI3oaKsLKcBrScE=
X-Received: by 2002:a92:aa92:: with SMTP id p18mr24225574ill.199.1593913254428;
 Sat, 04 Jul 2020 18:40:54 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 4 Jul 2020 18:40:43 -0700
Message-ID: <CAFXsbZoeTyRp7bwjBUcXT5H2GhrTmNeeoQSFcgiS9aNRFw6V_g@mail.gmail.com>
Subject: [PATCH] ARM: dts: vfxxx: Add node for CAAM
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for CAAM device in NXP Vybrid SoC.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2d547e7b21ad..0fe03aa0367f 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -729,6 +729,28 @@
                 dma-names = "rx","tx";
                 status = "disabled";
             };
+
+            crypto: crypto@400f0000 {
+                compatible = "fsl,sec-v4.0";
+                #address-cells = <1>;
+                #size-cells = <1>;
+                reg = <0x400f0000 0x9000>;
+                ranges = <0 0x400f0000 0x9000>;
+                clocks = <&clks VF610_CLK_CAAM>;
+                clock-names = "ipg";
+
+                sec_jr0: jr0@1000 {
+                    compatible = "fsl,sec-v4.0-job-ring";
+                    reg = <0x1000 0x1000>;
+                    interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+                };
+
+                sec_jr1: jr1@2000 {
+                    compatible = "fsl,sec-v4.0-job-ring";
+                    reg = <0x2000 0x1000>;
+                    interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+                };
+            };
         };
     };
 };
--
2.21.3
