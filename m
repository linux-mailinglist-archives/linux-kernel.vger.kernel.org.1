Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C542BA7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgKTKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKTKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:43:30 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F263C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:43:29 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so7465716pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQuIBxgF3nInKkS93utHCBrC42W7hV1R/eZWClqzWyY=;
        b=jiRnb2Vun3WvAKHS2DVxvEth9FjyVS5SogsErgiDU4+Q6Nsl1EGkcY74MuYVE4cdHt
         4UkhpyFGRkFL0rkcjKRRhqb2HrxSRT3UyE6BJJ/QTpKI9yRuYogR7MAQQlXKOxcrBILc
         xWvHgkwZgKZpJOiX0hqQ+dfqZOfNS2i0tGSUzlQ8eYltW413589oOzimfkKRfZRgXZbu
         ovGqzcvtMNNluYeI3x1gx4YA/2VWUdbmVMGdr3n6B6s7XvGbTV1t+yezpa9kCTest+gj
         TWKYtrUPbumihdKMfV1amAuikbAsIGwbTvMzjI1aY+Ua669lZKvVfq1+kUqq+xOYAMvx
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQuIBxgF3nInKkS93utHCBrC42W7hV1R/eZWClqzWyY=;
        b=KuxPsekVeVT6RD/2G4T3q3RwGCkWPnNgsTduVE5xDNEQE+/BZoHjNVGaStJ/sURZql
         oVCJe9JYXSEgxiYLPTS+Rup4NuWEopyYfoAXDOTaa34aHDY1UwAzI7kXXCHK9wR1rOfH
         N6kQvg7zdmg3MS5e/X/iSRFfi1LsdPo84tVaXaHUu55KtOZ1gB8sKC2QjoaLKG9VHtvO
         AbQEBB2QBz/Qon461CoZjYVnCXU0AwS8ELg97ElmFJDwzJWvXgX4T/sRZAASNG/9w9fY
         +/LUJlE4yNtheOGg5RS4xWjfZwn15UnopMb7TGRKhYg30iG9G+ToJxM018zMU51DpgeC
         sMgg==
X-Gm-Message-State: AOAM533u9lvo+d6/9eXJ/Jcz+QOcWi4IOcxmoUKKGxhJ2m/67saTCVpm
        Gnw7E6bKccwNafsfjbjSf9AR582USxMBLmlAacwjTw==
X-Google-Smtp-Source: ABdhPJzU2lJHp8cWhl4H5eA0FRp40MwByTZiz8vUxJJfLjqWf4fU0UXLqt245oSkK/Dg28Trz55Pdn020p1OgPAU5sw=
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr16046991pgh.31.1605869009142;
 Fri, 20 Nov 2020 02:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com> <dc77d433-b5f0-0f4a-a4e9-f888b079618a@redhat.com>
In-Reply-To: <dc77d433-b5f0-0f4a-a4e9-f888b079618a@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 18:42:46 +0800
Message-ID: <CAMZfGtXEf01XeLhTS5_EuTTWYKKj8DzUzCQJ=zXB_3VGB3MMDw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing
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

On Fri, Nov 20, 2020 at 5:16 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.11.20 07:43, Muchun Song wrote:
> > We only can free the unused vmemmap to the buddy system when the
> > size of struct page is a power of two.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index c3b3fc041903..7bb749a3eea2 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -671,7 +671,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       unsigned int order = huge_page_order(h);
> >       unsigned int vmemmap_pages;
> >
> > -     if (hugetlb_free_vmemmap_disabled) {
> > +     if (hugetlb_free_vmemmap_disabled ||
> > +         !is_power_of_2(sizeof(struct page))) {
> >               pr_info("disable free vmemmap pages for %s\n", h->name);
> >               return;
> >       }
> >
>
> This patch should be merged into the original patch that introduced
> vmemmap freeing.

Oh, yeah. Will do.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
