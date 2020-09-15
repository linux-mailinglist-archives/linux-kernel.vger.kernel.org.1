Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63B326AB25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgIORwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgIORd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:33:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E6C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r19so1711276pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8l6c/TjWYQRiXwPIxqfhPqbNDCVlwzZu6ART7sGA8U=;
        b=wJA7qJJabH1MtZuv73Nto4ArpYL8bpMpf3xBzAkp/k8HKbnVO+qNgBxVpGr0Fz0Ggd
         KUH/bdakO5dHORUiBJWUEiCC3O57yGwfrShO2YsEYl8X8n7zw4Tx3s+Cd5uEnn03KBrx
         iW+qRGl4cXUKUBcnQ3rqhtGNr7wgb44cq83D4pqDmM31tCIBVppOTUNzZ0uRaUuWN+Yd
         UvkfdyVoGzjnJ5jnEHZulu8IBOnYzM0iIZoCSFxiftDvpraX/xRihGAzgEbajBkm1CAo
         ZG+nTnkW1iTOo8PBTTwFv/WO0iuy9ZWcRS6qv6eUtgmLjjAJnAy5zwyE8a4nYq6ANJD/
         +4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8l6c/TjWYQRiXwPIxqfhPqbNDCVlwzZu6ART7sGA8U=;
        b=JzExK6Ir+xlb5gvI/bwqs/bVx9PhAJyhdfVp254wNtk9G8SEE6BgriYpY/zEllDQpc
         or2r1lZeoHBDfE1JxWz6p6OEey30RCCzSmvxJUkjP5RzXFam2BmtBKIFIakRyDkTBc7f
         5yRmolQi6sr03m2QNhiHSN6K24Nn/0R0Vlr6cu80H/sk6EIUAXrZxEoRRHH0zo7XBw+V
         iUngQQq7DhF9ersyhirEc+iCqFE9WfnS9yR6hEGvNiafAevK0LB9GR9Byab3ZAaWfhG7
         cQY61wj0L4+vitTJvi+dLCoiWjxVzPulykl7kkx7bkk43eL20/1h6jPzXeZrnuge2rO5
         rDUQ==
X-Gm-Message-State: AOAM530xRP71zgypY1MrOuF8ydVK19ej1nsj7bfBwRNdTLfqksIlxyqL
        Zv4VxgnyeY85Ni55Tzn3K1CbQrGG9zeG1PONbczuUg==
X-Google-Smtp-Source: ABdhPJxdqveluwOFObD/Q2IeyCwgxfBsJ6CnsJl5rU2wrD26p6QqzakCfSftmjvTx3O57U4UaQflQENKIp65BvUQEN4=
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr388035pjb.147.1600191202144;
 Tue, 15 Sep 2020 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org> <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org>
In-Reply-To: <20200915154213.GI5449@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 01:32:46 +0800
Message-ID: <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > This patch series will free some vmemmap pages(struct page structures)
> > > > associated with each hugetlbpage when preallocated to save memory.
> > >
> > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > impossible right now.  Consider, for example, get_user_pages() called
> > > on the fifth page of a hugetlb page.
> >
> > Can you elaborate on the problem? Thanks so much.
>
> OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> on a 4kB base page system.  Today, that results in a bio_vec containing
> {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> page to get the physical address of the I/O, and we turn it into a struct
> scatterlist, which similarly has a reference to the page (head+5).

As I know, in this case, the get_user_pages() will get a reference
to the head page (head+0) before returning such that the hugetlb
page can not be freed. Although get_user_pages() returns the
page (head+5) and the scatterlist has a reference to the page
(head+5), this patch series can handle this situation. I can not
figure out where the problem is. What I missed? Thanks.

>
> If you're returning page (head+1) from get_user_pages(), all the
> calculations will be wrong and you'll do DMA to the wrong address.
>
> What needs to happen is a conversion to get_user_bvecs().  That way we
> can return a bvec which is {head, 0x5000, 0x800} and the calculations
> will work.  So that's going to involve touching a lot of device drivers.
> Christoph has a start on it here:
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/gup-bvec
>
> Overlapping with that is a desire to change the biovec so that it
> only stores {phys_addr, length} rather than {page, offset, length}.
> We're also going to have to rework the scatterlist so that it doesn't
> carry a struct page either.



-- 
Yours,
Muchun
