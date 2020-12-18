Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC952DE90B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgLRSpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLRSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:44:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7C4C0617B0;
        Fri, 18 Dec 2020 10:44:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l11so8003852lfg.0;
        Fri, 18 Dec 2020 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0fCfXv23hcMbrK0vkpX5yrUTQIgWo/LBQi3JCq5v3U=;
        b=BRBkJ7olBl6fTwB2usxhg5NKyfuP3D20mllCDnoEJWPJKDLz+oUL8rEhwf7kWu/I8G
         6WODofyakvTn2lUj5ap49C3bOcYqRr2yXi1N4u3CYmQ4GYKjhp8z5mQz19hJVGK/Eji1
         3xq0Iesx4t768GxHJ11PGal/wVR3pJ06fpTAwyrbdr1yb3cGt2YCSWdA3C8514RlDEeo
         YgLsAYxTX5iUO/+6/+LCQ565RSemufUyZUMdIzfkFy51eUKCOFy3z1wVjpIjzQ/34ujj
         oNhTerXAo0ghtjv2EnGag/V0n0gJFewL3uCLQ5cOYvtXhPbbAzsvOaqDRMF4mlPOSx6H
         Mo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=k0fCfXv23hcMbrK0vkpX5yrUTQIgWo/LBQi3JCq5v3U=;
        b=OlHD4lsIMD9cWgZcguPDkLLZuK6p60kk9yUI+rUtLPf8y+NA827dhcwLk8EDd0OVt+
         LyCFkd9ivYaIcBa0cl6qnWYge4weR4K4A1SQBFYz3cLN7Ou1MrKObis4xs4F0tiFca7U
         At/1dorUL+kekZ/wgX188nMgvaRh37pe0kSn+IYWtxAC+6UWCX98CShZ2z5FlIfxS0tN
         RBY+szOU/Pvk9+QM7ZwbvvYBN+fqx1wCN7NbncwvAo2i8Bb7TgzAsIGAll1IpDg21tPG
         z1tRX2G4lzaTSnMdaV9x5GM15IAY49fdgz/AqGvTUz8FigyosvJqquCQRr+MviSBK9us
         2Xng==
X-Gm-Message-State: AOAM532jcqHjgXdUWzxuXijBmeJK0YQnZn+pJIF4BYlK/IMa0UDExWau
        e+1ggPWPuAVF6tF1X68T8ok=
X-Google-Smtp-Source: ABdhPJyrs5By+McT6eGLzdWCxsJWbxW405cujB/lu+mt42OA8q25d4C5ye8SNJglRd7H2iROo+8uPA==
X-Received: by 2002:a2e:804a:: with SMTP id p10mr2488310ljg.295.1608317048942;
        Fri, 18 Dec 2020 10:44:08 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:2c04:50ad:1138:9ea2])
        by smtp.gmail.com with ESMTPSA id s7sm1116980ljp.38.2020.12.18.10.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 10:44:08 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org,
        gentoo-sparc@l.g.o
Subject: [PATCH v1 01/13] sparc32: Drop sun4m/sun4d support from head_32.S
Date:   Fri, 18 Dec 2020 19:43:35 +0100
Message-Id: <20201218184347.2180772-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the most obvious parts of sun4* support from head_32.S.
Use a single print if a sun4* machine is detected thus restricting
boots to LEON machines.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/head_32.S | 190 ++----------------------------------
 1 file changed, 9 insertions(+), 181 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index be30c8d4cc73..b7b14250cbe0 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -45,11 +45,7 @@ cputypvar:
 	.align 4
 
 notsup:
-	.asciz	"Sparc-Linux sun4/sun4c or MMU-less not supported\n\n"
-	.align 4
-
-sun4e_notsup:
-        .asciz  "Sparc-Linux sun4e support does not exist\n\n"
+	.asciz	"Sparc-Linux sun4* or MMU-less not supported\n\n"
 	.align 4
 
 /* The trap-table - located in the __HEAD section */
@@ -215,114 +211,10 @@ not_a_sun4:
 		be	leon_remap		/* It is a LEON - jump */
 		 nop
 
-		/* Sanity-check, is MMU enabled */
-		lda	[%g0] ASI_M_MMUREGS, %g1
-		andcc	%g1, 1, %g0
-		be	halt_notsup
-		 nop
-
-		/* Check for a viking (TI) module. */
-		cmp	%g3, PSR_IMPL_TI
-		bne	srmmu_not_viking
-		 nop
-
-		/* Figure out what kind of viking we are on.
-		 * We need to know if we have to play with the
-		 * AC bit and disable traps or not.
-		 */
-
-		/* I've only seen MicroSparc's on SparcClassics with this
-		 * bit set.
-		 */
-		set	0x800, %g2
-		lda	[%g0] ASI_M_MMUREGS, %g3	! peek in the control reg
-		and	%g2, %g3, %g3
-		subcc	%g3, 0x0, %g0
-		bnz	srmmu_not_viking			! is in mbus mode
-		 nop
-
-		rd	%psr, %g3			! DO NOT TOUCH %g3
-		andn	%g3, PSR_ET, %g2
-		wr	%g2, 0x0, %psr
-		WRITE_PAUSE
-
-		/* Get context table pointer, then convert to
-		 * a physical address, which is 36 bits.
-		 */
-		set	AC_M_CTPR, %g4
-		lda	[%g4] ASI_M_MMUREGS, %g4
-		sll	%g4, 0x4, %g4			! We use this below
-							! DO NOT TOUCH %g4
-
-		/* Set the AC bit in the Viking's MMU control reg. */
-		lda	[%g0] ASI_M_MMUREGS, %g5	! DO NOT TOUCH %g5
-		set	0x8000, %g6			! AC bit mask
-		or	%g5, %g6, %g6			! Or it in...
-		sta	%g6, [%g0] ASI_M_MMUREGS	! Close your eyes...
-
-		/* Grrr, why does it seem like every other load/store
-		 * on the sun4m is in some ASI space...
-		 * Fine with me, let's get the pointer to the level 1
-		 * page table directory and fetch its entry.
-		 */
-		lda	[%g4] ASI_M_BYPASS, %o1		! This is a level 1 ptr
-		srl	%o1, 0x4, %o1			! Clear low 4 bits
-		sll	%o1, 0x8, %o1			! Make physical
-
-		/* Ok, pull in the PTD. */
-		lda	[%o1] ASI_M_BYPASS, %o2		! This is the 0x0 16MB pgd
-
-		/* Calculate to KERNBASE entry. */
-		add	%o1, KERNBASE >> (PGDIR_SHIFT - 2), %o3
-
-		/* Poke the entry into the calculated address. */
-		sta	%o2, [%o3] ASI_M_BYPASS
-
-		/* I don't get it Sun, if you engineered all these
-		 * boot loaders and the PROM (thank you for the debugging
-		 * features btw) why did you not have them load kernel
-		 * images up in high address space, since this is necessary
-		 * for ABI compliance anyways?  Does this low-mapping provide
-		 * enhanced interoperability?
-		 *
-		 * "The PROM is the computer."
-		 */
-
-		/* Ok, restore the MMU control register we saved in %g5 */
-		sta	%g5, [%g0] ASI_M_MMUREGS	! POW... ouch
-
-		/* Turn traps back on.  We saved it in %g3 earlier. */
-		wr	%g3, 0x0, %psr			! tick tock, tick tock
-
-		/* Now we burn precious CPU cycles due to bad engineering. */
-		WRITE_PAUSE
-
-		/* Wow, all that just to move a 32-bit value from one
-		 * place to another...  Jump to high memory.
-		 */
-		b	go_to_highmem
+		/* Not LEON - halt */
+		ba	halt_notsup
 		 nop
 
-srmmu_not_viking:
-		/* This works on viking's in Mbus mode and all
-		 * other MBUS modules.  It is virtually the same as
-		 * the above madness sans turning traps off and flipping
-		 * the AC bit.
-		 */
-		set	AC_M_CTPR, %g1
-		lda	[%g1] ASI_M_MMUREGS, %g1	! get ctx table ptr
-		sll	%g1, 0x4, %g1			! make physical addr
-		lda	[%g1] ASI_M_BYPASS, %g1		! ptr to level 1 pg_table
-		srl	%g1, 0x4, %g1
-		sll	%g1, 0x8, %g1			! make phys addr for l1 tbl
-
-		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
-		add	%g1, KERNBASE >> (PGDIR_SHIFT - 2), %g3
-		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry
-		b	go_to_highmem
-		 nop					! wheee....
-
-
 leon_remap:
 		/* Sanity-check, is MMU enabled */
 		lda	[%g0] ASI_LEON_MMUREGS, %g1
@@ -343,8 +235,6 @@ leon_remap:
 		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
 		add	%g1, KERNBASE >> (PGDIR_SHIFT - 2), %g3
 		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry
-		b	go_to_highmem
-		 nop					! wheee....
 
 /* Now do a non-relative jump so that PC is in high-memory */
 go_to_highmem:
@@ -413,13 +303,13 @@ execute_in_high_mem:
 		ldub	[%o2 + 0x4], %l1
 
 		cmp	%l1, 'm'
-		be	sun4m_init
+		be	no_sun4_here		! sun4m
 		 cmp	%l1, 's'
-		be	sun4m_init
+		be	no_sun4_here		! sun4m
 		 cmp	%l1, 'd'
-		be	sun4d_init
+		be	no_sun4_here		! sun4d
 		 cmp	%l1, 'e'
-		be	no_sun4e_here		! Could be a sun4e.
+		be	no_sun4_here		! Could be a sun4e.
 		 nop
 		b	no_sun4u_here		! AIEEE, a V9 sun4u... Get our BIG BROTHER kernel :))
 		 nop
@@ -441,68 +331,6 @@ leon_init:
 		/* Update boot_cpu_id only on boot cpu */
 		stub	%g1, [%g2 + %lo(boot_cpu_id)]
 
-		ba continue_boot
-		 nop
-
-/* CPUID in bootbus can be found at PA 0xff0140000 */
-#define SUN4D_BOOTBUS_CPUID     0xf0140000
-
-sun4d_init:
-	/* Need to patch call to handler_irq */
-	set	patch_handler_irq, %g4
-	set	sun4d_handler_irq, %g5
-	sethi	%hi(0x40000000), %g3		! call
-	sub	%g5, %g4, %g5
-	srl	%g5, 2, %g5
-	or	%g5, %g3, %g5
-	st	%g5, [%g4]
-
-#ifdef CONFIG_SMP
-	/* Get our CPU id out of bootbus */
-	set     SUN4D_BOOTBUS_CPUID, %g3
-	lduba   [%g3] ASI_M_CTL, %g3
-	and     %g3, 0xf8, %g3
-	srl     %g3, 3, %g4
-	sta     %g4, [%g0] ASI_M_VIKING_TMP1
-	sethi	%hi(boot_cpu_id), %g5
-	stb	%g4, [%g5 + %lo(boot_cpu_id)]
-#endif
-
-	/* Fall through to sun4m_init */
-
-sun4m_init:
-/* Ok, the PROM could have done funny things and apple cider could still
- * be sitting in the fault status/address registers.  Read them all to
- * clear them so we don't get magic faults later on.
- */
-/* This sucks, apparently this makes Vikings call prom panic, will fix later */
-2:
-		rd	%psr, %o1
-		srl	%o1, PSR_IMPL_SHIFT, %o1	! Get a type of the CPU
-
-		subcc	%o1, PSR_IMPL_TI, %g0		! TI: Viking or MicroSPARC
-		be	continue_boot
-		 nop
-
-		set	AC_M_SFSR, %o0
-		lda	[%o0] ASI_M_MMUREGS, %g0
-		set	AC_M_SFAR, %o0
-		lda	[%o0] ASI_M_MMUREGS, %g0
-
-		/* Fujitsu MicroSPARC-II has no asynchronous flavors of FARs */
-		subcc	%o1, 0, %g0
-		be	continue_boot
-		 nop
-
-		set	AC_M_AFSR, %o0
-		lda	[%o0] ASI_M_MMUREGS, %g0
-		set	AC_M_AFAR, %o0
-		lda	[%o0] ASI_M_MMUREGS, %g0
-		 nop
-
-
-continue_boot:
-
 /* Aieee, now set PC and nPC, enable traps, give ourselves a stack and it's
  * show-time!
  */
@@ -670,9 +498,9 @@ continue_boot:
 		call	halt_me
 		 nop
 
-no_sun4e_here:
+no_sun4_here:
 		ld	[%g7 + 0x68], %o1
-		set	sun4e_notsup, %o0
+		set	notsup, %o0
 		call	%o1
 		 nop
 		b	halt_me
-- 
2.27.0

