Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0144425E43F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 19:38:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56358 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIDXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:38:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 084NcaTN010536;
        Fri, 4 Sep 2020 18:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599262716;
        bh=JaVxi5ZEccH7pcfX1MXpA31CIphet/zwm1BPz91FW+o=;
        h=From:To:CC:Subject:Date;
        b=q1FOdOLyzo6yHsI1UEAXCegkMZm5Vd8/JPDLS+ZwrXpp5L+/q8cDgtmdWWwi4Bt8X
         8CqFSIRi06wdsFmGr7kz9zduKQXz7pEmdJcIzdjAFmZUJ/wcry1MBNMiZcgqqYp36P
         6N+dFC90O2zALoHcl2ml2TKOtEV+XL/aVzfTvEl4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 084Nca5e011822;
        Fri, 4 Sep 2020 18:38:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 18:38:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 18:38:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 084NcZYP054084;
        Fri, 4 Sep 2020 18:38:35 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>, Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
Date:   Sat, 5 Sep 2020 02:38:26 +0300
Message-ID: <20200904233830.11370-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

arm64: dts: ti: k3-j7200: add dma and mcu cpsw nodes

This series adds DT nodes for TI J7200 SoC
- INTR/INTA, Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
  with J721E Soc, to enable DMA support
- MCU CPSW2g DT nodes to enable networking

This series depends on:
 - [PATCH v2 0/4] arm64: Initial support for Texas Instrument's J7200 Platform [1]
   from: Lokesh Vutla <lokeshvutla@ti.com>
 - [PATCH] soc: ti: k3-socinfo: Add entry for J7200 [2]
   from: Peter Ujfalusi <peter.ujfalusi@ti.com>

[1] https://lore.kernel.org/linux-arm-kernel/20200827065144.17683-1-lokeshvutla@ti.com/T/#m141ae4d0dd818518c00c81806d689983d6e832e6
[2] https://lore.kernel.org/patchwork/patch/1283230/

Grygorii Strashko (3):
  arm64: dts: ti: k3-j7200-main: add main navss cpts node
  arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
  arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
    and phy defs

Peter Ujfalusi (1):
  arm64: dts: ti: k3-j7200: add DMA support

 .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  73 +++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
 3 files changed, 236 insertions(+)

-- 
2.17.1

