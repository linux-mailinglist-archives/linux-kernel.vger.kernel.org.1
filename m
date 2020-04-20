Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE11B19C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 00:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgDTWwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 18:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDTWwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:52:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5FC218AC;
        Mon, 20 Apr 2020 22:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587423158;
        bh=5C7s/qSVaNv2106+z5QfBbJ5HF3obzRVbPhXQwkzMnI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j87CF2BDztq+xDTfNKO0+xDowilpfPtOnTjkrx+LtOU/kJRmOlvqKFfU2pkDF2cDq
         PhomJCqDYE25XANMzhIWFyaaphzfVSxWWcMREQOzYfuJlGzPlUdtGTVBISLqyCXIt9
         RaIzewuD7N8gfFqK/neiGzr1TuIvWosE7DKZ8zHQ=
Date:   Mon, 20 Apr 2020 15:52:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
Message-Id: <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
In-Reply-To: <20200418201944.482088-32-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
        <20200418201944.482088-32-dima@arista.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 21:19:25 +0100 Dmitry Safonov <dima@arista.com> wrote:

> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Add log level argument to printk_address() as a preparation to introduce
> show_stack_loglvl().
> 
> As a good side-effect show_fault_oops() now prints the address with
> KERN_EMREG as the rest of output, making sure there won't be situation
> where "PC: " is printed without actual address.
> 
> --- a/arch/sh/include/asm/kdebug.h
> +++ b/arch/sh/include/asm/kdebug.h
> @@ -12,7 +12,8 @@ enum die_val {
>  };
>  
>  /* arch/sh/kernel/dumpstack.c */
> -extern void printk_address(unsigned long address, int reliable);
> +extern void printk_address(unsigned long address, int reliable,
> +			   const char *loglvl);
>  extern void dump_mem(const char *str, const char *loglvl,
>  		     unsigned long bottom, unsigned long top);
>  
> ...
>
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -196,7 +196,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
>  
>  	printk(KERN_CONT " at %08lx\n", address);
>  	printk(KERN_ALERT "PC:");
> -	printk_address(regs->pc, 1);
> +	printk_address(regs->pc, 1, KERN_ALERT);
>  

It would be more intuitive to do

	printk_address(KERN_ALERT, regs->pc, 1);

because the loglevel always comes first.

I guess it doesn't matter much, as sh seems to be rather dead.

