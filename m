Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3D276803
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgIXEys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:54:48 -0400
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:62677 "EHLO
        mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXEyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:54:47 -0400
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 00:54:46 EDT
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym03.jp.fujitsu.com with smtp
         id 2783_2cfd_64562af8_ea9a_4753_b429_e475f2a5d975;
        Thu, 24 Sep 2020 13:43:38 +0900
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 935C3AC0111
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:43:37 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id E760C1C014; Thu, 24 Sep 2020 13:42:38 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuichi Ito <ito-yuichi@fujitsu.com>
Subject: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Date:   Thu, 24 Sep 2020 13:42:34 +0900
Message-Id: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI

This patchset enables IPI_CPU_CRASH_STOP IPI to be pseudo-NMI.
This allows kdump to collect system information even when the CPU is in
a HARDLOCKUP state.

Only IPI_CPU_CRASH_STOP uses NMI and the other IPIs remain normal IRQs.

The patch has been tested on ThunderX.

This patch assumes Marc's latest IPIs patch-set. [1]
It also uses some of Sumit's IPI patch set for NMI.[2]

[1] https://lore.kernel.org/linux-arm-kernel/20200901144324.1071694-1-maz@kernel.org/
[2] https://lore.kernel.org/linux-arm-kernel/1599830924-13990-3-git-send-email-sumit.garg@linaro.org/

$ echo 1 > /proc/sys/kernel/panic_on_rcu_stal
$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
   : kernel panics and crash kernel boot
   : makedumpfile saves the system state at HARDLOCKUP in vmcore.

crash utility:
crash> bt
  PID: 3213   TASK: fffffd001adc5940  CPU: 8   COMMAND: "bash"
  #0 [fffffe0022fefcf0] lkdtm_HARDLOCKUP at fffffe0010888ab4
  #1 [fffffe0022fefd10] lkdtm_do_action at fffffe00108882bc
  #2 [fffffe0022fefd20] direct_entry at fffffe0010888720
  #3 [fffffe0022fefd70] full_proxy_write at fffffe001058cfe4
  #4 [fffffe0022fefdb0] vfs_write at fffffe00104a4c2c
  #5 [fffffe0022fefdf0] ksys_write at fffffe00104a4f0c
  #6 [fffffe0022fefe40] __arm64_sys_write at fffffe00104a4fbc
  #7 [fffffe0022fefe50] el0_svc_common.constprop.0 at fffffe0010159e38
  #8 [fffffe0022fefe80] do_el0_svc at fffffe0010159fa0
  #9 [fffffe0022fefe90] el0_svc at fffffe00101481d0
  #10 [fffffe0022fefea0] el0_sync_handler at fffffe00101484b4
  #11 [fffffe0022fefff0] el0_sync at fffffe0010142b7c


Sumit Garg (1):
  irqchip/gic-v3: Enable support for SGIs to act as NMIs

Yuichi Ito (1):
  Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI

 arch/arm64/kernel/smp.c      | 39 ++++++++++++++++++++++++++++--------
 drivers/irqchip/irq-gic-v3.c | 13 ++++++++++--
 2 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.25.1

