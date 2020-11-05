Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF22A7394
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgKEAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:04:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgKEAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534699; x=1636070699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Jbu9mlrWPt2lhI04EDYr8YcAwZ3WGSkZpcHFvGSqPg=;
  b=D2CvsYwJ4a2qqmS2Jma3RIm9XsZaqfBPI3JdbHvEbt+ep5mMQY60E9OK
   PT2P+/noZGofxmTUwG7FuWhoFdf5cN4fTAicxzh1RVeeJPyqpA6rpvQo2
   mpMyQ4IU/lBA4SpxViKDGYMsRyJjjMsuCoff1mn+zNdkQbhmYuw8W1Goc
   pRkNTGbvbB+8/k/xSurmM5ieQUX9QNYfNimatq+Kc42V2yus9g4iER6x0
   Ps238/dokEOSxKyL5KiVVViI7RaB+9QEccSa1jipqR/jhJl73VvYkp95K
   4EDFVcsNapHUYWX0KyzPuh1P2VOG09wJ/ag+KFxnBDMdvTgG2IHvi2+JO
   A==;
IronPort-SDR: v8yk5jxi6B0ecfr0KNOAtQGQeq6mv0ezbXY5fx1HbkdsdFluiJ4Z+8vP4kOt4ZyRVH4EtCbikB
 +ZFFutCySlh4iDBndDPC6gRFFZJb6iy8Ej96WqGVyKtTbBFqGHuT1sghk8d7+8as5IJtQ8jTU1
 kTPB6d1k8yMcqXRZp19k1qf4ZNVg/AW2bIihyTzBlcfgdAmB9DuT2JkRj4vBxYAG4CCBIFnqNF
 ZnlJqjP2bI7OLDx63hrRu5ZzX33QuWRT5cwHPWw4P3s/7QRxdano1oLse7PswbjGvdViF1jI2t
 wug=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945098"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:04:58 +0800
IronPort-SDR: HXO9+qbhngTRcb9Ffl8Rz66htlad1cwDfukGBqaspgM7BUXL1KlRuj8m743q0Zv2SwMdgy44oC
 nQAFRbWBQv3tDAXBeFeJXM2JXI4xNlweBeYVOx7++VK6HiEsSyuATGpUW8AXSQsNPKLON5Bfu2
 LCoJwRFf7GaXciKucpD6cRo9f8DeXkzgn1Gt47BmdHPjTJAMX4OIdqt6q6XTSKXX9qndTOCpu/
 Dx+G4BSk3Y5Vqbrmd1DEGTvxFVAZDDTsfCf6ZQXx7pQ0pJLl7lWgeAIpbfaxK5nyjuZUimKdX7
 EG9+1tLc2jS4uL9mBGQFBwqn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:06 -0800
IronPort-SDR: jpIGTmzFazPZ0xjmhFi/wus5jV/kNztNLCqrZRgxI/wQvzDR7evQnf4B1FeEhOl2YY1/2ICEL5
 T5a46wNcWPxWHm/TLZ2bHJ4BjT6j3Hp3VoGhOv2O5ev8WmZtMzSbnqqrZM3VO1tSCtdlI3942q
 VfnUlEjwPjPVu0HIqYKGBXk1vQFufffA4x3Zb0mlhUwBlhnZmY9eJ9YGN8VwwBS9SGGEPoPHkx
 jKDSXNxrN8pjw+QAMysS/M3tsZVNWuDhRxNZbFbVg2eLXzg5spCwNL54a8+vB+whDuMoisy89o
 lkY=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:04:59 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <ren_guo@c-sky.com>, linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/5] Improve kernel section protections
Date:   Wed,  4 Nov 2020 16:04:34 -0800
Message-Id: <20201105000439.1491243-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims at improving kernel permissions by doing following things.

1. Protect kernel sections early instead of after /init.
2. Protect .init.text & .init.data sections with appropriate permissions.
3. Move dynamic relocation section to _init.
4. Moved .init sections after .text. This is what most of the other archs
   are also doing.

After applying this patch, here are the linear mapped sections with non-uefi boot.

---[ Linear mapping ]---
0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PMD     D A . . X . R V
0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PMD     D A . . . W R V
0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PMD     D A . . . . R V
0xffffffe001200000-0xffffffe03fe00000    0x0000000081400000      1004M PMD     D A . . . W R V

Linear mapping with uefi boot.

---[ Linear mapping ]---
0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PTE     D A . . X . R V
0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PTE     D A . . . W R V
0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PTE     D A . . . . R V
0xffffffe001200000-0xffffffe03e534000    0x0000000081400000   1002704K PTE     D A . . . W R V
0xffffffe03e538000-0xffffffe03e539000    0x00000000be738000         4K PTE     D A . . . W R V
0xffffffe03e53a000-0xffffffe03e53c000    0x00000000be73a000         8K PTE     D A . . . W R V
0xffffffe03e540000-0xffffffe03e541000    0x00000000be740000         4K PTE     D A . . . W R V
0xffffffe03e545000-0xffffffe03e546000    0x00000000be745000         4K PTE     D A . . . W R V
0xffffffe03e549000-0xffffffe03e54a000    0x00000000be749000         4K PTE     D A . . . W R V
0xffffffe03e54b000-0xffffffe03fd6d000    0x00000000be74b000     24712K PTE     D A . . . W R V
0xffffffe03fd6e000-0xffffffe03fdee000    0x00000000bff6e000       512K PTE     D A . . . W R V


Changes from v2->v3:
1. Added few extra comments to clarify rodata permissions.
2. Changed the name of the functions set_memory_default to set_memory_rw_nx.
3. Squashed patch 3&5 together as they depend on each other to allow
   bisectability.
4. Removed redundant arguments in protect_kernel_text_data.

Changes from v1->v2:
1. .init.text section is aligned with SECTION_ALIGN.
2. .init.text is moved to below of .text so that .head.text & .text are in
   one section.
3. We don't need Guo's fix for static object issue.
4. Rebased on 5.10-rc1.

Atish Patra (5):
RISC-V: Move __start_kernel to .head.text
RISC-V: Initialize SBI early
RISC-V: Align the .init.text section
RISC-V: Protect all kernel sections including init early
RISC-V: Move dynamic relocation section under __init

arch/riscv/include/asm/sections.h   |  2 +
arch/riscv/include/asm/set_memory.h |  4 ++
arch/riscv/kernel/head.S            |  1 -
arch/riscv/kernel/setup.c           | 19 +++++++--
arch/riscv/kernel/vmlinux.lds.S     | 63 +++++++++++++++++------------
arch/riscv/mm/init.c                | 21 +++++++---
arch/riscv/mm/pageattr.c            |  6 +++
7 files changed, 80 insertions(+), 36 deletions(-)

--
2.25.1

