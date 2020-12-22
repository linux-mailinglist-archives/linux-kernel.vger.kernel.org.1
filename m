Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA52E0FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLVVoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 16:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgLVVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 16:44:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE72C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 13:43:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r4so8075565pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V18RJFVoSD2HfPTrMybJhWRx+16Y//JP10XUyAiF9C0=;
        b=MoFoz97ipfgL0tskYxv3eUZrXs1Gtf4S6AIT48y4RoUx4gTy/pyHeDU0ASRe4+CTGV
         6EQPpsfEG8ojet/F+BqJP7osfq2axER1b9OdQ5I7dbdF8eIZ5zNdTK9moJab2eBpN90w
         Vqz2Kherc3CmoKwR9ICk4/+1KBetvtuXSFh+kNpzebgvZW1e10DodKAND41hjcHoL7O1
         aPBdL2Cp6KXghjcUF5GrxhFp4g+00u7vCveST0JC+7XDzWJjhpp47uHFhFbzr8/ZqfKw
         O4BIlbC80rAzXV+Cw98wRd4KHOlJJ73+yFwfcfXmpcLWmwDJ8GtjtZWcE5k59g3GypE5
         qpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V18RJFVoSD2HfPTrMybJhWRx+16Y//JP10XUyAiF9C0=;
        b=WAwTlepQBeY9pOIpu3CII6wHjluuKHN+ISVcMDarT5f2LhD2op804qOVTQDCBrNTe6
         /4jfjco2GjcQTpbzoFid1C0BK0zIMzllmL9KhcXxdigf/zjYHvPThzVa0oMbA4uAkqal
         gl/PFJLpXKm1rZMQsKv9uwQ3bPqq6yiM63ItgzXphgHTGFxM48bumDEGkXuzF7yqAKLe
         f1dinLa5Abt+S2BylB95MzpTXJp13OEpz2Ligs5XvFD4Nv5H1G4ntpzgJhudWF92xcmL
         SwRwR9MRwxbHCZ7nBW0o1wZcKGpKqooVYpt9fpvb8Ny9b6H3CvSoXgRsrPatD++KveDJ
         WvJQ==
X-Gm-Message-State: AOAM531K845FNSkld6yFveq9zr+HdhsOgH57tVLL8IECMVOGqAq5ifuT
        ssPtT4R0WbdBMsN85nS+nl3kXA==
X-Google-Smtp-Source: ABdhPJynPZBPU88MgcEl5WcwU0cdYjZC20/3FRJRStClymFa4iKtg9+XkPvnpAcMdwtKD+bNajR6Jw==
X-Received: by 2002:a17:90a:fc83:: with SMTP id ci3mr24052182pjb.145.1608673407151;
        Tue, 22 Dec 2020 13:43:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s29sm22665086pgn.65.2020.12.22.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 13:43:26 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:43:23 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: building csky with CC=clang
Message-ID: <20201222214323.655tjdqdvxhw3722@google.com>
References: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-22, 'Nick Desaulniers' via Clang Built Linux wrote:
>Hello!
>I was playing with some of LLVM's experimental backends (m68k) and saw
>there was a CSKY backend. I rebuilt LLVM to support CSKY, but I ran
>into trouble building the kernel before even getting to the compiler
>invocation:
>
>$ ARCH=csky CROSS_COMPILE=csky-linux-gnu- make CC=clang -j71 defconfig
>...
>scripts/Kconfig.include:40: linker 'csky-linux-gnu-ld' not found
>
>My distro doesn't package binutils-csky-linux-gnu, is there
>documentation on how to build the kernel targeting CSKY, starting with
>building GNU binutils configured with CSKY emulation?

Note also that the llvm/lib/Target/CSKY has not been fully upstreamed
yet. It is a WIP https://lists.llvm.org/pipermail/llvm-dev/2020-August/144481.html
I will not expect clang csky to work currently.
(The latest committed LLVM patch is https://reviews.llvm.org/D93372
Normally committing an important piece of a large patch series like this should take
a bit longer time longer after someone in the community accepted it
https://llvm.org/docs/CodeReview.html#can-code-be-reviewed-after-it-is-committed )

I do want to raise the recent LLVM M68k target. Its patches ([M67k] (Patch */8))
are very organized and the main proposer shares updates to llvm-dev regularly.
There is a lot from the process where the C-SKY target can learn from.
