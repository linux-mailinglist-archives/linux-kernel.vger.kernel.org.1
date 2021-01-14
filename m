Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5D2F6185
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbhANNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbhANNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:06:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C504C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:05:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n25so3762766pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otxZaMxXrqXQ+HB6nBjrd36W75JtcSkls6JE059kKq8=;
        b=Y5wdk5Z+2zXharmJBzMfvHlw+DCQOtiGesEKv/ljgEMRr2bZnbpYpeN5Rc6nkzBSU7
         6GZaLZNf2+smELPyQ7e1VoARGBuINS5W3oUPrtBX3hmlAxujkz6OCS92eRfWqs8YR7cy
         SyIyelX801SjXYu3JKgZT72YIOJP8SANg6sSD8lt7xGj+VRtWODdLPAmAaofjvpLHQgi
         k7Fw7ZRWx8UOFc+lFuD4W6OhkoVyRMiwgORb5OSsnkjwmHOCfQpmzYUHG2WdxIqVeZ1k
         p5KFqGx34Rk9jsS+lk6PDzPCsRug5oPCXF5v/nfS/Bwd2xy8CiIrNOhyZcYR0HC6uE9e
         /y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otxZaMxXrqXQ+HB6nBjrd36W75JtcSkls6JE059kKq8=;
        b=lSLJ6ZE4YN7wYh/WhgQpw4cjMTlYU+owdMEhZ1SfCqLd9h5dS5fr24oq6Y6yhWatWH
         gDtHCuzpblNvS2QP3/y6ckAcUiW2ceeQb0F2D8Gg4cxYxT7juZ0EaiIC0wUG91EADlTc
         3gMqQLXlNYtnafidmjqjbLbtBq8hIPzYHo4qNhW25WKLC/nQXnIgsCiW97fb/o6BS8I5
         UJ0K08bp3yGF+UVjMngKRBiR/ZYv3vNgvlrHHsLHOyM51TpA0ahI4kSHdCPvfOz2dAmR
         DpAfu6ixiF5wcEM7LW/Werfz/SG9XCfoQ9SQAgim4Xz/auOkIsEraQ2NNJ+ApII8B+0O
         ZkXQ==
X-Gm-Message-State: AOAM531m76yNZPc0bJrTSBgG5R/aVyPObExD1en2wu1ZxjteD09Q3vPl
        PPDepreWtcvvqeKzl44xxq3p8r9c/GYNdg08CfOMig==
X-Google-Smtp-Source: ABdhPJzXR6KWx5reUzFIFz1GMOxEjEoANCQaSp+5a9EX5pYZyQ4qs0zpJRJh7vxaZ4eM6E2Q8vb99n3CxNo6z+THTLU=
X-Received: by 2002:a63:480f:: with SMTP id v15mr7419423pga.341.1610629545074;
 Thu, 14 Jan 2021 05:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com> <20210112080453.GA10895@linux>
 <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
 <20210113092028.GB24816@linux> <a9baf18c-22c7-4946-9778-678f6bc808dc@oracle.com>
 <CAMZfGtUhhMDCaZKeayS1+w0MvBijDZC2AiUV4z5rUFrfbXBefw@mail.gmail.com> <20210114115248.GA24592@localhost.localdomain>
In-Reply-To: <20210114115248.GA24592@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 14 Jan 2021 21:05:06 +0800
Message-ID: <CAMZfGtXksc0Ugasqn4czpwHunsGR5nfxVO_iLsrLrnYMsgieYw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 7:52 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Jan 14, 2021 at 06:54:30PM +0800, Muchun Song wrote:
> > I think this approach may be only suitable for generic huge page only.
> > So we can implement it only for huge page.
> >
> > Hi Oscar,
> >
> > What's your opinion about this?
>
> I tried something like:
>
> static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>                               unsigned long end,
>                               struct vmemmap_remap_walk *walk)
> {
>         pte_t *pte;
>
>         pte = pte_offset_kernel(pmd, addr);
>
>         if (!walk->reuse_page) {
>                 BUG_ON(pte_none(*pte));
>
>                 walk->reuse_page = pte_page(*pte++);
>                 addr = walk->remap_start;
>         }
>
>         for (; addr != end; addr += PAGE_SIZE, pte++) {
>                 BUG_ON(pte_none(*pte));
>
>                 walk->remap_pte(pte, addr, walk);
>         }
> }
>
> void vmemmap_remap_free(unsigned long start, unsigned long end,
>                         unsigned long reuse)
> {
>         LIST_HEAD(vmemmap_pages);
>         struct vmemmap_remap_walk walk = {
>                 .remap_pte      = vmemmap_remap_pte,
>                 .reuse_addr     = reuse,
>                 .remap_start = start,
>                 .vmemmap_pages  = &vmemmap_pages,
>         };
>
>         BUG_ON(start != reuse + PAGE_SIZE);
>
>         vmemmap_remap_range(reuse, end, &walk);
>         free_vmemmap_page_list(&vmemmap_pages);
> }
>
> but it might overcomplicate things and I am not sure it is any better.
> So I am fine with keeping it as is.
> Should another user come in the future, we can always revisit.
> Maybe just add a little comment in vmemmap_pte_range(), explaining while we
> are "+= PAGE_SIZE" for address and I would like to see a comment in
> vmemmap_remap_free why the BUG_ON and more important what it is checking.

OK, I will add some comments to explain why we do this in
vmemmap_remap_free and vmemmap_remap_free. Thanks.

>
> --
> Oscar Salvador
> SUSE L3
