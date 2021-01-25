Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00820302D40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbhAYVG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:06:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbhAYVCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:02:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF218AD62;
        Mon, 25 Jan 2021 21:01:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/4] bcm2835-defconfig-next-2021-01-25
Date:   Mon, 25 Jan 2021 22:01:29 +0100
Message-Id: <20210125210131.14969-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125210131.14969-1-nsaenzjulienne@suse.de>
References: <20210125210131.14969-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-defconfig-next-2021-01-25

for you to fetch changes up to 5462a35ce3e4748e079ee325a1e9bb436f4950b3:

  ARM: multi_v7_defconfig: Enable nvmem's rmem driver (2021-01-25 21:57:33 +0100)

----------------------------------------------------------------
Enable NVMEM_RMEM as module to expose RPi4's bootloader configuration to
userspace

----------------------------------------------------------------
Nicolas Saenz Julienne (1):
      ARM: multi_v7_defconfig: Enable nvmem's rmem driver

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)
