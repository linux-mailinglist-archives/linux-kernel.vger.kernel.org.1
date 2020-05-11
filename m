Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71E1CCF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgEKCRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 22:17:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729102AbgEKCRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:17:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8809825BBDEEAECEA50;
        Mon, 11 May 2020 10:17:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:17:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 00/10] riscv: make riscv build happier
Date:   Mon, 11 May 2020 10:19:51 +0800
Message-ID: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add RISCV arch to huawei build test, there are some build
issue, let's fix them to make riscv build happier :) 

Those patches is rebased on next-20200508.

Kefeng Wang (10):
  riscv: Fix unmet direct dependencies built based on SOC_VIRT
  riscv: stacktrace: Fix undefined reference to `walk_stackframe'
  riscv: Add pgprot_writecombine/device and PAGE_SHARED defination if
    NOMMU
  riscv: Fix print_vm_layout build error if NOMMU
  riscv: Disable ARCH_HAS_DEBUG_WX if NOMMU
  riscv: Disable ARCH_HAS_DEBUG_VIRTUAL if NOMMU
  riscv: Make SYS_SUPPORTS_HUGETLBFS depends on MMU
  riscv: pgtable: Fix __kernel_map_pages build error if NOMMU
  timer-riscv: Fix undefined riscv_time_val
  riscv: mmiowb: Fix implicit declaration of function 'smp_processor_id'

 arch/riscv/Kconfig                |  5 +++--
 arch/riscv/Kconfig.socs           | 17 +++++++++--------
 arch/riscv/include/asm/mmio.h     |  2 ++
 arch/riscv/include/asm/mmiowb.h   |  1 +
 arch/riscv/include/asm/pgtable.h  |  3 +++
 arch/riscv/kernel/stacktrace.c    |  2 +-
 arch/riscv/mm/init.c              |  2 +-
 drivers/clocksource/timer-riscv.c |  1 +
 8 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.26.2

