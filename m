Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2772756A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIWKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:52:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIWKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:52:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqDFG128190;
        Wed, 23 Sep 2020 05:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858333;
        bh=6koQNnMykB9jtqwNMIqP0z3+LzvInBm/KvxOmL64LhY=;
        h=From:To:CC:Subject:Date;
        b=jgw10mqtQUEXVRVM1q4soSzKMgU3iOzDlWKzjStoSbVZEG0grxMEOSLa4rREQl8+T
         H/8jL+IYQxyubtHZ2WFRGObg6Q8TPZbrFOBy9IaczKQmai8OktlxIQb4mB4Ic8PTUS
         U/iEi2FGhJ2qneLI2Vk5mfQU0sJokAx/4iHvqWWs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqDvo086061;
        Wed, 23 Sep 2020 05:52:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:12 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qh059762;
        Wed, 23 Sep 2020 05:52:08 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/6] Add UHS mode support for TI's AM65x, J721e, J7200 boards
Date:   Wed, 23 Sep 2020 16:22:00 +0530
Message-ID: <20200923105206.7988-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are driver and documentation patches to enable UHS modes for
TI's AM65x, J721e, and J7200 boards. Device tree and defconfig patches
will be sent in a separate series.

With the complete set, the following maximum modes will be supported:

am654x-evm,idk		- SDR104, HS200
j721e-common-proc-board	- DDR50, HS200
j7200-common-proc-board	- DDR50, HS200

These patches mainly add support for the software tuning algorithm[1]
needed for higher speed modes

[1] [1] https://www.ti.com/lit/pdf/spract9

Faiz Abbas (6):
  dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller
    documentation to json schema
  dt-bindings: mmc: sdhci-am654: Add documentation for input tap delay
  mmc: sdhci_am654: Fix hard coded otap delay array size
  mmc: sdhci_am654: Add support for input tap delay
  mmc: sdhci_am654: Add support for software tuning
  mmc: sdhci_am654: Enable tuning for SDR50

 .../devicetree/bindings/mmc/sdhci-am654.txt   |  65 ------
 .../devicetree/bindings/mmc/sdhci-am654.yaml  | 218 ++++++++++++++++++
 drivers/mmc/host/sdhci_am654.c                | 179 ++++++++++----
 3 files changed, 358 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml

-- 
2.17.1

