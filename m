Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695572CF157
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgLDP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:56:04 -0500
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:45136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727125AbgLDP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:56:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 96467100E7B46;
        Fri,  4 Dec 2020 15:55:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:1801:2194:2199:2393:2559:2562:2693:2828:2902:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:3872:4321:4605:5007:6119:7875:7903:7904:7974:8556:10004:10848:11232:11658:11914:12043:12048:12297:12555:12740:12895:12986:13439:13894:14093:14097:14181:14659:14721:21067:21080:21325:21451:21627:21939:21990:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: foot04_4212f4e273c5
X-Filterd-Recvd-Size: 5091
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Dec 2020 15:55:22 +0000 (UTC)
Message-ID: <189ad2584d80d915d3c9f76c044947f83ca5ebf8.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon: Change printk() to pr_cont()
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 04 Dec 2020 07:55:21 -0800
In-Reply-To: <87h7p1vnym.fsf@mpe.ellerman.id.au>
References: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
         <87h7p1vnym.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-04 at 21:56 +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > Since some time now, printk() adds carriage return, leading to
> > unusable xmon output:
> > 
> > [   54.288722] sysrq: Entering xmon
> > [   54.292209] Vector: 0  at [cace3d2c]
> > [   54.292274]     pc:
> > [   54.292331] c0023650
> 
> ...
> 
> > diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
> > index 5c1a50912229..9b0d85bff021 100644
> > --- a/arch/powerpc/xmon/nonstdio.c
> > +++ b/arch/powerpc/xmon/nonstdio.c
> > @@ -178,7 +178,7 @@ void xmon_printf(const char *format, ...)
> >  
> > 
> >  	if (n && rc == 0) {
> >  		/* No udbg hooks, fallback to printk() - dangerous */
> > -		printk("%s", xmon_outbuf);
> > +		pr_cont("%s", xmon_outbuf);
> >  	}
> 
> Ah OK, in the case where there's no udbg backend. We basically always
> have a udbg backend on 64-bit, via hvc console. Which explains why we
> haven't noticed it.
> 
> Will pick up the patch.
> 
> cheers

Perhaps all of these bare printks should be inspected for defects:

$ git grep -P -n '\bprintk\s*\(\s*(?!KERN_\w+)"[^\\n]*"' arch/powerpc
arch/powerpc/kernel/process.c:1475:     printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
arch/powerpc/kernel/process.c:1479:     printk("MSR:  "REG" ", regs->msr);
arch/powerpc/kernel/process.c:1513:             printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
arch/powerpc/kernel/process.c:1514:             printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
arch/powerpc/kernel/process.c:2157:                     printk("%s["REG"] ["REG"] %pS",
arch/powerpc/kernel/traps.c:621:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:726:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:766:        printk("Caused by (from MCSR=%lx): ", reason);
arch/powerpc/kernel/traps.c:791:        printk("Caused by (from SRR1=%lx): ", reason);
arch/powerpc/kernel/udbg.c:95:          printk("%s", s);
arch/powerpc/math-emu/fabs.c:13:        printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fctiw.c:22:       printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fctiwz.c:29:      printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fmr.c:13: printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fnabs.c:13:       printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/fneg.c:13:        printk("%s: D %p, B %p: ", __func__, frD, frB);
arch/powerpc/math-emu/lfd.c:15: printk("%s: D %p, ea %p: ", __func__, frD, ea);
arch/powerpc/math-emu/stfd.c:11:        printk("%s: S %p, ea %p: ", __func__, frS, ea);
arch/powerpc/mm/nohash/44x.c:192:                                       printk("%d ", i);
arch/powerpc/platforms/4xx/machine_check.c:19:          printk("Data");
arch/powerpc/platforms/chrp/pci.c:256:                  printk(" at %llx", (unsigned long long)r.start);
arch/powerpc/platforms/embedded6xx/ls_uart.c:47:                                        printk("%c", in_8(avr_addr + UART_RX));
arch/powerpc/platforms/powermac/pfunc_core.c:83:        printk("%s", title);
arch/powerpc/platforms/powermac/pfunc_core.c:85:                printk("%02x ", *((u8 *)blob));
arch/powerpc/platforms/powernv/pci-ioda.c:81:   printk("%spci %s: [PE# %.2x] %pV",
arch/powerpc/sysdev/tsi108_pci.c:63:    printk("PCI CFG write : ");
arch/powerpc/sysdev/tsi108_pci.c:64:    printk("%d:0x%x:0x%x ", bus->number, devfunc, offset);
arch/powerpc/sysdev/tsi108_pci.c:65:    printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
arch/powerpc/sysdev/tsi108_pci.c:164:           printk("PCI CFG read : ");
arch/powerpc/sysdev/tsi108_pci.c:165:           printk("%d:0x%x:0x%x ", bus->number, devfn, offset);
arch/powerpc/sysdev/tsi108_pci.c:166:           printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
arch/powerpc/sysdev/tsi108_pci.c:315:           printk("cfg_ctl=0x%08x ", temp);
arch/powerpc/xmon/nonstdio.c:181:               printk("%s", xmon_outbuf);


