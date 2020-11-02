Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA652A32FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKBSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:30:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47270 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:30:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2IUADm075894;
        Mon, 2 Nov 2020 12:30:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604341810;
        bh=0Nrlmr+WA0tymRRQkTOvMZD2muzS4xdx01WK6tTzwWg=;
        h=From:To:CC:Subject:Date;
        b=MmE1a7LaVZsgPjfPC+ApspODKbWQLQvC2mUSMqFiZmOWb27RsYKv5k9DB341JWkJw
         IF1DGa9Ba6IXdgTMiTN8DsIin8inHjNXYHK5AL8S9/++Aiw/ZhX9mij4izBDXHR3+U
         5I/1VonY1b7aLURbXb8DNl2+UnHsbHHaTOk71TVQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2IUAwo045941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 12:30:10 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 12:30:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 12:30:10 -0600
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2IU6Lf083062;
        Mon, 2 Nov 2020 12:30:07 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2] arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform
Date:   Tue, 3 Nov 2020 00:00:05 +0530
Message-ID: <20201102183005.14174-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configs to help enable regulators that supply power to the SD card
on TI's J721e platform. These regulators are controlled by either
SoC gpios or gpios over i2c expander.

Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

Changes in v2: Squashed changes into a single patch

v1: https://lore.kernel.org/linux-arm-kernel/20201002164535.9920-1-faiz_abbas@ti.com/

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..bbf42faaddfe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -438,6 +438,7 @@ CONFIG_I2C_IMX=y
 CONFIG_I2C_IMX_LPI2C=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_I2C_OMAP=y
 CONFIG_I2C_OWL=y
 CONFIG_I2C_PXA=y
 CONFIG_I2C_QCOM_CCI=m
@@ -497,6 +498,7 @@ CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_GPIO_ALTERA=m
+CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_MPC8XXX=y
-- 
2.17.1

