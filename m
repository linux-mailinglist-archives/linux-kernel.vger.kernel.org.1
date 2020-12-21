Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7982DFB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLULIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgLULIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:08:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22078C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:07:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z12so5977633pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOlZCOLM2fiX9IZHU6rHTKDZB2KqCTIIheGSQkZLkzk=;
        b=keW0J8Q4lXZv+SIUf1De3T7sb3p2+MR0Lv0chpM09bx0Nf5BD8D5xSd/IAc7+zxacC
         TWPoC21wd4gx+W52iqF52xIef/afr+jhVsi7ICGWneMOi4bju/knXoiROvRkFBMcggys
         gkA4Ik1i+mImdXy06ZzmVZofmSfej86CBElBp5x9DGRYfeQd4HWCLFRlbaKjaowPGAsJ
         IVkAjGPr4+BIpMFGmzi2+qnWEg3k/aB5NkTtneAyxaWGJsaxzm+lfSEVxypucCTxG0Lf
         p3NLvydg4KDMuXdIT3HZUgFFg5XlzjgZy5lcvJZS07IWPc3vUWStqiexCXRwm73UpQh6
         Onmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOlZCOLM2fiX9IZHU6rHTKDZB2KqCTIIheGSQkZLkzk=;
        b=BeuYuTHyr9LU0pAXTyXoLSOmWHKAQ5L8hkgi4W1GSStSq99A306Pp3/RLER+SmuuEw
         +Chq3AsQUmjH+TmuedxLEUWGFveHP1jOcSc8SmGJgsgc8uL8Nst//Dq1BvTHgL225zPt
         v4zNTKf3vxYsYM59E26fSIiA4p42ny1klgYynTb0SM+TcF/aNYHLh7fXafRt842Gp+fQ
         rzj8AUF3naSNx0zhSs1XbH0QSVNWoGOdNQEWK4nkgL3W2w98/4cyxoWzMtg+0oEdewm1
         wpPId4y95Kbl/7HfsCp/ruDq2rhYRwxmRw0SirEn+jqMwd+jaAI3xSY6ILE+hd71edgK
         dy3w==
X-Gm-Message-State: AOAM532QO4L9OY5y5nRwAlac1v4RSF5s2GkKalkHHpbBSvyxnc9r+9ry
        R+wJbruRfufpLNSc3CTvsWOzOhTxpV2cx13zw17nnQ==
X-Google-Smtp-Source: ABdhPJwoJStF1A669nR7sEzwHJAQg6sembIt+S/xmXLOZRFLjO1my0AFoe54teplQtqVoxYW3ICQo1YTApqa6dAcBYs=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr15600526plb.34.1608548876589; Mon, 21
 Dec 2020 03:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-5-songmuchun@bytedance.com> <20201221102703.GA15804@linux>
In-Reply-To: <20201221102703.GA15804@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 19:07:18 +0800
Message-ID: <CAMZfGtW0jzNchLqieAudyk4TsaAUtYEdoC=j+gkkVLJBaKg3pA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 04/11] mm/hugetlb: Defer freeing of
 HugeTLB pages
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
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 6:27 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:12:56PM +0800, Muchun Song wrote:
> > In the subsequent patch, we will allocate the vmemmap pages when free
> > HugeTLB pages. But update_and_free_page() is called from a non-task
> > context(and hold hugetlb_lock), so we can defer the actual freeing in
> > a workqueue to prevent from using GFP_ATOMIC to allocate the vmemmap
> > pages.
>
> I think we would benefit from a more complete changelog, at least I had
> to stare at the code for a while in order to grasp what are we trying
> to do and the reasons behind.

OK. Will do.

>
> > +static void __free_hugepage(struct hstate *h, struct page *page);
> > +
> > +/*
> > + * As update_and_free_page() is be called from a non-task context(and hold
> > + * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
> > + * use GFP_ATOMIC to allocate a lot of vmemmap pages.
>
> The above implies that update_and_free_page() is __always__ called from a
> non-task context, but that is not always the case?

IIUC, here is always the case.

>
> > +static void update_hpage_vmemmap_workfn(struct work_struct *work)
> >  {
> > -     int i;
> > +     struct llist_node *node;
> > +     struct page *page;
> >
> > +     node = llist_del_all(&hpage_update_freelist);
> > +
> > +     while (node) {
> > +             page = container_of((struct address_space **)node,
> > +                                  struct page, mapping);
> > +             node = node->next;
> > +             page->mapping = NULL;
> > +             __free_hugepage(page_hstate(page), page);
> > +
> > +             cond_resched();
> > +     }
> > +}
> > +static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
>
> I wonder if this should be moved to hugetlb_vmemmap.c

Maybe I can do a try.

>
> > +/*
> > + * This is where the call to allocate vmemmmap pages will be inserted.
> > + */
>
> I think this should go in the changelog.

OK. Will do.

>
> > +static void __free_hugepage(struct hstate *h, struct page *page)
> > +{
> > +     int i;
> > +
> >       for (i = 0; i < pages_per_huge_page(h); i++) {
> >               page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> >                               1 << PG_referenced | 1 << PG_dirty |
> > @@ -1313,13 +1377,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >       set_page_refcounted(page);
> >       if (hstate_is_gigantic(h)) {
> >               /*
> > -              * Temporarily drop the hugetlb_lock, because
> > -              * we might block in free_gigantic_page().
> > +              * Temporarily drop the hugetlb_lock only when this type of
> > +              * HugeTLB page does not support vmemmap optimization (which
> > +              * context do not hold the hugetlb_lock), because we might
> > +              * block in free_gigantic_page().
>
> "
>  /*
>   * Temporarily drop the hugetlb_lock, because we might block
>   * in free_gigantic_page(). Only drop it in case the vmemmap
>   * optimization is disabled, since that context does not hold
>   * the lock.
>   */
> " ?

Thanks a lot.

>
>
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
