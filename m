Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102CA299A16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395128AbgJZXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51586 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394354AbgJZXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753403; x=1635289403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yvlTyQ9O0XqzdAdjO0Pl2oB3b2ZTm/0cBZYL5R5guvA=;
  b=NptwF+kPb/AZ/d2puIXpxPJ+eYjLsYgHyf292uWWHCjvKmOVq578+43x
   NgTmJDgEMX547scHCmpvVNDTkeBvUyxt8QNtG6PgoeN7ZQLRIUHhXBGmU
   md2bU2/n+QLo3mqI0oQGDGCpdeHTGtaZXgQNDxvukR3lt7j4S4o/TlZg9
   B/Mb2uYxXFTBSyR4X7iF3s2L0DNJrCFRtzzpxzzvbLZfHThg4kWCbN7Qy
   VMCw+KCpEfIgWhuCb/ChqUhRC2CvwSgEAPyujWD2LxBtCcQ2w8k+uLrig
   hpTRj7ykELmxh2aJ/mNo5SlGGnS7yBUFwuIPjy29g/8JrnXZjBPsTM1IP
   w==;
IronPort-SDR: 3oedUoIVuDIOKfnZDDV16inpBiKWiJRR0hrdlcTdvfyvCh+Nu/2QBAsYl1VjSPt1YrZNSaui7U
 c/enPP7E3c2IyzPDA8mi+h9EsrS3sgSDphUR69KqrVpEJgebsNBMkbI77lF+C9NuYEi/fkKTZ8
 wDaJV9XErz2MRPlXQdfBkN++P+PXcq0mBa2rLpXjbs4dZ/hmJyyqTPa2TLLNtv5IJBLO9ucYU2
 7YTtOtJLCXNpgSbaMRELf/ITzC9hbJGfkIisiMBbrObOLE4/d4hsWadtirv8yK5uAs5jZRKlCW
 2to=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009458"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:23 +0800
IronPort-SDR: ggAT4sdAmWTsBVP1l+dInWTuIfMjO+VD4bP/9yt1nugJTls5HoWJLTmlDaQdrG1XLQdRzBbWOt
 73YpSAQ2wjNaZid0NDGCxLmzGaH8T8Y4sl/TwqwCnGW5AdnWT2FOgqDwJpvW1m/BGDOXCZXRbF
 l2smxD3r0yFw8+Xz+c565wzqb6p7RX2abLe6U9Qv5/F0IsBEh1qh1/nHQGPLy8uhyqZHvXM7go
 e6FJ35u1Fomwpwr5Pvktalpoxtyd7oynGYNAB+uin+CkHWFZnTUvdE7JYPE5t9Ca2d6xmVrSsn
 PIKTRd1hS07zjxZ9gAayimTp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:41 -0700
IronPort-SDR: G33XPMYKh2dkvNJCfiAdtlEDxk2ehe+0xdYyU9F4fsaIiIGgD/4rvWG4Q5v8MwQa2AK/Cxitdy
 QFgJV7wp6k3ZphxR0FRRJLRUp3D1WxxZtc5nA+xyCVgdDtHun68zTYWWR9H1R7Lzs8Ghv6IDDH
 K858azlRRPkH7DezKo35P/7GWU2UVwcdPoXCbF544m+VPG85dRm+gbmvSei9WMEei/iBmymhUW
 qqJAnOC3zJiPyHsr4TeLhzRQB312aIYClaiVNOjF9qHHfIxnMrMCn7d41C3Y0MZHrEGAz0tMc5
 8MM=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:23 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/6] Improve kernel section protections
Date:   Mon, 26 Oct 2020 16:02:48 -0700
Message-Id: <20201026230254.911912-1-atish.patra@wdc.com>
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

After applying this patch, here are the linear mapped sections.

---[ Linear mapping ]---
0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8M PMD     D A . . X . R V
0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4M PMD     D A . . . W R V
0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6M PMD     D A . . . . R V
0xffffffe001200000-0xffffffe03fe00000    0x0000000081400000      1004M PMD     D A . . . W R V

Changes from v1->v2:
1. .init.text section is aligned with SECTION_ALIGN.
2. .init.text is moved to below of .text so that .head.text & .text are in
   one section.
3. We don't need Guo's fix for static object issue.
4. Rebased on 5.10-rc1.

Atish Patra (6):
RISC-V: Move __start_kernel to .head.text
RISC-V: Initialize SBI early
RISC-V: Enforce protections for kernel sections early
RISC-V: Align the .init.text section
RISC-V: Protect .init.text & .init.data
RISC-V: Move dynamic relocation section under __init

arch/riscv/include/asm/sections.h   |  2 +
arch/riscv/include/asm/set_memory.h |  4 ++
arch/riscv/kernel/head.S            |  1 -
arch/riscv/kernel/setup.c           | 18 +++++++--
arch/riscv/kernel/vmlinux.lds.S     | 63 +++++++++++++++++------------
arch/riscv/mm/init.c                | 19 +++++++--
arch/riscv/mm/pageattr.c            |  6 +++
7 files changed, 79 insertions(+), 34 deletions(-)

--
2.25.1

