Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04BF26E5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIQTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:55:39 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1964 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgIQTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:55:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63bf2a0003>; Thu, 17 Sep 2020 12:55:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 12:55:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Sep 2020 12:55:35 -0700
Received: from [10.2.52.182] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 19:55:34 +0000
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200915191346.GD2949@xz-x1> <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca> <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca> <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <29a76f98-ddc5-4fc1-92ed-3eff01130b11@nvidia.com>
Date:   Thu, 17 Sep 2020 12:55:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600372522; bh=1+Mrfdy5duzyBhCJDTygdYru375hdyXmBf78tKAvjJc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hB2NxzFKSVfLYWQQEDc12bT89tFoOKFak4i4XVIIP0ApjS015JhzC11fjYXTgSIf2
         1VcxhlqcDjhLhMfu0SuLlvCKn0sKjozMrKDScrmnFDrumwTV3P6q+nEkRDf2boOpNM
         EmstdSw2/ManEGNC0G37AEoYtNbte8kwtZupGEHPV0mRsvF3uTfozGppwP5cE4qG3h
         YtNqfnCK7a3T373c4DxP4c5kA43v+zxGKF0JqP4ubcE603Lqh3TEWUvolC/SS6R0pl
         pNV4WxcVK8ryThk9qgSd7iA877BBfLmHX8landEgg7L6qL0Xr8EhIq3VE7g06AGo0c
         jTdZTRhSgnEWg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 12:42 PM, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 12:03 PM Peter Xu <peterx@redhat.com> wrote:
...
> 
> Is there possibly somethign else we can filter on than just
> GUP_PIN_COUNTING_BIAS? Because it could be as simple as just marking
> the vma itself and saying "this vma has had a page pinning event done
> on it".
> 
> Because if we only start copying the page *iff* the vma is marked by
> that "this vma had page pinning" _and_ the page count is bigger than
> GUP_PIN_COUNTING_BIAS, than I think we can rest pretty easily knowing
> that we aren't going to hit some regular old-fashioned UNIX server
> cases with a lot of forks..
> 
>                         Linus

OK, so this sounds like an improvement that would be desirable in the
core API:

1) Have all the pin_user_pages*() functions reach up and mark the vma(s)
as FOLL_PIN_HAPPENED. I'm assuming that the vma can live it's full life
without the need to ever clear that flag. That *seems* reasonable, based
on the use cases for these kinds of pages.

2) And then rename:

    page_maybe_dma_pinned() --> page_likely_dma_pinned()

:)


thanks,
-- 
John Hubbard
NVIDIA
