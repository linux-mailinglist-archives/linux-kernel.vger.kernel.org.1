Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944552DFF68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLUSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgLUSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:12:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77CC061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:11:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so6023643pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhvMmYOdFPEQsdkzltW2aRwWzXxJ2fIZG/7Lv2kkB4c=;
        b=S5szebOzFDTVguVH8GCcLC9zpyBaokUUS+BlpueH6g4aieSbtIbuFAiiS9ULXSSPK5
         YhMDHcJxfvAo6CKneTwM3uuCMuExpke2+xkkUi55NbLlv8d7UawDMb1fUYKFrj7F9YIZ
         eqLlBlQ30iCPJh0YZXC1pwX57XF0Ra7y63UMvYAT2gG2SpmeROQU3KoJwYG3nhfzmOE8
         dgPvXgeghZrwoQ+0i6TzwM5Rhg2zBVDrdapU3W0185lxQ62LVv6WKSJ5m9jZeCsh2HDY
         tQFEHxx5KfF4kRJwzW+SPzGk5jSlNa3iXvRRg7zflT7KlH6mX4lMS+llXxNok4UtMVes
         nWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhvMmYOdFPEQsdkzltW2aRwWzXxJ2fIZG/7Lv2kkB4c=;
        b=TM2yxKd47S49dItSaIIPAQF1oEradeS0yXPwJN6Ri8a8XXJXwAsqayvlx0jEAicN9b
         vOYlsYh0+yh2KDlgq7fW5TzAnlsgYQVBBAfBrkgZc9GxShwZ2ezbsSc037omAQzFKquM
         kheBZfyASd+bn2qGpJQAh5NRUbJyJ9mwtic/hYO7g3SyXahy6sGEOyo3eA/SsaywGYM7
         thBbkiNRPRqgSw/VhToMwKQx8WGCnKPXKTTHutEFCy+a0ZmPs4/gffzQC5zVwbeU82Eh
         EeftCHl3CTrh+4hjRGz0l4rWAabzt6bfzV5jsZUBgR2Rs8csVUKomu2DmQDtNZxuxv1y
         JQNw==
X-Gm-Message-State: AOAM530z7oQN5crMAtdVzgSb0Io77PSm7KM3u8DAUcjIu+wLo0BouIlt
        2zKhbSTLgFsk9g6HcQqOfUB0FzIl5GzAbsOvn5XR/NhOQiWKZ24B
X-Google-Smtp-Source: ABdhPJwVx//EDYahork2LZ/VOpYoYko3xANCgxRVilG3AdbDW9UcKntl7bSI1Dn7ehiZiOaGvbQDz+RUAAvPxjhTtiM=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr17050460pld.20.1608563927117; Mon, 21
 Dec 2020 07:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-5-songmuchun@bytedance.com> <20201221102703.GA15804@linux>
 <CAMZfGtW0jzNchLqieAudyk4TsaAUtYEdoC=j+gkkVLJBaKg3pA@mail.gmail.com> <20201221141242.GA19680@linux>
In-Reply-To: <20201221141242.GA19680@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 23:18:11 +0800
Message-ID: <CAMZfGtXgzorGv_hymZF_cJPv2qziVG6xN5hCGFqT3KOjCZOteg@mail.gmail.com>
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

On Mon, Dec 21, 2020 at 10:14 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Dec 21, 2020 at 07:07:18PM +0800, Muchun Song wrote:
> > > The above implies that update_and_free_page() is __always__ called from a
> > > non-task context, but that is not always the case?
> >
> > IIUC, here is always the case.
>
> I might be missing something obvious, so bear with me.
>
> I guess you are refering to the call __free_huge_page()->update_and_free_page().
> AFAICS, free_huge_page might call __free_huge_page right away when in task
> context, and so, we would be calling update_and_free in a task context as well.

Yeah. You are right. I mean the call __free_huge_page()->update_and_free_page().
Because update_and_free_page is called under hugetlb_lock, it is
non-task context,
right?


>
> Or are you referring to the other callers?
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
