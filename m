Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBED426BA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIPCuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIPCup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:50:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:50:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so3115806pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYR6CHS6loRJIABEz9ABQj6kDf1KJv7YPUTb24cE/XM=;
        b=YrwVuyB3J14Kg5MaZPFURBAiJ9SLI/oCjAErvxvEXtQvdFjO04L47g+34E2LsWWx8Q
         nEeA4AU+ZgL6w2ohWBqDyb2aqil/Xlo+IHq4Db3M4A6VyPStuMfEWUN8xpQDFl9TLzx5
         Q5ULWT4J677jlVOTA7M1LRJIjIH5HcYjy7cbNsS0k4B0s97gKqd6HTZoXlAQo+yBugdf
         g5Hv3dqG5cDkra6hpNTYs7l+pkuVtfkIyuGGZAIkETOJCJn65JnUSZoRoG3VZhz2uqYZ
         khhOVY4T5gI17rK0pcJbyfL3MeVAloctAXs6pfBR0W5Qme7J5A7UGs38WOVVLfdatWFK
         /euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYR6CHS6loRJIABEz9ABQj6kDf1KJv7YPUTb24cE/XM=;
        b=Oz7UEumlRPWXVRA8uzhP7BWuN27bVV52ayMUq4Cppgjbonsk7oAmlhyTnjHXMN16h1
         r3PoVVkkI/SR3aD8BODLEaYT+SQ7hN0Dy8iVmbRV0o57g1ZFAshTZ1jNOgUfU9imaIfV
         XT/Btd7+cFI0mbP24wFbhvl37fRtOBcLYLBnglwDP8oNJvHjgVp9AfPsuh7OKHHmKLix
         pk126Xx+1cyn3hV2ACVySnIc3C+gfOkNsMll2hm79+LvwhgsmsBMmQIy2CCzoOosV48b
         0O5HjqUZjiGHHaj59w1WbLY9Y5FYp9fMdwMO5M5/OOk02vwYIRKcfuYMK+AW0QuhL7+s
         7H7A==
X-Gm-Message-State: AOAM531UVJXtJfAseh2OL7PX8m1c7eDGBYVPs57TNYB0LIjrPRGI+BZH
        ALRhssztfEl7Exrf3OvdWij8gxoNWyRxLN7ia2qDwA==
X-Google-Smtp-Source: ABdhPJygo3+e9hvtqwXsVCKyySEwLTSAnydXpah+5F2oEsgg2BEaQIApV2SHB5qDQ+ck1wJ3d7xM0nJevDNWIZPJjVk=
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr4441184pfm.59.1600224644849; Tue, 15 Sep
 2020 19:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-21-songmuchun@bytedance.com> <defc8d4f-b143-d4ae-f609-fd22624aafc3@infradead.org>
In-Reply-To: <defc8d4f-b143-d4ae-f609-fd22624aafc3@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 10:50:08 +0800
Message-ID: <CAMZfGtVv_8GR7c4syah8PNH6FBS8H7FQesBYr_qQRQaUEgZbsQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 20/24] mm/hugetlb: Add a kernel
 parameter hugetlb_free_vmemmap
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:11 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
> Please see comments below.
>
> On 9/15/20 5:59 AM, Muchun Song wrote:
> > Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  9 ++++++++
> >  Documentation/admin-guide/mm/hugetlbpage.rst  |  3 +++
> >  mm/hugetlb.c                                  | 23 +++++++++++++++++++
> >  3 files changed, 35 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 5debfe238027..69d18ef6f66b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1551,6 +1551,15 @@
> >                       Documentation/admin-guide/mm/hugetlbpage.rst.
> >                       Format: size[KMG]
> >
> > +     hugetlb_free_vmemmap=
> > +                     [KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> > +                     this disables freeing unused vmemmap pages associated
>
>                         this controls
>
> > +                     each HugeTLB page.
>
>                         with each HugeTLB page.
>
> > +                     Format: { on (default) | off }
> > +
> > +                     on:  enable the feature
> > +                     off: dosable the feature
>
>                              disable
>
> > +
> >       hung_task_panic=
> >                       [KNL] Should the hung task detector generate panics.
> >                       Format: 0 | 1
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..7d6129ee97dd 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -145,6 +145,9 @@ default_hugepagesz
> >
> >       will all result in 256 2M huge pages being allocated.  Valid default
> >       huge page size is architecture dependent.
>
> insert blank line here.
>
> > +hugetlb_free_vmemmap
> > +     When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
> > +     unused vmemmap pages associated each HugeTLB page.
> >
> >  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
> >  indicates the current number of pre-allocated huge pages of the default size.
>

Thanks for your comments.

>
> --
> ~Randy
>


-- 
Yours,
Muchun
