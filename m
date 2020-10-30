Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592AE2A0CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJ3SBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgJ3SBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:01:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DC7C0613CF;
        Fri, 30 Oct 2020 11:01:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c16so3742559wmd.2;
        Fri, 30 Oct 2020 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lBTe67Ruhj9ZxKfZu9SkKaoknEjrb1M2KTUSKiTS93w=;
        b=J43rbx0mOC0X1soYthDm9e8MBasFvBiVlfwiySp++iZtC7tRwMMIXBYujnMBPEUbYI
         vkdCHMN+rnNL/b0bzh7VuaENPKbisQeq2g+hBJyD12AWIMZwOlUZ3/pcze31bcdkPrYY
         kUzqMQR3p82eIdFbE24I9isdSBvjflsqM1tNxwwSO47qpg7/maWZASfh6izn7cpfijeO
         QFMLcABlGdXzUtMzVzUWYnrINCc82mAAgmj8DIvaR1C/HejtrFxZH3lUyAe2KWUfFoVe
         +90vDgu2VkEfU5KLknDUketFwT6PyGWOgdwS0vulMlLLdzNyh4Ti5J3FGjW2q+uTJJHS
         9qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lBTe67Ruhj9ZxKfZu9SkKaoknEjrb1M2KTUSKiTS93w=;
        b=pnvOZP3J30+eCsB41syEaFQ4Knp2OydmX50uyIkiRaiHpzMdxKlIfa1LNb4N2NcgCV
         WjWf5hyF+aTco+lxXG3U8d4fOwhxbdMs+TRcA4L49ICFXN6HvbEpoS5SDnpDVU80mkDD
         ImixZMJF9wYrcYAjiXEswdoY2WgvaEzXTX7I5y6IcgKR1UYYRerghaQ4obrtWCIaby90
         Jq2JY3WUtGL5RRsI2vDX6Dn4g2OjnC9Yt8JZARcoOnQ6k50EMGtGUB6fo5exfebccYCR
         /fR7c+HscTt3YdYzoVG/oYiHQ7ojmRE2kmNQClVglIDx3JrJeYFOyzOaADg1Wy94RGR5
         YnUQ==
X-Gm-Message-State: AOAM532oKhzH4vRmYJesS2Cq/lRxFZL3n7OHRSVCRmLuilRTPzu9laI2
        sWOSaETjvGRIxe0foNPGE9o=
X-Google-Smtp-Source: ABdhPJwC01U3vjAh2A+zDHHy1FB0x3lZvf5hR/bOZulRgtWQiwIp0Qov0R/6GZyFV1x2HfibS0kwDQ==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr3970462wmi.62.1604080861592;
        Fri, 30 Oct 2020 11:01:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d8sm4335619wmb.11.2020.10.30.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:01:00 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add watchdog to g12-common dtsi
Date:   Fri, 30 Oct 2020 18:00:57 +0000
Message-Id: <20201030180057.23886-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G12 vendor kernels show the watchdog on the same address as AXG
so add the node to meson-g12-common.dtsi. GX boards inherit the
same from meson-gx.dtsi.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 1e83ec5b8c91..92afec3ffb2d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2179,6 +2179,12 @@
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
 			};
 
+			watchdog: wtd@f0d0 {
+				compatible = "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0xf0d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
+
 			spicc0: spi@13000 {
 				compatible = "amlogic,meson-g12a-spicc";
 				reg = <0x0 0x13000 0x0 0x44>;
-- 
2.17.1

