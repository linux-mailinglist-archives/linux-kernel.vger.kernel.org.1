Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3003003DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbhAVNLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbhAVNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:10:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A4C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:10:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id v67so7467378lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM6zpCES+0HLn8XlUNi032+O57IMQ4RlIhY5sPMlY+Q=;
        b=sF5zAjDT56BXiHUey17OUSfQJ66O9gcNB/c6sn5CjzVA/TG8uudCB1ttxC7JwOpY3K
         qIB1A5e7fuCatdIf+5BL5DYq0UuC+ftUgAIEvi3YC5xTK9SBTvWSgrFOBn0lRFms7Xws
         9YSdzTRVxlR3bmUlTGBzpMETm64mfRVCQkQ2LEL/+zTbIQSLC1MxJyX0y0/Mku+Uwr+g
         Po0AbrD406ZbDdueebjDmUt49f7PZoFwWFK/6oIhfRGB6J3GePuH//HPXFcypYtsnNGg
         teRWxa9ynMonmK9sWmd+YcmJci32W7kQOXEDs5ju0ygcEo5dtXPSYY9zqvnhGp+PNLCC
         bk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM6zpCES+0HLn8XlUNi032+O57IMQ4RlIhY5sPMlY+Q=;
        b=lzk+/HQJKlfb7jwhUk4fU+m4QaQTx6fRFJ3U24+WAPTpsyXnraOg7wdy/PhEnA08Cl
         4o676zm4WHDxvuMFuOO2QVdh0Bk0nrYlG2takuYhs2FPvoPrJfMUIPFBHx2LfxxYLh7Q
         zkZJgalCpTdZR/yCnfeUbxENbtiQoMWQpdSJTD55SfVaZyIMe4JD/tN/YU3en+X1bn8C
         fulIeCgLds9FOwQFCEwI3lNYf7uedPReaOeOtLx2rNMwaKt7Tdtwm3frXExdam+kSow7
         x4R1n8/cJH6oQ0vaVxo4QdpInqpgze03fzpOHoti6hsXAsa/sfp+Fl3/hadqfOJ6g/pI
         twkA==
X-Gm-Message-State: AOAM533poTVGXy6Y0EFUrUjU0ox+ao113rliIvhAaPKkw+ueD33YmawS
        D/fEDAw3srOdq4GX+TFYsfklWjcWZlF1MbudF98QcA==
X-Google-Smtp-Source: ABdhPJxHLxFQGKxSHSjonKXZfD+TP3Iizcnks53UjMPVH/itFaqhB5xo0zcrd/h+EYj3WPQIojePEaOg0ILdmqpfLcI=
X-Received: by 2002:a05:6512:38c1:: with SMTP id p1mr2197526lft.193.1611321000384;
 Fri, 22 Jan 2021 05:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
In-Reply-To: <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jan 2021 14:09:33 +0100
Message-ID: <CAG48ez3YavBAO1nQquca6W-RvH4yy2B7oiY4jWn96B_aaA_gVw@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Jan 21, 2021 at 7:19 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 1/21/21 11:01 AM, Christoph Lameter wrote:
> > > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> > >
> > >> > The problem is that calculate_order() is called a number of times
> > >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> > >> > This makes the use of num_online_cpus() irrelevant for those cases
> > >> >
> > >> > After adding in my command line "slub_min_objects=36" which equals to
> > >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > >> > , the regression diseapears:
> > >> >
> > >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> >
> > I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> > supposed to be a scheduler benchmark? What exactly is going on?
>
> Uuuh, I think powerpc doesn't have cmpxchg_double?
>
> "vgrep cmpxchg_double arch/" just spits out arm64, s390 and x86? And
> <https://liblfds.org/mediawiki/index.php?title=Article:CAS_and_LL/SC_Implementation_Details_by_Processor_family>
> says under "POWERPC": "no DW LL/SC"
>
> So powerpc is probably hitting the page-bitlock-based implementation
> all the time for stuff like __slub_free()? Do you have detailed
> profiling results from "perf top" or something like that?
>
> (I actually have some WIP patches and a design document for getting
> rid of cmpxchg_double in struct page that I hacked together in the
> last couple days; I'm currently in the process of sending them over to
> some other folks in the company who hopefully have cycles to
> review/polish/benchmark them so that they can be upstreamed, assuming
> that those folks think they're important enough. I don't have the
> cycles for it...)

(The stuff I have in mind will only work on 64-bit though. We are
talking about PPC64 here, right?)
