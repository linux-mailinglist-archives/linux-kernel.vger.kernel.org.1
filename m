Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B92DB9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLPDZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLPDZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:25:45 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314BC061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:24:59 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id n3so897841pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 19:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnjH3+59C2HesEkci6o2tYhXJ5O1oMeATLk3gN2lfbg=;
        b=H/9T2Di4Pe5rI0y2nVUFZ3UMm216WYTE9Xf04MP8zhn5RjRWrRdwoQPP1ZdIskjwCa
         0ctDKAtETaY9G7isbgjYkIf5DYftsCeExeXvEWyNO5KUVqgo0FsoVIt5n4206Rh/C1u3
         DqrTfdrwwQoXKUZvKWIIr6CuET9zfMcIsDN9AZv8SvCEG35pGKfGKjWKmZP/pixw/aOG
         if41hwRtBpC4dNX4So5hbysvkAwWwPRHRzK7k2eYLR5LDq2FZmNmf4Gb/fxa/kxDvQ+O
         2ShBjFsGiYuYQU9JDfwPuZ2ZvWwbw1cnSGm5uEKy8+68QBRgPp3z8jjVRV+BB7v3RsIx
         gzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnjH3+59C2HesEkci6o2tYhXJ5O1oMeATLk3gN2lfbg=;
        b=RShtmCOAIL9Iy7LKNMWRpTbFBgWcxd34Uu6kBQzdRzQyOyq7fauTvZdtJtUqwJ1GYX
         xCquo1aqym3SUJrPUE7kCgnlddNBw8iZMkUdZH7avgtwRlxGnTamWRUvpy7HI2aaddil
         zGZXDUgTV1LQbA2A0349DgjEllmaGn1YC6gEFZrAp7ccbPah3ioCM49vP+91OifLfxKI
         pCgk9rrsFZ+0M7CRFS0kdv2YJH9cItP7lf180K2+FSTjCTd4EuSXP+cooik+cPoEOTI7
         asKgGBQrx6cavD/pKQADgwEGpjcjW2/06lQCZVgVGmFoWxfqvQgUvQrz256jHpLoSpdk
         CIBg==
X-Gm-Message-State: AOAM5331VDT/LLeNTXoFKTNS43UO/23VDlPaTHx2T2/tVVrW2bTX73fL
        YODURZ95KALsy0nJVVMkmZe4Pp2nOgTOwMoiXiif8w==
X-Google-Smtp-Source: ABdhPJz0vnVdzRo2r8SFm69RR6xf0plpTm8e0X2u/aZgJ2No7jCV4ESWSR3kVc3lFpAv+GCLKBDYBT07o/8XH1oEPrA=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr3476341pld.20.1608089098795; Tue, 15
 Dec 2020 19:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-3-songmuchun@bytedance.com> <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
In-Reply-To: <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Dec 2020 11:24:22 +0800
Message-ID: <CAMZfGtVdFNdxqvx7HL1CSQ55M7ry3QsyDRHzPStuuX-ibkmdjQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 02/11] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 9:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/13/20 7:45 AM, Muchun Song wrote:
> > The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > whether to enable the feature of freeing unused vmemmap associated with
> > HugeTLB pages. And this is just for dependency check. Now only support
> > x86-64.
> >
> > Because this config depends on HAVE_BOOTMEM_INFO_NODE. And the function
> > of the register_page_bootmem_info() is aimed to register bootmem info.
> > So we should register bootmem info when this config is enabled.
>
> Suggested commit message rewording?
>
> The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing of
> unnecessary vmemmap associated with HugeTLB pages.  The config option is
> introduced early so that supporting code can be written to depend on the
> option.  The initial version of the code only provides support for x86-64.
>
> Like other code which frees vmemmap, this config option depends on
> HAVE_BOOTMEM_INFO_NODE.  The routine register_page_bootmem_info() is used
> to register bootmem info.  Therefore, make sure register_page_bootmem_info
> is enabled if HUGETLB_PAGE_FREE_VMEMMAP is defined.

Thank Mike. Will update.

>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/mm/init_64.c |  2 +-
> >  fs/Kconfig            | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 0a45f062826e..0435bee2e172 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >
> >  static void __init register_page_bootmem_info(void)
> >  {
> > -#ifdef CONFIG_NUMA
> > +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >       int i;
> >
> >       for_each_online_node(i)
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 976e8b9033c4..4c3a9c614983 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -245,6 +245,21 @@ config HUGETLBFS
> >  config HUGETLB_PAGE
> >       def_bool HUGETLBFS
> >
> > +config HUGETLB_PAGE_FREE_VMEMMAP
> > +     def_bool HUGETLB_PAGE
> > +     depends on X86_64
> > +     depends on SPARSEMEM_VMEMMAP
> > +     depends on HAVE_BOOTMEM_INFO_NODE
> > +     help
> > +       When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> > +       memory from pre-allocated HugeTLB pages when they are not used.
> > +       6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
> > +       pages per HugeTLB page of the pud level mapping.
> > +
> > +       When the pages are going to be used or freed up, the vmemmap array
> > +       representing that range needs to be remapped again and the pages
> > +       we discarded earlier need to be rellocated again.
>
> I see the previous discussion with David about wording here.  How about
> leaving the functionality description general, and provide a specific
> example for x86_64?  As mentioned we can always update when new arch support
> is added.  Suggested text?

Good suggestion. Thanks.

>
>         The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
>         some vmemmap pages associated with pre-allocated HugeTLB pages.
>         For example, on X86_64 6 vmemmap pages of size 4KB each can be
>         saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
>         each can be saved for each 1GB HugeTLB page.
>
>         When a HugeTLB page is allocated or freed, the vmemmap array
>         representing the range associated with the page will need to be
>         remapped.  When a page is allocated, vmemmap pages are freed
>         after remapping.  When a page is freed, previously discarded
>         vmemmap pages must be allocated before before remapping.
>
> --
> Mike Kravetz
>
> > +
> >  config MEMFD_CREATE
> >       def_bool TMPFS || HUGETLBFS
> >
> >



-- 
Yours,
Muchun
