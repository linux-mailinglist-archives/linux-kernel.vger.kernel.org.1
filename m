Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF092BFE89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgKWDPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgKWDPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:15:37 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106DC061A4D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:15:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id j19so12927850pgg.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PkJLLTHTHGvD+6CtGT0JeNBynTOmH00lzXh1tBHgdk=;
        b=AXE3qcuKn7MS7+bY1HUIYsfwTG1XJGA7xLViJTzXwgBVDETzOpmegz5ECIjDn2PI6h
         zrcfQeSm3Vptg3QLVl59UvnleVo11+Y/AKzjtWAFtcwkXUVGQfDwiF7QYd4CD4cGmN4w
         xioSYxW5L0BNvgRH3OJCAGFpx9iArOMLbfFhG0D78VIA8qMjQaKbSGu8OrRIJWaTFGzR
         wxtcXQR5QVGAablFJ6/mYQWeToPYeHaoIkBTLfHglYGcZvgIorxjZUYtuAMzI/o7lyF6
         0olX85dcFaO+Bt/dg9cNtpdq9kfu2AUcn0374Vr8dOaSvp90AbUGXjb3wimXzUg1dxyy
         N/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PkJLLTHTHGvD+6CtGT0JeNBynTOmH00lzXh1tBHgdk=;
        b=YNETaex9TKkJytqt5WS5Q823Ky9RQ6C+MqLSOI6YT0Ytpq9hC6p440r46pbqxRTwOP
         vBJUueDS1zhKdt9nFOEV521QhK2ImY4ZsdUSNf66N+zgWZRWWWX5DytbvBPRzb+J0aQi
         BuMkRLYZJP1AxxIVpnF9vyYhHBOHpSsa4P21gQh/P6wf8kXPTww6FQVvkfqkU8l355d7
         yFaQ8YpbVGNLkIIwitRXFj2GR74FPr3Q/aSna7EvMLHqYy9rzESk5TA6sdtlxF0uTrvp
         j9azMEwi16ftiiAKy/C7eqiK8QtikjjeQiSlfGQPw/cUwL2WnXLmcwHV6GJoBts9fXaD
         sAeA==
X-Gm-Message-State: AOAM533Lvx66AN78r1yFr+ijggG74bIL2aVB8wxgawqV9NmJ3bQmc/PA
        FnuoUAcK5GePSRowln4/rCk66cqcsB9VUlMNxt5vAQ==
X-Google-Smtp-Source: ABdhPJxKovdhcbkAgrBDEdjMU7ZJHmMEXN8Mq3F1RYkM6JeOu075ftsAAt6nPr79OpJpAUY1RCGxxxOksG4bUMsVeKQ=
X-Received: by 2002:a63:594a:: with SMTP id j10mr25427312pgm.341.1606101336098;
 Sun, 22 Nov 2020 19:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com> <20201120082552.GI3200@dhcp22.suse.cz>
 <20201122190002.GH4327@casper.infradead.org>
In-Reply-To: <20201122190002.GH4327@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 11:14:59 +0800
Message-ID: <CAMZfGtW9drQ7OBhf0wMG4joVz=5UAN1d8P=GQxs2M4MjKoBwxw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
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

On Mon, Nov 23, 2020 at 3:00 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 20, 2020 at 09:25:52AM +0100, Michal Hocko wrote:
> > On Fri 20-11-20 14:43:25, Muchun Song wrote:
> > > We only can free the unused vmemmap to the buddy system when the
> > > size of struct page is a power of two.
> >
> > Can we actually have !power_of_2 struct pages?
>
> Yes.  On x86-64, if you don't enable MEMCG, it's 56 bytes.  On SPARC64,
> if you do enable MEMCG, it's 72 bytes.  On 32-bit systems, it's
> anything from 32-44 bytes, depending on MEMCG, WANT_PAGE_VIRTUAL and
> LAST_CPUPID_NOT_IN_PAGE_FLAGS.
>

On x86-64, even if you do not enable MEMCG, it's also 64 bytes. Because
CONFIG_HAVE_ALIGNED_STRUCT_PAGE is defined if we use SLUB.



-- 
Yours,
Muchun
