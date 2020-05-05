Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C181C1C5D78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgEEQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbgEEQ0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:26:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A5EFAD09;
        Tue,  5 May 2020 16:26:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
Date:   Tue,  5 May 2020 18:26:05 +0200
Message-Id: <20200505162607.334-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to be
loaded explicitly. Earlier versions didn't need that as they where using
an EEPROM for that purpose. This series takes care of setting up the
relevant infrastructure and run the firmware loading routine at the
right moment.

Note that this builds on top of Sylwester Nawrocki's "USB host support
for Raspberry Pi 4 board" series.

---

Note: this was tested on both rpi_arm64_defconfig on both rpi3 & rpi4.

Changes since v2:
 - Correct comment on patch #1
 - Address Matthias' comments

Changes since v1:
 - Rename function
 - Use callback in xhci-pci.c

Nicolas Saenz Julienne (2):
  arm: rpi: Add function to trigger VL805's firmware load
  usb: xhci: Load Raspberry Pi 4 VL805's firmware

 arch/arm/mach-bcm283x/include/mach/mbox.h | 13 +++++++
 arch/arm/mach-bcm283x/include/mach/msg.h  |  7 ++++
 arch/arm/mach-bcm283x/msg.c               | 45 +++++++++++++++++++++++
 board/raspberrypi/rpi/rpi.c               |  6 +++
 drivers/usb/host/xhci-pci.c               |  6 +++
 include/usb/xhci.h                        |  3 ++
 6 files changed, 80 insertions(+)

-- 
2.26.2

