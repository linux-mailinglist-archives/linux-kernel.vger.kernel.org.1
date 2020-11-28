Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75E02C73DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgK1Vtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:53 -0500
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:51332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733277AbgK1SBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:01:35 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 10E81800CE04
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 16:44:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 42A46180A7FDA;
        Sat, 28 Nov 2020 16:44:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7904:10004:10400:10848:11232:11658:11914:12048:12296:12297:12663:12740:12760:12895:13069:13160:13161:13229:13311:13357:13439:14659:14721:14822:21080:21451:21627:21795:21990:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: spot52_1600c7927392
X-Filterd-Recvd-Size: 2452
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 16:44:33 +0000 (UTC)
Message-ID: <1e0ffe90dc73d45e3e2c3bdd8686aa8e9afa8b23.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, apw@canonical.com, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 28 Nov 2020 08:44:31 -0800
In-Reply-To: <8a48dbc8-59cc-5fff-e9ea-e68ffb9e698a@redhat.com>
References: <20201127214316.3045640-1-trix@redhat.com>
         <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
         <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
         <6e9917257cfd6774066446014051d39b784ba497.camel@perches.com>
         <8a48dbc8-59cc-5fff-e9ea-e68ffb9e698a@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-28 at 08:30 -0800, Tom Rix wrote:
> On 11/28/20 8:00 AM, Joe Perches wrote:
> > On Sat, 2020-11-28 at 07:36 -0800, Tom Rix wrote:
> > > On 11/27/20 2:10 PM, Joe Perches wrote:
> > []
> > > > I think an exception mechanism would be better than a specific
> > > > mechanism added to various entries.
> > > Can you give an example of what you mean ?
> > Inherit the parent prefix then add the basename(dirname) as a default.
> > 
> > For instance, changes to any subsystem of drivers/staging starts as
> > "staging: " and with "$basename(path): " appended.
> 
> Ah, this is quite a bit different.
> 
> As far as I can tell there is no default.

The idea is to avoid adding a D: entry to each subsystem section.

> MAINTAINERS would only have the exceptions, obviously needing drivers/foo to be 'foo:'
> 
> Without the full prefix, the user would be need to use get_maintainer.pl to figure it out.

True.  Or some other script.
 
> Are the ""'s in the D value necessary ?

Maybe not.  I did that for clarity with the space after colon.
My recollection is some systems used "[subsystem]" separators
and other use / without space and not colons, but I'm for
whatever approriate changes that support standarization

I think most developer/maintainers don't care one way or
another about patch commit prefixes, but those that do care
seem to care a lot.


