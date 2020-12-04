Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838D2CF197
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgLDQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgLDQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:09:08 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:08:28 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id qw4so9384695ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgJ3P5TSBGZilokHFX8v5OKRIwn1E+p9CC+Sd10NgMQ=;
        b=LK/Ok/J7yG5aJDlJu3t4ObQmoWk9vv1x4VKKVqhoqZ6Rp9H41TAXFWtXqWaRmZGG6c
         +of8NdIYflycxa9MMZwjUWNVSDU4ZujAWKT0Bsh8pv2N/O2A/ypIiwUzljXRPgQHntZb
         AVw3LQb/yaP2aLSkRDX1uoDwzbTNnifaheWIVSN5FLXFszfCpjoeDnl3nkmu0Svin0GT
         xsToUnZa2J3mOjlFUkF3eJILBjMtRWC2GKZmHOdon8sHNsg6CC8kOLTNRtx6RToaVqAM
         kURXO187jDRswd2iE64ufKBM1W4Cg8Ry/tWS8EnFTFjvY2+E1RfwpyaROJDyhJIeq/xN
         LTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgJ3P5TSBGZilokHFX8v5OKRIwn1E+p9CC+Sd10NgMQ=;
        b=or8DyD1YeIOjEmsq4uC5wCJyXhmvn5jQYeTkG7wwhf4WpAtrnedndt+QKlBDs9+kEj
         t6AAyEMurnP8OKKh6xx2rPSCr1eAVgmf13mXHKLsUQGJobTY7fIQunIbxkVJ10s6X52o
         JeFOkSYQSfYfQWbTAfa0WJt0l2jPr7+J/0zcz+bpahROG9JVoGhFYWv6jDnSO+saJucY
         vtaj5V7n1q8kvXMDTIcdcsX9MmZLEBo/KnW1qBOzhzsZMYUqG1yyoJ8PIR/4Kuarv2rS
         KullOtP4uGyRsJzYAu1Aail0IO1/ttEytS4Ripoc96/w5Su1VxEM712xFXWiAPKukTxF
         xM2Q==
X-Gm-Message-State: AOAM531lzzTyaH5k5szYwf/HI8/nEI3ECuplPpHg+b+bmpzJm3od8B0u
        4eYJI8vxzGqRb9QWhiiwk6vj7eeNAW4gva26wdswZA==
X-Google-Smtp-Source: ABdhPJw///BFE4BaSY8UnV6aE0C4WBjQc/DC3TSJISHaKAazmCia7ZOh3/BZ8cz1zZ13sXf8TG/iQdUxReSmgKICNfE=
X-Received: by 2002:a17:906:fb9b:: with SMTP id lr27mr7997127ejb.175.1607098107080;
 Fri, 04 Dec 2020 08:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com> <20201203091703.GA17338@dhcp22.suse.cz>
 <CA+CK2bB-BC-5Szs1Piv3O=OGxQbJSGWzgMmDUtDewrCqEoNaXw@mail.gmail.com>
 <20201204084312.GA25569@dhcp22.suse.cz> <20201204085401.GB25569@dhcp22.suse.cz>
In-Reply-To: <20201204085401.GB25569@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 11:07:51 -0500
Message-ID: <CA+CK2bCyMWMXpz9xmPMRey0euS1AYuPEjmXo6OF9Hsv9x+f9GQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Fri, Dec 4, 2020 at 3:54 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-12-20 09:43:13, Michal Hocko wrote:
> > On Thu 03-12-20 10:15:41, Pavel Tatashin wrote:
> [...]
> > > Also, current_gfp_context() is used elsewhere, and in some
> > > places removing __GFP_MOVABLE from gfp_mask means that we will need to
> > > also change other things. For example [1], in try_to_free_pages() we
> > > call current_gfp_context(gfp_mask) which can reduce the maximum zone
> > > idx, yet we simply set it to: reclaim_idx = gfp_zone(gfp_mask), not to
> > > the newly determined gfp_mask.
> >
> > Yes and the direct reclaim should honor the movable zone restriction.
> > Why should we reclaim ZONE_MOVABLE when the allocation cannot really
> > allocate from it? Or have I misunderstood your concern?
>
> Btw. if we have gfp mask properly filtered for the fast path then we can
> remove the additional call to current_gfp_context from the direct
> reclaim path. Something for a separate patch.

Good point. I am thinking to make a preparation patch at the beginning
of the series where we move current_gfp_context() to the fast path,
and also address all other cases where this call is not going to be
needed anymore, or where the gfp_mask will needed to be set according
to what current_gfp_context() returned.

Thanks,
Pasha
