Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5672E0D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgLVQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:22:51 -0500
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:35312 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbgLVQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:22:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 48F1E100E7B46;
        Tue, 22 Dec 2020 16:22:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12043:12294:12297:12438:12663:12740:12760:12895:13095:13161:13229:13255:13439:14096:14097:14659:14721:21080:21212:21365:21433:21451:21627:21990:30003:30012:30030:30054:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: shock82_5013a7b27461
X-Filterd-Recvd-Size: 3498
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Dec 2020 16:22:07 +0000 (UTC)
Message-ID: <983e6452a7f2af14ca7edfa56cd2e2997172a771.camel@perches.com>
Subject: Re: [PATCH] checkpatch: make the line length warnings match the
 coding style document
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, apw@canonical.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Dec 2020 08:22:06 -0800
In-Reply-To: <20201222131234.GA29028@lst.de>
References: <20201210082251.2717564-1-hch@lst.de>
         <c3f1d9de2e5a61588f64e69a1309968d84a2dd12.camel@perches.com>
         <20201210200930.GB7338@casper.infradead.org>
         <4898c0c03d370a23b1b98ddabb72e70ec8d430fa.camel@perches.com>
         <93a470c7631d2607e7b2a12e9cc5d8e930911989.camel@perches.com>
         <20201222131234.GA29028@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-22 at 14:12 +0100, Christoph Hellwig wrote:
> On Mon, Dec 21, 2020 at 08:08:20PM -0800, Joe Perches wrote:
> > On Thu, 2020-12-10 at 13:27 -0800, Joe Perches wrote:
> > > On Thu, 2020-12-10 at 20:09 +0000, Matthew Wilcox wrote:
> > > > On Thu, Dec 10, 2020 at 12:05:04PM -0800, Joe Perches wrote:
> > > > > Also, given the ever increasing average identifier length, strict
> > > > > adherence to 80 columns is sometimes just not possible without silly
> > > > > visual gymnastics.  The kernel now has quite a lot of 30+ character
> > > > > length function names, constants, and structs.
> > > > 
> > > > maybe checkpatch should warn for identifiers that are 30+ characters
> > > > long?  address the problem at its source ..
> > > 
> > > Hard to know when to warn as patches could just add uses of already
> > > existing names and emitting warnings for those would just be annoying.
> > > 
> > > Maybe something that tests long identifier additions of
> > > defines/functions/macros/structs but not their uses and maybe only
> > > then in patches and not files.
> > > 
> > > Perhaps:
> > 
> > Anyone care that this should be added or not added to checkpatch?
> 
> It is pretty useless.

Maybe so, if only because I chose a high value for the max id length
to avoid controversy.  I would prefer something like 20.

> What we need is a patch that doesn't make people
> uselessly add overly long lines against the intent of the coding style
> document.  I have submitted a pretty reasonable one, and I'm open to
> alternatives, but we need to to stop people submitting code that does
> not fit the coding style all the time because checkpatch doesn't
> complain.

Having checkpatch complain about > 80 column lines didn't stop
patches before, likely it wouldn't stop patches now.

Emitting yet more messages for trivial lines > 80 columns is also
against the intent of the commit that changed the line length maximum.

commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
checkpatch/coding-style: deprecate 80-column warning

The effect of your patch might as well revert the checkpatch portion
of that commit.

I think that's not a great idea for the reason in the commit message.


