Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906D2CEB78
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgLDJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbgLDJws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:52:48 -0500
Date:   Fri, 4 Dec 2020 10:52:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607075527;
        bh=VBEU0/umszddH3l73gwxnFt6AiwKnUwdHry/s8NXBpo=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=VtM0Vc9JF05yTvT1EWnZp9K5SoE9Wnc5zB+HFTVrwV1X1zit+vBXEgu5NWc3A8fUQ
         NjA9Rs3I9+tz6KWwGg6wlPf+/NsY4oUVSRAFJVCEITOxiEH9egeHmdoGFXgT37CEk8
         3lMfvAf0kmTaVWk8dAkq2W6IK2UIe87eSXNj5zN2gJyf9eLckcHXT56pt81Wsma6K2
         r0i72mJZQeay6TLviQsuQfvcapqTU+gdmXzX2avv5ioc+ZO7e9GoX551w02jSj7G26
         NTB6tfPrXlUlgySqaEEB82aokgszjydUrZJPpzrIlqJIKR6B2HJsbl1Q0hSh2CR+a7
         RQ0aorsHnjOyA==
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts: get_feat.pl: make complete table more
 coincise
Message-ID: <20201204105202.3d5862a7@coco.lan>
In-Reply-To: <47d1d76bf557716cb90d7382c31fe3d1ade65a2e.1607074458.git.mchehab+huawei@kernel.org>
References: <7c82a766867f2813a1e5c7b982b5e952e50b6c5e.1607073967.git.mchehab+huawei@kernel.org>
        <47d1d76bf557716cb90d7382c31fe3d1ade65a2e.1607074458.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  4 Dec 2020 10:35:44 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Currently, there are too many white spaces at the tables,
> and the information is very sparsed on it.
> 
> Make the format a lot more compact.
> 
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

...

> +		my @lines;
> +		my $line = "";
> +		foreach my $arch (sort {
> +					($arch_table{$a} cmp $arch_table{$b}) or
> +					("\L$a" cmp "\L$b")
> +				       } keys %arch_table) {

Actually, I have one doubt myself with the above sort.

Right now, it places things on this order:

	Not Compatible: ...
	TODO: ...
	ok: ...

I'm wondering if it would it be better to place them at the reverse order,
e. g.:

	ok: ...
	TODO: ...
	Not Compatible: ...

In other words, to output it like:

+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|Feature              |Kconfig / Description                                                    |Status per architecture                                     |
+=====================+=========================================================================+============================================================+
|batch-unmap-tlb-flush|``ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH``                                    |- **ok**: x86                                               |
|                     |                                                                         |- **TODO**: alpha, arc, arm, arm64, csky, hexagon, ia64     |
|                     |arch supports deferral of TLB flush until multiple pages are unmapped    |  mips, nds32, parisc, powerpc, riscv, s390, sh, sparc      |
|                     |                                                                         |  xtensa                                                    |
|                     |                                                                         |- **Not compatible**: c6x, h8300, m68k, microblaze, nios2   |
|                     |                                                                         |  openrisc, um                                              |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|ELF-ASLR             |``ARCH_HAS_ELF_RANDOMIZE``                                               |- **ok**: arm, arm64, mips, parisc, powerpc, s390, x86      |
|                     |                                                                         |- **TODO**: alpha, arc, c6x, csky, h8300, hexagon, ia64     |
|                     |arch randomizes the stack, heap and binary images of ELF binaries        |  m68k, microblaze, nds32, nios2, openrisc, riscv, sh       |
|                     |                                                                         |  sparc, um, xtensa                                         |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|huge-vmap            |``HAVE_ARCH_HUGE_VMAP``                                                  |- **ok**: arm64, powerpc, x86                               |
|                     |                                                                         |- **TODO**: alpha, arc, arm, c6x, csky, h8300, hexagon      |
|                     |arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs|  ia64, m68k, microblaze, mips, nds32, nios2, openrisc      |
|                     |                                                                         |  parisc, riscv, s390, sh, sparc, um, xtensa                |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|ioremap_prot         |``HAVE_IOREMAP_PROT``                                                    |- **ok**: arc, mips, powerpc, s390, sh, x86                 |
|                     |                                                                         |- **TODO**: alpha, arm, arm64, c6x, csky, h8300, hexagon    |
|                     |arch has ioremap_prot()                                                  |  ia64, m68k, microblaze, nds32, nios2, openrisc, parisc    |
|                     |                                                                         |  riscv, sparc, um, xtensa                                  |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|PG_uncached          |``ARCH_USES_PG_UNCACHED``                                                |- **ok**: ia64, x86                                         |
|                     |                                                                         |- **TODO**: alpha, arc, arm, arm64, c6x, csky, h8300        |
|                     |arch supports the PG_uncached page flag                                  |  hexagon, m68k, microblaze, mips, nds32, nios2, openrisc   |
|                     |                                                                         |  parisc, powerpc, riscv, s390, sh, sparc, um, xtensa       |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|pte_special          |``ARCH_HAS_PTE_SPECIAL``                                                 |- **ok**: arc, arm, arm64, mips, powerpc, riscv, s390, sh   |
|                     |                                                                         |  sparc, x86                                                |
|                     |arch supports the pte_special()/pte_mkspecial() VM APIs                  |- **TODO**: alpha, c6x, csky, h8300, hexagon, ia64, m68k    |
|                     |                                                                         |  microblaze, nds32, nios2, openrisc, parisc, um, xtensa    |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+
|THP                  |``HAVE_ARCH_TRANSPARENT_HUGEPAGE``                                       |- **ok**: arc, arm, arm64, mips, powerpc, s390, sparc, x86  |
|                     |                                                                         |- **TODO**: alpha, ia64, nds32, parisc, riscv               |
|                     |arch supports transparent hugepages                                      |- **Not compatible**: c6x, csky, h8300, hexagon, m68k       |
|                     |                                                                         |  microblaze, nios2, openrisc, sh, um, xtensa               |
+---------------------+-------------------------------------------------------------------------+------------------------------------------------------------+

Changing the order is one line patch (see enclosed).

If you think that reverting the order looks better, feel
free to apply the enclosed patch, or fold it with the
previous one.

Thanks,
Mauro

[PATCH] script: get_feat: change the group by order

Right now, arch compatibility is grouped by status at the
alphabetical order from A to Z, and then from a to z, e. g:.

	---
	TODO
	ok

Revert the order, in order to print first the OK results,
then TODO, and, finally, the not compatible ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 10bf23fbc9c5..3f73c8534059 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -397,7 +397,7 @@ sub output_matrix {
 		my @lines;
 		my $line = "";
 		foreach my $arch (sort {
-					($arch_table{$a} cmp $arch_table{$b}) or
+					($arch_table{$b} cmp $arch_table{$a}) or
 					("\L$a" cmp "\L$b")
 				       } keys %arch_table) {
 

