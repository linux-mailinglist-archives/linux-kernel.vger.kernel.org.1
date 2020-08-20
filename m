Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AB24C2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgHTQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 12:03:32 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:59558 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgHTQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:03:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9CFA4100E7B61;
        Thu, 20 Aug 2020 16:03:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3874:3876:4321:5007:6120:7576:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12663:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cough98_310225427031
X-Filterd-Recvd-Size: 2202
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 16:03:23 +0000 (UTC)
Message-ID: <7ef3bf5553285840fcf082d0a616ca1e3edd0cd3.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Aug 2020 09:03:21 -0700
In-Reply-To: <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-2-john.ogness@linutronix.de>
         <e1e3164eabf69e04ad9e9ddc259ca685f48c5e27.camel@perches.com>
         <b17fc8afc8984fedb852921366190104@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 07:44 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 20 August 2020 01:34
> > 
> > On Thu, 2020-08-20 at 01:32 +0206, John Ogness wrote:
> > > Implement a new buffering mechanism for pr_cont messages.
> > > 
> > > Old mechanism syntax:
> > > 
> > >     printk(KERN_INFO "text");
> > >     printk(KERN_CONT " continued");
> > >     printk(KERN_CONT "\n");
> > > 
> > > New mechanism syntax:
> > > 
> > >     pr_cont_t c;
> > > 
> > >     pr_cont_begin(&c, KERN_INFO "text");
> > 
> > bikeshed:
> > 
> > I suggest:
> > 
> > 	printk_begin(&printk_context, fmt, ...)
> > 	printk_continue(&printk_context, fmt, ...) (maybe printk_next())
> > 	printk_end(&printk_context, fmt, ...)
> 
> I see some very long source lines looming ...

Macros make that pretty short.

pr_<level>_start
pr_next
pr_end

Doesn't seem too bad.

