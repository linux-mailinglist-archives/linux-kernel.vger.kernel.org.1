Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4C28E813
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgJNUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:48:39 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:56500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727413AbgJNUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:48:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6EB9618224D68;
        Wed, 14 Oct 2020 20:48:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12291:12297:12663:12683:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:14915:21080:21451:21622:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fan01_4617e032720e
X-Filterd-Recvd-Size: 2449
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 20:48:37 +0000 (UTC)
Message-ID: <8aff1623d069f37e089c5dcc7fb3fa00c272a886.camel@perches.com>
Subject: Re: [PATCH 0/2] module: some refactoring in module_sig_check()
From:   Joe Perches <joe@perches.com>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 14 Oct 2020 13:48:36 -0700
In-Reply-To: <d97f1700-f149-0fb5-99cf-3af421e399dc@omprussia.ru>
References: <789a4e5c-8efd-bb1c-86e2-eed8b2b7b0af@omprussia.ru>
         <3897a8ce5760affa304952c2d30c1266589407f2.camel@perches.com>
         <e6fd4ba1-b431-afd8-1800-3a8f4b74f30e@omprussia.ru>
         <e8382da95dda4dffa06f81a05e92e5555a074bab.camel@perches.com>
         <d97f1700-f149-0fb5-99cf-3af421e399dc@omprussia.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 22:44 +0300, Sergey Shtylyov wrote:
> On 10/14/20 11:35 AM, Joe Perches wrote:
> 
> [...]
> > > > > Here are 2 patches against the 'modules-next' branch of Jessica Yu's 'linux.git' repo.
> > > > > I'm doing some little refactoring in module_sig_check()...
> > > > > 
> > > > > [1/2] module: merge repetitive strings in module_sig_check()
> > > > > [2/2] module: unindent comments in module_sig_check()
> > > > 
> > > > I think this code is rather cryptic and could be made clearer.
> > > > 
> > > > How about:
> > > > ---
> > > >   kernel/module.c | 51 ++++++++++++++++++++++++++-------------------------
> > > >   1 file changed, 26 insertions(+), 25 deletions(-)
> > > 
> > >     Looks good. Do you want to post complete patch(es)? :-)
> > 
> > I don't like posting actual patches on top of other people.
> > It's a complete and compilable diff, it's just unsigned.
> 
>    It does too many things simultaneously, I'll need to decompose it...
> 
> > If you want a Signed-off-by: here's one:
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
>    I think I'll rather use Suggested-by: where appropriate...

I don't think it does too many things and I'm not
a big fan of micro-patches, but no worries, do what
you want to it.

I just thought the code poor and a bit unreadable
given the internal goto in a switch/case block.


