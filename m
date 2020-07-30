Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBF2338F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgG3T0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 15:26:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44750 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3T0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:26:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UJQFKu057848;
        Thu, 30 Jul 2020 14:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596137175;
        bh=sCkppKn5L7SzVpqcIP0Z28bMAlVEY8CVrkvmfxBVjx0=;
        h=From:To:CC:Subject:Date;
        b=T71glaAZfK/wvfLqPZZGNUexdtqWOQV+fBRzQYxRXiPO2PI8Qc+fvJTR0BS8gEEt3
         yu2kx66atM9uClFRb5+2VOLYdk54uVohISDew4YMuq+qj3sDAKHwje44Njcq16RV2Z
         p6k7AM/H0v7DyC0nY8T+/8w0OswxLNzLSeQ1qUbw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UJQFbA112262;
        Thu, 30 Jul 2020 14:26:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 14:26:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 14:26:15 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UJQCp9052740;
        Thu, 30 Jul 2020 14:26:13 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] J7200: Add I2C support
Date:   Fri, 31 Jul 2020 00:55:58 +0530
Message-ID: <20200730192600.1872-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C and I2C IO expanders nodes for J7200

Based on top of https://lore.kernel.org/linux-arm-kernel/20200723084628.19241-1-lokeshvutla@ti.com/

Vignesh Raghavendra (2):
  arm64: dts: ti: j7200: Add I2C nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders

 .../dts/ti/k3-j7200-common-proc-board.dts     | 49 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 77 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 ++++++++
 3 files changed, 159 insertions(+)

-- 
2.28.0

