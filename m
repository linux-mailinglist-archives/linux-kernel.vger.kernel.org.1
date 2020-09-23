Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1BC275D76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:32:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58854 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgIWQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:32:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NGW061062885;
        Wed, 23 Sep 2020 11:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600878720;
        bh=RPb87F5duetIESPa+Zvpc608qrftjz4a2cyJEHjI2y4=;
        h=From:To:CC:Subject:Date;
        b=yE2g+topkQsl3Xh+YjZDhVxJm12sP3HxT3p0P+HdeFPqbkl2Whhm7bhRsp71svHpq
         hWH3i6/WOR2ediD4UfVyhQAGCP/QlfEipQYKIw+cxrXwt3+j40kc2Gbgd3qTHiOadD
         j4Ewe1dUqUKpXMp66O6BfzArhA8tCL7/nONIwQDs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NGW0Ix100241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 11:32:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 11:31:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 11:31:59 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NGVude099701;
        Wed, 23 Sep 2020 11:31:57 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j7200: Add HyperFlash related nodes
Date:   Wed, 23 Sep 2020 22:01:48 +0530
Message-ID: <20200923163150.16973-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds HyperBus and HyperFlash nodes for TI's J7200 SoC

v2:
Rebase on latest ti-k3-next + I2C series
Align reg address format with this file's convention

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
  arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 27 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.28.0

