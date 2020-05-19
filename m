Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3A1D8F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 07:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgESFJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 01:09:40 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:44680 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgESFJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:09:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A235A18029DBF;
        Tue, 19 May 2020 05:09:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2827:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4398:5007:6119:7903:8660:8985:9025:9040:9391:10004:10400:10848:10967:11026:11232:11658:11783:11914:12043:12296:12297:12555:12663:12740:12895:12986:13019:13069:13148:13161:13229:13230:13311:13357:13894:14093:14097:14181:14659:14721:14777:21080:21433:21627:21819:21990:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: quiet00_141721926d0a
X-Filterd-Recvd-Size: 2958
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 05:09:36 +0000 (UTC)
Message-ID: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
Subject: Re: [PATCH] init/main.c: Print all command line when boot
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?=E7=8E=8B=E7=A8=8B=E5=88=9A?= <wangchenggang@vivo.com>
Cc:     'Masami Hiramatsu' <mhiramat@kernel.org>,
        "'Steven Rostedt (VMware'" <rostedt@goodmis.org>,
        'Kees Cook' <keescook@chromium.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Dominik Brodowski' <linux@dominikbrodowski.net>,
        'Arvind Sankar' <nivedita@alum.mit.edu>,
        'Mike Rapoport' <rppt@linux.ibm.com>,
        'Alexander Potapenko' <glider@google.com>,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Date:   Mon, 18 May 2020 22:09:34 -0700
In-Reply-To: <20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org>
References: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
         <20200518204415.d1a3adaba597ce5b232b4b2a@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 20:44 -0700, Andrew Morton wrote:
> On Tue, 19 May 2020 11:29:46 +0800 王程刚 <wangchenggang@vivo.com> wrote:
> 
> > Function pr_notice print max length maybe less than the command line length,
> > need more times to print all.
> > For example, arm64 has 2048 bytes command line length, but printk maximum
> > length is only 1024 bytes.
> 
> I can see why that might be a problem!
> 
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -825,6 +825,16 @@ void __init __weak arch_call_rest_init(void)
> >  	rest_init();
> >  }
> >  
> > +static void __init print_cmdline(void)
> > +{
> > +	const char *prefix = "Kernel command line: ";
> 
> const char prefix[] = "...";
> 
> might generate slightly more efficient code.
> 
> > +	int len = -strlen(prefix);
> 
> hm, tricky.  What the heck does printk() actually return to the caller?
> Seems that we forgot to document this, and there are so many different
> paths which a printk call can take internally that I'm not confident
> that they all got it right!

There is no use of the return value of any pr_<level> or
dev_<level> or netdev_<level) in the kernel.

All the pr_<level> mechanisms (as functions) should return void.
https://lore.kernel.org/lkml/1466739971-30399-1-git-send-email-joe@perches.com/

> > +	len += pr_notice("%s%s\n", prefix, boot_command_line);
> > +	while (boot_command_line[len])
> > +		len += pr_notice("%s\n", &boot_command_line[len]);
> > +}

More likely it'd be better to use a strlen(boot_command_line)
and perhaps do something like print multiple lines with args
using strchr(, ' ') at some largish value, say 132 or 256 chars
maximum per line.



