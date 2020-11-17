Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840C2B69E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKQQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:20:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgKQQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:20:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJl5P106024;
        Tue, 17 Nov 2020 10:19:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605629987;
        bh=kg41fzr6IfLFG85hwpt903XW2gFVaU++Z+vl0ZxbKSo=;
        h=From:To:CC:Subject:Date;
        b=TJuKbf0IzzH9zDaFn2SpZ9cB3npN4Uve/9gfuHuFb56fas+WE/VVAKRpdN5h8Gipe
         02/JjA40AiBGcMLBWyYJ9aapSYR4dRobUG+UfcqJOnrlsNa6HIr89UApBTnFF5kavD
         4JvcRb8GphyO6lBHxxUZGVNCq6yPLoRE1nkPwQy0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHGJlLA098410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:19:47 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 10:19:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 10:19:46 -0600
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHGJhwG032251;
        Tue, 17 Nov 2020 10:19:43 -0600
From:   Sekhar Nori <nsekhar@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: J7200 GPIO support and warning fixes
Date:   Tue, 17 Nov 2020 21:49:38 +0530
Message-ID: <20201117161942.38754-1-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add gpio support for TI's J7200 platform. The first
two patches fix existing warnings in preparation for adding GPIO
support.

Changes in v2:
- Add patches fixing existing warnings so GPIO support does not
  end up adding more warnings
- Addressed Nishanth's comments on GPIO patches
  - merge patches adding main and wakeup domain GPIOs into single patch
  - fix commit description going over 75 chars
  - fix W=2 warnings about lack of #address-cells in GPIO nodes

Faiz Abbas (2):
  arm64: dts: ti: k3-j7200: Add gpio nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
    modules

Sekhar Nori (2):
  arm64: dts: ti: k3: squelch warning about lack of #interrupt-cells
  arm64: dts: ti: k3: squelch warnings regarding no #address-cells for
    interrupt-controller

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  6 ++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  2 +
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  1 +
 .../dts/ti/k3-j7200-common-proc-board.dts     | 16 ++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 75 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 35 +++++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 12 +++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  3 +
 9 files changed, 151 insertions(+)

-- 
2.17.1

