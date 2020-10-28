Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07E29DA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbgJ1XVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:21:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1453 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390128AbgJ1XVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:21:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9908f40001>; Tue, 27 Oct 2020 23:00:20 -0700
Received: from [10.2.58.85] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 06:00:40 +0000
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
 <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
 <20201027093301.GA16090@quack2.suse.cz> <20201027095545.GA30382@lst.de>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b222ea3c-25e4-2e89-d74b-55190b9fde95@nvidia.com>
Date:   Tue, 27 Oct 2020 23:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027095545.GA30382@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603864820; bh=1BRrdI6k089JuedPu4h+i0NMU17gAvFPAvbhYmzev/M=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Xfsw0UI4t5xVfE+nacUIJXsGIGAfvps6PNJ6PUb2v1NTST9dz3Ffo1a2bL6VuNzri
         M+VtxgnRePumz0BSWiRcU6d7MGjm+os+mUdCBXvoocI2QTQ0x6MrfjpHL95Th9kkIC
         jSP51w8T4ys4qSq1R6KeYCUVLjdg+KyLP4MTAmSOfgR/U3mcSIegMoU4FfSjsJm1AK
         91RsH06l9NjEp2GRHnun8w/2LL1WIDZT1of1OHgO32u4/6ioeyAODxy2kQvdYtipDR
         zjk7MwdGHJa+5P0WlOwt4Q+Ifc8AeCvrU8vRd7TS+PJM3rZIdfWcDtLDnNtrM2Lb0F
         iGpZibMWyx1lA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 2:55 AM, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 10:33:01AM +0100, Jan Kara wrote:
>> Actually there are callers that care about partial success. See e.g.
>> iov_iter_get_pages() usage in fs/direct_io.c:dio_refill_pages() or
>> bio_iov_iter_get_pages(). These places handle partial success just fine and
>> not allowing partial success from GUP could regress things...

Good point. And those also happen to be the key call sites that I haven't
yet converted to pin_user_pages*(). Seeing as how I'm three versions into
attempting to convert the various *iov_iter*() routines, I should have
remembered that they are all about partial success. :)

> 
> But most users do indeed not care.  Maybe an explicit FOLL_PARTIAL to
> opt into partial handling could clean up a lot of the mess.  Maybe just
> for pin_user_pages for now.
> 

That does seem like the perfect mix. IIRC, all of the pin_user_pages()
call sites  today do not accept partial success (and it's easy enough to
audit and confirm). So likely no need to add FOLL_PARTIAL there, and no
huge danger of regressions. It would definitely reduce the line count at
multiple call sites, in return for adding some lines to gup.c.

And maybe it can go further, at some point, but that's a good way to start.

I'm leaning toward just sending out a small series to do that, unless there
are objections and/or better ways to improve this area...


thanks,
-- 
John Hubbard
NVIDIA
