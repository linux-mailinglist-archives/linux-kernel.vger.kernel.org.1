Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D81246887
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgHQOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:39:33 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:48732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728619AbgHQOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:39:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id F3DFE18029DBF;
        Mon, 17 Aug 2020 14:39:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4040:4321:5007:6119:6120:7903:8660:9008:10004:10400:10481:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13095:13148:13230:13311:13357:13439:14659:14721:19900:21080:21433:21627:21795:21939:30012:30051:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: water82_530756927017
X-Filterd-Recvd-Size: 1800
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 14:39:29 +0000 (UTC)
Message-ID: <908521d73a918b1ea6c9151a3376073765858737.camel@perches.com>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Mon, 17 Aug 2020 07:39:28 -0700
In-Reply-To: <20200817114441.GK1891694@smile.fi.intel.com>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
         <20200817114441.GK1891694@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-17 at 14:44 +0300, Andy Shevchenko wrote:
> On Fri, Aug 14, 2020 at 10:53:03AM -0700, Joe Perches wrote:
> > There is a print_vma_addr function used several places
> > that requires KERN_CONT use.
> > 
> > Add a %pv mechanism to avoid the need for KERN_CONT.
> 
> I like the idea, but I would accent the selling point to make code
> (in the user call sites) nicer.
[]
> > +#else
> > +	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);
> > +#endif
> 
> Can we avoid this spammy message? Really it's quite long and fills valuable
> space in kernel buffer. I would rather print the hashed pointer as it's done
> for the rest of %pXXX.

Don't see why not.  I believe it'd just use
	buf = ptr_to_id(buf, end, ip, spec);
instead


