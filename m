Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B838B28DFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgJNLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJNLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:12:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32801C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so1596456plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JZPfyUKOLo0JmSQwF5DLk3PgfF5Xy68EfOEmanNpczI=;
        b=djtN3pUho/ol4q4WNcM6YvULQBUk87Sftk6miU65ieEtzIT6Xrw22q2JOHPmBCZGWB
         YrF2vHs34C4Y8/XOvgWCadLiKthOBhwGXtuBXXR0QgGE9a7lBfuzOfCgT6FTN536BV4W
         yotgbbs5dipfOtcX6vcpOF81c3xMeynfS6/H5/nsToBku0KpoSqEfJ9mXIxdmbjdC6aJ
         Sd8i4Rhk3Eb414+QZ1ft/oS5ny4voVEoW8/08BtipLPigvLm0OaXn0SbnAjA7YQ3H1kI
         kM1VPws9Ze8mxfpE/ErIQwrJ/h8QC6e0UGoTRosCxDZDJpJPujZqcFTnf7eU7+agD/mu
         Ygog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JZPfyUKOLo0JmSQwF5DLk3PgfF5Xy68EfOEmanNpczI=;
        b=NaVtmzoxTkPEpfO91OIi15/L314Ugtu3hbBvsVMa0jxdgpiuLMaQ+1Vv+zBGdlqlix
         rv/zg+N1j364JreTrSSu2NNUMPzKXi+NTBJUBD/1m8bVu/eJSoiQFr5/09uye7nQSAld
         evOcVFnXQLNOO9Q9AzinC4BFuOspraux1vg6B20q1gEwZliE2VLqv8DRU9QQ6cVEkekc
         NT6ZYFS6zjraaSTFhVfWKy6OPIUI0gJLWk/5D7C5mnrWScEfjRYFaYaTdJnFuUhKSpPY
         g4kOCZlQp1e6TtYS8BYgOO40vX4WSC8DX5hHoWDM50BJMbdd8TTvbXPCDFg1b+gpADDF
         SPFQ==
X-Gm-Message-State: AOAM533lnUnJqPhhzl5cQCAvuNJ9XKV0Z8pBclkqQWWthylY/KvUjTAC
        ipys6s8lQROqnKl/bXo+Lrd35w==
X-Google-Smtp-Source: ABdhPJwBQ7NoWd4vfeEzjj/Q9sPHpjSGWRyJLflJHCUZ0B12aNAqEkkqL3a3DdpN9uLC6iLQPHWu6A==
X-Received: by 2002:a17:90a:6f21:: with SMTP id d30mr2935794pjk.165.1602673961468;
        Wed, 14 Oct 2020 04:12:41 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.12.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:12:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/5] arm64: Add framework to turn an IPI as NMI
Date:   Wed, 14 Oct 2020 16:42:06 +0530
Message-Id: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pseudo NMIs support available its possible to configure SGIs to be
triggered as pseudo NMIs running in NMI context. And kernel features
such as:
- NMI backtrace can leverage IPI turned as NMI to get a backtrace of CPU
  stuck in hard lockup using magic SYSRQ.
- kgdb relies on NMI support to round up CPUs which are stuck in hard
  lockup state with interrupts disabled.

This patch-set adds framework to turn an IPI as NMI which can be triggered
as a pseudo NMI which in turn invokes registered NMI handlers.

After this patch-set we should be able to get a backtrace for a CPU
stuck in HARDLOCKUP. Have a look at an examples below from a hard lockup
testcase run on Developerbox:

$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT

NMI backtrace:
==============

# Issue Magic SysRq to dump backtrace

[  376.894502] NMI backtrace for cpu 8
[  376.894506] CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
[  376.894510] Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
[  376.894514] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
[  376.894517] pc : lkdtm_HARDLOCKUP+0x8/0x18
[  376.894520] lr : lkdtm_do_action+0x24/0x30
[  376.894524] sp : ffff800012cebd20
[  376.894527] pmr_save: 00000060
[  376.894530] x29: ffff800012cebd20 x28: ffff000875ae8000 
[  376.894540] x27: 0000000000000000 x26: 0000000000000000 
[  376.894550] x25: 000000000000001a x24: ffff800012cebe40 
[  376.894560] x23: 000000000000000b x22: ffff800010fc5040 
[  376.894569] x21: ffff000878b61000 x20: ffff8000113b2870 
[  376.894579] x19: 000000000000001b x18: 0000000000000010 
[  376.894588] x17: 0000000000000000 x16: 0000000000000000 
[  376.894598] x15: ffff000875ae8470 x14: 00000000000002ad 
[  376.894613] x13: 0000000000000000 x12: 0000000000000000 
[  376.894622] x11: 0000000000000007 x10: 00000000000009c0 
[  376.894631] x9 : ffff800012ceba80 x8 : ffff000875ae8a20 
[  376.894641] x7 : ffff00087f6b3280 x6 : ffff00087f6b3200 
[  376.894651] x5 : 0000000000000000 x4 : ffff00087f6a91f8 
[  376.894660] x3 : ffff00087f6b0120 x2 : 1aa310cec69eb500 
[  376.894670] x1 : 0000000000000000 x0 : 0000000000000060 
[  376.894679] Call trace:
[  376.894683]  lkdtm_HARDLOCKUP+0x8/0x18
[  376.894686]  direct_entry+0x124/0x1c0
[  376.894689]  full_proxy_write+0x60/0xb0
[  376.894693]  vfs_write+0xf0/0x230
[  376.894696]  ksys_write+0x6c/0xf8
[  376.894699]  __arm64_sys_write+0x1c/0x28
[  376.894703]  el0_svc_common.constprop.0+0x74/0x1f0
[  376.894707]  do_el0_svc+0x24/0x90
[  376.894710]  el0_sync_handler+0x180/0x2f8
[  376.894713]  el0_sync+0x158/0x180

KGDB:
=====

# Enter kdb via Magic SysRq

[6]kdb> btc
btc: cpu status: Currently on cpu 6
Available cpus: 0-5(I), 6, 7(I), 8, 9-23(I)
<snip>
Stack traceback for pid 555
0xffff000875ae8000      555      554  1    8   R  0xffff000875ae89c0  bash
CPU: 8 PID: 555 Comm: bash Not tainted 5.9.0-rc3-00740-g06ff047-dirty #242
Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #73 Apr  6 2020
Call trace:
 dump_backtrace+0x0/0x1a0
 show_stack+0x18/0x28
 dump_stack+0xc0/0x11c
 kgdb_cpu_enter+0x648/0x660
 kgdb_nmicallback+0xa0/0xa8
 ipi_kgdb_nmicallback+0x24/0x30
 ipi_nmi_handler+0x48/0x60
 handle_percpu_devid_fasteoi_ipi+0x74/0x88
 generic_handle_irq+0x30/0x48
 handle_domain_nmi+0x48/0x80
 gic_handle_irq+0x18c/0x34c
 el1_irq+0xcc/0x180
 lkdtm_HARDLOCKUP+0x8/0x18
 direct_entry+0x124/0x1c0
 full_proxy_write+0x60/0xb0
 vfs_write+0xf0/0x230
 ksys_write+0x6c/0xf8
 __arm64_sys_write+0x1c/0x28
 el0_svc_common.constprop.0+0x74/0x1f0
 do_el0_svc+0x24/0x90
 el0_sync_handler+0x180/0x2f8
 el0_sync+0x158/0x180
<snip>

Changes in v5:
- Rebased to head of upstream master.
- Remove redundant invocation of ipi_nmi_setup().
- Addressed misc. comments.

Changes in v4:
- Move IPI NMI framework to a separate file.
- Get rid of hard-coded IPI_CALL_NMI_FUNC allocation.
- Add NMI backtrace support leveraged via magic SYSRQ.

Changes in v3:
- Rebased to Marc's latest IPIs patch-set [1].

[1] https://lkml.org/lkml/2020/9/1/603

Changes since RFC version [1]:
- Switch to use generic interrupt framework to turn an IPI as NMI.
- Dependent on Marc's patch-set [2] which turns IPIs into normal
  interrupts.
- Addressed misc. comments from Doug on patch #4.
- Posted kgdb NMI printk() fixup separately which has evolved since
  to be solved using different approach via changing kgdb interception
  of printk() in common printk() code (see patch [3]).

[1] https://lkml.org/lkml/2020/4/24/328
[2] https://lkml.org/lkml/2020/5/19/710
[3] https://lkml.org/lkml/2020/5/20/418

Sumit Garg (5):
  arm64: Add framework to turn IPI as NMI
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: smp: Allocate and setup IPI as NMI
  arm64: kgdb: Round up cpus using IPI as NMI
  arm64: ipi_nmi: Add support for NMI backtrace

 arch/arm64/include/asm/irq.h  |  6 +++
 arch/arm64/include/asm/kgdb.h |  8 ++++
 arch/arm64/include/asm/nmi.h  | 16 ++++++++
 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/ipi_nmi.c   | 90 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kgdb.c      | 21 ++++++++++
 arch/arm64/kernel/smp.c       |  8 ++++
 drivers/irqchip/irq-gic-v3.c  | 13 ++++++-
 8 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

-- 
2.7.4

