Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29F2A0D26
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3SMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgJ3SMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:12:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CAC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:12:23 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so7304876ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMmkVHvpx+9c4Kcbr1IxBNO0GDjjw4+qKABw3ISg6v4=;
        b=N5gZbgf19kF710L7m95j69NTDI9+S+/kt13dqsXKEGtqdmahszO6q+LxyMf6h0vNgW
         /AYw4tKsShDI3vrPxwnfaD8K7Uwrb7eKS/K6uIDp5XH1ogWWuaDPb/23l2pPjCrSsFn9
         MDHIxBT/lIYsv4BZCiJR1BEWDyDGfpi/nDaTTK7peWScbMM62KSxdPvCHAW0W8YRqmEB
         yMBj3QxFi3n10BOUyGJr0Yfg9MDNaOKB+2pmZpilKinnsVq+/1T6H2FeDyUK90TBMB3C
         zW++2tZdRiwnBJYdnp1j7yvtksHermYsihxmjFpCKXy9sZfcOLb+xzOC8rMobVki575Q
         Lc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMmkVHvpx+9c4Kcbr1IxBNO0GDjjw4+qKABw3ISg6v4=;
        b=j6B452oN7FspLMGfmWRPzDDCLUy0pZd9hyzaok5EIjxmEMhTAPpgQQdgm13SIQQsLk
         RGQSFpB6tbhFojCbEeNARpD/T6Ibak+7QH9JISJh2waUzhFMi7JpMB/Wd+6qWGgQrQez
         DE5FHiX69hUi7h0r2vcZc85feMN+ZPGzbnIggbYLvKrsgOB0+8qnBs2KWLdgG4o2s3Qk
         Xtm63XelqIxAqku/1AZeju6jvOlkhMllC/iQK2aBpETFVGMHJdphfOJ48tKxPDYXwVfB
         bAaP4HQ1PtEDUICJX9dyVULd2QO0tLPLANKtPSVXQVRV07Sqoht0sIRkUasv+s+QCyJC
         H4Uw==
X-Gm-Message-State: AOAM531SUstM+6ndUy1na5So7rYr4xctBlvlGob79n4ah0FNJyMAuJHF
        8w8LaU0udeWD7NbB71bTcva/4CimyfZY4muee9Ig+Q==
X-Google-Smtp-Source: ABdhPJz3s35TYiyIyaR/Sj8G36G1w0m+9fA+LMFiGCfrE81FXWx7wZAKort7SOId47vTRR1GdgofSZXFpFye4lMiv4U=
X-Received: by 2002:a92:cd0e:: with SMTP id z14mr2732005iln.135.1604081542237;
 Fri, 30 Oct 2020 11:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201030061655.162839-1-dlatypov@google.com> <CABVgOSkn1n-N50YZr7aNTgAGxkj7zkZO31B16Ji88OxM8m2WPQ@mail.gmail.com>
In-Reply-To: <CABVgOSkn1n-N50YZr7aNTgAGxkj7zkZO31B16Ji88OxM8m2WPQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 30 Oct 2020 11:12:11 -0700
Message-ID: <CAGS_qxpr1XiqcGPcfxnsAuxqnyJ0K+0UF-q146oQjsQqyHbm9g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix --raw_output to actually show output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:23 AM David Gow <davidgow@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 2:17 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently --raw_output means nothing gets shown.
> > Why?
> > Because `raw_output()` has a `yield` and therefore is a generator, which
> > means it only executes when you ask it for a value.
> >
> > Given no one actually is using it as a generator (checked via the added
> > type annotation), drop the yield so we actually print the output.
> >
> > Also strip off the trailing \n (and any other whitespace) to avoid
> >   [<601d6d3a>] ? printk+0x0/0x9b
> >
> >   [<601e5058>] ? kernel_init+0x23/0x14b
> >
> >   [<600170d2>] ? new_thread_handler+0x82/0xc0
> > making the output unreadable.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> The bug where --raw_output doesn't show anything is already fixed[1],
> but it does still show the extra newlines.

I'm not sure how I missed that, sorry for the noise.

>
> Maybe it's worth making just the newline fix, and rolling it into the
> other patch[2] handling newlines?

Sounds good.

>
> Cheers,
> -- David
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=3023d8ff3fc60e5d32dc1d05f99ad6ffa12b0033
> [2]: https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/
