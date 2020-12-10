Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248612D5B48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbgLJNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:08:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgLJNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:08:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD7xdJ060290;
        Thu, 10 Dec 2020 07:07:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607605679;
        bh=8w3tN/GkEKy2qdWLhSNgrT3zaBBEblVCy0wp1e+L/lo=;
        h=From:To:CC:Subject:Date;
        b=b617WEEkyx9I8tgwaMYTcNyToz32lse+gXvCnMnBWeQPFavMvorqUTeIPV2jF2hfN
         YacYdO4djRBB6Sc7LwUZC11yl+qQ73ENW2acbN6mIe/r2dGqNilcQs1ktzMXkZ11p5
         T+VU4Y2hxJsAqdBtIZJcacQIcSC2HxFuvHZV6fVA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BAD7xop093231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 07:07:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 07:07:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 07:07:59 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD7raf098988;
        Thu, 10 Dec 2020 07:07:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] PCI: J7200/J721E PCIe bindings
Date:   Thu, 10 Dec 2020 18:37:41 +0530
Message-ID: <20201210130747.25436-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 of the patch series is sent [1]

Changes from v1:
1) Include only the device tree patches here (the binding patch is sent
separately)
2) Include couple of patches that fixes J721E DTS.

[1] -> http://lore.kernel.org/r/20201102101154.13598-1-kishon@ti.com

Kishon Vijay Abraham I (6):
  arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
  arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
    pcieX_ctrl
  arm64: dts: ti: k3-j7200-main: Add DT for WIZ and SERDES
  arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
  arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe

 .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 109 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  52 ++-------
 3 files changed, 155 insertions(+), 44 deletions(-)

-- 
2.17.1

