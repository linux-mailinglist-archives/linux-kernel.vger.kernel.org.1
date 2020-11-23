Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDA2C0950
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgKWNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388509AbgKWNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:06:02 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F5C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:06:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so5676325pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02jqOVqVG3o3zemslXDICxm50Q80xsNgcwxbt1BQaO8=;
        b=wdtiVdCSXTYkX5Llm07WsCeM2l5OjQx0QT7j6/20KXIXC5Cz4YvF9BaMBeNHFUcdn1
         TJOy7xJAHMWIurkODNbdhsHz13BBKEclsv/THVJRS6rEuPh24SnDOHbJVF8V1SHnqjPp
         oBgoisa5jgquZi4Pxjx5BoLu/ESItCsecVzOIe7Bqh6wa4uWK80WSra2iqTrqBuIk5Qg
         NV+54zyqCwhX2UwU7Wxp34u/na3qlnA6mq5Q7N/NFNzZYnRBvHLec/c8jyb2P0UjGGtn
         aBtLG8nfs00RpR1cK/vy012TRFipmmjbzfqzLiMr2hAijZLJdmuSMW5WhOLELMp3WxUB
         UVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02jqOVqVG3o3zemslXDICxm50Q80xsNgcwxbt1BQaO8=;
        b=nbeDfHqweFzxGz1zytXrwHDOqf2CD/x6Euk4T0r/Lcca27PfHnzZrEabCLK9Ot2Kcz
         ULE5TfCJInhBbdVEDxw4hwJvP9KA8W+vRQujSvGsY0W7I1P08JYIDZqEThpMpzpe8uAn
         gSLUr3FGCb4WPO38OXY2RKgP8ZOXHK2A4f6qpfSCv9KdED6CAP2fcHnsPA1pjDYqQ8aQ
         NdL3nPCPG/CCJvL/ssrYetoe8BOLGwYh8e3ZARJ7dVVQ9UHjI8RDH07Al/2zJR+ZlsDA
         FXrF7io2pdV5sjr5p1J+z70SOTIUScDqo9pcLlY77b94A3Fhy+38S41ZAI1w+SxvcXEG
         J8vw==
X-Gm-Message-State: AOAM532YMdx4UEug5dPaWWMO/hLe6VujiRFT1QegCwGx4fiV7VsrrOJZ
        QdqtC5/A0DfI3CJF8cVDeiJI/hyO2sd8cl3LgNlFMw==
X-Google-Smtp-Source: ABdhPJw3p1FWKUpZ9PGL0u6MoANh2yKcf/YhnTR4E6ftHWfkWBw+A8Y2BLWvYmo51GlR128zahdNafwS/gBghxutmgU=
X-Received: by 2002:a63:ff18:: with SMTP id k24mr26654043pgi.273.1606136761761;
 Mon, 23 Nov 2020 05:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz> <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz> <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz> <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz> <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
 <20201123104258.GJ27488@dhcp22.suse.cz> <20201123124513.GI4327@casper.infradead.org>
In-Reply-To: <20201123124513.GI4327@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 21:05:23 +0800
Message-ID: <CAMZfGtX0XaNNL6eDTnggDdiL5RVywOAYaELv-gJhGadTMMyOBA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 23, 2020 at 11:42:58AM +0100, Michal Hocko wrote:
> > On Mon 23-11-20 18:36:33, Muchun Song wrote:
> > > > No I really mean that pfn_to_page will give you a struct page pointer
> > > > from pages which you release from the vmemmap page tables. Those pages
> > > > might get reused as soon sa they are freed to the page allocator.
> > >
> > > We will remap vmemmap pages 2-7 (virtual addresses) to page
> > > frame 1. And then we free page frame 2-7 to the buddy allocator.
> >
> > And this doesn't really happen in an atomic fashion from the pfn walker
> > POV, right? So it is very well possible that
> >
> > struct page *page = pfn_to_page();
> > // remapping happens here
> > // page content is no longer valid because its backing memory can be
> > // reused for whatever purpose.
>
> pfn_to_page() returns you a virtual address.  That virtual address
> remains a valid pointer to exactly the same contents, it's just that
> the page tables change to point to a different struct page which has
> the same compound_head().

I agree with you.

Hi Michal,

Maybe you need to look at this.

-- 
Yours,
Muchun
