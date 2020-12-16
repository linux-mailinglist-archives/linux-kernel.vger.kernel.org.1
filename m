Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4402DC222
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLPO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgLPO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:27:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C6C0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:26:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h186so6223811pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WM83lb97KepD4KmRISVDaNGwvKB/0GjjAaBayPIvpU=;
        b=S1E/ZV+vN0Og3JgNA5Cn2YIKeoGnmvTCR7g1K0s9BmGYSWT9bm3Lo/7FoFkWMma1K2
         1Z7WoG9TeNLxGvdJ1Iw+HNp4UlLHALLxVbgxXqTlAOKgFDkSDixhtHp387OBGRFtX2bb
         qAELSHEsUPqfmYUfnbrFyhBI9eFf0yZnVV5dnhvSiGIdPg14xVilijefMZDs11Mqq22X
         QGu/9UFgiA1GFT56dAQcleW+3L1Dkpc76FVUYGF/S8DqTYKO0uA3ouwbO/2sOakTjxHe
         yKX6FwYGPjvf5W+xuYPNCni/vKCLYAuvDTAL16QWeWaHr+aNaAn0JCo8/rtxkasVGt59
         RsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WM83lb97KepD4KmRISVDaNGwvKB/0GjjAaBayPIvpU=;
        b=gyfEm+ThK4oJEupK7K8a6CPB74jx+N0Y3SC1CIOwkPDuBV2PSZWdgl1grU8YE8pDJ6
         pfjOYRrJPdqjF5M6Q6YQhv4mEXmINgFpINXZpR4iTXbLUSiAnJIveDLVqX0dQrOkWY+6
         +dHX/oXQ9Cx4MU4pUW9D+ouF5pksXUlAFyXnd28gzhm1yxqf0I1P2WDbVd/NY3TNAEAl
         Y4Y5YSKqlubNv+9B22ke++FMXD8UmqrsLEcKG/D5FNchA2H61iCdVpTeIeeX3Khnoy/A
         oay6beMkBXGrVdLs1S5m6gxWDD0mxD8okVg/GwjUHA0nJWl7jJIsjAuVquvAlh7EZbOj
         QS2g==
X-Gm-Message-State: AOAM533eoMB6sqz+rUTrEX83hWyvX2DZ0lhE/s9VgUoEajtwcDuJbrEV
        AqjMkx1IiMcjRNsN6hm02ay7ghSaN5TA2aGYwRRUow==
X-Google-Smtp-Source: ABdhPJwce9/AVHptfdglalHmeS/eT0gVNrSN7cUYjB3PIyYd9xeIxzY1Ah23S9+RjgyIKSmckj4+gU1OpZezBIOgxmI=
X-Received: by 2002:a63:50a:: with SMTP id 10mr5249784pgf.273.1608128802894;
 Wed, 16 Dec 2020 06:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-11-songmuchun@bytedance.com> <20201216140340.GE29394@linux>
In-Reply-To: <20201216140340.GE29394@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Dec 2020 22:26:02 +0800
Message-ID: <CAMZfGtVq29N1Rysy+BL1N7dYW_3X3uCKG=mAXXZbsJw_nt=aBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 10/11] mm/hugetlb: Gather discrete
 indexes of tail page
To:     Oscar Salvador <osalvador@suse.de>
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

On Wed, Dec 16, 2020 at 10:03 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Dec 13, 2020 at 11:45:33PM +0800, Muchun Song wrote:
> > For HugeTLB page, there are more metadata to save in the struct page.
> > But the head struct page cannot meet our needs, so we have to abuse
> > other tail struct page to store the metadata. In order to avoid
> > conflicts caused by subsequent use of more tail struct pages, we can
> > gather these discrete indexes of tail struct page. In this case, it
> > will be easier to add a new tail page index later.
> >
> > There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> > page structs can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so
> "that can be..."

Thanks.

>
> > add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> I think this makes the current situation with metadata usage in sub-pages
> easier to track.

Agree.

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thank you.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
