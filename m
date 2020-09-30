Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55EC27E85E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgI3MUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:20:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3MUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKauI096021;
        Wed, 30 Sep 2020 07:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601468436;
        bh=bX1syfrsKGpq+o4W7deg1wIBEzvvdV9P2y0SvSys/ag=;
        h=From:To:CC:Subject:Date;
        b=NhXfp5kR0ePBaNRy9WxNpi1CqqRRu/hpmUwaEPv1Am4tRr8qpqeatdHy3pWTf0Giw
         C3g4yvfvbkYhnCUKwzrE2VtQ371IuAPoFtYL25RysD0w4BFc5mVfI30NmCA9XATUvF
         0CqJQB6XE+LnpBISPuzSdR+jQpzTcqc8PMCIBYoI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UCKaAo107579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:20:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:20:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:20:36 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKXr2049132;
        Wed, 30 Sep 2020 07:20:34 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Wed, 30 Sep 2020 15:20:26 +0300
Message-ID: <20200930122032.23481-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero/Nishanth,

This series adds USB2.0 support for the J7200 EVM.

Series is based on top of: linux-next next-20200930

cheers,
-roger

Changelog:
v5:
- Rebased on next-20200930. Added Reviewed-by and Acked-by.

v4:
- use single header file for MUX defines. drop WIZ from macro names.

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
  dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
  arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
  arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
  arm64: dts: ti: k3-j7200-main: Add USB controller
  arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
 include/dt-bindings/mux/ti-serdes.h           | 22 ++++++++
 3 files changed, 101 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

