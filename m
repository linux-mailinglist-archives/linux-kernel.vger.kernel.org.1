Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923E52B1F26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgKMPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:49:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50434 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:49:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADFn8ha127755;
        Fri, 13 Nov 2020 09:49:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605282548;
        bh=rP3NNmod4yEZAOaMs77YdlPrXCJ607nw7HeXs0KdxI0=;
        h=From:To:CC:Subject:Date;
        b=WxTtqgSlJ+x2kVSXhV+7Ab6hiUJzhsm9FT/fygHzkQkhRtr5dHN9Nl+SZy+h8F4Ul
         EXX2t9gM25jC4UnDlZkbgSRWscTs1tYUC90qpxc98oIhtSaVtKusSJSIzTA0rdJ5GD
         +QaOBjjcc/SJ8aShU5NedLWzkt44FgE8lBB29Pwc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADFn8pt008682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 09:49:08 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 09:49:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 09:49:08 -0600
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADFn51b005538;
        Fri, 13 Nov 2020 09:49:06 -0600
From:   Sekhar Nori <nsekhar@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform
Date:   Fri, 13 Nov 2020 21:19:05 +0530
Message-ID: <20201113154905.40095-1-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add configs to help enable regulators that supply power to the SD card
on TI's J721e platform. These regulators are controlled by either
SoC gpios or gpios over i2c expander.

vmlinux size before and after patch follow:

Before:
   text	   data	    bss	    dec	    hex	filename
19755448	10376346	 535572	30667366	1d3f266	vmlinux

After:
   text	   data	    bss	    dec	    hex	filename
19769232	10381390	 536212	30686834	1d43e72	vmlinux

difference is 19,468 (dec)

Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
changes in v3:
- add size delta as requested by Nishanth Menon

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c5f404ce2eec..e44d3f438530 100644
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
@@ -498,6 +499,7 @@ CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_GPIO_ALTERA=m
+CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_MPC8XXX=y
-- 
2.17.1

