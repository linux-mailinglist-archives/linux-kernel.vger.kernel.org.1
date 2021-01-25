Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA3302A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhAYS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbhAYS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:28:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:27:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j21so3576130pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rH51Ivc55ptvFbtJscFbdlO/ZDzsRHEdg+dEPlaRK4c=;
        b=KqBWErOVNKTWOR2DkBApBRlPLMxnS/H5zTdCCjP0/wpyrm11wzzILf4M1sxaOspxuK
         5cVwoCqSLEshDs31dHsdSNgNgiAxT8aYJDbSRUjVbuNKXsb9P+zoUZxnz0YPL1BqBl00
         xBkkgg73CdrVFG9txay538Ptv6lhPUd4oIetXRpXdnxyuvwL0zmEZ8aWsuszeSIyWI65
         6bikn3vme9aV8MHnCbMSb52yqj5wga234PPOjlMHPR5URXix8xoe4cfZmbaPUkdF9QTE
         LEMvEvBlTKlcHyxE9A/9SfMGn9uF+0Ldx8pXQBSzby8XGbfriXO02V+db8IZ9TWaQy/7
         hwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rH51Ivc55ptvFbtJscFbdlO/ZDzsRHEdg+dEPlaRK4c=;
        b=cIoab69mTt2dhvOxgWMTbYBOJ++5c8WXtnIQ/lC4Zfh8RqPCM46D5j9ZLVC3QevERU
         evmdLXbB4KLUH2Dk1Q7vnaLuJRIRjC/io61nLX5Q0e3RiYT9nPAqrICwxy3jjNmgvD58
         WqnUu1+ntzZ+lKHVse1O/17O8876e0kW/XoUJD/ZbiGBJHG+9Hmip/8MzKvaB2AbDfzy
         b+WToFw10V/1P5rg3HeTYMscipc2xbUNPOfhYgHTFxvCPFiB0QjG+7aTw+Klkr/hktnS
         uNXAgqOfMmsZZ7IxlbL9ryUWDcVQR0nPxSwKwV4fMYXDKPY+ScfGiw9eUZYWWl7ClnJi
         D0aw==
X-Gm-Message-State: AOAM533b761HHJPu9/BAVVCK8vtnbofRyZJVS1qrFBjGLkhqrYQKABw2
        o+rV/AJZc8cz/BQHFSpS1yqf6nisjt/lP3UvrTJlig==
X-Google-Smtp-Source: ABdhPJx2YOu9DODyhHPIBO8CoLu8MRNSftF+KFP3I6bHrp5wBDrDHzYq5B2GpE8c6EuB99CWrH6Sm4Mtc6l9IDAygcs=
X-Received: by 2002:a17:90b:228f:: with SMTP id kx15mr1617388pjb.32.1611599241506;
 Mon, 25 Jan 2021 10:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20201231212852.3175381-1-dennis@kernel.org> <20210104234651.GA3548546@ubuntu-m3-large-x86>
 <X/O46grb51Z4faI1@google.com> <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
In-Reply-To: <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jan 2021 10:27:11 -0800
Message-ID: <CAKwvOdnxnooqtyeSem63V_P5980jc0Z2PDG=0iM8ixeYTSaTCg@mail.gmail.com>
Subject: Re: [PATCH] percpu: fix clang modpost warning in pcpu_build_alloc_info()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 3:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
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

I had to look this one up; it's new to me!
https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
https://awesomekling.github.io/Smarter-C++-inlining-with-attribute-flatten/

Seems pretty cool/flexible to control inlining on the caller side!

At the least though, we should avoid open coding the function attributes.  See
include/linux/compiler_attributes.h

Testing quickly in godbolt, __flatten__ has been supported since at
least clang 3.5 and gcc 4.4, FWIW (so it doesn't need a
__has_attribute guard).

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
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
