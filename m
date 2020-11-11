Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D432AEA54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgKKHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:50:54 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63531C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:50:54 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id z13so227550ooa.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6RzBU8NK+ALGWSpn/m7jTQQEqoq0Kx4JgYMbShvEO30=;
        b=OuvAtIt2NPP249/334v42ON1hgNeWAciqKYIDj/hI5aXw8zjwK9J+TSbhhbwiZvi7A
         d2pj8K+389ap3er/p54uWrQ6Wllgb8lA8KSw+9fTQ6iaLKHIvj/f4OuQqD6+EJtfLvmB
         e9EElIZPIgHJuBJVxDYy7zzRoyopxgzQ51uTKUtqy9R9TERjWyaohNECfMDOEs1svzem
         xkpjYWIdvnESLegco00Xq+IDGznrTP8ociKQ4+afzGxIaYqtLORQLve+Gv6mRONvk20Y
         NEI4TVCeVUtdMghfOJSeEbWAJgYB6f5pNUWXfDOse1ET6PojJL98lodlJh+7cX9QVEfG
         f0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6RzBU8NK+ALGWSpn/m7jTQQEqoq0Kx4JgYMbShvEO30=;
        b=LkZT5T8X1DV+B4ijXkjdxwKLDocvHXdeDJFPX7dC8tiUhYyupGetarIp9AgGnicWFB
         6rrzJE8WmgWfSnoVZNOFgZd9oZNCYy+GQcxlXaAs1q4h+iSv9x9rYYMz/ZZjSDcgplYR
         3vWbnQVhaifJjLjjr3sfshkEwIpG0C80xvvAan33h6o2M6PS1aeu47GyBu6B7Od3tFAe
         p52mglg2R/qAkmab5V0WhYBpC93Pr/MEF3EbclmrLmzMP7Q+yz/IWUjYedgGGjAcZGWA
         o0woAT70mXKajKT63B3lxqIysVz5G3ew3HpUtet1FOMUGAi7NEAPB9SMrXp9DfJ3orxc
         6NkA==
X-Gm-Message-State: AOAM531SZ0yJJtBEgeRSHo8yOmlxBBSRrkjzBmvYTiA3qGjEEzrHU8kW
        q8XUA7Ti/l2QCbEHBoufAAJuQg==
X-Google-Smtp-Source: ABdhPJxh/HxKUV/witGMklUb4vP64lLsFA9zYOw5ob7dEhcNLkW5+yaCXUXvGfmFVUpPprylJsuiHA==
X-Received: by 2002:a4a:5857:: with SMTP id f84mr15967000oob.34.1605081053376;
        Tue, 10 Nov 2020 23:50:53 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i82sm292461oia.2.2020.11.10.23.50.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2020 23:50:52 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:50:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Shakeel Butt <shakeelb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] mm/rmap: always do TTU_IGNORE_ACCESS
In-Reply-To: <CALvZod6cd8FipvBu-M7cT+tXSSnDmAsikeqgbsGh81fFMdu-Og@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2011102342250.1183@eggly.anvils>
References: <20201104231928.1494083-1-shakeelb@google.com> <alpine.LSU.2.11.2011051751130.4455@eggly.anvils> <CALvZod6cd8FipvBu-M7cT+tXSSnDmAsikeqgbsGh81fFMdu-Og@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020, Shakeel Butt wrote:
> On Thu, Nov 5, 2020 at 7:00 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I don't know why this was addressed to me in particular (easy to imagine
> > I've made a mod at some time that bears on this, but I haven't found it);
> > but have spent longer considering the patch than I should have done -
> > apologies to everyone else I should be replying to.
> >
> 
> I really appreciate your insights and historical anecdotes. I always
> learn something new.

:)

> 
> > On Wed, 4 Nov 2020, Shakeel Butt wrote:
> >
> > > Since the commit 369ea8242c0f ("mm/rmap: update to new mmu_notifier
> > > semantic v2"), the code to check the secondary MMU's page table access
> > > bit is broken for !(TTU_IGNORE_ACCESS) because the page is unmapped from
> > > the secondary MMU's page table before the check. More specifically for
> > > those secondary MMUs which unmap the memory in
> > > mmu_notifier_invalidate_range_start() like kvm.
> >
> > Well, "broken" seems a bit unfair to 369ea8242c0f. It put a warning
> > mmu_notifier_invalidate_range_start() at the beginning, and matching
> > mmu_notifier_invalidate_range_end() at the end of try_to_unmap_one();
> > with its mmu_notifier_invalidate_range() exactly where the
> > mmu_notifier_invalidate_page() was before (I think the story gets
> > more complicated later).  Yes, if notifiee takes invalidate_range_start()
> > as signal to invalidate all their own range, then that will sometimes
> > cause them unnecessary invalidations.
> >
> > Not just for !TTU_IGNORE_ACCESS: there's also the !TTU_IGNORE_MLOCK
> > case meeting a VM_LOCKED vma and setting PageMlocked where that had
> > been missed earlier (and page_check_references() has intentionally but
> > confusingly marked this case as PAGEREF_RECLAIM, not to reclaim the page,
> > but to reach the try_to_unmap_one() which will recognize and fix it up -
> > historically easier to do there than in page_referenced_one()).
> >
> > But I think mmu_notifier is a diversion from what needs thinking about.
> >
> > >
> > > However memory reclaim is the only user of !(TTU_IGNORE_ACCESS) or the
> > > absence of TTU_IGNORE_ACCESS and it explicitly performs the page table
> > > access check before trying to unmap the page. So, at worst the reclaim
> > > will miss accesses in a very short window if we remove page table access
> > > check in unmapping code.
> >
> > I agree with you and Johannes that the short race window when the page
> > might be re-referenced is no issue at all: the functional issue is the
> > one in your next paragraph.  If that's agreed by memcg guys, great,
> > then this patch is a nice observation and a welcome cleanup.
> >
> > >
> > > There is an unintented consequence of !(TTU_IGNORE_ACCESS) for the memcg
> > > reclaim. From memcg reclaim the page_referenced() only account the
> > > accesses from the processes which are in the same memcg of the target
> > > page but the unmapping code is considering accesses from all the
> > > processes, so, decreasing the effectiveness of memcg reclaim.
> >
> > Are you sure it was unintended?
> >
> > Since the dawn of memcg reclaim, it has been the case that a recent
> > reference in a "foreign" vma has rescued that page from being reclaimed:
> > now you propose to change that.  I expect some workflows will benefit
> > and others be disadvantaged.  I have no objection myself to the change,
> > but I do think it needs to be better highlighted here, and explicitly
> > agreed by those more familiar with memcg reclaim.
> 
> The reason I said unintended was due to bed7161a519a2 ("Memory
> controller: make page_referenced() cgroup aware"). From the commit
> message it seems like the intention was to not be influenced by
> foreign accesses during memcg reclaim but it missed to make
> try_to_unmap_one() memcg aware.

Oooh, that's a good reference (much better than the mmu_notifier one
you cited in the patch).  Yes, I agree Balbir was explicit about the
intention then, and you're simply fixing it up.

> 
> I agree with you that this is a behavior change and we have explicitly
> agree to not let memcg reclaim be influenced by foreign accesses.

I've not seen anyone else protesting, and Johannes and Andrew happy
with this: so no more protest from me, let's proceed with the nice
cleanup, and hope no regression surfaces.

Hugh
