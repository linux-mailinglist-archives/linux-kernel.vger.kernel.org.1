Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014542A9811
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKFPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:10:14 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58695C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 07:10:12 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so1081529lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J875vJy4G6JRz4RHdTS0OV7v0tPgG3iBUds7VS16zmE=;
        b=CfjTEv+JuiJbqP3tNIDaqkmsOq4d/P2UJ3l2SP5rP3+619BmCSAfpFZjxtSyqXgGyo
         JA516SjkbzjGilEMWaHbWskuDT9po/r+gpxXj4h6rmOJnU43+qEgP3j4Uufzu3OIdQlO
         e1zfOBsXkNVdYo+Ke4+mmkpASCd+AJqpNWLes3+lqYvRqm8K7grgwgpSV21Q/JrEBo+m
         2oiZFZE4uAk06S2nINjhrDlceGJVuOxzd9LNKS4RlIBqBHV+/dXY2QceY4U3DZ6Uk5xr
         LHsentyuwZxHQ7cAiqMIW3ZVLco6qr3Qe0hcu5t7VH3jrckoysHcDsJLe6AoZk10pz6E
         +/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J875vJy4G6JRz4RHdTS0OV7v0tPgG3iBUds7VS16zmE=;
        b=XsT4Ao3ibRhXl6HIGdYW6FhTlGLyNhYAN/UAyeg75e9bv8B9kdZ00uxPsfRWAQRM0g
         MZTNucucTC41/T2PBvmqWtImcPyg6vN+qvB4bKwzgAUdySo/SwxtWFOLlrw4JkUeF0zV
         WN7AoycAqdz+r0doL49oIta0J4R8JNH70mlNoIq9NCXl5wQoKFypHvu3XESugbZINCGh
         +MHrBqsidlI9d9/z+uc0SyQOhOnqn2iQcH3DIerTnjXpJEAYK48IuTaaYcMMIBlV4fNS
         aBdo46jwzbGwAWVRW3J2utQMRaZEmYwbkE3lPpQtgi3+E1v6WwQbq+Fda9pnpDxQcicD
         D5mg==
X-Gm-Message-State: AOAM530raD6Uv0B14zSPuoDw6rsKLiOSByYiFQh8vSVnWakU2yr+coSz
        Cs5hizwZnrz/EktSambJ+aHZe3E39QuQkK1LbXahow==
X-Google-Smtp-Source: ABdhPJyaeOu53rdnZPr4ni399H9U3vOZ12MXF2gx2gxY/O2mk7BoRTDLUdbJDE26YRcI8seTjqgYhARUGTByNKp95ZQ=
X-Received: by 2002:a19:8741:: with SMTP id j62mr1018286lfd.449.1604675410452;
 Fri, 06 Nov 2020 07:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20201104231928.1494083-1-shakeelb@google.com> <alpine.LSU.2.11.2011051751130.4455@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011051751130.4455@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Nov 2020 07:09:58 -0800
Message-ID: <CALvZod6cd8FipvBu-M7cT+tXSSnDmAsikeqgbsGh81fFMdu-Og@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: always do TTU_IGNORE_ACCESS
To:     Hugh Dickins <hughd@google.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 7:00 PM Hugh Dickins <hughd@google.com> wrote:
>
> I don't know why this was addressed to me in particular (easy to imagine
> I've made a mod at some time that bears on this, but I haven't found it);
> but have spent longer considering the patch than I should have done -
> apologies to everyone else I should be replying to.
>

I really appreciate your insights and historical anecdotes. I always
learn something new.

> On Wed, 4 Nov 2020, Shakeel Butt wrote:
>
> > Since the commit 369ea8242c0f ("mm/rmap: update to new mmu_notifier
> > semantic v2"), the code to check the secondary MMU's page table access
> > bit is broken for !(TTU_IGNORE_ACCESS) because the page is unmapped from
> > the secondary MMU's page table before the check. More specifically for
> > those secondary MMUs which unmap the memory in
> > mmu_notifier_invalidate_range_start() like kvm.
>
> Well, "broken" seems a bit unfair to 369ea8242c0f. It put a warning
> mmu_notifier_invalidate_range_start() at the beginning, and matching
> mmu_notifier_invalidate_range_end() at the end of try_to_unmap_one();
> with its mmu_notifier_invalidate_range() exactly where the
> mmu_notifier_invalidate_page() was before (I think the story gets
> more complicated later).  Yes, if notifiee takes invalidate_range_start()
> as signal to invalidate all their own range, then that will sometimes
> cause them unnecessary invalidations.
>
> Not just for !TTU_IGNORE_ACCESS: there's also the !TTU_IGNORE_MLOCK
> case meeting a VM_LOCKED vma and setting PageMlocked where that had
> been missed earlier (and page_check_references() has intentionally but
> confusingly marked this case as PAGEREF_RECLAIM, not to reclaim the page,
> but to reach the try_to_unmap_one() which will recognize and fix it up -
> historically easier to do there than in page_referenced_one()).
>
> But I think mmu_notifier is a diversion from what needs thinking about.
>
> >
> > However memory reclaim is the only user of !(TTU_IGNORE_ACCESS) or the
> > absence of TTU_IGNORE_ACCESS and it explicitly performs the page table
> > access check before trying to unmap the page. So, at worst the reclaim
> > will miss accesses in a very short window if we remove page table access
> > check in unmapping code.
>
> I agree with you and Johannes that the short race window when the page
> might be re-referenced is no issue at all: the functional issue is the
> one in your next paragraph.  If that's agreed by memcg guys, great,
> then this patch is a nice observation and a welcome cleanup.
>
> >
> > There is an unintented consequence of !(TTU_IGNORE_ACCESS) for the memcg
> > reclaim. From memcg reclaim the page_referenced() only account the
> > accesses from the processes which are in the same memcg of the target
> > page but the unmapping code is considering accesses from all the
> > processes, so, decreasing the effectiveness of memcg reclaim.
>
> Are you sure it was unintended?
>
> Since the dawn of memcg reclaim, it has been the case that a recent
> reference in a "foreign" vma has rescued that page from being reclaimed:
> now you propose to change that.  I expect some workflows will benefit
> and others be disadvantaged.  I have no objection myself to the change,
> but I do think it needs to be better highlighted here, and explicitly
> agreed by those more familiar with memcg reclaim.

The reason I said unintended was due to bed7161a519a2 ("Memory
controller: make page_referenced() cgroup aware"). From the commit
message it seems like the intention was to not be influenced by
foreign accesses during memcg reclaim but it missed to make
try_to_unmap_one() memcg aware.

I agree with you that this is a behavior change and we have explicitly
agree to not let memcg reclaim be influenced by foreign accesses.
