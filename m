Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E301D2DD81F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgLQSQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:16:17 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:33476 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727063AbgLQSQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:16:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B896E1804E50E;
        Thu, 17 Dec 2020 18:15:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12740:12895:13071:13161:13229:13439:13894:14096:14097:14180:14181:14659:14721:21060:21080:21324:21365:21451:21627:21660:21886:21889:30012:30029:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hot93_45040be27436
X-Filterd-Recvd-Size: 2933
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 18:15:33 +0000 (UTC)
Message-ID: <f650d87a5c65e3da44a129297c3254b7da48767c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add new warning when lookup_symbol_name()
 is used
From:   Joe Perches <joe@perches.com>
To:     Helge Deller <deller@gmx.de>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 10:15:32 -0800
In-Reply-To: <e0b41739-f72d-be5c-cfaa-39ced0e2ab6f@gmx.de>
References: <20201217171111.GA8295@ls3530.fritz.box>
         <816c1571b4132f991089b40a759cf68afcf4af43.camel@perches.com>
         <e0b41739-f72d-be5c-cfaa-39ced0e2ab6f@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 18:42 +0100, Helge Deller wrote:
> On 12/17/20 6:27 PM, Joe Perches wrote:
> > On Thu, 2020-12-17 at 18:11 +0100, Helge Deller wrote:
> > > In most cases people use lookup_symbol_name() to resolve a kernel symbol
> > > and then print it via printk().
> > > 
> > > In such cases using the %ps, %pS, %pSR or %pB printk formats are easier
> > > to use and thus should be preferred.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -4317,6 +4317,12 @@ sub process {
> > >  			     "LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged\n" . $herecurr);
> > >  		}
> > > 
> > > +# avoid lookup_symbol_name()
> > > +		if ($line =~ /\blookup_symbol_name\b/) {
> > > +			WARN("PREFER_PRINTK_FORMAT",
> > > +			     "If possible prefer %ps or %pS printk format string to print symbol name instead of using lookup_symbol_name()\n" . $herecurr);
> > > +		}
> > > +
> > >  # check for uses of printk_ratelimit
> > >  		if ($line =~ /\bprintk_ratelimit\s*\(/) {
> > >  			WARN("PRINTK_RATELIMITED",
> > 
> > Huh?  nak.
> > 
> > lookup_symbol_name is used in the kernel a grand total of 3 times.
> 
> Yes, there were much more in the past which got fixed by patches I submitted.

Hi Helge.

Much more may be a bit of an overstatement.

I found 3 instances of lookup_symbol_name removals in 2 patches.

commit 36dbca148bf8e3b8658982aa2256bdc7ef040256
-		lookup_symbol_name((ulong)pm_power_off, symname);
-		lookup_symbol_name((ulong)pm_power_off, symname);
commit da88f9b3113620dcd30fc203236aa53d5430ee98
-	if (lookup_symbol_name((unsigned long)sym, symname) < 0)

There's a tension between adding tests and newbies that consider
checkpatch warnings as dicta that must be followed so there would
be patches submitted eventually against the existing correct uses.

So thanks, but given the very few existing all correct uses of
this function and the low probability of new uses I'd prefer not
to apply this.


