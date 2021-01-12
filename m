Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002CC2F32EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbhALOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:25:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbhALOZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:25:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF6C5AE6D;
        Tue, 12 Jan 2021 14:24:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nsaenzjulienne@suse.de, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH v3 5/5] ARM: multi_v7_defconfig: Enable nvmem's rmem driver
Date:   Tue, 12 Jan 2021 15:23:42 +0100
Message-Id: <20210112142342.7290-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112142342.7290-1-nsaenzjulienne@suse.de>
References: <20210112142342.7290-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'll be used by the RPi4 family of boards to access its bootloader
configuration.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6492a3601e7c..0914fa09af0c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1106,6 +1106,7 @@ CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_MESON_MX_EFUSE=m
+CONFIG_NVMEM_RMEM=m
 CONFIG_FSI=m
 CONFIG_FSI_MASTER_GPIO=m
 CONFIG_FSI_MASTER_HUB=m
-- 
2.29.2

