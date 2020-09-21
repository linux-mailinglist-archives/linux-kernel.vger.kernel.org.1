Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46542727E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgIUOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:39:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44370 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:39:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LEdl3K069411;
        Mon, 21 Sep 2020 09:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600699187;
        bh=e+M6JgWdAlSSDTjakEYHJvrxyQZMyfj2xj5cWZCovLA=;
        h=From:To:CC:Subject:Date;
        b=d6bynlHNaKRNMn/q18mhsCgv//p9P4lhEaXvNRdymgv0rTJrxLTOMrQVHRI4th08L
         y3HZHB1JQe7R1GLzv/gBNpGO10dfJFRjWLPi3B0jQvEJTei+K0+r0MA4VUUKzzXDnF
         2ITH7+RrqkJTgMmvUteYv/+bszBgCta3zGPhUOA4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LEdlXt028893;
        Mon, 21 Sep 2020 09:39:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 09:39:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 09:39:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LEdivl065452;
        Mon, 21 Sep 2020 09:39:44 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <peda@axentia.se>, <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Mon, 21 Sep 2020 17:39:35 +0300
Message-ID: <20200921143941.13905-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero/Nishanth,

This series adds USB2.0 support for the J7200 EVM.

Series is based on top of:

    Faiz's MMC/SD support series
    https://lore.kernel.org/lkml/20200907090520.25313-1-faiz_abbas@ti.com/
    Lokesh's initial support series
    https://patchwork.kernel.org/cover/11740039/
    Vignesh's I2C support series
    https://lore.kernel.org/patchwork/cover/1282152/
    Vignesh's Hyperflash series
    https://lore.kernel.org/patchwork/cover/1285326/
    MUX binding cleanup
    https://lore.kernel.org/lkml/20200918165930.2031-1-rogerq@ti.com/

cheers,
-roger

Changelog:
v4:
- use single header file for MUX defines. drop WIZ from macro names.

v3:
- use 0x00 instead of 0x0 in device tree for consistency.
- update commit log for USB support patch.

v2:
- fixed warnings when built with W=2. Still one warning is present
as property name "dr_mode" by USB core contains underscore.

Kishon Vijay Abraham I (1):
  arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane
    function

Roger Quadros (5):
  dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
  arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
  arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
  arm64: dts: ti: k3-j7200-main: Add USB controller
  arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
 include/dt-bindings/mux/ti-serdes.h           | 22 ++++++++
 3 files changed, 101 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

