Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41B82B218B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:08:07 -0500
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:59902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726094AbgKMRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:08:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E490918224956;
        Fri, 13 Nov 2020 17:08:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2890:3138:3139:3140:3141:3142:3354:3421:3622:3865:3866:3867:3868:3870:3872:3873:3874:4042:4250:4321:4361:5007:9108:10004:10400:10471:10848:11026:11232:11658:11914:12043:12114:12295:12297:12438:12740:12895:13161:13229:13255:13439:13618:13894:14093:14097:14180:14181:14659:14721:21080:21450:21451:21627:30001:30029:30030:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: back79_4308f9c27310
X-Filterd-Recvd-Size: 3298
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Nov 2020 17:08:18 +0000 (UTC)
Message-ID: <70cc9c74785937695c795b5a655f3ab894b14141.camel@perches.com>
Subject: Re: [PATCH 3/2] checkpatch: document the function renaming and
 deprecation around devm_ioremap_resource
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 13 Nov 2020 09:08:17 -0800
In-Reply-To: <20201113170043.osr63jash7anc3xn@pengutronix.de>
References: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
         <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
         <fe5ad7c72eadac32eda6a41b61feaa42c04392b0.camel@perches.com>
         <20201113170043.osr63jash7anc3xn@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-13 at 18:00 +0100, Uwe Kleine-König wrote:
> On Fri, Nov 13, 2020 at 08:36:44AM -0800, Joe Perches wrote:
> > On Fri, 2020-11-13 at 10:11 +0100, Uwe Kleine-König wrote:
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > this can also be squashed into the respective patches instead.
> > > 
> > > Best regards
> > > Uwe
> > > 
> > >  scripts/checkpatch.pl | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -615,6 +615,11 @@ our %deprecated_apis = (
> > >  	"rcu_barrier_sched"			=> "rcu_barrier",
> > >  	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
> > >  	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
> > > +	"devm_platform_get_and_ioremap_resource" => "devm_platform_get_request_and_ioremap_resource",
> > 
> > Do we really need 46 character length function names?
> 
> I can drop the "_and" and maybe "_get", so we're down to 38 "only".
> Other than that I think all name parts are relevant.
> 
> > > +	"devm_platform_ioremap_resource"	=> "devm_platform_request_ioremap_resource",
> > > +	"devm_platform_ioremap_resource_wc"	=> "devm_platform_request_ioremap_resource_wc",
> > > +	"devm_ioremap_resource"			=> "devm_request_ioremap_resource",
> > > +	"devm_ioremap_resource_wc"		=> "devm_request_ioremap_resource_wc",
> > >  );
> > >  
> > > 
> > >  #Create a search pattern for all these strings to speed up a loop below
> > 
> > And do please send your proposed patches to the appropriate maintainers.
> 
> Yes, sure. This patch 3/2 was only a quick shot and it was already clear
> to me that I have to redo it. I want to squash this change in the patch
> that does the actual renaming, I assume that's fine for you?!

Sure.

But please do take Thierry Reding's comment about overall
API complexity into account.

All wrapper macro/functions aren't always obviously good.

They can be useful, but can make knowing which of many
possible wrappers to use and when to use them appropriately
difficult.

Wrappers also add complexity to documentation.


