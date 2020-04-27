Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D771BADAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgD0TPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:15:07 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:42114 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgD0TPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:15:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8DCD1181D302B;
        Mon, 27 Apr 2020 19:15:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3874:4250:4321:5007:6119:9036:10004:10400:10481:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:14819:19900:21080:21433:21627:21795:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hope22_839d3c6f86007
X-Filterd-Recvd-Size: 2356
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 19:15:04 +0000 (UTC)
Message-ID: <c324eed2e6c76fd0157969c69e463e7e7b9ba144.camel@perches.com>
Subject: Re: [PATCH 2/3] mtd: lpddr: Replace printk with pr_notice
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Date:   Mon, 27 Apr 2020 12:15:02 -0700
In-Reply-To: <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
         <c9684a22b661fdeff9efcd5b18be01653911fc89.1588013366.git.gustavo@embeddedor.com>
         <d036dbad02241fdeb0a6400896f73ff11e98e53b.camel@perches.com>
         <67c4b34d-019d-e4c9-ebd2-3a8477470048@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:10 -0500, Gustavo A. R. Silva wrote:
> 
> On 4/27/20 14:01, Joe Perches wrote:
> > On Mon, 2020-04-27 at 14:03 -0500, Gustavo A. R. Silva wrote:
> > > pr_notice is preferred over printk.
> > 
> > So is coalescing formats
> > 
> > ? diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> > []
> > > @@ -127,31 +127,31 @@ static inline void print_drs_error(unsigned dsr)
> > >  	int prog_status = (dsr & DSR_RPS) >> 8;
> > >  
> > >  	if (!(dsr & DSR_AVAILABLE))
> > > -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> > > +		pr_notice("DSR.15: (0) Device not Available\n");
> > >  	if ((prog_status & 0x03) == 0x03)
> > > -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> > > +		pr_notice("DSR.9,8: (11) Attempt to program invalid "
> > >  						"half with 41h command\n");
> > 
> > 		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
> > 
> 
> I didn't want to mess with the rest of format, because some maintainers
> don't like that. If Miquel is OK with that, I can fix that up, too.

He should.  Coalescing is part of coding-style.

"never break user-visible strings such as printk messages"

cheers, Joe

