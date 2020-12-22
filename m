Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3B2E034F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgLVAMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVAMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:12:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2064C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:11:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so27795464lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTuaw61/vu6Ch8LghemKyv8ZjkRGc9Bd4nL0SHS84i8=;
        b=XRqPvAjqNYfYvdTAPbyVeX/6O742pr4s6sQMYn9OH27FKmpUFDXDQcK9Tl2txOM6YO
         vqCZR/1DVmPxmcBQfj8ygABjF6pmB8V6dG3OaZcI7+9pJSjvqpbcqzrEpWL97R7G4EDm
         qS6LzBxmqQ8dWZpVnIRQLX6xY4Ofvg3UtYHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTuaw61/vu6Ch8LghemKyv8ZjkRGc9Bd4nL0SHS84i8=;
        b=oVKmEuhZk1HLuRK+sOP2i85Lye+IN9qu1P8Wlt6KCU4t4PP8NAeQJ7dDqoFv0Mi0sj
         PJG2oLA7LwTvkw648utP6RHGqYKf/uLiTH7ur4MBvnhmooKcoZlp12+Tr3aA6qQvbFYS
         z8GtNwGBvVKgoVEFdkOh5b0Ya1/r5L0LL/G8xUcOquw94399/eoJsXrTo+cdWFHUfcSW
         YsiIch4VBmqpYgd5KR9j+FxUbQOUIx321hMW65yqj1u1Lhv6SR8haatnr3+kt4c0UuwN
         SUl25tdhP6xV0Lr2RpLkbg2ULnqt3jEdCvX3HkIhoAVlHxUCcOzErhZJuY5B1I2q6/21
         Wxbw==
X-Gm-Message-State: AOAM532RovPWvleieHlHQpWVJUqeQr/ZO2I/BbmGNSd+Rzq/Ff9rMPiV
        V0XIuq2LgirKH1d2erfmiUhPQ0OeUNRqkA==
X-Google-Smtp-Source: ABdhPJwWEcgkz3m1P7Jph0GqQIOwcg0VPDNDUGQTP6VS+DAzqPvq4JhyCXeOqqLYo+SW4SHiPXk8YA==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr7609677lfg.381.1608595879913;
        Mon, 21 Dec 2020 16:11:19 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h13sm2321309lfj.110.2020.12.21.16.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 16:11:18 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id o17so27916415lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:11:18 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr7001569lfi.377.1608595877900;
 Mon, 21 Dec 2020 16:11:17 -0800 (PST)
MIME-Version: 1.0
References: <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com> <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com> <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <X+Er1Rjv1W7rzcw7@google.com>
 <CAHk-=wiEp-D36h972CBHqJ-c8tR9fytg9tesZ1j_9B0ax9Ad_Q@mail.gmail.com> <X+E3FmxrEVfc0B/X@google.com>
In-Reply-To: <X+E3FmxrEVfc0B/X@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 16:11:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWkZGSsPXAbonBoNLYj3vETkoB+9eKOxoFZutPgqkYzA@mail.gmail.com>
Message-ID: <CAHk-=wiWkZGSsPXAbonBoNLYj3vETkoB+9eKOxoFZutPgqkYzA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 4:00 PM Yu Zhao <yuzhao@google.com> wrote:
>
> My first instinct is to be conservative and revert 09854ba94c6a ("mm:
> do_wp_page() simplification") so people are less likely to come back
> and complain about performance issues from holding mmap lock for
> write when clearing pte_write.

Well, the thing is, that simplificaiton was actually part of fixing a
real regression wrt GUP.

Reverting that would break a308c71bf1e6 ("mm/gup: Remove enfornced COW
mechanism").

And that one was the (better) fix for commit 17839856fd58 that fixed a
real security issue, but did it with a big hammer that then caused
problems for uffd-wp (and some other loads). There's a bit more
context in the merge message in commit b25d1dc9474e Merge branch
'simplify-do_wp_page'.

So while that commit 09854ba94c6a on its own is "just" a
simplification, it's actually part of a bigger series that fixes
serious problems.

                Linus
