Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3058304DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbhAZXO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:14:29 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:38318 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhAZFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:12:16 -0500
Received: by mail-io1-f48.google.com with SMTP id 16so840149ioz.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 21:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmaMPZV/VxgqIwEqykBR9Gxeq43EdO4m32aypNvWqws=;
        b=DdvjtA5Jf63Z3ctpnm//8/14ive/PWN7C6U7XJMSoK0LoixrZ6K9BUswDIAfEbvqJY
         QSnjnWJbXU5TIZHlKBKeeEFuw4epCCLFK1sKRW0Ub06ygQPtZTOZxE3bxWhy2Y9OV265
         7fwioUhqGdxrUC9hcc3kvjhnPyBrBUbRVj2kGL0RUinBu2kb7yNix3s3YqZo4Wqn4gMI
         O7m6k2O4qSz2HPPiuzpmV5F6mgjvRctevszsOnrTx1E8Zt/8K3adwCkw1IhlN+3bWdPD
         Up6eX8uKwwPh1I0JIMA9nntWIP4GRYxaUoRIjwTZzaV/Pl/gr8g75fDbwYCF98eGeDtQ
         YHVQ==
X-Gm-Message-State: AOAM533zQYlkXo2vycZ+jsscTSoypN+NftNsVEmz0Xqxmj6B/Qp29Gq7
        32Hl1l3j0SvSYoTm5faqRzhbv2nDEXAiuFZ1
X-Google-Smtp-Source: ABdhPJzg5a2tpmFmJ61pfzc7Am/xdYUmierqENfZpjYyQN8FBl91Q6evPtafE7hB0cEkxfchrwrotA==
X-Received: by 2002:a05:6e02:1564:: with SMTP id k4mr3219033ilu.282.1611637894279;
        Mon, 25 Jan 2021 21:11:34 -0800 (PST)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y1sm12045326ioj.32.2021.01.25.21.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:11:33 -0800 (PST)
Date:   Tue, 26 Jan 2021 05:11:32 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] percpu: fix clang modpost warning in
 pcpu_build_alloc_info()
Message-ID: <YA+khB+34zmp+Aj7@google.com>
References: <20201231212852.3175381-1-dennis@kernel.org>
 <20210104234651.GA3548546@ubuntu-m3-large-x86>
 <X/O46grb51Z4faI1@google.com>
 <CAK8P3a2ZWfNeXKSm8K_SUhhwkor17jFo3xApLXjzfPqX0eUDUA@mail.gmail.com>
 <CAKwvOdnxnooqtyeSem63V_P5980jc0Z2PDG=0iM8ixeYTSaTCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnxnooqtyeSem63V_P5980jc0Z2PDG=0iM8ixeYTSaTCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, Jan 25, 2021 at 10:27:11AM -0800, Nick Desaulniers wrote:
> On Mon, Jan 25, 2021 at 3:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Jan 5, 2021 at 1:55 AM Dennis Zhou <dennis@kernel.org> wrote:
> > >
> > > On Mon, Jan 04, 2021 at 04:46:51PM -0700, Nathan Chancellor wrote:
> > > > On Thu, Dec 31, 2020 at 09:28:52PM +0000, Dennis Zhou wrote:
> > > > >
> > >
> > > Hi Nathan,
> > >
> > > >
> > > > Hi Dennis,
> > > >
> > > > I did a bisect of the problematic config against defconfig and it points
> > > > out that CONFIG_GCOV_PROFILE_ALL is in the bad config but not the good
> > > > config, which makes some sense as that will mess with clang's inlining
> > > > heuristics. It does not appear to be the single config that makes a
> > > > difference but it gives some clarity.
> > > >
> > >
> > > Ah, thanks. To me it's kind of a corner case that I don't have a lot of
> > > insight into. __init code is pretty limited and this warning is really
> > > at the compilers whim. However, in this case only clang throws this
> > > warning.
> > >
> > > > I do not personally have any strong opinions around the patch but is it
> > > > really that much wasted memory to just annotate mask with __refdata?
> > >
> > > It's really not much memory, 1 bit per max # of cpus. The reported
> > > config is on the extreme side compiling with 8k NR_CPUS, so 1kb. I'm
> > > just not in love with the idea of adding a patch to improve readability
> > > and it cost idle memory to resolve a compile time warning.
> > >
> > > If no one else chimes in in the next few days, I'll probably just apply
> > > it and go from there. If another issue comes up I'll drop this and tag
> > > it as __refdata.
> >
> > I've come across this one again in linux-next today, and found that
> > I had an old patch for it already, that I had never submitted:
> >
> > From 7d6f40414490092b86f1a64d8c42426ee350da1a Mon Sep 17 00:00:00 2001
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Mon, 7 Dec 2020 23:24:20 +0100
> > Subject: [PATCH] mm: percpu: fix section mismatch warning
> >
> > Building with arm64 clang sometimes (fairly rarely) shows a
> > warning about the pcpu_build_alloc_info() function:
> >
> > WARNING: modpost: vmlinux.o(.text+0x21697c): Section mismatch in
> > reference from the function cpumask_clear_cpu() to the variable
> > .init.data:pcpu_build_alloc_info.mask
> > The function cpumask_clear_cpu() references
> > the variable __initdata pcpu_build_alloc_info.mask.
> > This is often because cpumask_clear_cpu lacks a __initdata
> > annotation or the annotation of pcpu_build_alloc_info.mask is wrong.
> >
> > What appears to be going on here is that the compiler decides to not
> > inline the cpumask_clear_cpu() function that is marked 'inline' but not
> > 'always_inline', and it then produces a specialized version of it that
> > references the static mask unconditionally as an optimization.
> >
> > Marking cpumask_clear_cpu() as __always_inline would fix it, as would
> > removing the __initdata annotation on the variable.  I went for marking
> > the function as __attribute__((flatten)) instead because all functions
> 
> I had to look this one up; it's new to me!
> https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
> https://awesomekling.github.io/Smarter-C++-inlining-with-attribute-flatten/
> 
> Seems pretty cool/flexible to control inlining on the caller side!
> 
> At the least though, we should avoid open coding the function attributes.  See
> include/linux/compiler_attributes.h
> 

Arnd do you mind spinning a new version to add __flatten to
compiler_attributes.h?

> Testing quickly in godbolt, __flatten__ has been supported since at
> least clang 3.5 and gcc 4.4, FWIW (so it doesn't need a
> __has_attribute guard).
> 

Thanks for testing this!

Thanks,
Dennis
