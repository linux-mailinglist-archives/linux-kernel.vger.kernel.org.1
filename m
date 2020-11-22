Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157212BC899
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKVTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgKVTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 14:22:29 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BFC061A4A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 11:22:29 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so15649511ljo.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zCFPYC7NieJSPwfWvwXaHyvNAXU5hOa2nbtBXCuwjQ=;
        b=VxGhmukWqaHWigNsKzqHqk9TIPfVskleOV5Imj9Zf5YAT4dgZBn2NNVPb5hXde0AlD
         2ounXEXn95qj7dZBgtxlxlEWoJZnBVysC4tfTJYRJiyrLiBCBMLj5xiiQwK5jqsSwF9q
         ACr7jjAQeuMF7X3NiHUezng0xq4TE6ipz5CbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zCFPYC7NieJSPwfWvwXaHyvNAXU5hOa2nbtBXCuwjQ=;
        b=SgrWzBOciz7jcFiahLChTWfc55D3Dzq9iezl/124RiAlfZEgJOWS8u62tr8kfW4FVW
         pXBdGAfKukNNlWG+wKz391xHx+gOhwYJJMxNkKMYLaF0IkhXJnhN5FImKSz1lY+8lpVL
         YiT8NWVOHVTYu0v8XjhpGZmc77hXZaWxiIxEQha84E+KRYtzvCCTxrlQr2SIXbVBd4hm
         HNbQZwsUIlCDXt6Djtvbh4o+gJYA7HNcCT3dEKhSz9cQH/zrNLxfQHP6PSMg967NvNM9
         yqm+4A2NizP57N3pJwIWuZq4UbNOFVhrSBY5Ze6ZVZ81BDTXz0Lwm8MfCng7c+tAR1xY
         Lulw==
X-Gm-Message-State: AOAM530bdPYPw4QRRrTNUcOKbJKHFFmNsi7HZOEIJtjQAu656U9LR5+Z
        TWKYeD1nGRHWPz1MZ3RGw4QpWeH7OLyrqw==
X-Google-Smtp-Source: ABdhPJz6z2ntBf3duHEmAT/h2eK2fcIH+Fq3VQyqDp9KwliW5fPRRANHb1/IiZh/Q85Pm5ivGWUXyA==
X-Received: by 2002:a2e:910f:: with SMTP id m15mr2207869ljg.467.1606072946527;
        Sun, 22 Nov 2020 11:22:26 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s1sm1121264lfd.236.2020.11.22.11.22.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 11:22:25 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id r18so907122ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 11:22:25 -0800 (PST)
X-Received: by 2002:a2e:50c:: with SMTP id 12mr444533ljf.371.1606072944698;
 Sun, 22 Nov 2020 11:22:24 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com> <254318.1606051984@warthog.procyon.org.uk>
In-Reply-To: <254318.1606051984@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Nov 2020 11:22:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
Message-ID: <CAHk-=wggLYmTe5jm7nWvywcNNxUd=Vm4eGFYq8MjNZizpOzBLw@mail.gmail.com>
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 5:33 AM David Howells <dhowells@redhat.com> wrote:
>
> I don't know enough about how spectre v2 works to say if this would be a
> problem for the ops-table approach, but wouldn't it also affect the chain of
> conditional branches that we currently use, since it's branch-prediction
> based?

No, regular conditional branches aren't a problem. Yes, they may
mispredict, but outside of a few very rare cases that we handle
specially, that's not an issue.

Why? Because they always mispredict to one or the other side, so the
code flow may be mis-predicted, but it is fairly controlled.

In contrast, an indirect jump can mispredict the target, and branch
_anywhere_, and the attack vectors can poison the BTB (branch target
buffer), so our mitigation for that is that every single indirect
branch isn't predicted at all (using "retpoline").

So a conditional branch takes zero cycles when predicted (and most
will predict quite well). And as David Laight pointed out a compiler
can also turn a series of conditional branches into a tree, means that
N conditional branches basically only needs log2(N) conditionals
executed.

In contrast, with retpoline in place, an indirect branch will
basically always take something like 25-30 cycles, because it always
mispredicts.

End result:

 - well-predicted conditional branches are basically free (apart from
code layout issues)

 - even with average prediction, a series of conditional branches has
to be fairly long for it to be worse than an indirect branch

 - only completely unpredictable conditional branches end up basically
losing, and even then you probably need more than one. And while
completely unpredictable conditional branches do exist, they are
pretty rare.

The other side of the coin, of course, is

 - often this is not measurable anyway.

 - code cleanliness is important

 - not everything needs retpolines and the expensive indirect branches.

So this is not in any way "indirect branches are bad". It's more of a
"indirect branches really aren't necessarily better than a couple of
conditionals, and _may_ be much worse".

For example, look at this gcc bugzilla:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952

which basically is about the compiler generating a jump table (is a
single indirect branch) vs a series of conditional branches. With
retpoline, the cross-over point is basically when you need to have
over 10 conditional branches - and because of the log2(N) behavior,
that's around a thousand cases!

(But this depends hugely on microarchitectural details).

             Linus
