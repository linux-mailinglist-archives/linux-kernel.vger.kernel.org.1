Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC83827F5E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgI3XWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbgI3XWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:22:15 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C65C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:22:14 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v60so2564309ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGlnswLCEbO8zj3EJbctth4RiRNCq3y8UGSmi1Mw83E=;
        b=o6wFEBgIzTm9Qy5lEIMUS/k8X2PABBVt1TCORpbI/sROaLzcsJIjQraiWU9XcnujRF
         4EqBI/4aPa/ucrjdz0MSrCEVlut+eqiudSD5l8CaT+MmrMctt0aK+iO8fX52uI6VogGP
         vVd8d5P04W2IllMoLxdJpu3I4i4p3UD8uGUoATr51xPDShI0sM1ctjqsJsJWQUUdNUr6
         fgjee1q2DQYiNxzaEwnEG+JzDY8joxBgMNyTAp7w7uvMpoAZImKfwkID0abaMoow8aG5
         03hxtsXXDXkLKYEToY+C8ZAshPt/pC2XGh/AivywvzI5x7m8C5L5Xn+JBuFmSGjxsh7T
         VArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGlnswLCEbO8zj3EJbctth4RiRNCq3y8UGSmi1Mw83E=;
        b=gWwUZ9+MDfobsMHK01GjWme5sVPmJLdaVTN7lI+L8C1fnoMGnfhT/0rB2yrE4EOI7o
         xhbWKNeFUlmpFsSfqGegwkrhR7kKJVEh1pe6MsuTS3mjW8qrfxiFhz+SbdWFsImSJcXI
         S+/QpMu6+aJAZjZVSVz0yHwR5F5ca8QVQtMZrF0O/Qj+/poPWzkh/FmFRT7yh3CnUSGw
         xbKStelU6jk99YhGb1L7meYBifTHbA1qRXWBy4wt+e78UukMrPMTDjNuVXnXmQ/9pVNO
         2wdvKqSHmwX7zvntKUawWfj5VIMGN045U/0Py129ZjAYXOjVipWPSEXQnVZ3zONwKW18
         I3LQ==
X-Gm-Message-State: AOAM5320Wdm/UbysnYNts77lcGxS3qTBUi5zACUNlYoD+Rb+qRk0Zfoa
        3oMqG3BMsk1qBOozq5VR3k70Mj27OzsROhB3xbkkxg==
X-Google-Smtp-Source: ABdhPJx0nCwi62CTHcPTZSjFp3h6IxK3xoGUNxz4YS/KvWpXzEDzAx8kw3NKuYQBZBxL81jZXILzT/zQEcR9j/CcM70=
X-Received: by 2002:a25:c549:: with SMTP id v70mr6871788ybe.516.1601508133034;
 Wed, 30 Sep 2020 16:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez1-PBCdv3y8pn-Ty-b+FmBSLwDuVKFSt8h7wARLy0dF-Q@mail.gmail.com>
In-Reply-To: <CAG48ez1-PBCdv3y8pn-Ty-b+FmBSLwDuVKFSt8h7wARLy0dF-Q@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 30 Sep 2020 16:22:00 -0700
Message-ID: <CANN689HJoFxU+EhbtxEDXWngQqJzc-8LE0erWKVyLQ9wXuZK4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] binfmt_elf: Take the mmap lock around find_extend_vma()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 6:20 PM Jann Horn <jannh@google.com> wrote:
> create_elf_tables() runs after setup_new_exec(), so other tasks can
> already access our new mm and do things like process_madvise() on it.
> (At the time I'm writing this commit, process_madvise() is not in mainline
> yet, but has been in akpm's tree for some time.)
>
> While I believe that there are currently no APIs that would actually allow
> another process to mess up our VMA tree (process_madvise() is limited to
> MADV_COLD and MADV_PAGEOUT, and uring and userfaultfd cannot reach an mm
> under which no syscalls have been executed yet), this seems like an
> accident waiting to happen.
>
> Let's make sure that we always take the mmap lock around GUP paths as long
> as another process might be able to see the mm.
>
> (Yes, this diff looks suspicious because we drop the lock before doing
> anything with `vma`, but that's because we actually don't do anything with
> it apart from the NULL check.)
>
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for these cleanups :)
Acked-by: Michel Lespinasse <walken@google.com>
