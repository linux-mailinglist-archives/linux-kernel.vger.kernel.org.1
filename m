Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B625F8A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgIGKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:41:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40276 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgIGKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:38:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087AcFcE019085;
        Mon, 7 Sep 2020 05:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599475095;
        bh=p+0wAfHk5gbSBmT9ku6pLh44LvqVXQ5D8Uua6/oyQiU=;
        h=From:To:CC:Subject:Date;
        b=X2X4otQO0M0yzOfSQEQOwxnaVUzLu+/WdTO6p/Y2h75o8/t1G4HyVJnSNB/qYdVTB
         rL5PiN+Ez85HShwIM0EWVvPuaA9z+ER90bP+ETiHw5Lf5b4s2rCalXWetImzpiDaDk
         j1kB6JaiN8hr3vsxL+/EjdMg7k3Q9BBYvIMQD1vs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087AcFjQ114140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 05:38:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 05:38:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 05:38:15 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087AcCOo085251;
        Mon, 7 Sep 2020 05:38:13 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Mon, 7 Sep 2020 13:38:04 +0300
Message-ID: <20200907103810.9870-1-rogerq@ti.com>
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

