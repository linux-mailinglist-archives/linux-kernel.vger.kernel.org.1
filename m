Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8025564E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgH1IW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:22:28 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:54576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727971AbgH1IW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:22:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 358A4180154A4;
        Fri, 28 Aug 2020 08:22:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3872:3874:4250:4321:4425:5007:8531:10004:10400:10848:11232:11658:11914:12295:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21433:21627:21990:30054:30056:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: head10_2f0dd8327074
X-Filterd-Recvd-Size: 3029
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 08:22:24 +0000 (UTC)
Message-ID: <a98b0a411abdaf6b58c73322511087f57353fb22.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Fri, 28 Aug 2020 01:22:23 -0700
In-Reply-To: <526af204ddf95f94012c6132d12693852bfe7442.camel@perches.com>
References: <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <202008271517.ECC1F1F8F@keescook>
         <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
         <d99c613aa70617f440c51d9413372b858a4ae826.camel@perches.com>
         <202008280056.6442BCC@keescook>
         <526af204ddf95f94012c6132d12693852bfe7442.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-28 at 01:10 -0700, Joe Perches wrote:
> On Fri, 2020-08-28 at 00:58 -0700, Kees Cook wrote:
> > On Thu, Aug 27, 2020 at 09:12:06PM -0700, Joe Perches wrote:
> > > Perhaps something like the below with a sample conversion
> > > that uses single and multiple sysfs_emit uses.
> > 
> > On quick review, I like it. :)
> > 
> > > [...]
> > > +int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
> > > +{
> > > +	int len;
> > > +	va_list args;
> > > +
> > > +	WARN(pos < buf, "pos < buf\n");
> > > +	WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
> > > +	     pos - buf, PAGE_SIZE);
> > > +	if (pos < buf || pos - buf >= PAGE_SIZE)
> > > +		return 0;
> > 
> > This can be:
> > 
> > 	if (WARN(pos < buf, "pos < buf\n") ||
> > 	    WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
> > 		 pos - buf, PAGE_SIZE))
> > 		return 0;
> 
> I have some vague recollection that WARN could be compiled
> away to nothing somehow.  True or false?
> 
> If false, sure, of course, it'd be faster too.

I can't find an instance where WARN doesn't return the
condition.

And likely even faster would be to just show "invalid pos"
instead of specific messages.

	if (WARN(pos < buf || (pos - buf) >= PAGE_SIZE,
		 "Invalid pos\n");
		return 0;

or maybe use WARN_ONCE or no WARN at all.

