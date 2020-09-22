Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADD2747EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIVSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:02:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18391 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:02:05 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a3bee0002>; Tue, 22 Sep 2020 11:01:18 -0700
Received: from [10.2.52.174] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 18:02:04 +0000
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jann Horn" <jannh@google.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3d17619c-36b4-b080-08ff-26b3e9acb616@nvidia.com>
Date:   Tue, 22 Sep 2020 11:02:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922151736.GD19098@xz-x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600797678; bh=f5HBlmgjNz3J2e1EmpuzWn7tl8jPNjkQlDmEc1IEB1Y=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=groaZUA+qmBF2rUoWrmkRYVpMU0YkBRICplXas67ZSE9T/rX3VSAXlXyWFxX0NfYl
         Hd8EJrp6xfKWCRpGgcXOic5poE0nXuCtiCB+CAQKOVzfHx1hoIGzeVRwFqbAmTfZ54
         JzzM5cSw83VGErCbXpgLmdCqDCJFeiSfwPx5UbfMseX9yfG0PzokPxQ1nUsX2hVfKg
         SWXGaKi1rVmQZ7lvKuZ1jQQOWOPFvySWH+km/nYy0h/HDfLJT6l9EcxkmKavbTjiW4
         8nz+7HPoKQsFO1oCykWfJugPI90CXkfzAsu8wS/qXT65twuVMP5/RAS+ZpiOkFbAoX
         AFBIwS/wbBBxQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 8:17 AM, Peter Xu wrote:
> On Mon, Sep 21, 2020 at 04:53:38PM -0700, John Hubbard wrote:
>> On 9/21/20 2:17 PM, Peter Xu wrote:
>>> (Commit message collected from Jason Gunthorpe)
>>>
>>> Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
>>
>> Not yet, it doesn't. :)  More:
>>
>>> track if the mm_struct has ever been used with pin_user_pages(). mm_structs
>>> that have never been passed to pin_user_pages() cannot have a positive
>>> page_maybe_dma_pinned() by definition. This allows cases that might drive up
>>> the page ref_count to avoid any penalty from handling dma_pinned pages.
>>>
>>> Due to complexities with unpining this trivial version is a permanent sticky
>>> bit, future work will be needed to make this a counter.
>>
>> How about this instead:
>>
>> Subsequent patches intend to reduce the chance of false positives from
>> page_maybe_dma_pinned(), by also considering whether or not a page has
>> even been part of an mm struct that has ever had pin_user_pages*()
>> applied to any of its pages.
>>
>> In order to allow that, provide a boolean value (even though it's not
>> implemented exactly as a boolean type) within the mm struct, that is
>> simply set once and never cleared. This will suffice for an early, rough
>> implementation that fixes a few problems.
>>
>> Future work is planned, to provide a more sophisticated solution, likely
>> involving a counter, and *not* involving something that is set and never
>> cleared.
> 
> This looks good, thanks.  Though I think Jason's version is good too (as long
> as we remove the confusing sentence, that's the one starting with "mm_structs
> that have never been passed... ").  Before I drop Jason's version, I think I'd
> better figure out what's the major thing we missed so that maybe we can add
> another paragraph.  E.g., "future work will be needed to make this a counter"
> already means "involving a counter, and *not* involving something that is set
> and never cleared" to me... Because otherwise it won't be called a counter..
> 

That's just a bit of harmless redundancy, intended to help clarify where this
is going. But if the redundancy isn't actually helping, you could simply
truncate it to the first half of the sentence, like this:

"Future work is planned, to provide a more sophisticated solution, likely
involving a counter."


thanks,
-- 
John Hubbard
NVIDIA
