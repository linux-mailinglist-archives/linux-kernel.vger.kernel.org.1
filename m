Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA127B8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgI2ASw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:18:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13610 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgI2ASt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:18:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f727d5c0000>; Mon, 28 Sep 2020 17:18:36 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 00:18:48 +0000
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
References: <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
 <CAHk-=wiRHLVK7Usrfdbh0MF7b86NLZ7gBWHV-Y89K_p3GU4KQg@mail.gmail.com>
 <20200928235739.GU9916@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6c1292e6-11f0-811c-6cdd-cfc1f4bccbc2@nvidia.com>
Date:   Mon, 28 Sep 2020 17:18:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928235739.GU9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601338716; bh=jmpEGsoMCEZFctwNCe64tE1wCWqRXRFpjk0kPlELp9U=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Ip0+ASZj36jbq8s5v/IRZrxCWxN7x9Ajr9pKiIngaoMWvezVaC+2qD1ODDIaqoAZM
         3c4N8uS+/i2iohuT+Xo9cXMyOlM0UgLf31nnbgUJ/kf5zWp/8DYtIkZXQYNy9vGcVp
         kIH9y6/2LnfRWNs+j8p3ccNk5rKULE9A7/s5iNEwZV+7nTQE8E/YFL4BVzIEbSnQNy
         l52c4dfm475LxdYswpYaGNs9znw/AA3hqQTBBSxrhGO2qasfHkAuf9gFoA9na/Y/aS
         RtZdcAu/RlRBVcdKhQfV0XV9CpY+uvVdbHtnatZHcL7Vmr6Owys6x6maLO3Vt8DGnG
         edzvpmBLkJRJw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 4:57 PM, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2020 at 12:29:55PM -0700, Linus Torvalds wrote:
...
> I think this is really hard to use and ugly. My thinking has been to
> just stick:
> 
>     if (flags & FOLL_LONGTERM)
>         flags |= FOLL_FORCE | FOLL_WRITE
> 
> In pin_user_pages(). It would make the driver API cleaner. If we can

+1, yes. The other choices so far are, as you say, really difficult to figure
out.

> do a bit better somehow by not COW'ing for certain VMA's as you
> explained then all the better, but not my primary goal..
> 
> Basically, I think if a driver is using FOLL_LONGTERM | FOLL_PIN we
> should guarentee that driver a consistent MM and take the gup_fast
> performance hit to do it.
> 
> AFAICT the giant wack of other cases not using FOLL_LONGTERM really
> shouldn't care about read-decoherence. For those cases the user should
> really not be racing write's with data under read-only pin, and the
> new COW logic looks like it solves the other issues with this.

I hope this doesn't kill the seqcount() idea, though. That was my favorite
part of the discussion, because it neatly separates out the two racing domains
(fork, gup/pup) and allows easy reasoning about them--without really impacting
performance.

Truly elegant. We should go there.

> 
> I know Jann/John have been careful to not have special behaviors for
> the DMA case, but I think it makes sense here. It is actually different.
> 

I think that makes sense. Everyone knew that DMA/FOLL_LONGTERM call sites
were at least potentially special, despite the spirited debates in at least
two conferences about the meaning and implications of "long term". :)

And here we are seeing an example of such a special case, which I think is
natural enough.


thanks,
-- 
John Hubbard
NVIDIA
