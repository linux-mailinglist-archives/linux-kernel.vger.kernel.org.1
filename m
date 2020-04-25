Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8891B8879
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 20:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDYSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 14:18:39 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:60430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:18:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B46191802926E;
        Sat, 25 Apr 2020 18:18:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:4250:4321:4605:5007:6742:8660:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12438:12740:12760:12895:13069:13148:13161:13229:13230:13311:13357:13439:14659:14721:21080:21433:21451:21627:21795:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wine94_684a8c69f9151
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Apr 2020 18:18:36 +0000 (UTC)
Message-ID: <38aeb1431d8245b0c37b5d3d7ec6d9e2f33c330e.camel@perches.com>
Subject: Re: [PATCHv3 11/50] c6x: Add show_stack_loglvl()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
Date:   Sat, 25 Apr 2020 11:18:35 -0700
In-Reply-To: <20200418201944.482088-12-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
         <20200418201944.482088-12-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-18 at 21:19 +0100, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
[]
> diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
[]
> @@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
>  
>  static int kstack_depth_to_print = 48;
>  
> -static void show_trace(unsigned long *stack, unsigned long *endstack)
> +static void show_trace(unsigned long *stack, unsigned long *endstack,
> +		       const char *loglvl)
>  {
>  	unsigned long addr;
>  	int i;
> 
> -	pr_debug("Call trace:");
> +	printk("%sCall trace:", loglvl);

These are not equivalent transforms as pr_debug
is compiled to nothing unless DEBUG is defined
or CONFIG_DYNAMIC_DEBUG is enabled.

Perhaps all the conversions should be checked
for these "not the same" object code changes.

