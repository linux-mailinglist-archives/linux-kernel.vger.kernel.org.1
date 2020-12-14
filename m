Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB622D97F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgLNMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbgLNMYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:24:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7030B73F;
        Mon, 14 Dec 2020 12:23:39 +0000 (UTC)
Date:   Mon, 14 Dec 2020 13:23:40 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v5.11
Message-ID: <20201214122340.GH26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/platform drivers pile for v5.11.

Thx.

---

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.11

for you to fetch changes up to c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2:

  x86/platform/uv: Update sysfs documentation (2020-12-07 21:19:20 +0100)

----------------------------------------------------------------
- Add a new uv_sysfs driver and expose read-only information from UV BIOS
(Justin Ernst and Mike Travis)

- The usual set of small fixes.

----------------------------------------------------------------
Dan Carpenter (1):
      x86/platform/uv: Fix an error code in uv_hubs_init()

Justin Ernst (5):
      x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
      x86/platform/uv: Add and export uv_bios_* functions
      x86/platform/uv: Add new uv_sysfs platform driver
      x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
      x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

Mike Travis (5):
      x86/platform/uv: Add kernel interfaces for obtaining system info
      x86/platform/uv: Add sysfs leaves to replace those in procfs
      x86/platform/uv: Add sysfs hubless leaves
      x86/platform/uv: Add deprecated messages to /proc info leaves
      x86/platform/uv: Update sysfs documentation

Zou Wei (1):
      x86/platform/uv: Make uv_pcibus_kset and uv_hubs_kset static

 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 160 +++-
 MAINTAINERS                                     |   6 +
 arch/x86/include/asm/uv/bios.h                  |  51 ++
 arch/x86/include/asm/uv/uv_geo.h                | 103 +++
 arch/x86/kernel/apic/x2apic_uv_x.c              |  23 +-
 arch/x86/platform/uv/Makefile                   |   2 +-
 arch/x86/platform/uv/bios_uv.c                  |  55 ++
 arch/x86/platform/uv/uv_sysfs.c                 |  63 --
 drivers/platform/x86/Kconfig                    |  11 +
 drivers/platform/x86/Makefile                   |   3 +
 drivers/platform/x86/uv_sysfs.c                 | 929 ++++++++++++++++++++++++
 11 files changed, 1327 insertions(+), 79 deletions(-)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c
 create mode 100644 drivers/platform/x86/uv_sysfs.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
