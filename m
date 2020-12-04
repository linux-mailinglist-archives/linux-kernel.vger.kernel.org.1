Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590692CF159
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgLDP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgLDP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:56:48 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:56:07 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id d17so9334151ejy.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1hSH0l5Mma4TVkpXqECWzqdZtweOdCfO88BYm8fACs=;
        b=RUzCcvPH0tW5ee4reJQV971WgWVIF+pT2Zzgzrx7RqkCoMfZv49Ur27stVaGJbAobj
         mNZUiVCfBJmH1BYYnKppQ1c3uuKMVEWq9h0vp+Ryg1k8c/B6fU/R9wUXJbpEVhjqEfsS
         3/w3MD13NUqO/iOhjGvzn3nRbQPpS94fJZ509yjyRP+z5fmTE9UqkIAHDKwZZJNFyFqM
         5aaD+Fv5DH4cxwHWTokWvH64sebt9P6miHnsB12RFnonT96X5mnIWyWGgF+xGA4IAKkI
         iV7gCCyHtMnDjYbWPMSfoL2ekwNa3t+te3gFp/joq9Hb7Exv5zNMXbL4uM9xYAChdFQ+
         RJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1hSH0l5Mma4TVkpXqECWzqdZtweOdCfO88BYm8fACs=;
        b=MzYL09PlZ/LkaeAjO+I70HQBlNJpQIZW7eMRGGE+DuzRoXs9AxBD0GS/clEFcV8kJZ
         VTlgJARtHyBI+n+PrWy3gBHEpr+Ru8WSZEittXqvQ3vKQu1mlNlUkBgdU2sP+J5vnNZx
         6h8HlgtOO9g03nnCeRGO3I3pHoMiHFj+C+diwU+/Jc3eJSb0uvMRC85izMZoVURSZWU+
         dpL/32q0vbNPOypI0HLCQ9ITghi4Sj6ulGho29kfNut2CG08BfsWFTgiXVtvZ19NnQdp
         sYv5mHWStqfxHJKZsh8UEy6loxWRBgLxJ/WGcCFi/xkUxt/Xhi9b+Zow+yhx/xVmwqij
         ZjVA==
X-Gm-Message-State: AOAM5334/SxAwhnF0xjdZCdtPxDktv22or3FHzaeKTqAQYmncmeAZRDB
        6SFJlAceTmRc9hTk/EzhCIl5EHuAJUQiaSKCRrVrIw==
X-Google-Smtp-Source: ABdhPJyYx9fPZe07SmVSs01be5+MSE5f/I39Ebl7hnoQ/Cwrxmg307rfKvaC6gipYgPUpXrRYOA8LB9osYG/5huDQbM=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr7510400ejh.383.1607097366456;
 Fri, 04 Dec 2020 07:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com> <20201204035953.GA17056@js1304-desktop>
In-Reply-To: <20201204035953.GA17056@js1304-desktop>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 10:55:30 -0500
Message-ID: <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:03 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> Hello,
>
> On Wed, Dec 02, 2020 at 12:23:24AM -0500, Pavel Tatashin wrote:
> > When page is pinned it cannot be moved and its physical address stays
> > the same until pages is unpinned.
> >
> > This is useful functionality to allows userland to implementation DMA
> > access. For example, it is used by vfio in vfio_pin_pages().
> >
> > However, this functionality breaks memory hotplug/hotremove assumptions
> > that pages in ZONE_MOVABLE can always be migrated.
> >
> > This patch series fixes this issue by forcing new allocations during
> > page pinning to omit ZONE_MOVABLE, and also to migrate any existing
> > pages from ZONE_MOVABLE during pinning.
>
> I love what this patchset does, but, at least, it's better to consider
> the side-effect of this patchset and inform it in somewhere. IIUC,
> ZONE_MOVABLE exists for two purposes.
>
> 1) increasing availability of THP
> 2) memory hot-unplug
>
> Potential issue would come from the case 1). They uses ZONE_MOVABLE
> for THP availability and hard guarantee for migration isn't required
> until now. So, there would be a system with following congifuration.
>
> - memory layout: ZONE_NORMAL-512MB, ZONE_MOVABLE-512MB
> - memory usage: unmovable-256MB, movable pinned-256MB, movable
>   unpinned-512MB
>
> With this patchset, movable pinned should be placed in ZONE_NORMAL so
> 512MB is required for ZONE_NORMAL. ZONE_NORMAL would be exhausted and
> system performance would be highly afftect according to memory usage
> pattern.
>
> I'm not sure whether such configuration exists or not, but, at least,
> it's better to write down this risk on commit message or something
> else.

Yes, this indeed could be a problem for some configurations. I will
add your comment to the commit log of one of the patches.

Thank you,
Pasha
