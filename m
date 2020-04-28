Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E741BD088
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 01:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD1XRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 19:17:07 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:40440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgD1XRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:17:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 35322182CED28;
        Tue, 28 Apr 2020 23:17:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8957:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:21811:30012:30054:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: body11_780e320e03c1f
X-Filterd-Recvd-Size: 1981
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 23:17:04 +0000 (UTC)
Message-ID: <a2d7dbae193800ce430321d3fcc71ab5d1a5ed03.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
Date:   Tue, 28 Apr 2020 16:17:03 -0700
In-Reply-To: <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
References: <20200428020223.GA28074@udknight>
         <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 09:10 -0700, Joe Perches wrote:
> On Tue, 2020-04-28 at 10:02 +0800, Wang YanQing wrote:
> > According to submitting-patches.rst, 'Fixes:' tag has a little
> > stricter condition about the one line summary:
> > ...
> > Do not split the tag across multiple
> > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > parsing scripts
> > ...
> > 
> > And there is no 'Fixes:' tag format checker in checkpatch to check
> > the commit id length too, so let's add dedicated checker to check
> > these conditions for 'Fixes:' tag.
> 
> There's no need to duplicate functionality like this.
> Put this additional Fixes: logic into the existing block.
> 
> (and don't take advise from Markus too seriously when it
> comes to English grammar or wording.  He is not an arbiter
> of taste for this code)
> 

btw:  I suggested this patch last year.

https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/


