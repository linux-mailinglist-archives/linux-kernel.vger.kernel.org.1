Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02572FD757
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbhATRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387425AbhATRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:37:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC85C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:36:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b26so35240516lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaiePnQY+bs5Y3022o4Z3Zarrb82Su2xJPiMkpIuFPA=;
        b=D+0mwpd/VUnW/R6OcVdoKZrl4YIa6nc2g+bxfzzahCNSOIVQ2h0ooR4ZB+P0Cif547
         mzrKPNcBqCdKr4B/1cfG11U/Gkz5Li5ARkwCdfV86NRnecNyFgvRACGsU+lj8/Hn1h+e
         IICkU2S7Fq3ZNccQCDDwpVpQW5EbRfYvDvzu41HQIm4ooWny2UQdEKMuoZh1WTuB0AZ4
         hKl58ipVUpX55hEkcLFzBCFr1KVAteln5suPCcB/A8k2nmqQJ56SAYOqj45o2qpiDlYV
         xc84B4Cem4RznEY5APAJ07U+ffh57jXg8q2gr2I+jF3T2RhceAWVknqR53dPoFHWcr8h
         lhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaiePnQY+bs5Y3022o4Z3Zarrb82Su2xJPiMkpIuFPA=;
        b=nztWzSFDYTW7srOu3Ney91kNcDg6l9JpIu+DWoPv9oDFESth8e3ZaHU19XWzIy4JYx
         +WaZjriiUFOehWbxGlhJeHQ4FQBde/tImriG1ExHoSdhdoLwQ5usi3P882PebO0loPNI
         9k8tWa2x9WHOFmlS/I+xQ0EKf2JLEYOJ8GgBMyTLpUH8PrFmgV2uO18OpAyqDgwZZZmL
         juJsgLAXctXU7wMCBdvH1CMPbF89ws/mQ8appSmvuVNDRpCb7Bq0hilidexfv//Dai8p
         t3sYxoc7BwcEyBvN/xRbujw3+ZVTxqyssxuKfww2GujCNFoBudQzhLyjjhsWakVJmNxK
         NiSw==
X-Gm-Message-State: AOAM532tES+aBNytPyYNI5f/Hz6yQf7ybEKFDq99VNm/mJXLLm0ef2mP
        gHyj14LOyGIfIkC3NYQcIOXxGE8WVwt1bWEvxZEAfQ==
X-Google-Smtp-Source: ABdhPJxCVR/wWmgKAdo1oGCHDZboYVXHR5SqsujaYHMOMGujZL2oWtndtbkbia4ansbYjHZPtCedx8PnG2ZNaRCrado=
X-Received: by 2002:ac2:5442:: with SMTP id d2mr4701758lfn.154.1611164202587;
 Wed, 20 Jan 2021 09:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
In-Reply-To: <20201118082759.1413056-1-bharata@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jan 2021 18:36:31 +0100
Message-ID: <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        vbabka@suse.cz, shakeelb@google.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 18 Nov 2020 at 09:28, Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> The page order of the slab that gets chosen for a given slab
> cache depends on the number of objects that can be fit in the
> slab while meeting other requirements. We start with a value
> of minimum objects based on nr_cpu_ids that is driven by
> possible number of CPUs and hence could be higher than the
> actual number of CPUs present in the system. This leads to
> calculate_order() chosing a page order that is on the higher
> side leading to increased slab memory consumption on systems
> that have bigger page sizes.
>
> Hence rely on the number of online CPUs when determining the
> mininum objects, thereby increasing the chances of chosing
> a lower conservative page order for the slab.
>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
> This is a generic change and I am unsure how it would affect
> other archs, but as a start, here are some numbers from
> PowerPC pseries KVM guest with and without this patch:
>
> This table shows how this change has affected some of the slab
> caches.
> ===================================================================
>                 Current                         Patched
> Cache   <objperslab> <pagesperslab>     <objperslab> <pagesperslab>
> ===================================================================
> TCPv6           53    2                 26    1
> net_namespace   53    4                 26    2
> dtl             32    2                 16    1
> names_cache     32    2                 16    1
> task_struct     53    8                 13    2
> thread_stack    32    8                 8     2
> pgtable-2^11    16    8                 8     4
> pgtable-2^8     32    2                 16    1
> kmalloc-32k     16    8                 8     4
> kmalloc-16k     32    8                 8     2
> kmalloc-8k      32    4                 8     1
> kmalloc-4k      32    2                 16    1
> ===================================================================
>
> Slab memory (kB) consumption comparision
> ==================================================================
>                         Current         Patched
> ==================================================================
> After-boot              205760          156096
> During-hackbench        629145          506752 (Avg of 5 runs)
> After-hackbench         474176          331840 (after drop_caches)
> ==================================================================
>
> Hackbench Time (Avg of 5 runs)
> (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> ==========================================
> Current         Patched
> ==========================================
> 10.990          11.010
> ==========================================
>
> Measuring the effect due to CPU hotplug
> ----------------------------------------
> Since the patch doesn't consider all the possible CPUs for page
> order calcluation, let's see how affects the case when CPUs are
> hotplugged. Here I compare a system that is booted with 64CPUs
> with a system that is booted with 16CPUs but hotplugged with
> 48CPUs after boot. These numbers are with the patch applied.
>
> Slab memory (kB) consumption comparision
> ===================================================================
>                         64bootCPUs      16bootCPUs+48HotPluggedCPUs
> ===================================================================
> After-boot              390272          159744
> After-hotplug           -               251328
> During-hackbench        1001267         941926 (Avg of 5 runs)
> After-hackbench         913600          827200 (after drop_caches)
> ===================================================================
>
> Hackbench Time (Avg of 5 runs)
> (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> ===========================================
> 64bootCPUs      16bootCPUs+48HotPluggedCPUs
> ===========================================
> 12.554          12.589
> ===========================================
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

I'm facing significant performances regression on a large arm64 server
system (224 CPUs). Regressions is also present on small arm64 system
(8 CPUs) but in a far smaller order of magnitude

On 224 CPUs system : 9 iterations of hackbench -l 16000 -g 16
v5.11-rc4 : 9.135sec (+/- 0.45%)
v5.11-rc4 + revert this patch: 3.173sec (+/- 0.48%)
v5.10: 3.136sec (+/- 0.40%)

This is a 191% regression compared to v5.10.

The problem is that calculate_order() is called a number of times
before secondaries CPUs are booted and it returns 1 instead of 224.
This makes the use of num_online_cpus() irrelevant for those cases

After adding in my command line "slub_min_objects=36" which equals to
4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
, the regression diseapears:

9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)



> diff --git a/mm/slub.c b/mm/slub.c
> index 34dcc09e2ec9..8342c0a167b2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3433,7 +3433,7 @@ static inline int calculate_order(unsigned int size)
>          */
>         min_objects = slub_min_objects;
>         if (!min_objects)
> -               min_objects = 4 * (fls(nr_cpu_ids) + 1);
> +               min_objects = 4 * (fls(num_online_cpus()) + 1);
>         max_objects = order_objects(slub_max_order, size);
>         min_objects = min(min_objects, max_objects);
>
> --
> 2.26.2
>
