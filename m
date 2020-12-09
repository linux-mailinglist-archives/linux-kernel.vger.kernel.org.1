Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193E62D45D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgLIPwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgLIPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:52:15 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78BC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:51:35 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so1415186pgi.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LZhGST1GCxC0x+dge/6O0xwr4iPxq7vR6B3gDXWbaY=;
        b=TepoJq8ZxONsJtMIn6sV/S8fsWzxKVCUoerGn+0I6mFkm5HVZNIMAYNO+3zIUhLRq+
         gIquAEoIULX5PQyVi8eVg73fQax0Cu05O2gLpE1i7tGThxb6wP1cCrCmY7gkuy24SVCm
         w8SuZlGlCo+JVqrULBOWNKCkfwmhz5n2NBEyfJb/sjyZ+70HA+bn9xi4I8X0jUmzNyly
         bnb2zGjKh6JHEdjYoQPSR721WutrvYUKF0NFgma3uclwa6wPLyHej7DktmkDZQ4YsgQY
         VIbf6uuabOVmkfN4qwMxLu5F/AwnoRMqIVmL33LCj/c7Ae4LZovpR2+b5oEQSIrXURhj
         L8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LZhGST1GCxC0x+dge/6O0xwr4iPxq7vR6B3gDXWbaY=;
        b=kKvfGhkkMy15xBo4h8wciIuqdZyXmJBusj/GiawkC35Kh4WKppgl+6O5oZIDIRiwdC
         BTvmaO1ppMwDBjfQHGopE1J0atx5JPtwAz7nMkRUTa4hv7E1VTJHaNoDplHde+WdLvLZ
         HvsWLv44ZvLuv7jZlU+Fo3mQiGbyNX46NzweBGWFGgU2FGXj2bfTDOuyEe2p5lJO2O8M
         drw99N7xWCMQXPqf97ncyyPoXnzijigb/NaJchHPEOtJVJVIjHp0wOVfDUk0hM/ZeOZL
         3cUxFIFaEp+64NhJLfgwx5WvzwXJZGtX/v0rMeHehAgHkdZQ2lq4dpen4idJVXyHDx0K
         3GGw==
X-Gm-Message-State: AOAM530/8yHc0jwK0g9EKCo0T0nyMynU/8BBlz1jVE6JWTMTLeZQrwVM
        p9y32gSrDUbEUe+1NGjJ+ElJPCl3OsfZNm33mAnpig==
X-Google-Smtp-Source: ABdhPJzjuEOybsjABCGyo7OEYfRyelLQEgnUPKXjPCn1BIBWRyGfHkwLg5OS7NCcIZzz6sMyj3H7XziomX6ZNhzeE6o=
X-Received: by 2002:a63:c15:: with SMTP id b21mr2461280pgl.341.1607529095084;
 Wed, 09 Dec 2020 07:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com>
 <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com> <a6d11bc6-033d-3a0b-94ce-cbd556120b6d@redhat.com>
 <CAMZfGtWfz8DcwKBLdf3j0x9Dt6ZvOd+MvjX6yXrAoKDeXxW95w@mail.gmail.com> <33779de1-7a7a-aa5c-e756-92925d4b097d@redhat.com>
In-Reply-To: <33779de1-7a7a-aa5c-e756-92925d4b097d@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 23:50:58 +0800
Message-ID: <CAMZfGtX=BBOmj4c9FiL7u6DMJ8dd=FMHBvFMsjSFOH6TwNCHMQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:48 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 16:13, Muchun Song wrote:
> > On Wed, Dec 9, 2020 at 6:10 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 09.12.20 11:06, David Hildenbrand wrote:
> >>> On 09.12.20 11:03, Muchun Song wrote:
> >>>> On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>>
> >>>>> On 30.11.20 16:18, Muchun Song wrote:
> >>>>>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> >>>>>> when the size of struct page is a power of two.
> >>>>>>
> >>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>>>> ---
> >>>>>>  mm/hugetlb_vmemmap.c | 5 +++++
> >>>>>>  1 file changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>>>>> index 51152e258f39..ad8fc61ea273 100644
> >>>>>> --- a/mm/hugetlb_vmemmap.c
> >>>>>> +++ b/mm/hugetlb_vmemmap.c
> >>>>>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >>>>>>       unsigned int nr_pages = pages_per_huge_page(h);
> >>>>>>       unsigned int vmemmap_pages;
> >>>>>>
> >>>>>> +     if (!is_power_of_2(sizeof(struct page))) {
> >>>>>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
> >>>>>
> >>>>> I'd just drop that pr_info(). Users are able to observe that it's
> >>>>> working (below), so they are able to identify that it's not working as well.
> >>>>
> >>>> The below is just a pr_debug. Do you suggest converting it to pr_info?
> >>>
> >>> Good question. I wonder if users really have to know in most cases.
> >>> Maybe pr_debug() is good enough in environments where we want to debug
> >>> why stuff is not working as expected.
> >>>
> >>
> >> Oh, another thought, can we glue availability of
> >> HUGETLB_PAGE_FREE_VMEMMAP (or a new define based on the config and the
> >> size of a stuct page) to the size of struct page somehow?
> >>
> >> I mean, it's known at compile time that this will never work.
> >
> > I want to define a macro which indicates the size of the
> > struct page. There is place (kernel/bounds.c) where can
> > do similar things. When I added the following code in
> > that file.
> >
> >         DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
> >
> > Then the compiler will output a message like:
> >
>
> Hm, from what I understand you cannot use sizeof() in #if etc. So it
> might not be possible after all. At least the compiler should optimize
> code like
>
> if (!is_power_of_2(sizeof(struct page))) {
>         // either this
> } else {
>         // or that
> }
>
> that can never be reached

Got it. Thanks so much.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
