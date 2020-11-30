Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5382C8F81
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgK3Uzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgK3Uzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:55:45 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB77C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:55:04 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so24414320lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTfnzUqR7eE/c5ODBZauRmscBfaFynv4YFH6nH3o6Mg=;
        b=iESeb0MEH+7s/qExp/N3mktxXfWdHWiEV13q9UH7sjCcZr9JnlrDn3s4e/clEfIJxd
         fbJX6mH+q+YqVO18WVSz2GvFEnKpnWUDssJiTtBtvsLTfZfBKSx4c2+TTZs7h+RlA7zN
         h4OPVb9idK6JPmb1lIfk64NTM+TfWJp1eO1U2l3ami9U0M0HQC39oK4hnnq+qW6xSN4e
         i6qh5U0IkCPCytPoXvVd8wKKikt2hWDUhHd9PgB4l/PMH5Gm2F1llnLZoPwG2noq6SYl
         E/tBnVZm3aUGBjrqB+Sxd1Wm3ZGXnjcfUKfRIv1wEnp6y6sDhm/qw0YK9p0e87kufIDU
         4t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTfnzUqR7eE/c5ODBZauRmscBfaFynv4YFH6nH3o6Mg=;
        b=U7N+kl1o2KV9xJUablvhvMtnDszaqiR6mjlbslA+1wRhcUNNw/ihh+lOEmQDqaC/DJ
         li7Hyh3E+5ASC3KiIYLr9bZTPaNW6tetK54tgupNiZdNyCiWqydmWewaEYnV3qItWLX7
         F/CPG+7qJuW0HcNsXoNC0yGc7v1L9GwUdHykOiwD3Yl8GG/rlimpCKT9ZbK20yXUwc7W
         MD8U95kI7aMDPF78iF6SJq/6Qs1Oy2CFJ4NheH0wXgzhGqJzw5S9nAb71Or9FPQg4Ajt
         It72T69Z5//O610oZGmVpYg53oynvUTHLt3uwi2bgSZVsep/F7kksmBXfP2uTYWHwaQa
         UQCA==
X-Gm-Message-State: AOAM533WAqSJVGISmGx3FCfeKhHbsLzu4q3d1vz3tIjkYMXOdEC2hgaW
        OrmRp1iiAmBEQsbOVL5cAYKhhdiW76BRbUCAt+aX9w==
X-Google-Smtp-Source: ABdhPJzHJ43OzzR4d4cxf19fhLc4beCs4TaEqmWwNN/y9mT68lRu90MXVtbbLHVdV/xQb4tKuITh1xD0DinGoiyOYCE=
X-Received: by 2002:ac2:5a4d:: with SMTP id r13mr10001081lfn.449.1606769703096;
 Mon, 30 Nov 2020 12:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20201126005603.1293012-1-shakeelb@google.com> <20201126005603.1293012-3-shakeelb@google.com>
 <20201130201916.GB23216@cmpxchg.org>
In-Reply-To: <20201130201916.GB23216@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 30 Nov 2020 12:54:51 -0800
Message-ID: <CALvZod5HFkpPK3ALTV7xq_Pu4Cj6gO=xJgCb6X0d4SsJQcgnDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcontrol: account pagetables per node
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:21 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 25, 2020 at 04:56:03PM -0800, Shakeel Butt wrote:
> > For many workloads, pagetable consumption is significant and it makes
> > sense to expose it in the memory.stat for the memory cgroups. However at
> > the moment, the pagetables are accounted per-zone. Converting them to
> > per-node and using the right interface will correctly account for the
> > memory cgroups as well.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Agreed, this is a useful stat item to have.
>
> Just one trivial issue:
>
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -151,7 +151,6 @@ enum zone_stat_item {
> >       NR_ZONE_UNEVICTABLE,
> >       NR_ZONE_WRITE_PENDING,  /* Count of dirty, writeback and unstable pages */
> >       NR_MLOCK,               /* mlock()ed pages found and moved off LRU */
> > -     NR_PAGETABLE,           /* used for pagetables */
> >       /* Second 128 byte cacheline */
> >       NR_BOUNCE,
> >  #if IS_ENABLED(CONFIG_ZSMALLOC)
> > @@ -206,6 +205,7 @@ enum node_stat_item {
> >  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> >       NR_KERNEL_SCS_KB,       /* measured in KiB */
> >  #endif
> > +     NR_PAGETABLE,           /* used for pagetables */
> >       NR_VM_NODE_STAT_ITEMS
> >  };
>
> You need to update mm/vmstat.c::vmstat_text accordingly or
> /proc/vmstat output will be bogus.

Oh I missed that. Thanks for catching.

>
> With that fixed, please feel free to add:
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.
