Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38492290E19
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411394AbgJPXVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410893AbgJPXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:21:40 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F4C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:21:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j8so4554966ilk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ulZ+tmdqBb+S0GzKOYD5fGwSZeOurFPRpc1Xyo7iyc=;
        b=euz46EZxLI9Anl4rbigu2pBhX9aMKb3nLNFgytSoAzzEqHArebFezY2UQFuF6yZi78
         7BV5knmNrMDGVavcJpxNx+rfC1XKoF67IV+kiB/vrFKgXWI8/Ha6V0blusE083OXVDbp
         mVJWjIvA9cwEyqCjyBouIC4W2lsyqurDIAvKefJj0e+CZOwzKhd5aX50Yz/wOaJdmFBx
         pdIrh/HLFlrHC8NR8zcr1N6shVvwtnP5gD/Q60zy6Yo694nxG8XYi4seRD14PxjJYGU1
         KtfzdqUypV2SjOWNCUb4kq6vzGkHXadbDsnI8rFJcQ7knwhKrPgp2Fk9UbaKka1PL/fT
         kdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ulZ+tmdqBb+S0GzKOYD5fGwSZeOurFPRpc1Xyo7iyc=;
        b=Ssx5NoY3De3/AeswWH+UWgPipuH2SmIiWU8B+/Zrcc2JP7aZXBBsMyBLWzq6uyDnhv
         qoCjPxVmoP2QbbBrSuXB2/1zcQ18nHHvoJ6HnNRRsgQfNj82d8D5XVKePdowAirAxdlQ
         vgAPt/2BFFpt12imWASAA5qY8djiw7pedl55Vm5B+oKhxuIDsHQBdnWvPkZnYfoWnJW6
         N3ucuLmGrFcer7oCrE07VKxF05aFWCgtJ9quMyZ8ZarklZq/xtHNJzgBlHpdQ4GcMLxF
         +uZJgcjsqm0HS47bYi428h9DeaeeoPVf1Fd4TOQGfxBz3kNfZwJ18992sdojOTjBc92P
         o1jg==
X-Gm-Message-State: AOAM530e+y+gwfZloho9h/U1nz6UiAZis+Q2pOhWcuoLJ4MVBQUm1y5q
        p/DNe1nOiJmnzjwQlJTb3AAX1Q==
X-Google-Smtp-Source: ABdhPJzjFd8h3bHaBoh0ogIzaDiyMMdYUfkan6OvINr5ocgY2Acjoku40/3OIptHi7g/ZGy1gzm0Sg==
X-Received: by 2002:a92:d5c1:: with SMTP id d1mr4372060ilq.212.1602890515637;
        Fri, 16 Oct 2020 16:21:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 144sm4089074ila.42.2020.10.16.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:21:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTZ2n-001Abo-Uc; Fri, 16 Oct 2020 20:21:53 -0300
Date:   Fri, 16 Oct 2020 20:21:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH resend 3/6] mm: Add refcount for preserving mm_struct
 without pgd
Message-ID: <20201016232153.GD37159@ziepe.ca>
References: <20201016230915.1972840-1-jannh@google.com>
 <20201016230915.1972840-4-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016230915.1972840-4-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
> Currently, mm_struct has two refcounts:
> 
>  - mm_users: preserves everything - the mm_struct, the page tables, the
>    memory mappings, and so on
>  - mm_count: preserves the mm_struct and pgd
> 
> However, there are three types of users of mm_struct:
> 
> 1. users that want page tables, memory mappings and so on
> 2. users that want to preserve the pgd (for lazy TLB)
> 3. users that just want to keep the mm_struct itself around (e.g. for
>    mmget_not_zero() or __ptrace_may_access())
> 
> Dropping mm_count references can be messy because dropping mm_count to
> zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
> work from RCU callbacks (which run in IRQ context). In those cases,
> mmdrop_async() must be used to punt the invocation of __mmdrop() to
> workqueue context.
> 
> That's fine when mmdrop_async() is a rare case, but the preceding patch
> "ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
> the common case; we should probably avoid punting freeing to workqueue
> context all the time if we can avoid it?
> 
> To resolve this, add a third refcount that just protects the mm_struct and
> the user_ns it points to, and which can be dropped with synchronous freeing
> from (almost) any context.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/kernel/tboot.c    |  2 ++
>  drivers/firmware/efi/efi.c |  2 ++
>  include/linux/mm_types.h   | 13 +++++++++++--
>  include/linux/sched/mm.h   | 13 +++++++++++++
>  kernel/fork.c              | 14 ++++++++++----
>  mm/init-mm.c               |  2 ++
>  6 files changed, 40 insertions(+), 6 deletions(-)

I think mmu notifiers and the stuff in drivers/infiniband/core/ can be
converted to this as well..

Actually I kind of wonder if you should go the reverse and find the
few callers that care about the pgd and give them a new api with a
better name (mmget_pgd?).

Jason
