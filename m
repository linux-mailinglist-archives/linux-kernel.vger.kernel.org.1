Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5B2FBF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391094AbhASS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392398AbhASSKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:10:50 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t6so10978018plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFtaJ8H/Mdt6Sr1dyWjnP3+YFNQP6voHmOJMCqsGuZc=;
        b=iTVqpmbodJAS/fRwVB62yMOqY+/c0mu4CTjbAtwQSfYD7Nxf/AZLVYfyjqQllGlOWP
         UAfvd1YwBr6bESOa7T7EFjDtucZNwjT683RxHTkg2kjxJusaGxJJ7qD7k5dRxYCwIzoK
         /yr6xEt/ZstK8Q7lOOYyrqTeIgXA7uSeJVSEACczeci9SjJnKW3xRcKUukqH04pLTS4F
         XpB53mwPxSXorHzac4kqn5YGbG1YG2Sc15HE37GEPEiO0wmC+T88m11TPP2eUz2Y19FW
         SPB3ip1NqxRz+w6p07V4+f55c6RYFhur1KXl71XtOnVeEZtxG76V9pqDA3s3bxU1nBfa
         xG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFtaJ8H/Mdt6Sr1dyWjnP3+YFNQP6voHmOJMCqsGuZc=;
        b=JmmIklDzpOgsRsk1nFrMl8KX84W+ORlQ5UO1TCq/rCnjb8m2Q8L8hpLCUo3xgpSwOd
         m51xLDSoMtgw1JkBeXu15Fjpst0MVhKjBm79bCYLcY2reTHKCwq3Ifx5yTo7oh5vO76o
         luaIZzI0FDg3RErndRX5GPAd2DLMbXakSpyBtysVQV2Oyb04DGC+O++v+1Y3lQtg0+8Z
         SiXcudOP5SWru/SHi4NgQ7jDXiYm1QfZrJIYQE6m1EWZoFCO6753qRUCEIQ0cd5EFfPc
         nVGKVa1Ki6ca76Jiz+VNNQJDrBMmGvL54F4jsrTivkce6NI0t01EJ+oU4faJ4I1JkmwT
         Ko/Q==
X-Gm-Message-State: AOAM530Lhpq4pWSUw3GBaRaB8S4mD4lPmk463FRY38foYy6eyvNYJOSR
        2x4xtS3CHKR/oDG5fOOEKrjSPevPUlA0Wi1og10onBIVXwQ=
X-Google-Smtp-Source: ABdhPJw37AqXfJn7ksx2H7kRJlKS/FI1/oUwiEcV0bted0CPYbP2xYgPP8v3Q/2KK3eiPkEi9t+AIxKn5LpEbeAYY1E=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr992416pjb.166.1611079809851;
 Tue, 19 Jan 2021 10:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210118183033.41764-1-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 19:09:58 +0100
Message-ID: <CAAeHK+xmmTs+T9WNagj0_f3yxT-juSiCDH+wjS-4J3vUviTFsQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 7:30 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
>
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
>
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
>
> The series contains as well an optimization to mte_assign_mem_tag_range().
>
> The series is based on linux 5.11-rc3.
>
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
>
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async

Hi Vincenzo,

This change has multiple conflicts with the KASAN testing patches that
are currently in the mm tree. If Andrew decides to send all of them
during RC, then this should be good to go through arm64. Otherwise, I
guess this will need to go through mm as well. So you probably need to
rebase this on top of those patches in any case.

Thanks!
