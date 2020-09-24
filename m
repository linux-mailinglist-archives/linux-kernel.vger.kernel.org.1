Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B87276FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgIXL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:27:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42104 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIXL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:27:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQmrC048666;
        Thu, 24 Sep 2020 06:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600946808;
        bh=fbCwOIpOdjy56NxH93HAZUZIpBF54AB0JlwVudWMdmg=;
        h=From:To:CC:Subject:Date;
        b=T4k/gTJSkJaVMipbAp98bc0hsWkCX2wTOt0MsA1kOatXxt5Kw58RfHTakWUwgRlVS
         jNychK9dvyKf74JkzrQE/DOtlZXslXnuNQVz4dw+3WsYiY3LN3xXjzpTRwzYOBKIKo
         AqLLhXXEdOU2+DOTx6Qro5DCy2kBUMS8wX9Ux32g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OBQmLI126111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 06:26:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 06:26:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 06:26:48 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OBQjMP036450;
        Thu, 24 Sep 2020 06:26:46 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 0/2] Add support for MMC/SD on j7200-evm
Date:   Thu, 24 Sep 2020 16:56:42 +0530
Message-ID: <20200924112644.11076-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dt support for MMC/SD on TI's j7200-evm.

Currently, eMMC support upto HS200 speed and SD card supports upto high
speed speed mode.

v2:
Fixed node names to use mmc@* format
Fixed reg address format to align with others in the file

Faiz Abbas (2):
  arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and
    SD card

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 37 +++++++++++++++++++
 2 files changed, 65 insertions(+)

-- 
2.17.1

