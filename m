Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC332A33C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKBTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:13:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:13:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JDMEH083827;
        Mon, 2 Nov 2020 13:13:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604344402;
        bh=abtVf9ASjEw9o5PAxcm5ZFODBEOmngwQQiZm8WF2HOg=;
        h=From:To:CC:Subject:Date;
        b=fk98h+wd3hwwsCCe8sxkbsdUXmlaYCCyT+4rnP7fYR4GSLxhA4Z8vqimrhBS9Xve5
         Zolw/TTNFFIDu9SU7My+xV9Ey+7mnUdoM5iq0vEMR4bUv2YFDMHNhkkieCGLHBXniK
         awivB9jDfy6BHypnSUq5ZWEz+xAnge2lgwsQ1zAg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2JDMH3110384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 13:13:22 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 13:11:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 13:11:24 -0600
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2JBLoN093265;
        Mon, 2 Nov 2020 13:11:22 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Add gpio support for TI's J7200 platform
Date:   Tue, 3 Nov 2020 00:41:17 +0530
Message-ID: <20201102191120.20380-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add gpio support for TI's J7200 platform.

These patches were posted as a part of an older series but have now
been split into three parts. The 3 parts add configs, gpios and MMC/SD
related dts patches respectively.

Older series is here:
https://lore.kernel.org/linux-arm-kernel/20201001190541.6364-1-faiz_abbas@ti.com/

Series adding configs to arm64 defconfig is here:
https://lore.kernel.org/linux-arm-kernel/20201102183005.14174-1-faiz_abbas@ti.com/

Faiz Abbas (3):
  arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
  arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
  arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
    modules

 .../dts/ti/k3-j7200-common-proc-board.dts     | 16 +++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 68 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 32 +++++++++
 3 files changed, 116 insertions(+)

-- 
2.17.1

