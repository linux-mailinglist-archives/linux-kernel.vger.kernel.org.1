Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86596304DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbhAZXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:13:54 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:36687 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbhAZFFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:05:16 -0500
Received: by mail-io1-f47.google.com with SMTP id d81so31304456iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 21:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcdD4SJ/UJtTKofX4QSGmixhFV/E0gfx+ZOLgohHiJg=;
        b=I9zQuLV2/8oSAp1f240TLJsGUzKFAKAkyW5zgm20KFhZVZ3EI65cj8Ndlj0TYg7Djz
         ct7mvXzdpYJV04J2lW5hzSw1XpoVC7rVTqrQEx6QFFI6SQ6a9iatEP+skIH02nD+Ho2X
         GbliUygQ/GV1kabFJZwZfAWHcd9R5BkNT2PjpBr+/1bpk2cnc/fWg+kAGavggmgNSmCX
         cWGr96asMUcqYZHXz7TrJ//MnPFtkFLGOTZ+MeIvl0ZpGT3hztasct37DpyM0kmIJmCw
         /644qU/Ejy7WgtMZJkh+FYc+8jR5DPbBCLo9p5bQjvIC3CHxOMnhgNW0FeAchv4gXJYV
         3xdA==
X-Gm-Message-State: AOAM530qGEZTqirUqviy/Fde7c7zN/txLIA/ynHMmBJadGm6hBFHR8a7
        s2NQW8rPY9HPMoRs6Q5+hyE=
X-Google-Smtp-Source: ABdhPJz9drmHYLiK1+qRtINPstvzZsK5QeLoMsxQbH2TDitFv8DLpDoJtWqIYuBlSwaud9U9LO0UHw==
X-Received: by 2002:a02:9042:: with SMTP id y2mr3428226jaf.94.1611637474552;
        Mon, 25 Jan 2021 21:04:34 -0800 (PST)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d12sm11855755ioh.51.2021.01.25.21.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:04:33 -0800 (PST)
Date:   Tue, 26 Jan 2021 05:04:32 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] percpu: fix clang modpost warning in
 pcpu_build_alloc_info()
Message-ID: <YA+i4O/2OrUI2pcK@google.com>
References: <20201231212852.3175381-1-dennis@kernel.org>
 <20210104234651.GA3548546@ubuntu-m3-large-x86>
 <X/O46grb51Z4faI1@google.com>
 <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:07:24PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 5, 2021 at 1:55 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > On Mon, Jan 04, 2021 at 04:46:51PM -0700, Nathan Chancellor wrote:
> > > On Thu, Dec 31, 2020 at 09:28:52PM +0000, Dennis Zhou wrote:
> > > >
> >
> > Hi Nathan,
> >
> > >
> > > Hi Dennis,
> > >
> > > I did a bisect of the problematic config against defconfig and it points
> > > out that CONFIG_GCOV_PROFILE_ALL is in the bad config but not the good
> > > config, which makes some sense as that will mess with clang's inlining
> > > heuristics. It does not appear to be the single config that makes a
> > > difference but it gives some clarity.
> > >
> >
> > Ah, thanks. To me it's kind of a corner case that I don't have a lot of
> > insight into. __init code is pretty limited and this warning is really
> > at the compilers whim. However, in this case only clang throws this
> > warning.
> >
> > > I do not personally have any strong opinions around the patch but is it
> > > really that much wasted memory to just annotate mask with __refdata?
> >
> > It's really not much memory, 1 bit per max # of cpus. The reported
> > config is on the extreme side compiling with 8k NR_CPUS, so 1kb. I'm
> > just not in love with the idea of adding a patch to improve readability
> > and it cost idle memory to resolve a compile time warning.
> >
> > If no one else chimes in in the next few days, I'll probably just apply
> > it and go from there. If another issue comes up I'll drop this and tag
> > it as __refdata.
> 
> I've come across this one again in linux-next today, and found that
> I had an old patch for it already, that I had never submitted:
> 
> From 7d6f40414490092b86f1a64d8c42426ee350da1a Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 7 Dec 2020 23:24:20 +0100
> Subject: [PATCH] mm: percpu: fix section mismatch warning
> 
> Building with arm64 clang sometimes (fairly rarely) shows a
> warning about the pcpu_build_alloc_info() function:
> 
> WARNING: modpost: vmlinux.o(.text+0x21697c): Section mismatch in
> reference from the function cpumask_clear_cpu() to the variable
> .init.data:pcpu_build_alloc_info.mask
> The function cpumask_clear_cpu() references
> the variable __initdata pcpu_build_alloc_info.mask.
> This is often because cpumask_clear_cpu lacks a __initdata
> annotation or the annotation of pcpu_build_alloc_info.mask is wrong.
> 
> What appears to be going on here is that the compiler decides to not
> inline the cpumask_clear_cpu() function that is marked 'inline' but not
> 'always_inline', and it then produces a specialized version of it that
> references the static mask unconditionally as an optimization.
> 
> Marking cpumask_clear_cpu() as __always_inline would fix it, as would
> removing the __initdata annotation on the variable.  I went for marking
> the function as __attribute__((flatten)) instead because all functions
> called from it are really meant to be inlined here, and it prevents
> the same problem happening here again. This is unlikely to be a problem
> elsewhere because there are very few function-local static __initdata
> variables in the kernel.
> 
> Fixes: 6c207504ae79 ("percpu: reduce the number of cpu distance comparisons")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 5ede8dd407d5..527181c46b08 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2662,10 +2662,9 @@ early_param("percpu_alloc", percpu_alloc_setup);
>   * On success, pointer to the new allocation_info is returned.  On
>   * failure, ERR_PTR value is returned.
>   */
> -static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
> -                               size_t reserved_size, size_t dyn_size,
> -                               size_t atom_size,
> -                               pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
> +static struct pcpu_alloc_info * __init __attribute__((flatten))
> +pcpu_build_alloc_info(size_t reserved_size, size_t dyn_size, size_t atom_size,
> +                     pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
>  {
>         static int group_map[NR_CPUS] __initdata;
>         static int group_cnt[NR_CPUS] __initdata;
> 
> 
> Not sure if this would be any better than your patch.
> 
>        Arnd

Hi Arnd,

I like this solution a lot more than my previous solution because this
is a lot less fragile.

Thanks,
Dennis
