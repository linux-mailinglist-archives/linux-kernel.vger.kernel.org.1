Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC91B62E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgDWSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 14:05:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58162 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:05:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NI5l5p005744;
        Thu, 23 Apr 2020 13:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587665147;
        bh=mMaO8t1Eqao/J6mtLde2dOBedpV17ybTny2HZzC7JxY=;
        h=From:To:CC:Subject:Date;
        b=FGotfNibqGvKapww+9XkCnFPum7qyEFRO+3Lr2RtKQajWJJC1AtH5csD2x4ktFPsk
         Hvl/AOb2mpj1tsqbeTkKPW24463op5xqnIlj0Vc4OtrZMQIJoqXokdiMYIlHqCe5Ak
         w32Cwr65Z2BBRwx8nJ8iRFZjuFZJlRSCkbvUQIt0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03NI5lZt097577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 13:05:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 13:05:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 13:05:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NI5jw4008985;
        Thu, 23 Apr 2020 13:05:46 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/5] soc: ti: add k3 platforms chipid module driver
Date:   Thu, 23 Apr 2020 21:05:40 +0300
Message-ID: <20200423180545.13707-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series introduces TI K3 Multicore SoC platforms chipid module driver
which provides identification support of the TI K3 SoCs (family, revision)
and register this information with the SoC bus. It is available under
/sys/devices/soc0/ for user space, and can be checked, where needed,
in Kernel using soc_device_match().
It is also required for introducing support for new revisions of
K3 AM65x/J721E SoCs.

Example J721E:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments K3 J721E SoC
  J721E
  SR1.0

Example AM65x:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments AM654 Base Board
  AM65X
  SR1.0

Grygorii Strashko (5):
  dt-bindings: soc: ti: add binding for k3 platforms chipid module
  soc: ti: add k3 platforms chipid module driver
  arm64: arch_k3: enable chipid driver
  arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
  arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module
    node

 .../bindings/soc/ti/k3-socinfo.yaml           |  40 ++++++
 arch/arm64/Kconfig.platforms                  |   1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   5 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   5 +
 drivers/soc/ti/Kconfig                        |  10 ++
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3-socinfo.c                   | 135 ++++++++++++++++++
 7 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
 create mode 100644 drivers/soc/ti/k3-socinfo.c

-- 
2.17.1

