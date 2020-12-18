Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E72DE928
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgLRSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLRSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:45:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA75C061248;
        Fri, 18 Dec 2020 10:44:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m12so7904537lfo.7;
        Fri, 18 Dec 2020 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNMAzeAbUgd0/Pwv00BAWyYvn6eBGgcQQ3CQrYWw0+o=;
        b=oGgLAWupQ9OoHiApSyja7UMCBQeXDQQs3OQ/psajcsS1gbPMgXFEAbDcXs4IBDppmv
         9TwmYm5s4h9eOuw87B6Tk2nh/64jhLjNq7JS+vMPT2UxFFh+mOwKQlulUdB1kuwBkGer
         LUbKoT2uexguzsNeE9uvFy4FVc25HQKJV+LDyvFaiwgRNiywA4RI1fbS5OLr0SdxaoIQ
         /p5vzxK2UNYwnw2/hCxa0yuMoXcwdDkTLiPsoVex2lI/hj6OaPBR3VeT9wTZZbqJVXhZ
         P8C99mzR0zY4lyfDThCPQ8RtolDFSDXwQYu3Srlf7KCiEdzk/cuCeeEhQ/7snTGLrb2Y
         KGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UNMAzeAbUgd0/Pwv00BAWyYvn6eBGgcQQ3CQrYWw0+o=;
        b=gbGzXrkkreL8T/qkobaK2sr7zUyqc2N+nGi1f4DeyvP7B0vRHaBSCgmlj/JP7y9uEP
         9tGp+BY8KDcbR23QtilkD192IchmX9PwIB7FelWl7fDM1fvDr4kDCMflJu5T6jC9BZT9
         5bwuuPBgZb3KlulTcwa/NriXrcBCoB+E0X+t/dZj6f8zMiCdPK41eJVb58XiGJiSMPux
         hPgXpTQqYEt0hdV3eEs0EXT0g8hyuqlZCzHq8iY2AEl7lqiRtLMW3acz3GD644kWCq4+
         QiOmoiBgOy2v4ubwLHlDGBrjGOcSTjzwFt1dCQ38rT7oEknRaXxCbto/ng9w3BBUG8tP
         mzWw==
X-Gm-Message-State: AOAM533mLAM0NyWYK4zpN8zrncm8oeGfIB15B3T0x7ApbKlq2bGLdzu/
        N51eiQrXhLxSRgiaRe7DOJg=
X-Google-Smtp-Source: ABdhPJwdnJxjFxdqg+S1tQOFTy9O/1d3iLOOoQELtImhvQL3nesrI/dW9EcEyu4sBVDmgE/iCP5Gww==
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr1861834lfr.487.1608317056091;
        Fri, 18 Dec 2020 10:44:16 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:2c04:50ad:1138:9ea2])
        by smtp.gmail.com with ESMTPSA id s7sm1116980ljp.38.2020.12.18.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 10:44:15 -0800 (PST)
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
Subject: [PATCH v1 05/13] sparc32: Drop run-time patching of ipi trap
Date:   Fri, 18 Dec 2020 19:43:39 +0100
Message-Id: <20201218184347.2180772-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no longer any need for the run-time patching of the ipi trap
with the removal of sun4m and sun4d. Remove the patching and drop the
ipi implementation for the two machines.

The patch includes removal of patching from pcic as this was needed to
fix the build. pcic will be removed in a later commit.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/entry.S     | 70 ++---------------------------------
 arch/sparc/kernel/kernel.h    |  4 --
 arch/sparc/kernel/leon_smp.c  |  3 --
 arch/sparc/kernel/pcic.c      | 11 ------
 arch/sparc/kernel/sun4d_smp.c |  3 --
 arch/sparc/kernel/ttable_32.S |  9 ++---
 6 files changed, 7 insertions(+), 93 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 9985b08a3467..1a2e20a7e584 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -174,32 +174,6 @@ maybe_smp4m_msg_check_resched:
 maybe_smp4m_msg_out:
 	RESTORE_ALL
 
-	.align	4
-	.globl	linux_trap_ipi15_sun4m
-linux_trap_ipi15_sun4m:
-	SAVE_ALL
-	sethi	%hi(0x80000000), %o2
-	GET_PROCESSOR4M_ID(o0)
-	sethi	%hi(sun4m_irq_percpu), %l5
-	or	%l5, %lo(sun4m_irq_percpu), %o5
-	sll	%o0, 2, %o0
-	ld	[%o5 + %o0], %o5
-	ld	[%o5 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
-	andcc	%o3, %o2, %g0
-	be	sun4m_nmi_error		! Must be an NMI async memory error
-	 st	%o2, [%o5 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x80000000
-	WRITE_PAUSE
-	ld	[%o5 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
-	WRITE_PAUSE
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4m_cross_call_irq
-	 nop
-	b	ret_trap_lockless_ipi
-	 clr	%l6
 
 	.globl	smp4d_ticker
 	/* SMP per-cpu ticker interrupts are handled specially. */
@@ -220,44 +194,6 @@ smp4d_ticker:
 	WRITE_PAUSE
 	RESTORE_ALL
 
-	.align	4
-	.globl	linux_trap_ipi15_sun4d
-linux_trap_ipi15_sun4d:
-	SAVE_ALL
-	sethi	%hi(CC_BASE), %o4
-	sethi	%hi(MXCC_ERR_ME|MXCC_ERR_PEW|MXCC_ERR_ASE|MXCC_ERR_PEE), %o2
-	or	%o4, (CC_EREG - CC_BASE), %o0
-	ldda	[%o0] ASI_M_MXCC, %o0
-	andcc	%o0, %o2, %g0
-	bne	1f
-	 sethi	%hi(BB_STAT2), %o2
-	lduba	[%o2] ASI_M_CTL, %o2
-	andcc	%o2, BB_STAT2_MASK, %g0
-	bne	2f
-	 or	%o4, (CC_ICLR - CC_BASE), %o0
-	sethi	%hi(1 << 15), %o1
-	stha	%o1, [%o0] ASI_M_MXCC	/* Clear PIL 15 in MXCC's ICLR */
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4d_cross_call_irq
-	 nop
-	b	ret_trap_lockless_ipi
-	 clr	%l6
-
-1:	/* MXCC error */
-2:	/* BB error */
-	/* Disable PIL 15 */
-	set	CC_IMSK, %l4
-	lduha	[%l4] ASI_M_MXCC, %l5
-	sethi	%hi(1 << 15), %l7
-	or	%l5, %l7, %l5
-	stha	%l5, [%l4] ASI_M_MXCC
-	/* FIXME */
-1:	b,a	1b
-
 	.globl	smpleon_ipi
 	.extern leon_ipi_interrupt
 	/* SMP per-cpu IPI interrupts are handled specially. */
@@ -618,11 +554,11 @@ sun4m_nmi_error:
 
 #ifndef CONFIG_SMP
 	.align	4
-	.globl	linux_trap_ipi15_sun4m
-linux_trap_ipi15_sun4m:
+	.globl	linux_trap_ipi15_leon
+linux_trap_ipi15_leon:
 	SAVE_ALL
 
-	ba	sun4m_nmi_error
+	ba      sun4m_nmi_error
 	 nop
 #endif /* CONFIG_SMP */
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7328d13875e4..c9e1b13d955f 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -135,10 +135,6 @@ void leonsmp_ipi_interrupt(void);
 void leon_cross_call_irq(void);
 
 /* head_32.S */
-extern unsigned int t_nmi[];
-extern unsigned int linux_trap_ipi15_sun4d[];
-extern unsigned int linux_trap_ipi15_sun4m[];
-
 extern struct tt_entry trapbase;
 extern struct tt_entry trapbase_cpu1;
 extern struct tt_entry trapbase_cpu2;
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..b0d75783d337 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -461,8 +461,5 @@ static const struct sparc32_ipi_ops leon_ipi_ops = {
 
 void __init leon_init_smp(void)
 {
-	/* Patch ipi15 trap table */
-	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_leon - linux_trap_ipi15_sun4m);
-
 	sparc32_ipi_ops = &leon_ipi_ops;
 }
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ee4c9a9a171c..87bdcb16019b 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -354,17 +354,6 @@ int __init pcic_probe(void)
 	prom_getstring(node, "name", namebuf, 63);  namebuf[63] = 0;
 	strcpy(pbm->prom_name, namebuf);
 
-	{
-		extern int pcic_nmi_trap_patch[4];
-
-		t_nmi[0] = pcic_nmi_trap_patch[0];
-		t_nmi[1] = pcic_nmi_trap_patch[1];
-		t_nmi[2] = pcic_nmi_trap_patch[2];
-		t_nmi[3] = pcic_nmi_trap_patch[3];
-		swift_flush_dcache();
-		pcic_regs = pcic->pcic_regs;
-	}
-
 	prom_getstring(prom_root_node, "name", namebuf, 63);  namebuf[63] = 0;
 	{
 		struct pcic_sn2list *p;
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index ff30f03beb7c..cecdda746baa 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -401,9 +401,6 @@ void __init sun4d_init_smp(void)
 {
 	int i;
 
-	/* Patch ipi15 trap table */
-	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
-
 	sparc32_ipi_ops = &sun4d_ipi_ops;
 
 	for (i = 0; i < NR_CPUS; i++) {
diff --git a/arch/sparc/kernel/ttable_32.S b/arch/sparc/kernel/ttable_32.S
index e79fd786fbbb..78bbf2548e1f 100644
--- a/arch/sparc/kernel/ttable_32.S
+++ b/arch/sparc/kernel/ttable_32.S
@@ -43,8 +43,7 @@ t_irq12:TRAP_ENTRY_INTERRUPT(12)            /* IRQ Zilog serial chip         */
 t_irq13:TRAP_ENTRY_INTERRUPT(13)            /* IRQ Audio Intr.               */
 t_irq14:TRAP_ENTRY_INTERRUPT(14)            /* IRQ Timer #2                  */
 
-	.globl	t_nmi
-t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 
 t_racc:	TRAP_ENTRY(0x20, do_reg_access)     /* General Register Access Error */
 t_iacce:BAD_TRAP(0x21)                      /* Instr Access Error            */
@@ -146,7 +145,7 @@ trapbase_cpu1:
 	TRAP_ENTRY_INTERRUPT(9) TRAP_ENTRY_INTERRUPT(10)
 	TRAP_ENTRY_INTERRUPT(11) TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13) TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)
@@ -245,7 +244,7 @@ trapbase_cpu2:
 	TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13)
 	TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)
@@ -345,7 +344,7 @@ trapbase_cpu3:
 	TRAP_ENTRY_INTERRUPT(12)
 	TRAP_ENTRY_INTERRUPT(13)
 	TRAP_ENTRY_INTERRUPT(14)
-	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
+	TRAP_ENTRY(0x1f, linux_trap_ipi15_leon)
 	TRAP_ENTRY(0x20, do_reg_access)
 	BAD_TRAP(0x21)
 	BAD_TRAP(0x22)
-- 
2.27.0

