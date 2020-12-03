Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C518D2CDF00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgLCTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:31:55 -0500
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:46110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgLCTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:31:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 40CD9180A7FFC;
        Thu,  3 Dec 2020 19:31:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7514:7903:8957:9010:9025:10004:10400:10471:10848:11026:11232:11473:11658:11914:12043:12109:12114:12297:12438:12679:12740:12760:12895:13069:13255:13311:13357:13439:13845:14181:14659:14721:14777:21080:21347:21627:21749:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: back27_4f096c0273be
X-Filterd-Recvd-Size: 2435
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Dec 2020 19:31:13 +0000 (UTC)
Message-ID: <26cfa56433bb87775524257ec0f5010e628837d3.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] [PATCH -mmots] checkpatch: add fix for
 non-standard signature - co-authored-by
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya <yashsri421@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Dec 2020 11:31:11 -0800
In-Reply-To: <X8k7srxYPa275pXQ@kroah.com>
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
         <20201202183045.9309-1-yashsri421@gmail.com>
         <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
         <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
         <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
         <X8k1CaSlaJpJdmcC@kroah.com>
         <CAKXUXMye+ppB1DhGu9xwqRa2BEuLKzsQVL3_RUNySy+zKXHoLg@mail.gmail.com>
         <X8k7srxYPa275pXQ@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 20:25 +0100, Greg KH wrote:
> On Thu, Dec 03, 2020 at 08:00:58PM +0100, Lukas Bulwahn wrote:
> > On Thu, Dec 3, 2020 at 7:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Thu, Dec 03, 2020 at 11:59:54AM +0100, Lukas Bulwahn wrote:
> > > > On Thu, Dec 3, 2020 at 10:59 AM Aditya <yashsri421@gmail.com> wrote:
> > > > > 
> > > > > On 3/12/20 12:26 am, Joe Perches wrote:
> > > > > > On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
> > > > > > > Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> > > > > > > non-standard signatures.
[]
> > > co-developed-by is the correct tag for this.  It is documented exactly
> > > for this reason, please do not try to use something that is not already
> > > accepted by the kernel developers for this type of thing.

Postel's law should apply here.

And there is a concurrent thread on the ksummit-discuss mailing list
that applies:

https://lore.kernel.org/ksummit-discuss/CAFhKne9ZSbwrH6-g7og2BBEEDGd6ScDnZTNg3znQLvLDCDfeoA@mail.gmail.com/T/#t

I hope all this becomes moot eventually.


