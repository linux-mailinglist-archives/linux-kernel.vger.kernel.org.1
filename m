Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6C2938F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405966AbgJTKOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:14:01 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:35808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404581AbgJTKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:14:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1B12E182CED5B;
        Tue, 20 Oct 2020 10:14:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:981:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2195:2199:2393:2525:2553:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7576:7875:7903:8603:9025:9036:10004:10394:10400:10848:10903:11232:11657:11658:11854:11914:12043:12048:12050:12266:12297:12438:12555:12663:12740:12760:12895:12986:13019:13255:13439:13972:14180:14181:14659:14721:21060:21080:21365:21451:21627:21660:21789:30003:30012:30034:30054:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plane05_1115cb72723e
X-Filterd-Recvd-Size: 3280
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Oct 2020 10:13:58 +0000 (UTC)
Message-ID: <291e3bbc22c84b18c54e072e995d18a7955a209b.camel@perches.com>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 20 Oct 2020 03:13:57 -0700
In-Reply-To: <c5af8f26bcb3468eb777bb8a8c8258d6@AcuMS.aculab.com>
References: <202010190356.fgwA7zzR-lkp@intel.com>
         <80f9a6c79771167d119b2990910fe273c3901df0.camel@perches.com>
         <c5af8f26bcb3468eb777bb8a8c8258d6@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-20 at 08:00 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 19 October 2020 16:47
> > On Mon, 2020-10-19 at 03:13 +0800, kernel test robot wrote:
> > > Hi Ard,
> > > 
> > > First bad commit (maybe != root cause):
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   9d9af1007bc08971953ae915d88dc9bb21344b53
> > > commit: 5fb8ef25803ef33e2eb60b626435828b937bed75 crypto: chacha - move existing library code into
> > lib/crypto
> > > date:   11 months ago
> > > config: i386-randconfig-r023-20201019 (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         #
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fb8ef25803ef33e2eb60b62
> > 6435828b937bed75
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 5fb8ef25803ef33e2eb60b626435828b937bed75
> > >         # save the attached .config to linux build tree
> > >         make W=1 ARCH=i386
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    lib/crypto/chacha.c: In function 'chacha_permute':
> > > > > lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes is larger than 1024 bytes [-
> > Wframe-larger-than=]
> > >       65 | }
> > >          | ^
> > > 
> > > vim +65 lib/crypto/chacha.c
> > 
> > This seems to come from function tracing overhead.
> 
> Are you sure?

No.  I'm trying to isolate it now.

> I've not got the x86 object, but the x86-64 version caches the 16 x[]
> values (from the parameter) in registers.
> The 32 bit cpu doesn't have enough registers, but gcc tends to
> compile assuming an infinite number.
> So it may have spilled lots of virtual registers to different
> stack locations - instead of writing the values to their 'target'
> address.



