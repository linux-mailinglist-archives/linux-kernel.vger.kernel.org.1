Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9801E6855
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405382AbgE1RIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:08:25 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:55776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405314AbgE1RIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:08:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0E039181D3028;
        Thu, 28 May 2020 17:08:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7903:9149:10004:10400:10848:11026:11232:11658:11914:12043:12114:12297:12533:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21433:21451:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shop26_1d0c21926d5c
X-Filterd-Recvd-Size: 3462
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 May 2020 17:08:20 +0000 (UTC)
Message-ID: <a4f8cfc41d4b7f9f76a403767cfc28d5ffafc1ee.camel@perches.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 28 May 2020 10:08:18 -0700
In-Reply-To: <20200528121455.GD11286@linux-b0ei>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <20200525084218.GC5300@linux-b0ei>
         <20200525091157.GF755@jagdpanzerIV.localdomain>
         <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
         <20200527083747.GA27273@linux-b0ei>
         <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
         <20200527155504.GD3529@linux-b0ei>
         <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
         <20200528105942.GB11286@linux-b0ei>
         <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
         <20200528121455.GD11286@linux-b0ei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-28 at 14:14 +0200, Petr Mladek wrote:
> On Thu 2020-05-28 20:33:10, Tetsuo Handa wrote:
> > On 2020/05/28 19:59, Petr Mladek wrote:
> > > 2. Add twist into vprintk_store(). In the current, implementation
> > >    it would do:
> > > 
> > >   #if TWIST
> > > 	return text_len;
> > >   #endif
> > > 
> > > 	return log_output(facility, level, lflags,
> > > 			  dict, dictlen, text, text_len);
> > 
> > This part could be possible. But
> > 
> > > 1. Add twist into ddebug_add_module() and enable all newly added
> > >    entries by default. For example, by calling
> > >    ddebug_exec_query("*:+p", const char *modname) or what is the syntax.
> > > 
> > >    This will cause that any pr_devel() variant will always get called.
> > 
> > how to handle
> > 
> > > >   #define no_printk(fmt, ...)                             \
> > > >   ({                                                      \
> > > >           if (0)                                          \
> > > >                   printk(fmt, ##__VA_ARGS__);             \
> > > >           0;                                              \
> > > >   })
> > 
> > part used by e.g. pr_devel() ? Since this macro is not using dynamic debug
> > interface, vprintk_store() will not be called from the beginning. Are you
> > suggesting that we should convert no_printk() to use dynamic debug interface ?
> 
> OK, this is one more path that would need special handling. Two paths
> are much better than 15.

A few more:

$ grep-2.5.4 --include=*.[ch] -rP '\if\s*\(\s*0\s*\)\s*\{?\s*\\?\s*no_printk' *
drivers/platform/x86/thinkpad_acpi.c:	do { if (0) no_printk(format, ##arg); } while (0)
fs/ntfs/debug.h:	if (0)								\
		no_printk(fmt, ##__VA_ARGS__);				\
include/linux/net.h:		if (0)						\
			no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
kernel/cred.c:	if (0)								\
		no_printk("[%-5.5s%5u] " FMT "\n",			\


