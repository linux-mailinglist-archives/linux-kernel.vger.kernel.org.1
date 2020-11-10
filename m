Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD82AD835
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgKJOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:01:32 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:01:32 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so10217981pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw4xoyFdbdHuyEb63lDnIpWG8CFdqBLB9T72UopL8mM=;
        b=KUTCW6u4yJgzk/3g97x8JENk0StNEPh+Ev3Tbja/6QsmlHWhyUmBLM15CC5JCckM4p
         Thg486qv7XBHc73yt3G8SOJLuxaMj6LfKEznKD1HQjgWMEFl5hCZoW6oWkgBmLbzyrlb
         lhdjGAdtXxYfRyYCA/MDASkkV7GE8Bfnw4rfeD0w3VZohQ5l/4krYQejJIVRnjP36ao3
         VBzN2ZY+YVwG9fNU8Ij42g4dtLtGm8hBIzh5EX/VOKuBv/DALtVPZfBPlp/PnY47kjKE
         EIxmHdeZFvVaL+GgwfYOk1aagoY+DfWPfDzotkVBCAgTL/GtvpgvVvviGlSPQMO78L5w
         2Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw4xoyFdbdHuyEb63lDnIpWG8CFdqBLB9T72UopL8mM=;
        b=TMBjyDAXQD4qTXGya3DRUTJePko7zJCMCOA1fgJNW4TKpos5BZZFO0KHaczpDXNrHn
         zPl3+4QNxD0WCoWRFsDoEThrd2xO5/GOU4yE+D72MBufmP0etS5nuD1RpUR8DkENffhq
         gs113chCZrU+jnq0jquVZap9ByKmRE4spLblmLtOXUaCfhRiYPP511zkWKJWFBpfp02R
         F4JyUhk2GgUQlQrQJ7g1/2b0tc/W2xnbHAnb4eYpkz5sctX6XACpgIdOitIDwQSm1cqE
         0mho5Il266VwOc4bID30x9Bj5rVvjiqZEWxnsBPw/OP1xfmctfsPTNiHaSYFzn7AxdcW
         TEUA==
X-Gm-Message-State: AOAM533SxdCZxtWtNpSXnkknD0KL+7D25MM9k4pdbAhcyScenC5otC1p
        0P8AzEzk9mQZdGT08XNPnmTJYnOxfdESSu3ky/eNuw==
X-Google-Smtp-Source: ABdhPJwU5QwCR2xxeNCT+mxLPbRxLxEnLOBux7J6tk0BgWSB9XQhZ9lxcE9XknqXnntajm6hRB/D3w3Tu4YYTa6PF2o=
X-Received: by 2002:a62:e116:0:b029:18b:d325:153f with SMTP id
 q22-20020a62e1160000b029018bd325153fmr13323150pfh.2.1605016892290; Tue, 10
 Nov 2020 06:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-10-songmuchun@bytedance.com> <20201109185138.GD17356@linux>
 <CAMZfGtXpXoQ+zVi2Us__7ghSu_3U7+T3tx-EL+zfa=1Obn=55g@mail.gmail.com>
 <20201110094830.GA25373@linux> <CAMZfGtW0nwhdgwUwwq5SXgEAk3+6cyDfM5n28UerVuAxatwj4g@mail.gmail.com>
 <20201110135210.GA29463@linux>
In-Reply-To: <20201110135210.GA29463@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 22:00:55 +0800
Message-ID: <CAMZfGtU=fhXc0R052hjRRdREShGHv5YUYfuBJpAT0qbwge_FEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 09/21] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 9:52 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Nov 10, 2020 at 06:47:08PM +0800, Muchun Song wrote:
> > > That only refers to gigantic pages, right?
> >
> > Yeah, now it only refers to gigantic pages. Originally, I also wanted to merge
> > vmemmap PTE to PMD for normal 2MB HugeTLB pages. So I introduced
> > those macros(e.g. freed_vmemmap_hpage). For 2MB HugeTLB pages, I
> > haven't found an elegant solution. Hopefully, when you or someone have
> > read all of the patch series, we can come up with an elegant solution to
> > merge PTE.
>
> Well, it is quite a lot of "tricky" code, so it takes some time.
>
> > > > > > +static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > > +{
> > > > > > +     pmd_t *pmd;
> > > > > > +     spinlock_t *ptl;
> > > > > > +     LIST_HEAD(free_pages);
> > > > > > +
> > > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > > +             return;
> > > > > > +
> > > > > > +     pmd = vmemmap_to_pmd(head);
> > > > > > +     ptl = vmemmap_pmd_lock(pmd);
>
> I forgot about this one.
> You might want to check whether vmemmap_to_pmd returns NULL or not.
> If it does means that something went wrong anyways, but still we should handle
> such case (and print a fat warning or something like that).

Yeah, maybe add a BUG_ON or WARN_ON. Do you think which one
would be more suitable?


>
>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
