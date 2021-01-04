Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4AA2E94BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhADMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:23:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59414 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:23:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104CMcjs009244;
        Mon, 4 Jan 2021 06:22:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609762958;
        bh=L8TZcyMNR3Bt/Q6VxRRv5zPQl8MsUnyrxKvla34e180=;
        h=From:To:CC:Subject:Date;
        b=jhnhSi5xmSRvNmFnmE01ukuN7jQMxFtXxOieYV3ikENkdyeryVX0Lvw+V/MjEGSx5
         cWbIjF+oRZwYIHqOy3Zn5osObJ4pcVjN+7l1oQ/Eh1tTEY/EqEtvV0WomDk9nDSv1p
         zDqpe49lLBWFUdECDcoQ84gWJufiMgczCECp6xBc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CMcbi102448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:22:38 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:22:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:22:38 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104CMZhM002211;
        Mon, 4 Jan 2021 06:22:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/6] PCI: J7200/J721E PCIe bindings
Date:   Mon, 4 Jan 2021 17:52:26 +0530
Message-ID: <20210104122232.24071-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds DT nodes in order to get PCIe working in J7200.
Also includes couple of fixes for J721e.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [2]

Changes from v2:
1) Moved serdes_refclk node out of interconnect node and also replaced
   "_" with "-"

Changes from v1:
1) Include only the device tree patches here (the binding patch is sent
separately)
2) Include couple of patches that fixes J721E DTS.

[1] -> http://lore.kernel.org/r/20201102101154.13598-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201210130747.25436-1-kishon@ti.com

Kishon Vijay Abraham I (6):
  arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
  arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
    pcieX_ctrl
  arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
  arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
  arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe

 .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 111 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  52 ++------
 3 files changed, 157 insertions(+), 44 deletions(-)

-- 
2.17.1

