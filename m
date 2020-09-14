Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB2268FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgINPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:21:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53250 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgINPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:21:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EFLRTe055708;
        Mon, 14 Sep 2020 10:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600096887;
        bh=ku0rpKxCD+4JFGEjSWY3zWlZvyQsUR8Q+B1sxITxMr0=;
        h=From:To:CC:Subject:Date;
        b=p4IoEJxyVZymsZeftlfFL0xWML0rAJ4dLBkS7IFBWSfc2NtJL8HTcfQmsfAfDhoDu
         IUNQzPbNB4xUdmWiKF6jz+IKwi0AnEtXkLz/uoLg39oPDKtZD1jdRpbtdt2DybFvEP
         G+MO7xHVsi4YBy1RPnvlmRJ9BXzQycvXtw1ydlf0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08EFLR2L062389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 10:21:27 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 10:21:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 10:21:26 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EFLNOP103257;
        Mon, 14 Sep 2020 10:21:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/2] Add DT to get PCIe working in J721E SoC
Date:   Mon, 14 Sep 2020 20:51:13 +0530
Message-ID: <20200914152115.1788-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that J721E PCIe support is merged (including the YAML bindings),
add PCIe device tree nodes to get PCIe working in J721E SoC both in
RC mode and EP mode.

Series has been rebased to:
git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux ti-k3-dts-next 

Changes from v1:
1) Renamed all syscon dt-nodes to "syscon" instead of pcieX-ctrl.
2) Add TI specific compatible for "syscon" DT nodes
3) Add information about appending "ranges" property to access all PCIe
   instances in commit log.

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe
    instances

 .../dts/ti/k3-j721e-common-proc-board.dts     |  80 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 232 +++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   5 +-
 3 files changed, 315 insertions(+), 2 deletions(-)

-- 
2.17.1

