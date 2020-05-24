Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2A1DFDCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEXJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 05:10:13 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51159 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgEXJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 05:10:12 -0400
X-Originating-IP: 90.112.45.105
Received: from localhost.localdomain (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C468AFF804;
        Sun, 24 May 2020 09:10:09 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/8] Introduce sv48 support 
Date:   Sun, 24 May 2020 05:10:00 -0400
Message-Id: <20200524091008.25587-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements sv48 support at runtime. The kernel will try to         
boot with 4-level page table and will fallback to 3-level if the HW does not     
support it.                                                                      
                                                                                 
The biggest advantage is that we only have one kernel for 64bit, which           
is way easier to maintain.                                                       
                                                                                 
Folding the 4th level into a 3-level page table has almost no cost at            
runtime. But as mentioned Palmer, the relocatable code generated is less         
performant.                                                                      
                                                                                 
At the moment, there is no way to build a 3-level page table non-relocatable     
64bit kernel. We agreed that distributions will use this runtime configuration   
anyway, but Palmer proposed to introduce a new Kconfig, which I will do later    
as sv48 support was asked for 5.8.                                               
                                                                                 
Finally, the user can now ask for sv39 explicitly by using the device-tree       
which will reduce memory footprint and reduce the number of memory accesses      
in case of TLB miss.

Alexandre Ghiti (8):
  riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
  riscv: Allow to dynamically define VA_BITS
  riscv: Simplify MAXPHYSMEM config
  riscv: Prepare ptdump for vm layout dynamic addresses
  riscv: Implement sv48 support
  riscv: Allow user to downgrade to sv39 when hw supports sv48
  riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
  riscv: Explicit comment about user virtual address space size

 arch/riscv/Kconfig                         |  34 ++--
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi |   4 -
 arch/riscv/include/asm/csr.h               |   3 +-
 arch/riscv/include/asm/fixmap.h            |   1 +
 arch/riscv/include/asm/page.h              |  15 ++
 arch/riscv/include/asm/pgalloc.h           |  36 ++++
 arch/riscv/include/asm/pgtable-64.h        |  97 ++++++++++-
 arch/riscv/include/asm/pgtable.h           |  30 +++-
 arch/riscv/include/asm/sparsemem.h         |   2 +-
 arch/riscv/kernel/cpu.c                    |  24 +--
 arch/riscv/kernel/head.S                   |   3 +-
 arch/riscv/mm/context.c                    |   4 +-
 arch/riscv/mm/init.c                       | 194 ++++++++++++++++++---
 arch/riscv/mm/ptdump.c                     |  49 +++++-
 14 files changed, 410 insertions(+), 86 deletions(-)

-- 
2.20.1

