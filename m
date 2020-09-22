Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92C2736FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgIVABU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:01:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7467 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIVABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:01:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f693e730000>; Mon, 21 Sep 2020 16:59:47 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 00:01:19 +0000
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
From:   John Hubbard <jhubbard@nvidia.com>
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <8bc86452-3a7e-c435-014b-5acc21f591d2@nvidia.com>
Date:   Mon, 21 Sep 2020 17:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600732787; bh=milZW06+puWuXJ7s4e6GxDGScmec4RaKsmWjlEMy2HQ=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Vc3t6sR2NkFygwWMzI8HjNAGrQrTsSHZImME3dRZ1Iip17Dj0+riHdTiIKPb7QhJ2
         nm8hsv/2R3+rFklud1O77an1P6U6LZSIQR+J/Qlyc9+VsPQGOqaG7wBR06umDU3DWw
         xpl3ycYaJJLcNXiUAa9u0VMC7E8cPJg1XNQWHXzXBl/B2c5hOK2xoVpBdFSgrs0fUN
         JlIPdxgbth/N+OvTIWLbdvtIPSeLC1Sqg6RScFaTNh2C/m4NT56Lmx2zYqLZDOUUd5
         PvZ65qLKfEjDOYMsN6s0Mp/I58TSK71FTCqxmxRZNk7O4xGTgX9hVM41Qeec/MIN28
         WqUBgWbwuPe0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 4:53 PM, John Hubbard wrote:
> On 9/21/20 2:17 PM, Peter Xu wrote:
>> (Commit message collected from Jason Gunthorpe)
>>
>> Reduce the chance of false positive from page_maybe_dma_pinned() by keep=
ing
>=20
> Not yet, it doesn't. :)=C2=A0 More:
>=20
>> track if the mm_struct has ever been used with pin_user_pages(). mm_stru=
cts
>> that have never been passed to pin_user_pages() cannot have a positive
>> page_maybe_dma_pinned() by definition. This allows cases that might driv=
e up
>> the page ref_count to avoid any penalty from handling dma_pinned pages.
>>
>> Due to complexities with unpining this trivial version is a permanent st=
icky
>> bit, future work will be needed to make this a counter.
>=20
> How about this instead:
>=20
> Subsequent patches intend to reduce the chance of false positives from
> page_maybe_dma_pinned(), by also considering whether or not a page has
> even been part of an mm struct that has ever had pin_user_pages*()


arggh, correction: please make that:

     "...whether or not a page is part of an mm struct that...".

(Present tense.) Otherwise, people start wondering about the checkered past
of a page's past lives, and it badly distracts from the main point here. :)


thanks,
--=20
John Hubbard
NVIDIA
