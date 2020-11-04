Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C052A5F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKDISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:18:09 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:61746 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgKDISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:18:08 -0500
IronPort-SDR: 4yuYhiGYj8dKmHxpnzbBjvJ6acPQDFuEq05UIvSsq6WXtiMzfr9FjZ4ixtogi0fZe0NQRsWVfs
 VdNCQOxAqmeWhlabdWYgKaY+CctRcSAIiPZGwyeDOmPU9MypnDJFxPYgeVpXiJsZN2zUdnGdmu
 7Ov7bkkFKZUf7ZwkWDww54PnCPdOkLUziq+YuioBq1ooaxJ5yMa+gbxwdwoADuXbImCSXCVR5O
 zdK2gpL/XrOanrewfD2SkK6LxfjpZDYElGZ3HWka0bT17WWVEFxC+2IOKNmziYbQzyU9GPbi3l
 5ho=
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="2259501"
X-IronPort-AV: E=Sophos;i="5.77,450,1596466800"; 
   d="scan'208";a="2259501"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2020 17:10:37 +0900
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.87.33])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 26E29E0378
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:37 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EBA2AC0081
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:36 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id 47231B99B; Wed,  4 Nov 2020 17:07:57 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuichi Ito <ito-yuichi@fujitsu.com>
Subject: [PATCH v2 0/3] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Date:   Wed,  4 Nov 2020 17:05:36 +0900
Message-Id: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables IPI_CPU_CRASH_STOP IPI to be pseudo-NMI.
This allows kdump to collect system information even when the CPU is in
a HARDLOCKUP state.

Only IPI_CPU_CRASH_STOP uses NMI and the other IPIs remain normal IRQs.

The patch has been tested on FX1000.

It also uses some of Sumit's IPI patch set for NMI.[1]

[1] https://lore.kernel.org/lkml/1603983387-8738-3-git-send-email-sumit.garg@linaro.org/

$ echo 1 > /proc/sys/kernel/panic_on_rcu_stal
$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
   : kernel panics and crash kernel boot
   : makedumpfile saves the system state at HARDLOCKUP in vmcore.

crash utility:
 #7 [fffffe00290afd30] lkdtm_HARDLOCKUP at fffffe0010857ee8
 #8 [fffffe00290afd40] direct_entry at fffffe0010857c94
 #9 [fffffe00290afd90] full_proxy_write at fffffe001055dea0
#10 [fffffe00290afdd0] vfs_write at fffffe001047533c
#11 [fffffe00290afe10] ksys_write at fffffe001047563c
#12 [fffffe00290afe60] __arm64_sys_write at fffffe00104756e8
#13 [fffffe00290afe70] do_el0_svc at fffffe00101590cc
#14 [fffffe00290afea0] el0_svc at fffffe0010147a30
#15 [fffffe00290afeb0] el0_sync_handler at fffffe001014835c
#16 [fffffe00290afff0] el0_sync at fffffe0010142c14

Changes in v1:
- Rebased to head of upstream master.
- Rebased to Sumit's latest IPIs patch-set [1].

[1] https://lore.kernel.org/lkml/1603983387-8738-3-git-send-email-sumit.garg@linaro.org/

- Add conditional branch of local_irq_disable(). 

Sumit Garg (1):
  irqchip/gic-v3: Enable support for SGIs to act as NMIs

Yuichi Ito (2):
  arch64: smp: Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI
  arch64: smp: Disable priority masking when received NMI on PSR.I section

 arch/arm64/kernel/smp.c      | 44 +++++++++++++++++++++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 17 deletions(-)

-- 
1.8.3.1

