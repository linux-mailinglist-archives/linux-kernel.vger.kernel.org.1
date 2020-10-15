Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC70428FB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgJOWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:53:23 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:53210 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731828AbgJOWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:53:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4FDD312CC;
        Thu, 15 Oct 2020 22:53:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:10004:10400:10848:11232:11658:11914:12295:12297:12663:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21092:21627:21740:21972:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: leaf97_0c0ea4827218
X-Filterd-Recvd-Size: 2647
Received: from XPS-9350 (unknown [172.58.35.12])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Oct 2020 22:53:17 +0000 (UTC)
Message-ID: <d8237d5151e108f969628302c22e27dda3860bdd.camel@perches.com>
Subject: Re: [PATCH V2] scripts: spelling:  Remove space in the entry memry
 to memory
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Oct 2020 15:53:15 -0700
In-Reply-To: <20201015224919.GA1129531@ArchLinux>
References: <20201015132336.1770828-1-unixbhaskar@gmail.com>
         <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
         <20201015135407.GB1899805@ArchLinux>
         <f479c3b907279ba79391ae1d4ec27773a79ffd15.camel@perches.com>
         <20201015224919.GA1129531@ArchLinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-16 at 04:19 +0530, Bhaskar Chowdhury wrote:
> On 14:10 Thu 15 Oct 2020, Joe Perches wrote:
> > On Thu, 2020-10-15 at 19:24 +0530, Bhaskar Chowdhury wrote:
> > > On 06:38 Thu 15 Oct 2020, Joe Perches wrote:
> > > > On Thu, 2020-10-15 at 18:53 +0530, Bhaskar Chowdhury wrote:
> > > > > Fix the space in the middle in below entry.
> > > > > 
> > > > > memry||memory
> > > > []
> > > > > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> > > > []
> > > > > @@ -885,7 +885,7 @@ meetign||meeting
> > > > >  memeory||memory
> > > > >  memmber||member
> > > > >  memoery||memory
> > > > > -memry ||memory
> > > > > +memry||memory
> > > > 
> > > > No.  Don't post a bad patch, assume
> > > > it's applied and then post a fix to
> > > > the bad patch as v2.
> > > > 
> > > > Send a single clean patch.
> > > > 
> > > 
> > > Not sure what you mean...could you elaborate...don't know what is going on..>
> > 
> > You sent a patch with a defect
> 
> Who doesn't???

No one.

> > You sent a V2 patch that just corrects the defect in the first patch.
> 
> That's how it is working here for long time ...I am not sure about your
>   involvement.

wrong.  Your first patch has not been, and should
not be applied, as it has a trivial known defect.

> Please don't unnecessarily streach thing ...we have other things to do ...do
> not bringing "new rules" here for the sake of it.

It's not a new rule.
Don't introduce patches with defects.



