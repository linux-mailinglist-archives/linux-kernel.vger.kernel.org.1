Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF927302453
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbhAYLdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbhAYLJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:09:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63FB022512
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611572861;
        bh=ykvbTLDS1xuiZgd19zHJhY/Jznh7sj0YaEkU8rD4LtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u1ecn5Kh2q52vcB8FGFEVXoL5l1LwtEsuCpBEFWGCrYSxqmcjqnFxIy4zZIx7schz
         KsmeYfnlOpqK8xK493WwBFheWnZSp+a8uvynl6CsBtwdFwTgOMIW6xkZSC0FiII2qn
         wqT508yDSEr6EICjuADXfjcjLN5POVm7ZOfQ136r+EL9Fm2cp4iMZ0bDyRZcqB3SZE
         GB9l+3B06zyB/UrCidQr/Esctb4LDpXNpHwb3JadTQcF6TbM/N7La2X3JJaCzuSwId
         iM2kIZtXL95UM2s7RGmg/+oVwQ+9qFVKTsVT2m/IKNqE7KsQ8f3f82lOyic13zwxA5
         RH1HrtTmvHFsA==
Received: by mail-oi1-f182.google.com with SMTP id r189so14335596oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 03:07:41 -0800 (PST)
X-Gm-Message-State: AOAM533jLJ1pPIavyn7mAG+p1ZiWLeWPhN9glJpPSQppw/Mj3HaRC4X8
        zFLxOH1a9cRUl+QfHYZEe6kT3fA6ynKxFhlA2Ek=
X-Google-Smtp-Source: ABdhPJzfl+lF2tQWSUdOOqkL2DytizL7v+hoOmPzIzshwFiRVwJEGW9MvCoojuo74xml0GbJQ9AZ/OQJ3z+4PT8V2B8=
X-Received: by 2002:aca:be54:: with SMTP id o81mr126955oif.67.1611572860723;
 Mon, 25 Jan 2021 03:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20201231212852.3175381-1-dennis@kernel.org> <20210104234651.GA3548546@ubuntu-m3-large-x86>
 <X/O46grb51Z4faI1@google.com>
In-Reply-To: <X/O46grb51Z4faI1@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Jan 2021 12:07:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
Message-ID: <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
Subject: Re: [PATCH] percpu: fix clang modpost warning in pcpu_build_alloc_info()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 1:55 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Mon, Jan 04, 2021 at 04:46:51PM -0700, Nathan Chancellor wrote:
> > On Thu, Dec 31, 2020 at 09:28:52PM +0000, Dennis Zhou wrote:
> > >
>
> Hi Nathan,
>
> >
> > Hi Dennis,
> >
> > I did a bisect of the problematic config against defconfig and it points
> > out that CONFIG_GCOV_PROFILE_ALL is in the bad config but not the good
> > config, which makes some sense as that will mess with clang's inlining
> > heuristics. It does not appear to be the single config that makes a
> > difference but it gives some clarity.
> >
>
> Ah, thanks. To me it's kind of a corner case that I don't have a lot of
> insight into. __init code is pretty limited and this warning is really
> at the compilers whim. However, in this case only clang throws this
> warning.
>
> > I do not personally have any strong opinions around the patch but is it
> > really that much wasted memory to just annotate mask with __refdata?
>
> It's really not much memory, 1 bit per max # of cpus. The reported
> config is on the extreme side compiling with 8k NR_CPUS, so 1kb. I'm
> just not in love with the idea of adding a patch to improve readability
> and it cost idle memory to resolve a compile time warning.
>
> If no one else chimes in in the next few days, I'll probably just apply
> it and go from there. If another issue comes up I'll drop this and tag
> it as __refdata.

I've come across this one again in linux-next today, and found that
I had an old patch for it already, that I had never submitted:

From 7d6f40414490092b86f1a64d8c42426ee350da1a Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 Dec 2020 23:24:20 +0100
Subject: [PATCH] mm: percpu: fix section mismatch warning

Building with arm64 clang sometimes (fairly rarely) shows a
warning about the pcpu_build_alloc_info() function:

WARNING: modpost: vmlinux.o(.text+0x21697c): Section mismatch in
reference from the function cpumask_clear_cpu() to the variable
.init.data:pcpu_build_alloc_info.mask
The function cpumask_clear_cpu() references
the variable __initdata pcpu_build_alloc_info.mask.
This is often because cpumask_clear_cpu lacks a __initdata
annotation or the annotation of pcpu_build_alloc_info.mask is wrong.

What appears to be going on here is that the compiler decides to not
inline the cpumask_clear_cpu() function that is marked 'inline' but not
'always_inline', and it then produces a specialized version of it that
references the static mask unconditionally as an optimization.

Marking cpumask_clear_cpu() as __always_inline would fix it, as would
removing the __initdata annotation on the variable.  I went for marking
the function as __attribute__((flatten)) instead because all functions
called from it are really meant to be inlined here, and it prevents
the same problem happening here again. This is unlikely to be a problem
elsewhere because there are very few function-local static __initdata
variables in the kernel.

Fixes: 6c207504ae79 ("percpu: reduce the number of cpu distance comparisons")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/mm/percpu.c b/mm/percpu.c
index 5ede8dd407d5..527181c46b08 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2662,10 +2662,9 @@ early_param("percpu_alloc", percpu_alloc_setup);
  * On success, pointer to the new allocation_info is returned.  On
  * failure, ERR_PTR value is returned.
  */
-static struct pcpu_alloc_info * __init pcpu_build_alloc_info(
-                               size_t reserved_size, size_t dyn_size,
-                               size_t atom_size,
-                               pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
+static struct pcpu_alloc_info * __init __attribute__((flatten))
+pcpu_build_alloc_info(size_t reserved_size, size_t dyn_size, size_t atom_size,
+                     pcpu_fc_cpu_distance_fn_t cpu_distance_fn)
 {
        static int group_map[NR_CPUS] __initdata;
        static int group_cnt[NR_CPUS] __initdata;


Not sure if this would be any better than your patch.

       Arnd
