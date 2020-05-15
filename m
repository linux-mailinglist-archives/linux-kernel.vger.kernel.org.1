Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371401D4C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEOLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 07:16:36 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52350 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgEOLQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541391; x=1621077391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NM+S8OMTmsMYRTLlSMp9bGaPdfxmccXI/+aoH5UKQmY=;
  b=ogPv4y5xKym60PKowlDyCrIh/OCPCwuIBeCeRnIkdIgQP6w01STdN/Uh
   AoNkIU0R/L6AmSzdphYDtSeN4Fob/yshGBuJUSWBoaz5rRddA2Qh+GTuV
   /GEsXSm6RhB9ByJTYQYqBvgX1dlpiEiHSbZ8BhzcK24oaewhHV9AbkjkK
   yp9/7tu3qDdEth8ZNpA7Ou6BeCuKkxdlyxQKdipM5ehxzblFBHsxl15CF
   DNGzPPK+i2e6D8zfDepK3z8GjyCkqx4cXGgC3JVO+49DJK/d/2Q+gCThq
   WRcPKYsszdHSoMia8MwkSRWjc7Fws76Tgj9nd9yRK2HxZMR2q13B85XRM
   A==;
IronPort-SDR: CdLWEe7E4LxivjZ4UG+P6hnBSPXZ+sOsohJl8T/n6fIosdWxU9OrfZu8YOCEOIDgBeyHTS4yaa
 GSlYgI+X3J8Ql4lI1gfPOw8qCPW4nDov+GmuufP0ePD4152C1DQTZy1SneGxTPmx/Bdt+kF3J1
 KGIu3NPVBdIPuUz7nlIjmAw+avMhzLj/HUKPAZH8mXrmYdDTyeVSZBPvoi4KEG+ey5/GMvNODy
 oW+qxXq+LPWwOQ8ffCELkN6qJfWA9K5SgicR5wQh86REfSxas27JQ2wvs1uGW12s18xK3y38eq
 5/I=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="76028022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:29 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:27 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 2/7] dt-bindings: usb: atmel: Update DT bindings documentation for sam9x60
Date:   Fri, 15 May 2020 14:16:26 +0300
Message-ID: <20200515111631.31210-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515111631.31210-1-cristian.birsan@microchip.com>
References: <20200515111631.31210-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add sam9x60 binding.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 44e80153b148..bae2b928a014 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -82,6 +82,7 @@ Required properties:
 	       "atmel,at91sam9rl-udc"
 	       "atmel,at91sam9g45-udc"
 	       "atmel,sama5d3-udc"
+	       "microchip,sam9x60-udc"
  - reg: Address and length of the register set for the device
  - interrupts: Should contain usba interrupt
  - clocks: Should reference the peripheral and host clocks
-- 
2.17.1

