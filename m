Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FB2BAF37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKTPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgKTPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:45:05 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE0C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:45:04 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so7599915pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUaJ36sT5sqvT77QZgKqlW4z7GZkzcPfj81qnxeQebA=;
        b=qW+cbYIfyE/YclD6/OoMNca+M7Tkh/aPKcKUa2/jD8YKhRzUfQ5xuQPJditN/3qfXi
         iomQyjtsl1XRlyUvHy/KwLYMeXPq92PnxjZRh34FTSNV944O/9RWLlra1f9ixcihX0wP
         Y7WNpIPH8xxtinwgWAu7uHXLAkTejPdX2VQvhz6fjsFQ/SaKWq/B9j8ARM38OACC1/aq
         zsgiwfkKQQ94B2YYCidxE7So02PncvNpjnNAor+EaeO7amsTxH6WxPopLIMA8JTTbnvI
         fSmTqpzpyg0uWYNUhZgg6wvslriEFUZlrnqOGOhrVPHyzv6x+L0+jgnptbqwJYBwICyu
         hSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUaJ36sT5sqvT77QZgKqlW4z7GZkzcPfj81qnxeQebA=;
        b=oAombXiajZLGRoxgMzPY1RrB7tTV0BtuWByFMNKVglymMon1XgEAOAeqNBjqlMOYAJ
         ll8C1Xg80EVsKWwzt9L0a8CSdYDNxV+0sBkZB0hbRxzMiAvI3zDuI6KWvWS/hwksPUMJ
         fzvLXg72t/QCvxdAE5VEPiT/I0SoB/IhOSht4L2P+7enbPdJNEpWg388ZkWOk5b4EWMH
         tfeeh6kmi3sAJ41BONoURbbgACbFDSxKRUjqF/KyOZd59Z+7LvMWSYXwK+VvslLCBR6a
         6eAfO5BT9lx8jsL2ULnJwhxu2Witw9PA3zfLogtcSshFpahJcRGN+mBzcHk0xMMDv5bz
         5woQ==
X-Gm-Message-State: AOAM533vyb+t/HcgoADvPhQOyARlpRVjV7YZl2hyiDnotqmj+LnJoqIY
        c8D/P3gp/xmBDF9vLJGofqyXQ5sjmU+ONg2RzzV4pg==
X-Google-Smtp-Source: ABdhPJzmbK5n3mM2ZmdJphA3yz5noZLknoJg14VWIwCafTYyHUe6A7LPpGU824Rpt37PGuu19LPqU3nP+FXJHz+pCRU=
X-Received: by 2002:a63:594a:: with SMTP id j10mr17197062pgm.341.1605887103558;
 Fri, 20 Nov 2020 07:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz> <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz>
In-Reply-To: <20201120131129.GO3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 23:44:26 +0800
Message-ID: <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Michal Hocko <mhocko@suse.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 9:11 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 20:40:46, Muchun Song wrote:
> > On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > > [...]
> > >
> > > Thanks for improving the cover letter and providing some numbers. I have
> > > only glanced through the patchset because I didn't really have more time
> > > to dive depply into them.
> > >
> > > Overall it looks promissing. To summarize. I would prefer to not have
> > > the feature enablement controlled by compile time option and the kernel
> > > command line option should be opt-in. I also do not like that freeing
> > > the pool can trigger the oom killer or even shut the system down if no
> > > oom victim is eligible.
> >
> > Hi Michal,
> >
> > I have replied to you about those questions on the other mail thread.
> >
> > Thanks.
> >
> > >
> > > One thing that I didn't really get to think hard about is what is the
> > > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > > invalid when racing with the split. How do we enforce that this won't
> > > blow up?
> >
> > This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
> > in this case, the pfn_to_page can work. The return value of the
> > pfn_to_page is actually the address of it's struct page struct.
> > I can not figure out where the problem is. Can you describe the
> > problem in detail please? Thanks.
>
> struct page returned by pfn_to_page might get invalid right when it is
> returned because vmemmap could get freed up and the respective memory
> released to the page allocator and reused for something else. See?

If the HugeTLB page is already allocated from the buddy allocator,
the struct page of the HugeTLB can be freed? Does this exist?
If yes, how to free the HugeTLB page to the buddy allocator
(cannot access the struct page)?

>
> > > I have also asked in a previous version whether the vmemmap manipulation
> > > should be really unconditional. E.g. shortlived hugetlb pages allocated
> > > from the buddy allocator directly rather than for a pool. Maybe it
> > > should be restricted for the pool allocation as those are considered
> > > long term and therefore the overhead will be amortized and freeing path
> > > restrictions better understandable.
> >
> > Yeah, I agree with you. This can be an optimization. And we can
> > add it to the todo list and implement it in the future. Now the patch
> > series is already huge.
>
> Yes the patchset is large and the primary aim should be reducing
> functionality to make it smaller in the first incarnation. Especially
> when it is tricky to implement. Releasing vmemmap sparse hugepages is
> one of those things. Do you really need it for your usecase?
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
