Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACDE2DB0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgLOQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:00:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:33306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgLOP6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:58:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE1A6ACE0;
        Tue, 15 Dec 2020 15:56:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        robh+dt@kernel.org, tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH 6/6] ARM: multi_v7_defconfig: Enable nvmem's rmem driver
Date:   Tue, 15 Dec 2020 16:56:26 +0100
Message-Id: <20201215155627.2513-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
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
index c5f25710fedc..7a326c5eff7a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1107,6 +1107,7 @@ CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_MESON_MX_EFUSE=m
+CONFIG_NVMEM_RMEM=m
 CONFIG_FSI=m
 CONFIG_FSI_MASTER_GPIO=m
 CONFIG_FSI_MASTER_HUB=m
-- 
2.29.2

