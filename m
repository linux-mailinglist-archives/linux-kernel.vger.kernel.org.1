Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120D2BC156
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgKUSHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgKUSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:07:38 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8CCC061A4A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:07:36 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b17so13476768ljf.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbDKuZb+4Xb0jnFLMLI8Wgp1RRr72QWDPW82I4gNVQ8=;
        b=EOxOPwqq1GcYc9TUwp2yv+S/40fBT3XQ6H4HT/ScAtNnRpMAsn/+yLf4uXUS8tYg/A
         KtUZ3nka7qWypTUKfVYmU7PlM6lJaw733/dbOueSWHEUqI8+yImVfzbF/XURUEqf/NnS
         EN7t2k+XkIuK+a6+4jG/PtOBQjpYB7DAMlI+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbDKuZb+4Xb0jnFLMLI8Wgp1RRr72QWDPW82I4gNVQ8=;
        b=lPHirL3YrYhmV4fTKriLZmlyxTeF4IBRmf7JrU3JHIezQTzr9eI0RuUdmPVGg5uLlK
         lndqVCbzgWTR99kuu/mTefXG6KLvaw+pP4NoTFNTK9DZIlknBMlNigsqDTjmf3VlcYdv
         uaCSY8aP989M4lP/C9NgAcGq4yMHAw3Q7Cfahpw7zHZVyJTeX7NlwYFRA9pb44xNqfrZ
         2GNErEogSActvjxxkSxBmyonC8SfwkY7XlfofcdHOVXPW85EQX70i9HqOtj20wAMbkBE
         8F5abuhG7GHeImb8Kr5cFFgcTmbs5bUZ1pQO9NCJLzNiKaSmDjpeEgZr+MjX9Y1xUPub
         Sw5A==
X-Gm-Message-State: AOAM530mPS65TlucKWhFQEYyMa2PbgWrB0HrLYgvK+2VE3oVf6rQg4TV
        hG1XaynuHLsLbNnNRkLEKFYrw9gHD/OAEA==
X-Google-Smtp-Source: ABdhPJzkn8j/XmAYbbtloDq8oHhPQDyFim350+aWbMFiRZoMuaRyF0979Vfjg/Z8+UB2hUElKdyFSA==
X-Received: by 2002:a2e:1607:: with SMTP id w7mr10270594ljd.419.1605982053993;
        Sat, 21 Nov 2020 10:07:33 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b25sm777918lfi.173.2020.11.21.10.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:07:32 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l10so13529562lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:07:32 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr9706686ljo.371.1605982052487;
 Sat, 21 Nov 2020 10:07:32 -0800 (PST)
MIME-Version: 1.0
References: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
 <CAHk-=wjrayP=rOB+v+2eTP8micykkM76t=6vp-hyy+vWYkL8=A@mail.gmail.com>
 <4bcf3012-a4ad-ac2d-e70b-17f17441eea9@kernel.dk> <CAHk-=wimYoUtY4ygMNknkKZHqgYBZbkU4Koo5cE6ar8XjHkzGg@mail.gmail.com>
 <ad8db5d0-2fac-90b6-b9e4-746a52b8ac57@kernel.dk> <d7095e1d-0363-0aad-5c13-6d9bb189b2c8@kernel.dk>
In-Reply-To: <d7095e1d-0363-0aad-5c13-6d9bb189b2c8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:07:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyRpBW_NOCKpJ1rZGD9jVOX80EWqKwwZxFeief2Khotg@mail.gmail.com>
Message-ID: <CAHk-=wgyRpBW_NOCKpJ1rZGD9jVOX80EWqKwwZxFeief2Khotg@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.10-rc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Actually, I think we can do even better. How about just having
> do_filp_open() exit after LOOKUP_RCU fails, if LOOKUP_RCU was already
> set in the lookup flags? Then we don't need to change much else, and
> most of it falls out naturally.

So I was thinking doing the RCU lookup unconditionally, and then doing
the nn-RCU lookup if that fails afterwards.

But your patch looks good to me.

Except for the issue you noticed.

> Except it seems that should work, except LOOKUP_RCU does not guarantee
> that we're not going to do IO:

Well, almost nothing guarantees lack of IO, since allocations etc can
still block, but..

> [   20.463195]  schedule+0x5f/0xd0
> [   20.463444]  io_schedule+0x45/0x70
> [   20.463712]  bit_wait_io+0x11/0x50
> [   20.463981]  __wait_on_bit+0x2c/0x90
> [   20.464264]  out_of_line_wait_on_bit+0x86/0x90
> [   20.464611]  ? var_wake_function+0x30/0x30
> [   20.464932]  __ext4_find_entry+0x2b5/0x410
> [   20.465254]  ? d_alloc_parallel+0x241/0x4e0
> [   20.465581]  ext4_lookup+0x51/0x1b0
> [   20.465855]  ? __d_lookup+0x77/0x120
> [   20.466136]  path_openat+0x4e8/0xe40
> [   20.466417]  do_filp_open+0x79/0x100

Hmm. Is this perhaps an O_CREAT case? I think we only do the dcache
lookups under RCU, not the final path component creation.

And there are probably lots of other situations where we finish with
LOOKUP_RCU (with unlazy_walk()), and then continue.

Example: look at "may_lookup()" - if inode_permission() says "I can't
do this without blocking" the logic actually just tries to validate
the current state (that "unlazy_walk()" thing), and then continue
without RCU.

It obviously hasn't been about lockless semantics, it's been about
really being lockless. So LOOKUP_RCU has been a "try to do this
locklessly" rather than "you cannot take any locks".

I guess we would have to add a LOOKUP_NOBLOCK thing to actually then
say "if the RCU lookup fails, return -EAGAIN".

That's probably not a huge undertaking, but yeah, I didn't think of
it. I think this is a "we need to have Al tell us if it's reasonable".

                Linus
