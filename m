Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123472D1055
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgLGMRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgLGMRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:17:24 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD082C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:16:43 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id j13so7332631pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jD4wHcJJlBIQx2668YfWwft0+hoWgNC83Bw+E+5vHU=;
        b=urv5yGIB55SdkAowinQ5hQNE4We7mRVn/jy61tXEo+c5qJikiNyPSAOANZcKoFVXCh
         JQ0T3BpdVoNDfuFySpVTHCLylsab91jHwBjvq5soJR3ST/M2x2My9gFuojp5nbBLNpto
         upQ9pq1liyxJFaO/7VXvevlieC6z4bnw9t/KkpXoO/gsbTaAZ6+z6QtnyLTH02Qyyl+6
         PB70h6zoFvrpjbqIUoisTMNjlRSfGJf9KONB5K2j2uyUVwI+wqxFY81JzWK/68VamowZ
         0b2SfHZxEvaf/EWswY/H4+6NEM/IoDl31NvbiGliB/iz+wIJN2URLSmT0+Qda2X+Jhex
         572Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jD4wHcJJlBIQx2668YfWwft0+hoWgNC83Bw+E+5vHU=;
        b=ae1GwPvny4FmhKH6v5fhwPGB7CFtHYc7p9Zfwcu2fF7U3bbOKY/CUJm3vC3wm21Etr
         C2u2qGr+EpfneH7U9rBkjV3GfvjR1lTSicTxCAjmnbFiU2frbDAsJlUO5DQl4MPVTKQc
         bQOvHHRhcOlQFiICNkSNFkl60xJ1JekrkIHaEaWp3tiPXiCBVowLEkcEx0PBRd1DhjoQ
         lIaQdeL/ZBoMyqu74JWc5Rszl+mEBHQ+LRlbrOr1QrGQxu50/oBLfNYyZhQg6x5DQwFj
         CE16/gUTCoRF/pEbO6WAxr9o2hXA7FIy7ga4ad2bMgeFMlqK19wYHBG+XnsxgfQVJbX7
         aSIQ==
X-Gm-Message-State: AOAM53026Rf7E/CZYjpiUfEZtZQcFtQB6PdjX2DCPgo5IJR/QTA2UHD2
        sH3ZtS/BbPzy0kBDmZEk7tCgsYvsBgY3xN9sTHWvig==
X-Google-Smtp-Source: ABdhPJx7dJV6HPyqzd41Q0ApDOhuD6KvtSFfq9vHWey0F0Shcc9vdI4nXgzDX3fwRfhjmHt9GIpXonvCDxH4DymN7Qs=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr16138235pjr.229.1607343403421;
 Mon, 07 Dec 2020 04:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-3-songmuchun@bytedance.com> <3840b0eb-bc65-6ad4-9ef9-f6e1603d1473@redhat.com>
In-Reply-To: <3840b0eb-bc65-6ad4-9ef9-f6e1603d1473@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 20:16:07 +0800
Message-ID: <CAMZfGtVa3mmdJip=sPoAT-ibgimhiOAy+OKzpjtatzLd0SahPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 02/15] mm/memory_hotplug: Move
 {get,put}_page_bootmem() to bootmem_info.c
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

On Mon, Dec 7, 2020 at 8:14 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.11.20 16:18, Muchun Song wrote:
> > In the later patch, we will use {get,put}_page_bootmem() to initialize
> > the page for vmemmap or free vmemmap page to buddy. So move them out of
> > CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code movement without any
> > functional change.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >  arch/x86/mm/init_64.c          |  2 +-
> >  include/linux/bootmem_info.h   | 13 +++++++++++++
> >  include/linux/memory_hotplug.h |  4 ----
> >  mm/bootmem_info.c              | 25 +++++++++++++++++++++++++
> >  mm/memory_hotplug.c            | 27 ---------------------------
> >  mm/sparse.c                    |  1 +
> >  6 files changed, 40 insertions(+), 32 deletions(-)
> >
>
> I'd squash this into the previous patch and name it like
>
> "mm/memory_hotplug: Factor out bootmem core functions to bootmem_info.c"

OK, will do. Thanks for your suggestions. :)

>
>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
