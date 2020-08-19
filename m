Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA124923C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHSBT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:19:59 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:40192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgHSBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:19:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A882B181D330D;
        Wed, 19 Aug 2020 01:19:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21063:21080:21627:21939:21990:30051:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wash41_4712ceb27023
X-Filterd-Recvd-Size: 2169
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 01:19:55 +0000 (UTC)
Message-ID: <3ca05f10dec479a70f6c33274ded8d4fab9c01ec.camel@perches.com>
Subject: Re: [PATCH v2 11/25] powerpc/signal: Refactor bad frame logging
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 18:19:54 -0700
In-Reply-To: <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
         <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 17:19 +0000, Christophe Leroy wrote:
> The logging of bad frame appears half a dozen of times
> and is pretty similar.
[]
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
[]
> @@ -355,3 +355,14 @@ static unsigned long get_tm_stackpointer(struct task_struct *tsk)
>  #endif
>  	return ret;
>  }
> +
> +static const char fm32[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %08lx lr %08lx\n";
> +static const char fm64[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n";

Why not remove this and use it in place with
%08lx/%016x used as %px with a case to (void *)?

> +void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
> +		  const char *where, void __user *ptr)
> +{
> +	if (show_unhandled_signals)
> +		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
> +				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);

	pr_info_ratelimited("%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n",
			    tsk->comm, task_pid_nr(tsk), where, ptr,
			    (void *)regs->nip, (void *)regs->link);


