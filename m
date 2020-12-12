Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177282D8435
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438062AbgLLEGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:06:07 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:42458 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbgLLEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:05:44 -0500
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 60B112008F;
        Sat, 12 Dec 2020 04:04:45 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 829A33F162;
        Sat, 12 Dec 2020 05:03:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 957382A379;
        Fri, 11 Dec 2020 23:03:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607745791;
        bh=Lb1vl5IRb8uF261H7Kcw2/rjUtWvWXJSqkTfJ5QSR1k=;
        h=From:To:Cc:Subject:Date:From;
        b=rlSboU9qbwIswonT5d3mn/sjavRmkSjwyJvLW+MNjehmqPh/DkYuiTD7s1LbuRZDX
         vvb9nDHwF4YzbPIPqpneje6LhatRkLF2lZPZa4/+ijqdnlkm4e6NKO1XODNHP3ASNL
         fwgjbqpgJF5mBOjJuW35uLA1NII2VhTjdIu11PfA=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qKTTfgDSdrRn; Fri, 11 Dec 2020 23:03:10 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 11 Dec 2020 23:03:10 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id B594942F59;
        Sat, 12 Dec 2020 04:03:09 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="mKh5sN6Y";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8CB3F42F58;
        Sat, 12 Dec 2020 04:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607745741; bh=Lb1vl5IRb8uF261H7Kcw2/rjUtWvWXJSqkTfJ5QSR1k=;
        h=From:To:Cc:Subject:Date:From;
        b=mKh5sN6Y0K1efQqNZCWXfvcm7Wh334gArsmaUT/Tkq5VkPonAkSG3pkQKilZ5O/Im
         Xkt+3k4lvoZXCRvNTbc3wHBbx4wzAIhGQOzYLErwOJvfM3SPbnot72uJgsu6wa95XJ
         kQoSxj0TiC+lFe1cAFG9MwdWJg/0fHrc6siqWcYY=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 00/12] Support for Allwinner V831 SoC
Date:   Sat, 12 Dec 2020 12:01:56 +0800
Message-Id: <20201212040157.3639864-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: B594942F59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner V831 is a new SoC by Allwinner oriented at the camera market.
It has a QFN88 package with co-packaged 64MiB DDR2 DRAM. Another SoC,
V833, is also available, which has the same die with V831 but w/o
co-packaged DRAM (thus a BGA package).

This patchset tries to add basical support for V831, with consideration
of V833 in many drivers.

The DT is only for a temporary test device w/o schematics, development
will be shifted to another device when the patchset leaves RFC.

Icenowy Zheng (12):
  dt-bindings: clock: sunxi-ng: add compatible for V831/V833 CCU
  dt-bindings: clk: sunxi-ng: add V833 CCU clock/reset indices headers
  clk: sunxi-ng: add CCU driver for V831/V833
  dt-bindings: pinctrl: sunxi: add compatible for V831/V833 pinctrl
  pinctrl: sunxi: add pinctrl driver for V831/V833
  dt-bindings: rtc: sun6i: add compatible string for V831/V833 RTC
  rtc: sun6i: add compatible string for V831/V833 RTC
  dt-bindings: mmc: sunxi: add compatible strings for V831 MMC
  dt-bindings: watchdog: sunxi: add compatible string for V831/V833 WDT
  dt-bindings: spi: sun6i: add compatible for V831 SPI
  ARM: dts: sun8i: add DTSI file for V831
  [DO NOT MERGE] ARM: dts: sun8i: v831: add a device tree file for Y20GA

 .../clock/allwinner,sun4i-a10-ccu.yaml        |   2 +
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |   3 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   4 +
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |   2 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |   1 +
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |   3 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts     |  53 +
 arch/arm/boot/dts/sun8i-v831.dtsi             | 244 +++++
 drivers/clk/sunxi-ng/Kconfig                  |   5 +
 drivers/clk/sunxi-ng/Makefile                 |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v833.c         | 930 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-v833.h         |  46 +
 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-v83x.c    | 743 ++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h         |   2 +
 drivers/rtc/rtc-sun6i.c                       |  18 +
 include/dt-bindings/clock/sun8i-v833-ccu.h    |  89 ++
 include/dt-bindings/reset/sun8i-v833-ccu.h    |  52 +
 20 files changed, 2206 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v831.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v833.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v833.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v83x.c
 create mode 100644 include/dt-bindings/clock/sun8i-v833-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v833-ccu.h

-- 
2.28.0
