Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45B02BB0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgKTQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:53:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbgKTQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:53:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F018AC60;
        Fri, 20 Nov 2020 16:53:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2020-11-20
Date:   Fri, 20 Nov 2020 17:52:56 +0100
Message-Id: <20201120165256.22439-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-11-20

for you to fetch changes up to 278407a53c3b33fb820332c4d39eb39316c3879a:

  ARM: dts: bcm283x: increase dwc2's RX FIFO size (2020-11-20 17:43:10 +0100)

----------------------------------------------------------------
- Maxime introduces a quirk to avoid EMI between WiFi and HDMI@1440p on
RPi4b.

- Pavel fixes dwc2's fifo size to properly support isochronous
transfers.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: dts: rpi-4: disable wifi frequencies

Pavel Hofman (1):
      ARM: dts: bcm283x: increase dwc2's RX FIFO size

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts             | 2 ++
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi        | 2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
