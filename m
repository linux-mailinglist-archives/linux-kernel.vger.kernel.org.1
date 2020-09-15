Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47ED26B8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgIPAvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:51:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45006 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIOLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:34:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKhh0013425;
        Tue, 15 Sep 2020 06:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600168843;
        bh=h+3WSyOto27sCenzTTEYF6dOn4Q7/03QKt+TepVhBzs=;
        h=From:To:CC:Subject:Date;
        b=Ak2EQyy+2jXVMTHSiinRlVSbqsfEv0Iko+duMAydyuH8jeTqnelJNZ3MyU9KfqCNV
         rgQdST4G3rqU29jKlQDN2H8FJe7+Gd3n65y5OSA7hwpZEyHUpuNlYsuqCaqdb9Y4vg
         StCJ8cgSW1Z42XnEggjMMJdM+If6dATdTtEQasmY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBKhwK022668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:20:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:20:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:20:42 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKdm9013285;
        Tue, 15 Sep 2020 06:20:40 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Tue, 15 Sep 2020 14:20:32 +0300
Message-ID: <20200915112038.30219-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
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

cheers,
-roger

Changelog:
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
  dt-bindings: mux-j7200-wiz: Add lane function defines
  arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
  arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
  arm64: dts: ti: k3-j7200-main: Add USB controller
  arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
 include/dt-bindings/mux/mux-j7200-wiz.h       | 29 +++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

