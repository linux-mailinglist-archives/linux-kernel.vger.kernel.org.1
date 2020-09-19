Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7906F270A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgISDE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISDE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:04:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C45BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:04:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m5so8160315lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1Ix3nDJUNCSSkI/qDnAEimI2vgF9CCBIhywdlTaE0U=;
        b=ELTsF7aYKL++ZnB8PzR2rM3B1QcCJLHPvQYUx/dbB0a5QGG2kNoBlM8rGw9xtfLHxI
         D5tTl0yi38La6jzPpyM77PdBMImhhiBH0F+P41vUTVj+kLSItaS/1xq+kUcvn5X6V4WI
         0vhbET7ZJMd4GFhXV+gyaSoYWQog+Xh8VfXIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1Ix3nDJUNCSSkI/qDnAEimI2vgF9CCBIhywdlTaE0U=;
        b=PeA1+sZoRx8firhLl3WgEjwO6qwv7EU89fuuuZxOdbO0P24QBhSE93K5+expPRtO4i
         xtI8PxiVSz99UhT89xOu0DKCGN74zxhy1Bi4IsOYaiem2UmACUoaWCPuPeWxn1cVT2cG
         ss55o6QPo/X8rRFURcO06+WubFKHLN7Hfez4RY++EHKCC8fv4suq91uzFx/l+wOaHzvW
         HfYw2GiykdeQWXGFtQOFlyhFbQyeGUy3LTYbCUU2g5bBuY2hjGTZsvKJ28Zx6+miiA1A
         840/ZhgkQ+qSiaoDK9j0Ku+z+gdfZNyMwnCqSP7YjtU7jXxdmXTVp5Bb0Ovi4sdFjrsk
         aQQA==
X-Gm-Message-State: AOAM533KjeIXhI7u4tURS5308PzqnvEGviRUxHTuWatpdZ0DuBfZxLWb
        w9qVHOhfGGBNCBYmnJsU3UGduhOeKKcBxQ==
X-Google-Smtp-Source: ABdhPJwQIu0X+GEmjuPmwxGwmh8GYs6JmJxJviHi7vNkQKgnKTiDFJXpWIPmSjLF9wjKBGrgRH0Qzg==
X-Received: by 2002:a05:6512:214c:: with SMTP id s12mr12511701lfr.578.1600484664179;
        Fri, 18 Sep 2020 20:04:24 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q18sm980408lfr.138.2020.09.18.20.04.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 20:04:23 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y17so8163324lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 20:04:22 -0700 (PDT)
X-Received: by 2002:a19:8907:: with SMTP id l7mr11418508lfd.105.1600484662603;
 Fri, 18 Sep 2020 20:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200918193426.GA15213@embeddedor> <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org> <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan> <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan> <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan> <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
 <20200919025336.GA3008405@rani.riverdale.lan>
In-Reply-To: <20200919025336.GA3008405@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 20:04:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqeOiHk2wjRg76M4-zCVFBkO29eTgpjc4tsLm=+AnKxw@mail.gmail.com>
Message-ID: <CAHk-=whqeOiHk2wjRg76M4-zCVFBkO29eTgpjc4tsLm=+AnKxw@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 7:53 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Is it ever necessary to allocate _at least_ sizeof() even if
> offsetof()+size is smaller?

Not that I can tell.

Obviously all allocators tend to have their own alignment concerns, so
they'll all align things up internally anyway.

But why would the alignment of the earlier members of the structure
have anything to do with the size of it? That's nonsensical outside of
the array situation, I feel.

Of course, maybe somebody has such a case: an "array of structures,
each with the same size of flexible array member". And then you _do_
want to align all those entries.

But honestly, once you start doing things like that, why would you
only have one single structure type, much less just one single size of
that flexible array? If you lay out these variably-sized things in
memory each after each other, maybe you lay out multiple different
_kinds_ of variably sized structures?

So there are lots of reasons to want alignment at the end, but why
would the alignment be the same as the beginning of that particular
type?

That said, in the kernel, this probably practically never really
matters. Because typically, our allocation alignment tends to be
bigger than any individual structure type alignment anyway.

So it's probably all moot. The difference between using "sizeof()" and
"offsetof()" is in the noise and not important per se.

No, the real reason I would advocate using 'offsetof()' is really just
that I'd rather have 'sizeof()' cause a warning.

> I think you can't do this in standard C. It's a GCC extension.
>
>         A structure containing a flexible array member, or a union
>         containing such a structure (possibly recursively), may not be a
>         member of a structure or an element of an array. (However, these
>         uses are permitted by GCC as extensions.)

Ahh.

But I'm pretty sure the 'sizeof()' thing is actually the standard, not gcc.

Arrays of those things is odd, and apparently the standard got that
right. Good (but I think it also means that allowing sizeof() makes
even less sense).

            Linus
