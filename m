Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF9277643
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgIXQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:09:02 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:52590 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728448AbgIXQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:09:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DC11718029143;
        Thu, 24 Sep 2020 16:09:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13019:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21324:21451:21627:30012:30054:30056:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: toe09_3205d4c27160
X-Filterd-Recvd-Size: 1971
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Sep 2020 16:08:58 +0000 (UTC)
Message-ID: <c0dbf88bb7ca4d77ed0576ced82302b81aebe664.camel@perches.com>
Subject: Re: [PATCH] x86/irq: Use printk_deferred() on raw_spin_lock()
 protected sections
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Sep 2020 09:08:57 -0700
In-Reply-To: <20200924102822.GA2628@hirez.programming.kicks-ass.net>
References: <e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com>
         <20200924102822.GA2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-24 at 12:28 +0200, Peter Zijlstra wrote:
> On Mon, Sep 21, 2020 at 06:22:12PM +0200, Daniel Bristot de Oliveira wrote:
> > While testing hotplug I got this BUG:
> > It was caused by printk() inside a code section protected by a
> > raw_spin_lock() that ended up calling a serial console that
> > uses a regular spin_lock().
> > 
> > Use the printk_deferred() to avoid calling the serial console
> > in a raw_spin_lock() protected section.
> 
> I consider printk_deferred() to be a bug, can't we just wait for the new
> printk implementation to land so we don't need all this nonsense?

It will be good to do a sed fixup for all these
printk_deferred uses soon,  but in the meantime
isn't it useful to avoid BUGs?



