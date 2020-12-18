Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102102DE6D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgLRPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:44:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:43010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLRPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:44:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81E22AD09;
        Fri, 18 Dec 2020 15:43:35 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nsaenzjulienne@suse.de, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH v2 0/5] Expose RPi4's bootloader configuration
Date:   Fri, 18 Dec 2020 16:43:15 +0100
Message-Id: <20201218154320.28368-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soon to be released versions of RPi4's firmware will take of care
passing their bootloader's configuration[1] to the OS by copying it into
memory and creating a reserved memory node in the board's DT. By
modeling this reserved memory node as an nvmem device using
'nvmem-rmem', which this series introduces, user-space applications will
be able to query this information through nvmem's sysfs interface.

An alternative approach, less nice IMO, would be to create a
platform-specific 'soc' driver.

Regards,
Nicolas

[1] https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md

---

Changes since v1:
 - Avoid the reserved-memory indirection by integrating the nvmem driver
   into the reserved memory node.

Nicolas Saenz Julienne (5):
  dt-bindings: nvmem: Add bindings for rmem driver
  nvmem: Add driver to expose reserved memory as nvmem
  ARM: dts: bcm2711: Add reserved memory template to hold firmware
    configuration
  arm64: defconfig: Enable nvmem's rmem driver
  ARM: multi_v7_defconfig: Enable nvmem's rmem driver

 .../devicetree/bindings/nvmem/rmem.yaml       | 49 ++++++++++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         | 17 ++++
 arch/arm/configs/multi_v7_defconfig           |  1 +
 arch/arm64/configs/defconfig                  |  1 +
 drivers/nvmem/Kconfig                         |  8 ++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/rmem.c                          | 97 +++++++++++++++++++
 drivers/of/platform.c                         |  1 +
 8 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
 create mode 100644 drivers/nvmem/rmem.c

-- 
2.29.2

