Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8C28CDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgJMMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgJMMO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:58 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CAC22363;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=Jfl3S5/CVm87dfrfFsJcJ1KcmDiVSxRRxlJQMp3INpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1eYstPcXcFq3NKpMJZUOZWeDlJ/3fKGrkhUrtGfj1AYmVNllVLXSxqzK0KdPe3lj
         Q8AtYylAYOX22FG/PQGbmtNDXkeAaH8G6No29h/5bskrsIpWELSfYPb+y+2geNsEn7
         0ITar86K20zICb84mLsSGnQi93lSSY4saheTo2Gw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCf-006Cob-7l; Tue, 13 Oct 2020 14:14:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/24] MAINTAINERS: fix broken doc refs due to yaml conversion
Date:   Tue, 13 Oct 2020 14:14:47 +0200
Message-Id: <2645a845a705a4ba5231db9d3570d7765b6204a0.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several *.txt files got converted to yaml. Update their
references at MAINTAINERS file accordingly.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/clock/hi6220-clock.txt | 2 +-
 MAINTAINERS                                              | 9 ++++-----
 .../devicetree/bindings/net/wireless/silabs,wfx.yaml     | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/hi6220-clock.txt b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
index ef3deb7b86ea..17ac4a3dd26a 100644
--- a/Documentation/devicetree/bindings/clock/hi6220-clock.txt
+++ b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
@@ -4,7 +4,7 @@ Clock control registers reside in different Hi6220 system controllers,
 please refer the following document to know more about the binding rules
 for these system controllers:
 
-Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
 
 Required Properties:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f1eeef654caa..891b735233d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -978,7 +978,7 @@ M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
 F:	drivers/iio/adc/ad7768-1.c
 
 ANALOG DEVICES INC AD7780 DRIVER
@@ -3867,7 +3867,7 @@ M:	Roger Quadros <rogerq@ti.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
-F:	Documentation/devicetree/bindings/usb/cdns-usb3.txt
+F:	Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 F:	drivers/usb/cdns3/
 
 CADET FM/AM RADIO RECEIVER DRIVER
@@ -7919,7 +7919,7 @@ HISILICON LPC BUS DRIVER
 M:	john.garry@huawei.com
 S:	Maintained
 W:	http://www.hisilicon.com
-F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 F:	drivers/bus/hisi_lpc.c
 
 HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
@@ -14910,7 +14910,6 @@ RENESAS ETHERNET DRIVERS
 R:	Sergei Shtylyov <sergei.shtylyov@gmail.com>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
-F:	Documentation/devicetree/bindings/net/renesas,*.txt
 F:	Documentation/devicetree/bindings/net/renesas,*.yaml
 F:	drivers/net/ethernet/renesas/
 F:	include/linux/sh_eth.h
@@ -18114,7 +18113,7 @@ M:	Yu Chen <chenyu56@huawei.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
+F:	Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
 F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
 
 USB ISP116X DRIVER
diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
index 43b5630c0407..510edd12ed19 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
@@ -24,7 +24,7 @@ description:
     In addition, it is recommended to declare a mmc-pwrseq on SDIO host above
     WFx. Without it, you may encounter issues with warm boot. The mmc-pwrseq
     should be compatible with mmc-pwrseq-simple. Please consult
-    Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt for more
+    Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml for more
     information.
 
   For SPI':'
-- 
2.26.2

