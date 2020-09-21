Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB6273596
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgIUWS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:18:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17645 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:18:28 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6926860004>; Mon, 21 Sep 2020 15:17:42 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 22:18:28 +0000
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
To:     Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <07bc5f59-74ae-73e8-2616-f11712c27b58@nvidia.com>
Date:   Mon, 21 Sep 2020 15:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3frkqQNHbE5bEB6rwYdbyoAA3B9FQZo=HKkUzWCM4H0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600726662; bh=yvFjZz5H7WJdvFOL+iOamQqOLsJG+P+1YgKrthibJWM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Jlbe/oAIF+Kj+XdyMgOu1fzzwVqxzP6YSa+FhzI/LeRGryj6jbi5EsnFIF4MozCJz
         ZEpfKqKXugxSAEnkwrn9rUu6wuAH18JrTIm3IjCdCIFTn92m+3D9HIoaUVGxFz3fhk
         VkN/mvruLCKBcMYTMFXwWwF1TxacefRBANYRCfx9OZn8B/qabtAsMTpUKUAWc45FOA
         4Ev8zS0pDd2K9wLkbXz2dDY95GhjmVqVMCp5+Q/6bfLv7du9Hle7kp55hSpvvAlFxH
         vYyHTKupTIqLqykWwBlfdZbkxJM6QMWqJczZ5Lv27mV3+/723UySFDJ82T131Q1hhh
         RZRxTGS6Dn4zw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:55 PM, Jann Horn wrote:
> On Mon, Sep 21, 2020 at 11:20 PM Peter Xu <peterx@redhat.com> wrote:
...
> I dislike the whole pin_user_pages() concept because (as far as I
> understand) it fundamentally tries to fix a problem in the subset of
> cases that are more likely to occur in practice (long-term pins
> overlapping with things like writeback), and ignores the rarer cases
> ("short-term" GUP).
> 

Well, no, that's not really fair. pin_user_pages() provides a key
prerequisite to fixing *all* of the bugs in that area, not just a
subset. The 5 cases in Documentation/core-api/pin_user_pages.rst cover
this pretty well. Or if they don't, let me know and I'll have another
pass at it.

The case for a "pin count" that is (logically) separate from a
page->_refcount is real, and it fixes real problems. An elevated
refcount can be caused by a lot of things, but it can normally be waited
for and/or retried. The FOLL_PIN pages cannot.

Of course, a valid remaining criticism of the situation is, "why not
just *always* mark any of these pages as "dma-pinned"? In other words,
why even have a separate gup/pup API? And in fact, perhaps eventually
we'll just get rid of the get_user_pages*() side of it. But the pin
count will need to remain, in order to discern between DMA pins and
temporary refcount boosts.

thanks,
-- 
John Hubbard
NVIDIA
