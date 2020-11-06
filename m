Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6052A99AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgKFQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:43:53 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:43:51 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 72so1825779pfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohGyP98uQQKhnB3pJGvLmrdRlMtpjmrRpHdlKsDa8JI=;
        b=cBVLpopjhvuZcULC1BoMrRoa/qq8goCwuZepVXmet2PTomK/LcORE5FdTGmV/Wu2B+
         dWCKuVD0LZOHtB2nvIN/jibiaWuYIPt5p5mCkqr3azhxoZwWxaH3kjA+7CfWvGJcC2DI
         quopXOYu4OBkMgKQf05O3xOEvSsSfiOzN0HVHuNMviMzMm/5R9gsAPj55tujY33FL13H
         u+fOVdxUbtfVU/lX/4JVhlYtX1331+EpqSLDaxenFQgBFAkwSOYPFktjFtCLNx/qKjPP
         kzg/VRVgKtJzxUFCEiApIjGfoO2lPrK+TWx72ZkasH9cVcULD7csMyqsGvqn2hsV+7A/
         iTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohGyP98uQQKhnB3pJGvLmrdRlMtpjmrRpHdlKsDa8JI=;
        b=czf5253YudxmF+VS/rVKDcuGxehVNDnSanh/8/mtoUAR5rNO3ELSzeyhACjv1TDUi/
         lxule7XAt5vI47qDgSqQw67F4eolkAMsm0fvvJ8mi0KWjkXLZl393LpbZk/dxhFwJjM0
         awYI4+ZuiRIBdG07R694qBVDkVW0Qwrf+Mz2EF+yfH+QD5HbbqxSc6699QTcONx0YB9S
         HQiINw9eJcyKK1GB0w0my1/nE6L25zTVIxBRXE3sLvHLwyztZMcAFNme5nmDQPPd325u
         Ye9xck1waoH8N06+qXChCSa52Me1+zp3lkhB3kN1wzaW+ELY0LS7pWemLJbRUyRQnhM2
         ftgg==
X-Gm-Message-State: AOAM530S/PX67CWa7IJAzj8/3TYePv6tnUWR7Mt1du3qWmPqkrhBJfZX
        ebqLvw/GNg8QFp0xnI1Rl2h0Kg0aj5kioCZzkQuPEg==
X-Google-Smtp-Source: ABdhPJyLaAnrd+IG224fnDzZZ5YAYD7PCCD1T83OO0MFDfB2bhbeqq8qZzCx71hvpPHp2KQsJtiiQ4jrSkR16OyaidE=
X-Received: by 2002:a17:90a:4749:: with SMTP id y9mr397490pjg.229.1604681031446;
 Fri, 06 Nov 2020 08:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-6-songmuchun@bytedance.com> <20201105132337.GA7552@linux>
 <CAMZfGtXwKJ3uCuNC3mxHQLNJqTcUzj7Gd2-JRuOWEjZ1C7Oh=A@mail.gmail.com> <20201106094643.GA15654@linux>
In-Reply-To: <20201106094643.GA15654@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 7 Nov 2020 00:43:12 +0800
Message-ID: <CAMZfGtWCUD=CjWMPMh2kMmrJRw7TgNtfwr7fLkrigp+T-K_Sww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 5:46 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Fri, Nov 06, 2020 at 12:08:22AM +0800, Muchun Song wrote:
> > > I do not think you need this.
> > > We already have hugepages_supported().
> >
> > Maybe some architectures support hugepage, but the vmemmap do not
> > use the hugepage map. In  this case, we need it. But I am not sure if it
> > exists in the real world. At least, x86 can reuse hugepages_supported.
>
> Yes, but that is the point.
> IIUC, this patchset will enable HugeTLB vmemmap pages only for x86_64.
> Then, let us make the patchset specific to that architecture.
>
> If at some point this grows more users (powerpc, arm, ...), then we
> can add the missing code, but for now it makes sense to only include
> the bits to make this work on x86_64.
>
> And also according to this the changelog is a bit "misleading".
>
> "On some architectures, the vmemmap areas use huge page mapping.
> If we want to free the unused vmemmap pages, we have to split
> the huge pmd firstly. So we should pre-allocate pgtable to split
> huge pmd."

Thanks for your suggestions. I will rewrite the commit log.

>
> On x86_64, vmemmap is always PMD mapped if the machine has hugepages
> support and if we have 2MB contiguos pages and PMD aligned.
> e.g: I have seen cases where after the system has ran for a period
> of time hotplug operations were mapping the vmemmap representing
> the hot-added range on page base, because we could not find
> enough contiguos and aligned memory.
>
> Something that [1] tries to solve:
>
> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201022125835.26396-1-osalvador@suse.de/
>
> But anyway, my point is that let us make it clear in the changelog that
> this is aimed for x86_64 at the moment.
> Saying "on some architures" might make think people that this is not
> x86_64 specific.
>
> >> > > +     vmemmap_pgtable_init(page);
> > >
> > > Maybe just open code this one?
> >
> > Sorry. I don't quite understand what it means. Could you explain?
>
> I meant doing
>
> page_huge_pte(page) = NULL
>
> But no strong feelings.
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
