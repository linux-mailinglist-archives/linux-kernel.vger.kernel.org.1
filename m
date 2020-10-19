Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD440292AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgJSPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:47:23 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:60726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730051AbgJSPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:47:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 37D0518029130;
        Mon, 19 Oct 2020 15:47:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:981:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:7875:7903:8603:9025:9036:10004:10394:10400:10848:10903:11232:11657:11658:11854:11914:12043:12050:12266:12297:12438:12555:12679:12740:12760:12895:12986:13069:13161:13229:13255:13311:13357:13439:14180:14181:14659:14721:21060:21080:21347:21365:21451:21627:21660:21740:21789:30012:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: band69_5601b1127238
X-Filterd-Recvd-Size: 2581
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Oct 2020 15:47:20 +0000 (UTC)
Message-ID: <80f9a6c79771167d119b2990910fe273c3901df0.camel@perches.com>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 19 Oct 2020 08:47:16 -0700
In-Reply-To: <202010190356.fgwA7zzR-lkp@intel.com>
References: <202010190356.fgwA7zzR-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-19 at 03:13 +0800, kernel test robot wrote:
> Hi Ard,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d9af1007bc08971953ae915d88dc9bb21344b53
> commit: 5fb8ef25803ef33e2eb60b626435828b937bed75 crypto: chacha - move existing library code into lib/crypto
> date:   11 months ago
> config: i386-randconfig-r023-20201019 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fb8ef25803ef33e2eb60b626435828b937bed75
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5fb8ef25803ef33e2eb60b626435828b937bed75
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/crypto/chacha.c: In function 'chacha_permute':
> > > lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       65 | }
>          | ^
> 
> vim +65 lib/crypto/chacha.c

This seems to come from function tracing overhead.

It it really useful to add function tracing to what
should be a single instruction?

AFAIK:

There isn't a good way to turn function tracing off
on a per-function basis.

Adding notrace doesn't work for that.  Should it?


