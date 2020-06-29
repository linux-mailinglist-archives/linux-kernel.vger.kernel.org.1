Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7720D6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgF2TWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:22:18 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:42508 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732234AbgF2TVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 56100513;
        Mon, 29 Jun 2020 19:21:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2525:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:5007:6119:7576:7903:8985:9025:10004:10400:10450:10455:10848:11232:11473:11658:11914:12043:12050:12297:12438:12555:12740:12760:12895:13069:13141:13153:13228:13230:13311:13357:13439:14181:14659:14721:19904:19999:21080:21451:21627:21740:21811:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: toes32_4b0cc6e26e71
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Jun 2020 19:21:35 +0000 (UTC)
Message-ID: <644c67ae316bde28669f660aa5aade274d19a2d0.camel@perches.com>
Subject: Re: [PATCH] mm: util: update the kerneldoc for kstrdup_const()
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 29 Jun 2020 12:21:34 -0700
In-Reply-To: <7f1439be-75c4-3a07-ab7b-f4505bf30c48@redhat.com>
References: <20200628152500.17916-1-brgl@bgdev.pl>
         <693db5a878ac09994e2a27c64cb14c0e552f3f50.camel@perches.com>
         <7f1439be-75c4-3a07-ab7b-f4505bf30c48@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-29 at 12:54 +0200, David Hildenbrand wrote:
> On 28.06.20 19:37, Joe Perches wrote:
> > On Sun, 2020-06-28 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > Memory allocated with kstrdup_const() must not be passed to regular
> > > krealloc() as it is not aware of the possibility of the chunk residing
> > > in .rodata. Since there are no potential users of krealloc_const()
> > > at the moment, let's just update the doc to make it explicit.
> > 
> > Another option would be to return NULL if it's
> > used from krealloc with a pointer into rodata
[]
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
[]
> > @@ -1683,6 +1683,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
> >   * @new_size: how many bytes of memory are required.
> >   * @flags: the type of memory to allocate.
> >   *
> > + * If the object pointed to is in rodata (likely from kstrdup_const)
> > + * %NULL is returned.
> > + *
[]
> Won't we have similar issues if somebody would do a kfree() instead of a
> kfree_const()? So I think the original patch makes sense.

Which is why I also suggested making kfree work for
more types of memory freeing earlier this month.

https://lore.kernel.org/lkml/573b3fbd5927c643920e1364230c296b23e7584d.camel@perches.com/


