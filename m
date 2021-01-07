Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930A2ED0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbhAGNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:24:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbhAGNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:24:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 107DMW21124013;
        Thu, 7 Jan 2021 07:22:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610025752;
        bh=zx9n/lsjA2NjYjIEY+6vD1Q829vq5WkYbOvLXJLYazQ=;
        h=From:To:CC:Subject:Date;
        b=so5eldP1tdbR50ccHACYp3hVNo0vsx2DwkL50Hp/9DkBHVpZsH9V511oxTAjDUyZ3
         ju8IO5e8wg9cADUhDLl056KKxfE8KmTfqD3PS4U1CQ//Mem3tPBzCYTf3n7vUPQLsl
         anZl0/iqh4BgwdA2TY0sQ4kjnLU9bQqCeC3LBsmA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 107DMW09101024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jan 2021 07:22:32 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 Jan
 2021 07:22:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 Jan 2021 07:22:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 107DMWwS095650;
        Thu, 7 Jan 2021 07:22:32 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, <soc@kernel.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] arm64: defconfig: Drop unused K3 SoC specific options
Date:   Thu, 7 Jan 2021 07:22:28 -0600
Message-ID: <20210107132228.6577-1-nm@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With [1] integrated and all users of the config symbols removed, we
can safely remove the options from defconfig.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026170624.24241-1-nm@ti.com/

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Could ARM SoC maintainers pick this up for the 5.11 cycle?
unfortunately, this dropped through the cracks as dependencies were
getting pulled together. I dont have any other patches for 5.11 rcs

V1: https://lore.kernel.org/linux-arm-kernel/20201112215438.31432-1-nm@ti.com/

 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 838301650a79..a0bcf0201261 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -991,8 +991,6 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_TEGRA_234_SOC=y
-CONFIG_ARCH_K3_AM6_SOC=y
-CONFIG_ARCH_K3_J721E_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
-- 
2.29.2

