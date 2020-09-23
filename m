Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E5274DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIWA5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:57:41 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:49515 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:57:41 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 20:57:39 EDT
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 9A4CE260EC;
        Wed, 23 Sep 2020 00:57:38 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 4355C3EDEC;
        Wed, 23 Sep 2020 02:57:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 209CE2A911;
        Wed, 23 Sep 2020 02:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600822656;
        bh=/II/CEGmEF33KiMDnOuB3H2n1E00NtMTTZdLbhbZwZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=wacWIwmcOd+KPI9bEG+27j1b94T9u5DHDmCEm8USkLmkjd3vOGK9F8LqjK97SZ3hh
         PH3h1BKhCeqWPxcXgqcgRJ1UANLqH1aj5XHb6bM4oDOPcT+8/wIbNmKTaXVfzoHWFQ
         v96SqnBT8t/BUZQhYtMcPlMkz9JKx2R35i21UD0A=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id phxwbAHuMYb5; Wed, 23 Sep 2020 02:57:35 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 02:57:34 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 8283441024;
        Wed, 23 Sep 2020 00:57:34 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="MVWz8cOb";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5CFB741024;
        Wed, 23 Sep 2020 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822650; bh=/II/CEGmEF33KiMDnOuB3H2n1E00NtMTTZdLbhbZwZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=MVWz8cObpgi8KaS6UL4TRjJEHBAOUf4grvRTI+BSUn0LgyPVsZmKlF5YJc4G0+/UM
         ns95fdxeC/Xu6mdPyK4nuNE/a/PaK8kFt3QK62jiHYbfNaqFFrrIGRlyIyVz6GQBY1
         7BG3fg/b4KX9YxytR0K/EMGbY+wHgKgXEJRLGi54=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/7] Pine64 PineCube support
Date:   Wed, 23 Sep 2020 08:57:02 +0800
Message-Id: <20200923005709.147966-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8283441024
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
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
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pine64 PineCube is an IP camera based on Allwinner S3 chip.

This patchset tries to add support for it.

In order to make sure the system do not hang when camera is brought up,
a fix to AXP209 driver is needed (sent individually), otherwise the
system will hang because it changes the voltage of LDO2 when LDO4
tweaking.

Icenowy Zheng (7):
  ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
  ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
  ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
  ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
  ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
  dt-bindings: arm: sunxi: add Pine64 PineCube binding
  ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-s3-pinecube.dts       | 235 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-v3.dtsi               |  13 +
 arch/arm/boot/dts/sun8i-v3s.dtsi              |  91 +++++++
 5 files changed, 345 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-pinecube.dts

-- 
2.27.0
