Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52F12DE6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgLRPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:44:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:43222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgLRPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:44:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E6D6AE12;
        Fri, 18 Dec 2020 15:43:39 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nsaenzjulienne@suse.de, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH v2 4/5] arm64: defconfig: Enable nvmem's rmem driver
Date:   Fri, 18 Dec 2020 16:43:19 +0100
Message-Id: <20201218154320.28368-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218154320.28368-1-nsaenzjulienne@suse.de>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'll be used by the RPi4 family of boards to access its bootloader
configuration.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 838301650a79..68d6a7e024c0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1062,6 +1062,7 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
+CONFIG_NVMEM_RMEM=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_STRATIX10_SOC=m
 CONFIG_FPGA_BRIDGE=m
-- 
2.29.2

