Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203392A3A57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKCCUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:20:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14360 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCCUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:20:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0be810000>; Mon, 02 Nov 2020 18:20:49 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 02:20:45 +0000
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Hugh Dickins" <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1> <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490> <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
Date:   Mon, 2 Nov 2020 18:20:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103004133.GD52235@lx-t490>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604370049; bh=SF/P3v4Ixbk7J/UkHQKXKJ3TSXKjJib+eDyvAh6jsJA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MEzefkt1PnBx1WOH9jrfOAluwkT+KjHfzGPtAXK73U33qCSEyTM5etq70MOzWComl
         MWLFfn4J2IV/4gVS0pOwbN5GPKgfzmbs5JLyGUI0p4J60FrWUN2EvtuOCjztXWXTj4
         WqZR1i/L0M+rZ5HR/80B5fr9f1OxGYdsEzImr4De5PSyGEDF2JdsCvkQE2GPqRDwyY
         wniaN73M/3ZMK2sWHT7MH6Lt+RYdhpJwrfO5SXNUz/mLDtQLh3EM45b/aWYHD8bFYr
         Ed8QroBfBjmp2Fus3sux31I3Z6rABf2qlH4OLiDGZ9FKdcoAXD65rD9otkQgNdo7yE
         dygKXGcWEiCZw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 4:41 PM, Ahmed S. Darwish wrote:
> On Mon, Nov 02, 2020 at 08:25:32PM -0400, Jason Gunthorpe wrote:
>> On Tue, Nov 03, 2020 at 01:17:12AM +0100, Ahmed S. Darwish wrote:
>>
>>> Please stick with the official exported API: raw_write_seqcount_begin().
>>
>> How did you know this was 'offical exported API' ??
>>
> 
> All the official exported seqlock.h APIs are marked with verbose
> kernel-doc annotations on top. The rest are internal...
> 

OK, but no one here was able to deduce that, probably because there is not
enough consistency throughout the kernel to be able to assume such things--even
though your seqlock project is internally consistent. It's just not *quite*
enough communication.

I think if we added the following it would be very nice:

a) Short comments to the "unofficial and internal" routines, identifying them as
such, and

b) Short comments to the "official API for general use", also identifying
those as such.

c) A comment about what makes "raw" actually raw, for seqlock.


Since I'm proposing new work, I'll also offer to help, perhaps by putting together
a small patch to get it kicked off, if you approve of the idea.

thanks,
-- 
John Hubbard
NVIDIA
