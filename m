Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7445273715
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgIVAIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:08:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2862 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIVAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:08:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f69407b0000>; Mon, 21 Sep 2020 17:08:27 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 00:08:39 +0000
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
To:     Jann Horn <jannh@google.com>
CC:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill Shutemov" <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kirill Tkhai" <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Leon Romanovsky" <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
 <07bc5f59-74ae-73e8-2616-f11712c27b58@nvidia.com>
 <CAG48ez1Y0==PxR_h6PoRAcxTABM5o0FRR4ow+z7V3W52xNYm_w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <24037577-0b96-4d8c-9487-8e788fbc29eb@nvidia.com>
Date:   Mon, 21 Sep 2020 17:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1Y0==PxR_h6PoRAcxTABM5o0FRR4ow+z7V3W52xNYm_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600733307; bh=pICGIgAAbiHAuske7W1id4qK5tmRw17lO8+nrtcOwW4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=SYPWmsd+dUkTOoJG4eRvvYWKKvK78cSn5KzELaZzoRknrDMUJmzPBs3udYNmixYtO
         gtwRnx454MPX3QSm/RpBoEa+02m5cCdMMh4ORJqCW3fBXuZsWduJ3rzxHDrK67mp3r
         4NFix4SbBUX8JshseEBi9Kz4CQYgpOOSNuZBVNBEYFTT9MmRV8za/w4ZyORDH0iODD
         j/oFnSj071MnxkodIXgXLL2kL7kAZgvqNdqnlAbUYiOssatNfGHczbK0DtjszrQXp1
         090E3B5dRl4ir5GLltzEsi4UuXg8X5uIasw9I8EB0zJ1Ek1izP9rVYZ1zzSquXnYEy
         gmRo3eTHLZmOA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 3:27 PM, Jann Horn wrote:
> On Tue, Sep 22, 2020 at 12:18 AM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 9/21/20 2:55 PM, Jann Horn wrote:
>>> On Mon, Sep 21, 2020 at 11:20 PM Peter Xu <peterx@redhat.com> wrote:
>> ...
> Ah... the documentation you linked implies that FOLL_WRITE should more
> or less imply FOLL_PIN? I didn't realize that.
> 

hmmm, that does seem like a pretty close approximation. It's certainly
true that if we were only doing reads, and also never marking pages
dirty, that the file system writeback code would be OK.

For completeness we should add: even just reading a page is still a
problem, if one also marks the page as dirty (which is inconsistent and
wrong, but still). That's because the file system code can then break,
during writeback in particular.


thanks,
-- 
John Hubbard
NVIDIA
