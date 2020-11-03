Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49F2A4FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKCTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:08:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38050 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:08:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3J8QjF108527;
        Tue, 3 Nov 2020 13:08:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604430506;
        bh=bycp6Kyb+J58jf9XxZdfTl9Z6ZQgf5Ww+4UQt3jG69Q=;
        h=From:To:CC:Subject:Date;
        b=iXwsYBBHs1cmN3zM1lyag0JZfh24F+ymY7Znwo3uUqvLwez77XHtaHDFmU2BRjx2y
         foGeq44DhPNKzHUygMa8hIqrWEegVv5bSm4TVuEzRN2GU74RYvdSdxgycdQEgWy+0V
         B3LmOklg0fjCXAtmsF7fQjMw1Mxif3ViKM7Wz3L0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3J8QBd091465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 13:08:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 13:08:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 13:08:25 -0600
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3J8MpI037680;
        Tue, 3 Nov 2020 13:08:23 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform
Date:   Wed, 4 Nov 2020 00:38:21 +0530
Message-ID: <20201103190821.30937-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configs to enable regulators that supply power to the SD card
on TI's J721e platform. These regulators are controlled by either
SoC gpios or gpios over i2c expander.

Changes to vmlinux size:
Before:
   text	    data     bss       dec       hex	  filename
20219067  10875634  523924   31618625   1e27641	  vmlinux

After:
   text     data     bss	dec	 hex	  filename
20228755  10880422  524628   31633805	1e2b18d   vmlinux

delta: 15180 (dec)

Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

Changes in v3: Added changes to vmlinux size in commit message

Changes in v2: Squashed changes into a single patch

v2:
https://lore.kernel.org/linux-arm-kernel/20201102183005.14174-1-faiz_abbas@ti.com/

v1:
https://lore.kernel.org/linux-arm-kernel/20201002164535.9920-1-faiz_abbas@ti.com/

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

