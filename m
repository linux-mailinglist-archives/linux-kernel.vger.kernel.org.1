Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CE2EFD21
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAICYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAICYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:24:07 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:23:27 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x23so2874483oop.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=O512iOdiQl7IEgpRDKJFQeplTuWfwibmOqpv/4fzERA=;
        b=ZQSLXT9/DFHCTODimbMizY/fKhhRRuE7vZE/TEUrfMucjwAm68A6KiUZ5AXuADWucB
         jZavZ/PqwcyhqTTMMBrIZZ3QZjVfHd772M0Cyq3wKIVdQX6FY+60PT2ll38GRJeEvMS2
         AjVFKUgDTfusb98LzWGlu/gTnG2/2Ck3HsINcLjec8htrGs9245emOxHX6G+31Dn5HbQ
         b+5fPgvEHhmRAD9Mu3TaNFj/KDud1BTXsKoTcpR1WuFaMBwKEjom8LhOxKu/wHR0vjbW
         nAyvjc+sTA04P51ck86N1cMejaM3idB0BN37mTP8lGh1KoRlOqz0AwIgpCMhh/uCOj3J
         36Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=O512iOdiQl7IEgpRDKJFQeplTuWfwibmOqpv/4fzERA=;
        b=Wl7bZkfnXAlCLvJgfsw56ASxaP9uA5KDzq7zC6k67vi2zzcX7F/0NJwByzgp5p9FSy
         RAe1U6aVg+nGBMGjKFOUrP/ePoxLnN8p9tbk93LkY4iPLNk3LbLCAynrVYwpS17mVTr0
         IBd91jKQAnzzlcegFqr2F2YeW+hrF23xP0lQsINI33TkX5OFOEjJBPZylC8tY326McYY
         mC4HXJjceNtIT8reU79ZK+ve//j2kA/GZOxRi7P+LAexRUbZkKkaSNd8jzR7WgkOVK4f
         leUGOTQTV5uepXjLl77RLjxGWeFPEOfGONqhOC9BXjWs7FCtLCr1M6MHhFYOiAQ/ekH/
         B0WQ==
X-Gm-Message-State: AOAM532R/ddB02pPWrF/hNRB+oUkF64LWJi2hTUpq5VrTkA5UKfmGcPB
        qaWqBvQjMzuJ5XLlovOcqQoTMg==
X-Google-Smtp-Source: ABdhPJwtu9DUbVYibKPjfPPmuoXTICJS+E8dU1Ezma2JC/Sd3l+R3WccOKyl4/nMLKee3Nxqll6a3Q==
X-Received: by 2002:a4a:e294:: with SMTP id k20mr6225934oot.82.1610159006663;
        Fri, 08 Jan 2021 18:23:26 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e10sm2150117otr.73.2021.01.08.18.23.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 08 Jan 2021 18:23:26 -0800 (PST)
Date:   Fri, 8 Jan 2021 18:23:09 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hui Su <sh_def@163.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Baoquan He <bhe@redhat.com>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
In-Reply-To: <b52ec93d-9d09-888e-3404-c8c78800c683@suse.cz>
Message-ID: <alpine.LSU.2.11.2101081720420.8770@eggly.anvils>
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils> <b52ec93d-9d09-888e-3404-c8c78800c683@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021, Vlastimil Babka wrote:
> On 1/4/21 6:03 AM, Hugh Dickins wrote:
> > Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
> > met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
> > recently added to the inline mem_cgroup_page_lruvec().
> > 
> > An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
> > been careful to do so after weeding out the mem_cgroup_disabled() case;
> > but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
> > clear_pgdat_congested() and age_active_anon().
> > 
> > Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
> > charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
> > 
> > Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> 
> > ---
> > 
> >  include/linux/memcontrol.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> > +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> > @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
> >  {
> >  	struct mem_cgroup *memcg = page_memcg(page);
> >  
> > -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> > +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
> 
> Nit: I would reverse the order of conditions as mem_cgroup_disabled() is either
> "return true" or a static key. Not that it matters too much on DEBUG_VM configs...

tl;dr I'm going to leave the patch as is.

You are certainly right that I was forgetting the static-key-ness of
mem_cgroup_disabled() when I put the tests that way round: I was thinking
of the already-in-a-register-ness of "memcg"; but had also not realized
that page_memcg() just did an "&", so condition bits nicely set already.

And I think you are right in principle, that the tests should be better
the way you suggest, when static key is in use - in the (unusual)
mem_cgroup_disabled() case, though not in the usual enabled case.

I refuse to confess how many hours I've spent poring over "objdump -ld"s
of lock_page_lruvec_irqsave(), and comparing with how it is patched when
the kernel is booted with "cgroup_disable=memory".

But I have seen builds where my way round worked out better than yours,
for both the enabled and disabled cases (SUSE gcc 9.3.1 was good, in
the config I was trying on it); and builds where disabled was treated
rather poorly my way (with external call to mem_cgroup_disabled() from
lock_page_lruvec() and lock_page_lruvec_irqsave(), but inlined into
lock_page_lruvec_irq() - go figure! - with SUSE gcc 10.2.1).

I suspect a lot depends on what inlining is done, and on that prior
page_memcg() doing its "&", and the second mem_cgroup_disabled() which
follows immediately in mem_cgroup_lruvec(): different compilers will
make different choices, favouring one or the other ordering.

I've grown rather tired of it all (and discovered on the way that
static keys depend on CONFIG_JUMP_LABEL=y, which I didn't have in
a config I've carried forward through "make oldconfig"s for years -
thanks); but not found a decisive reason to change the patch.

Hugh

> 
> >  	return mem_cgroup_lruvec(memcg, pgdat);
> >  }
> >  
> > 
