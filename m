Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60920255144
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgH0WpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:45:23 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:36066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgH0WpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:45:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DB2FD180339CD;
        Thu, 27 Aug 2020 22:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3872:3874:4250:4321:5007:7875:7903:8603:10010:10400:10848:11026:11232:11658:11914:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:21990:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pies81_1b16d5127070
X-Filterd-Recvd-Size: 3013
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 22:45:19 +0000 (UTC)
Message-ID: <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Denis Efremov <efremov@linux.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Thu, 27 Aug 2020 15:45:17 -0700
In-Reply-To: <202008271517.ECC1F1F8F@keescook>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <202008271517.ECC1F1F8F@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 15:20 -0700, Kees Cook wrote:
> On Fri, Aug 28, 2020 at 12:01:34AM +0300, Denis Efremov wrote:
> > Just FYI, I've send an addition to the device_attr_show.cocci script[1] to turn
> > simple cases of snprintf (e.g. "%i") to sprintf. Looks like many developers would
> > like it more than changing snprintf to scnprintf. As for me, I don't like the idea
> > of automated altering of the original logic from bounded snprint to unbouded one
> > with sprintf.
> 
> Agreed. This just makes me cringe. If the API design declares that when
> a show() callback starts, buf has been allocated with PAGE_SIZE bytes,
> then that's how the logic should proceed, and it should be using
> scnprintf...
> 
> show(...) {
> 	size_t remaining = PAGE_SIZE;
> 
> 	...
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 
> 	return PAGE_SIZE - remaining;
> }

It seems likely that coccinelle could do those transform
with any of sprintf/snprintf/scnprint too.

Though my bikeshed would use a single function and have
that function know the maximum output size

Something like:

With single line use:

	return sysfs_emit(buf, buf, fmt, ...) - buf;

and multi-line use:

	char *pos = buf;

	pos = sysfs_emit(buf, pos, fmt1, ...);
	pos = sysfs_emit(buf, pos, fmt2, ...);
	...

	return pos - buf;


