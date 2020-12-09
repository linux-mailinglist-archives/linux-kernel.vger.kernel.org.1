Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DF2D3FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgLIKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbgLIKMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:12:07 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0635C061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:11:26 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m5so643241pjv.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8yNDgYWASv11UhUw/bWcMz19H0C2yz7qXfuD0bhUn0=;
        b=dmAazBXoyUeAWM3edEVyWfiXKxv66KTgKIwyOz0VOteoRRUk7F3ylzt43TAE3VMM8Q
         1sFsmFSjj63jlXMen3WT9Urn7Q2qLWZlj/66N9zfy28SAr77QjrM/kjt9v6gTeAZ2/2Q
         DxWcZVRg8JuBlOn1nCXBjiwDKXFW2UrRAxKKutGUL0No8NJ0uU46GIErudp/1bpk2YOV
         3iug93DTUMEW2TAmeCsIw3wEhf9IHF6uOKwqCNO1Hpl26TMxv9bmpX9TmdEvCRvUfsXA
         OCgNgwTE8xwzTzA2JxXQOVrq4aT16xBpCrfgLj1GoHU8UovIah/xqh1uMCcQl+Rf6li8
         QDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8yNDgYWASv11UhUw/bWcMz19H0C2yz7qXfuD0bhUn0=;
        b=aWJnCkM+FtV6jmojKMg7tbS60X7TIz7JYHe6BFFUCawroQVVNQHcjnqvB8n2EAw82N
         PY1L9Tyri7Qa+YRUfGmDEBUZKTPvkdrUffwTN0WT70e20e2BAcElnaRMF+MT3X7sSVtJ
         CY3kjwq+lnQhExNbMqlLG7tm7BRbLY0/K9sEraakEnRulVwdpC5h8SR1mGjS3ipGSmxN
         HWyqu8SnpR7c/Pir7WzxctLCVxxrV9PHbSoJncocBNjuOfdUXyDpkqLlmdLBxf0Md2fI
         5XbuxM2JKONEoAOGhrNX0ribZgQiNYGsQUtWMnexyUtHQi1wiUxw7Jf87DEUXDksZGvD
         ZK1w==
X-Gm-Message-State: AOAM533bDi6p9qGM88S5ZWpDZ5CuxMqwMRmzHNDUDjt/BKAzpXPOYm/Y
        pE2cUJhD4nWskYTjPRoBXCQTMoEkVIn4TVBwoBn5vA==
X-Google-Smtp-Source: ABdhPJyZbpmo6sQ/giSzPaUJeLNjnQbqSMGyDjlFlX08gqr+lliLp5PTVbu7rjbOxMBdYCStZdmNjSw4u/bBranfZic=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr1578160pjq.13.1607508686459;
 Wed, 09 Dec 2020 02:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com> <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
In-Reply-To: <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 18:10:50 +0800
Message-ID: <CAMZfGtURKbRingD28boJoZ+MjMTcr7L8mOWPX+hQF9nVLV6S9w@mail.gmail.com>
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

On Wed, Dec 9, 2020 at 6:06 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 11:03, Muchun Song wrote:
> > On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 30.11.20 16:18, Muchun Song wrote:
> >>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> >>> when the size of struct page is a power of two.
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  mm/hugetlb_vmemmap.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>> index 51152e258f39..ad8fc61ea273 100644
> >>> --- a/mm/hugetlb_vmemmap.c
> >>> +++ b/mm/hugetlb_vmemmap.c
> >>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >>>       unsigned int nr_pages = pages_per_huge_page(h);
> >>>       unsigned int vmemmap_pages;
> >>>
> >>> +     if (!is_power_of_2(sizeof(struct page))) {
> >>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
> >>
> >> I'd just drop that pr_info(). Users are able to observe that it's
> >> working (below), so they are able to identify that it's not working as well.
> >
> > The below is just a pr_debug. Do you suggest converting it to pr_info?
>
> Good question. I wonder if users really have to know in most cases.
> Maybe pr_debug() is good enough in environments where we want to debug
> why stuff is not working as expected.

When someone enables this feature via the boot cmdline, maybe he should
want to know whether this feature works. From this point of view, the pr_info
is necessary. Right?

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
