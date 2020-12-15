Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB52DB0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgLOQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:08:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:60770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbgLOP5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CD2EAC7F;
        Tue, 15 Dec 2020 15:56:40 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH 0/6] Expose RPi4'd bootloader configuration
Date:   Tue, 15 Dec 2020 16:56:20 +0100
Message-Id: <20201215155627.2513-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soon to be released versions of RPi4's firmware will take of care
passing their bootloader's configuration to the OS by copying it into
memory and creating a reserved memory node in the board's DT. In order
to make use of this information, this series introduces a new generic
nvmem driver that maps reserved-memory nodes into nvmem devices.

An alternative approach, less nice IMO, would be to create a
platform-specific 'soc' driver.

Regards,
Nicolas

---

Nicolas Saenz Julienne (6):
  dt-bindings: nvmem: Add bindings for rmem driver
  nvmem: Add driver to expose reserved memory as nvmem
  ARM: dts: bcm2711: Add reserved memory template to hold firmware
    configuration
  ARM: dts: bcm2711: Expose boot-loader configuration
  arm64: defconfig: Enable nvmem's rmem driver
  ARM: multi_v7_defconfig: Enable nvmem's rmem driver

 .../devicetree/bindings/nvmem/rmem.yaml       | 35 +++++++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         | 25 +++++
 arch/arm/configs/multi_v7_defconfig           |  1 +
 arch/arm64/configs/defconfig                  |  1 +
 drivers/nvmem/Kconfig                         |  8 ++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/rmem.c                          | 92 +++++++++++++++++++
 7 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.yaml
 create mode 100644 drivers/nvmem/rmem.c

-- 
2.29.2

