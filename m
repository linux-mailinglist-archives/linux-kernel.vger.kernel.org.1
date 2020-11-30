Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48B2C8BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbgK3Rtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:49:40 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38056 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729216AbgK3Rt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:49:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UH3N1OB_1606758525;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH3N1OB_1606758525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 01:48:46 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org
Cc:     vkoul@kernel.org, geert+renesas@glider.be, Anson.Huang@nxp.com,
        michael@walle.cc, krzk@kernel.org, olof@lixom.net,
        vincenzo.frascino@arm.com, ardb@kernel.org, masahiroy@kernel.org,
        gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64:msr: Add MSR driver
Date:   Tue,  1 Dec 2020 01:48:30 +0800
Message-Id: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

MSR ARM driver aims to provide interfacs for user to read or write data to all
system registers. Its functions is same as MSR driver (x86 platform). It mainly
depends on kprobe and undef exception to read or write system registers
dynamicly.

In addition, this module create interfaces for each core. We have tested in the
virtual machine using tree command:

$ tree /dev/cpu
/dev/cpu
|-- 0
|   `-- msr
|-- 1
|   `-- msr
|-- 2
|   `-- msr
|-- 3
|   `-- msr
|-- 4
|   `-- msr
|-- 5
|   `-- msr
|-- 6
|   `-- msr
`-- 7
    `-- msr

8 directories, 8 files

The interfaces of this module is same as MSR module in user space, and to solve
the problem that ARM platform has no similar MSR module. Using this interface,
we did some pressure tests to test the stability and security of MSR driver. The
test results show that the driver will not cause system panic if various
illegal values and multithreading concurrent access are passed through the
interface.

We also designed a user space tool: system-register-tools. We have open
sourced this tool, which link as follows:
	https://github.com/alibaba/system-register-tools
In this tools, we provide two command: rdasr and wrasr, the aboving MSR driver
has been tested by:

$ rdasr -t
  0: OSDTRRX_EL1         : UNDEFINED or unreadable!
  1: DBGBVR0_EL1         : 0x0
  2: DBGBCR0_EL1         : 0x1e0
  3: DBGWVR0_EL1         : 0x0
  4: DBGWCR0_EL1         : 0x0
  5: DBGBVR1_EL1         : 0x0
  6: DBGBCR1_EL1         : 0x1e0
  7: DBGWVR1_EL1         : 0x0
  8: DBGWCR1_EL1         : 0x0
  9: MDCCINT_EL1         : 0x0
 10: MDSCR_EL1           : 0x1000
 11: DBGBVR2_EL1         : 0x0
...
...
598: ICC_IGRPEN1_EL3     : UNDEFINED or unreadable!
599: TPIDR_EL3           : UNDEFINED or unreadable!
600: SCXTNUM_EL3         : UNDEFINED or unreadable!
601: CNTPS_TVAL_EL1      : UNDEFINED or unreadable!
602: CNTPS_CTL_EL1       : UNDEFINED or unreadable!
603: CNTPS_CVAL_EL1      : UNDEFINED or unreadable!
604: CNTPS_CVAL_EL1      : UNDEFINED or unreadable!

The test ended and no system exception occurred!
Undefined or unreadable registers: 409
Readable registers: 196

The above is a test of more than 600 system registers, and no system exception
occurred

Rongwei Wang (3):
  arm64:insn: Export the symbol to modify code text
  arm64:msr: Introduce MSR ARM driver
  arm64:msr: Enable MSR ARM driver

 arch/arm64/Kconfig               |   9 +
 arch/arm64/configs/defconfig     |   1 +
 arch/arm64/include/asm/msr_arm.h |  80 ++++++++
 arch/arm64/kernel/Makefile       |   3 +-
 arch/arm64/kernel/insn.c         |   1 +
 arch/arm64/kernel/msr_arm.c      | 406 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/msr_smp.c      | 297 ++++++++++++++++++++++++++++
 7 files changed, 796 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/msr_arm.h
 create mode 100644 arch/arm64/kernel/msr_arm.c
 create mode 100644 arch/arm64/kernel/msr_smp.c

-- 
1.8.3.1

