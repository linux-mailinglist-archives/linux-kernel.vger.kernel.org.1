Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24132FB49C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbhASIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:55:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13421 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbhASIyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:54:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DKjB42TYbz9tyh6;
        Tue, 19 Jan 2021 09:53:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id y8-FIexcoXMA; Tue, 19 Jan 2021 09:53:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DKjB41VKmz9tyh3;
        Tue, 19 Jan 2021 09:53:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 206778B7B7;
        Tue, 19 Jan 2021 09:53:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UJKpNi577NlM; Tue, 19 Jan 2021 09:53:49 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 815D08B7AE;
        Tue, 19 Jan 2021 09:53:48 +0100 (CET)
Subject: Re: arch/powerpc/kernel/head_44x.S:601: Error: invalid operands and
 sections) for `|'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202101110602.dyNnp395-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4b152d9e-c6f3-1a0e-4135-7a16224c8fa4@csgroup.eu>
Date:   Tue, 19 Jan 2021 07:49:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202101110602.dyNnp395-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/01/2021 à 23:16, kernel test robot a écrit :
> Hi Christophe,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0653161f0faca68b77b3f36fb4b4b9b8b07050e5
> commit: 03fd42d458fb9cb69e712600bd69ff77ff3a45a8 powerpc/fixmap: Fix FIX_EARLY_DEBUG_BASE when page size is 256k

This problem has been existing for years (since b8e8efaa8639). The above mentionned commit only 
fixes another build failure, that's the reason why the reported problems appear only now


> date:   7 months ago
> config: powerpc64-randconfig-r034-20210111 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03fd42d458fb9cb69e712600bd69ff77ff3a45a8
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 03fd42d458fb9cb69e712600bd69ff77ff3a45a8
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>     fs/ntfs/mft.c: In function 'ntfs_sync_mft_mirror':
>>> fs/ntfs/mft.c:627:1: warning: the frame size of 2096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       627 | }
>           | ^
>     fs/ntfs/mft.c: In function 'write_mft_record_nolock':
>     fs/ntfs/mft.c:839:1: warning: the frame size of 2096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       839 | }
>           | ^
> --
>     fs/buffer.c: In function 'block_read_full_page':
>>> fs/buffer.c:2343:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      2343 | }
>           | ^
> --
>     arch/powerpc/kernel/head_44x.S: Assembler messages:
>>> arch/powerpc/kernel/head_44x.S:601: Error: invalid operands (*ABS* and *UND* sections) for `|'
>     arch/powerpc/kernel/head_44x.S:684: Error: invalid operands (*ABS* and *UND* sections) for `|'
> --
>     fs/ext4/move_extent.c: In function 'mext_page_mkuptodate':
>>> fs/ext4/move_extent.c:227:1: warning: the frame size of 2048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       227 | }
>           | ^
> --
>     fs/fat/dir.c: In function 'fat_add_new_entries':
>>> fs/fat/dir.c:1279:1: warning: the frame size of 2112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      1279 | }
>           | ^
>     fs/fat/dir.c: In function 'fat_alloc_new_dir':
>     fs/fat/dir.c:1195:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      1195 | }
>           | ^
> --
>     fs/fat/fatent.c: In function 'fat_free_clusters':
>>> fs/fat/fatent.c:632:1: warning: the frame size of 2080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       632 | }
>           | ^
>     fs/fat/fatent.c: In function 'fat_alloc_clusters':
>     fs/fat/fatent.c:550:1: warning: the frame size of 2136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       550 | }
>           | ^
> --
>     fs/exfat/fatent.c: In function 'exfat_zeroed_cluster':
>>> fs/exfat/fatent.c:311:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       311 | }
>           | ^
> --
>     drivers/media/common/saa7146/saa7146_hlp.c: In function 'calculate_clipping_registers_rect.isra.0':
>>> drivers/media/common/saa7146/saa7146_hlp.c:465:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       465 | }
>           | ^
> 
> Kconfig warnings: (for reference only)
>     WARNING: unmet direct dependencies detected for NETDEVICES
>     Depends on NET
>     Selected by
>     - AKEBONO && PPC_47x
>     WARNING: unmet direct dependencies detected for ETHERNET
>     Depends on NETDEVICES && NET
>     Selected by
>     - AKEBONO && PPC_47x
>     WARNING: unmet direct dependencies detected for NET_DEVLINK
>     Depends on NET
>     Selected by
>     - BNXT && NETDEVICES && ETHERNET && NET_VENDOR_BROADCOM && PCI
>     - NFP && NETDEVICES && ETHERNET && NET_VENDOR_NETRONOME && PCI && PCI_MSI && (VXLAN || VXLAN && (TLS && TLS_DEVICE || !TLS_DEVICE
>     WARNING: unmet direct dependencies detected for FAILOVER
>     Depends on NET
>     Selected by
>     - NET_FAILOVER && NETDEVICES
>     WARNING: unmet direct dependencies detected for PAGE_POOL
>     Depends on NET
>     Selected by
>     - BNXT && NETDEVICES && ETHERNET && NET_VENDOR_BROADCOM && PCI
> 
> 
> vim +601 arch/powerpc/kernel/head_44x.S
> 
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  577
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  578  	/* Mask of required permission bits. Note that while we
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  579  	 * do copy ESR:ST to _PAGE_RW position as trying to write
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  580  	 * to an RO page is pretty common, we don't do it with
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  581  	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  582  	 * event so I'd rather take the overhead when it happens
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  583  	 * rather than adding an instruction here. We should measure
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  584  	 * whether the whole thing is worth it in the first place
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  585  	 * as we could avoid loading SPRN_ESR completely in the first
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  586  	 * place...
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  587  	 *
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  588  	 * TODO: Is it worth doing that mfspr & rlwimi in the first
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  589  	 *       place or can we save a couple of instructions here ?
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  590  	 */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  591  	mfspr	r12,SPRN_ESR
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  592  	li	r13,_PAGE_PRESENT|_PAGE_ACCESSED
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  593  	rlwimi	r13,r12,10,30,30
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  594
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  595  	/* Load the PTE */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  596  	/* Compute pgdir/pmd offset */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  597  	rlwinm  r12,r10,PPC44x_PGD_OFF_SHIFT,PPC44x_PGD_OFF_MASK_BIT,29
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  598  	lwzx	r11,r12,r11		/* Get pgd/pmd entry */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  599
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  600  	/* Word 0 is EPN,V,TS,DSIZ */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05 @601  	li	r12,PPC47x_TLB0_VALID | PPC47x_TLBE_SIZE
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  602  	rlwimi	r10,r12,0,32-PAGE_SHIFT,31	/* Insert valid and page size*/
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  603  	li	r12,0
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  604  	tlbwe	r10,r12,0
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  605
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  606  	/* XXX can we do better ? Need to make sure tlbwe has established
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  607  	 * latch V bit in MMUCR0 before the PTE is loaded further down */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  608  #ifdef CONFIG_SMP
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  609  	isync
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  610  #endif
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  611
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  612  	rlwinm.	r12,r11,0,0,20		/* Extract pt base address */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  613  	/* Compute pte address */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  614  	rlwimi  r12,r10,PPC44x_PTE_ADD_SHIFT,PPC44x_PTE_ADD_MASK_BIT,28
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  615  	beq	2f			/* Bail if no table */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  616  	lwz	r11,0(r12)		/* Get high word of pte entry */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  617
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  618  	/* XXX can we do better ? maybe insert a known 0 bit from r11 into the
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  619  	 * bottom of r12 to create a data dependency... We can also use r10
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  620  	 * as destination nowadays
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  621  	 */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  622  #ifdef CONFIG_SMP
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  623  	lwsync
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  624  #endif
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  625  	lwz	r12,4(r12)		/* Get low word of pte entry */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  626
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  627  	andc.	r13,r13,r12		/* Check permission */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  628
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  629  	 /* Jump to common tlb load */
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  630  	beq	finish_tlb_load_47x
> e7f75ad01d590243 Dave Kleikamp 2010-03-05  631
> 
> :::::: The code at line 601 was first introduced by commit
> :::::: e7f75ad01d590243904c2d95ab47e6b2e9ef6dad powerpc/47x: Base ppc476 support
> 
> :::::: TO: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> :::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
