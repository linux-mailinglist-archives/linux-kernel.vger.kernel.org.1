Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442052B2696
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKMV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:27:00 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9483 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgKMV1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:27:00 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EE82C240003;
        Fri, 13 Nov 2020 21:26:56 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/9] iio: adc: at91_adc: cleanup DT bindings
Date:   Fri, 13 Nov 2020 22:26:41 +0100
Message-Id: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series cleans up the at91_adc devicetree bindings. This mainly
moves back the resolution options and names and the triggers description
back in the driver.

There are also other cleanups, like removing platform data support, this
was pending for a while.

Alexandre Belloni (8):
  iio: adc: at91_adc: remove platform data
  iio: adc: at91_adc: rework resolution selection
  iio: adc: at91_adc: rework trigger definition
  iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
  iio: adc: at91_adc: remove forward declaration
  iio: adc: at91_adc: use devm_input_allocate_device
  ARM: dts: at91: sama5d3: use proper ADC compatible
  ARM: dts: at91: remove deprecated ADC properties

Jonathan Cameron (1):
  dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
    at91_adc.txt

 .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 ----
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 ++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
 arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
 arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
 arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
 arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
 arch/arm/boot/dts/sama5d4.dtsi                |  22 -
 drivers/iio/adc/at91_adc.c                    | 377 +++++++-----------
 include/linux/platform_data/at91_adc.h        |  49 ---
 10 files changed, 259 insertions(+), 524 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
 delete mode 100644 include/linux/platform_data/at91_adc.h

-- 
2.28.0
