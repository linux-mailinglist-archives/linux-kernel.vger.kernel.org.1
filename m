Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD19275C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIWPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:55:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44678 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgIWPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:55:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NFtWdK040957;
        Wed, 23 Sep 2020 10:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600876533;
        bh=SuEqA1d2P4sVEvkOLGjtSCl8mLTb2PM27+gGWRfqOmc=;
        h=From:To:CC:Subject:Date;
        b=dLui2PyDEjPT1a5Mxar3VYvLkWvdETKdG11gtkeL63WNxDDL/vOV9uTsjYvAy6mS4
         WoYa9fcCpHK3YUvJ/ZX+AC+pqGIr2jQ6UDlkR9Zp8jOaGQKAVtXisF1hEyIDaWxWSA
         Z5k4sjBQqpPJWZK0f/Rfz8SKH5uW56GLSo5Wg9II=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFtWtv023965;
        Wed, 23 Sep 2020 10:55:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 10:55:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 10:55:32 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFtT8r074561;
        Wed, 23 Sep 2020 10:55:30 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/2] J7200: Add I2C support
Date:   Wed, 23 Sep 2020 21:23:58 +0530
Message-ID: <20200923155400.13757-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C and I2C IO expanders nodes for J7200

v2:
Align reg address format with that of file's (s/0x0/0x00)

Vignesh Raghavendra (2):
  arm64: dts: ti: j7200: Add I2C nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders

 .../dts/ti/k3-j7200-common-proc-board.dts     | 49 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 77 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 ++++++++
 3 files changed, 159 insertions(+)

-- 
2.28.0

