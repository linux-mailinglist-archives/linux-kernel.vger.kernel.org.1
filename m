Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A3234A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbgGaRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 13:17:08 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:49472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387465AbgGaRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:17:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CD52E182CED5B;
        Fri, 31 Jul 2020 17:17:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 87,8,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:247:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3450:3622:3865:3867:3868:3870:3871:3873:3874:4321:4605:5007:6691:8957:10004:10400:10848:11232:11658:11914:12294:12297:12555:12663:12740:12760:12895:13069:13146:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21795:30051:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: vein84_180cbba26f85
X-Filterd-Recvd-Size: 2243
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 17:17:02 +0000 (UTC)
Message-ID: <a2b0b4a44901674d46de9f949227f35afd21062b.camel@perches.com>
Subject: Re: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 10:17:01 -0700
In-Reply-To: <20200731170755.GB1726@embeddedor>
References: <20200731163301.GA8004@embeddedor>
         <4e30e2df7bec0fedf1a29f7825fbb4c12593eac9.camel@perches.com>
         <20200731170755.GB1726@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 12:07 -0500, Gustavo A. R. Silva wrote:
> On Fri, Jul 31, 2020 at 09:35:42AM -0700, Joe Perches wrote:
> > On Fri, 2020-07-31 at 11:33 -0500, Gustavo A. R. Silva wrote:
> > > Increase columns highlighting to 100+ once the 80-column warning has
> > > been deprecated in the Linux kernel[1].
> > > 
> > > [1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  plugin/linuxsty.vim | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
> > > index 6f7e331..c42ce72 100644
> > > --- a/plugin/linuxsty.vim
> > > +++ b/plugin/linuxsty.vim
> > > @@ -62,7 +62,7 @@ function s:LinuxFormatting()
> > >      setlocal tabstop=8
> > >      setlocal shiftwidth=8
> > >      setlocal softtabstop=8
> > > -    setlocal textwidth=80
> > > +    setlocal textwidth=100
> > 
> > This is not a good change.
> > 80 columns is still _preferred_.
> > 
> 
> Now that you mention that, I have mixed feelings about this.
> Let's see if we can get more opinions...

I am not a vim user, but maybe remove this line
altogether and add something like

	setlocal colorcolumn=80,100

and let people make their own wrapping decisions.


