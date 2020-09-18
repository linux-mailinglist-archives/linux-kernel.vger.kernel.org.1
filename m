Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC56927017C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:58:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51090 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRP6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:58:37 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:58:36 EDT
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcdnd116916;
        Fri, 18 Sep 2020 10:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600443519;
        bh=72bUgkgjAEqyMQAGm7k76mIyH68JLbzoDLSIcwiFaa4=;
        h=From:To:CC:Subject:Date;
        b=I6dRrXRpmDccviiy3jpzBcZzTTdej7OxyQj9cf8OGUobzFTCQWot6NTumW8cpzOoJ
         cvEAI7BWp9z9Y59BDRGwvQGqhXvr81/Qou/028urjECGkeNXu2MQrsUaTmH74A+Qvs
         /jmqS8Casms+XLq94oPjkAYvPdZwqdOStjiZmUKc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IFcdKC024198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 10:38:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:38:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:38:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcbTn035674;
        Fri, 18 Sep 2020 10:38:38 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
Date:   Fri, 18 Sep 2020 18:38:25 +0300
Message-ID: <20200918153829.14686-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds DT nodes for TI J7200 SoC
- Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
  with J721E Soc, to enable DMA support
- MCU CPSW2g DT nodes to enable networking and board data

This series depends on:
 - [PATCH v4 0/5] arm64: Initial support for Texas Instrument's J7200 Platform [1]
   from: Lokesh Vutla <lokeshvutla@ti.com>

[1] https://patchwork.kernel.org/cover/11774429/

Changes in v3:
 - rebase on top of [1]
 - updated dependencies
 - added tested-by

Changes in v2:
 - fixed DT build warnings (Nishanth Menon)

v1: https://lore.kernel.org/patchwork/cover/1301067/

Grygorii Strashko (3):
  arm64: dts: ti: k3-j7200-main: add main navss cpts node
  arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
  arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux and phy defs

Peter Ujfalusi (1):
  arm64: dts: ti: k3-j7200: add DMA support

 .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  48 +++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
 3 files changed, 211 insertions(+)

-- 
2.17.1

