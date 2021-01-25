Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB4302D43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbhAYVIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:08:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:54546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732100AbhAYVCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:02:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 616E0ACF5;
        Mon, 25 Jan 2021 21:01:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/4] bcm2835-dt-next-2021-01-25
Date:   Mon, 25 Jan 2021 22:01:28 +0100
Message-Id: <20210125210131.14969-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-01-25

for you to fetch changes up to 5878b8087904a5827c3551698be83da1ccf84e11:

  ARM: dts: bcm2711: Add the BSC interrupt controller (2021-01-25 21:49:41 +0100)

----------------------------------------------------------------
Add DSI compatible string for Raspberry Pi 4

Enable BSC controller used for HDMI DCC

Add reserved memory node to expose Raspberry Pi 4's bootloader configuration

----------------------------------------------------------------
Dave Stevenson (1):
      ARM: dts: bcm2711: Use compatible string for BCM2711 DSI1

Maxime Ripard (1):
      ARM: dts: bcm2711: Add the BSC interrupt controller

Nicolas Saenz Julienne (1):
      ARM: dts: bcm2711: Add reserved memory template to hold firmware configuration

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi        | 13 +++++++++++++
 2 files changed, 30 insertions(+)
