Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787772DFFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgLUSg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgLUSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:36:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:46 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q137so9692266iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YliUtlY76/UIPuQ5v8deFXxZeb8eSvRLcMxme2JxEEk=;
        b=HDksKqgKauZN6tvbdPBgggj8IeeTS2c7JRuSWMI+pRG1FwKAhMCJxMCv7JOIqk50wv
         3X1HRLkpEKIsTmGLQK6vIyf/RMl8sqUJoc0+IVGVdkvPNiQkOjCyDbUhahzYluorDnrk
         1PDsuxVXgwT/JnDR/e8fyiqWr/gjcp4gXGi2ngqD9bS5/EBS76qfZPKMvDBaRcXFxHGt
         YOSyX7QbQ/Koym0Jms6BgoWpgnw/5heVHu2j7+FeQsRTUWVZEWILea7Byq/nnV5Cq6bO
         YDDYicvRlZMY5s2D5oa9p6I/4Nwjhwv9qDpErWN/14vrvlkMgsgZNqe/YH2kcc3Fnt+d
         1eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YliUtlY76/UIPuQ5v8deFXxZeb8eSvRLcMxme2JxEEk=;
        b=i3VFtzb7VO4t0kEIemcLnu3ngK3vZTgLOX0YIMe4zCxjQQ4cCGM1e2YlhJAdi+ZMzU
         ue5gw6gpu5Ar4OgNXWYZSxaqI7fCg/csGtUJvLSd0Gj6kOz7DbqSpF9hVXf7hXoLpL7b
         zlhVUUtjqKZJsXCd64wdoDxiJdJ79uXdCfWR2010FDn17YrIhIiNnQOor0V5Xl/M6GZR
         wvx8bw/9MEhElkW4/OqJe+ee6ZItQ/KmCGcSmq6EniP+iyM6J4B+nulUoAh3KTmY2J2r
         sF1XdXNr+HjFs5DOL/wcaqaWaKQ9v023cZyP88pQc6M/p/zsqSAkPBwTu9bRwoWHpMmL
         WeJg==
X-Gm-Message-State: AOAM530UiSYxb/AkvnBO/fnjMTPf75GMVZQw+yfeereIC+vuglpMXkoq
        UsgKg3LzP76B2FsBO2kGVTUjFFk07vgkgVKAbhzjcqI2qDTu98GF
X-Google-Smtp-Source: ABdhPJxKT6tC6/ndV2N5i1FwKZxN3yOMknKcMYRbpSq6pVUOWTKpPSP2SnmFD7tg+Np8Z6fWmUqBTLjQBM+VPNs1bYw=
X-Received: by 2002:a63:480f:: with SMTP id v15mr2249541pga.341.1608565986866;
 Mon, 21 Dec 2020 07:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com> <20201221091123.GB14343@linux>
 <CAMZfGtVnS=_m4fpGBfDpOpdgzP02QCteUQn-gGiLADWfGiVJ=A@mail.gmail.com> <20201221134345.GA19324@linux>
In-Reply-To: <20201221134345.GA19324@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 21 Dec 2020 23:52:30 +0800
Message-ID: <CAMZfGtVTqYXOvTHSay-6WS+gtDSCtcN5ksnkj8hJgrUs_XWoWQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
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

On Mon, Dec 21, 2020 at 9:44 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Dec 21, 2020 at 07:25:15PM +0800, Muchun Song wrote:
>
> > Should we add a BUG_ON in vmemmap_remap_free() for now?
> >
> >         BUG_ON(reuse != start + PAGE_SIZE);
>
> I do not think we have to, plus we would be BUG_ing for some specific use
> case in "generic" function.

The vmemmap_remap_range() walks page table range [start, end),
if reuse is equal to (start + PAGE_SIZE), the range can adjust to
[start - PAGE_SIZE, end). But if not, we need some work to
implement the "generic" function.

  - adjust range to [min(start, reuse), end) and call
    vmemmap_remap_rangeand which skip the hole
    which is [reuse + PAGE_SIZE, start) or [end, reuse).
  - call vmemmap_remap_range(reuse, reuse + PAGE_SIZE)
    to get the reuse page.Then, call vmemmap_remap_range(start, end)
    again to remap.

Which one do you prefer?

> Maybe others think different though.
>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
