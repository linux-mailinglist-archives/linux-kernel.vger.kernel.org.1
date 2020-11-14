Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A602B2F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKNSCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:02:30 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265EC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:02:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so14797991ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibtq6RXVDNjvkead7Ak59B6ZtQU5QsMZHSgKTB4ZKxE=;
        b=IXKRzHPoWDYWN9OYXoXloIN5WAiasM9las6O6WsRBjZljQpWwA1el5ju0zRrSHXFjy
         ZvXkEoyYJDmSDb99dUOBT9iKYvZtKxArz3X9pctM/j+kogLQDs0CNsKoJPyujpFjb09z
         uWEZqUeVi3zDlTQQSjdj7m2aYc/u1vMgfDA8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibtq6RXVDNjvkead7Ak59B6ZtQU5QsMZHSgKTB4ZKxE=;
        b=ueown8dr3laMkVKDM/h3qVgBdBTefnoskBwRbiY4zabN16sKcMwOamy5hu2pgHUQ25
         8ZI5yV+zxGrRQGrJkInWRvihjeVYV8SsazMKxc19Ysf9P4MdFGqv03kuQ0c9gsaPCBNT
         jIFV9+jdiUsXXR89E56iBSLgZsHRxxG2nCVt5yKLuEGA0++mNHY6S0qXPwedqr4/VTZB
         73TVKHrEHGrDa2JSZrROPxC/p2EiXoaUvwQ/DBcRMh3843keiOnYDVB4Lsh0RxqR6Ez9
         GdddhsiJ97ITAzLHixK9AZPe75KCcEW8ggeOrVhdXN+QxwCorthLGSmt6XfVXnbtyxj5
         n2aA==
X-Gm-Message-State: AOAM5306ukSLNe4Rniz2anNTKDiWy8P6MgbL4lc9j6rdR2rEEW1F5Zb9
        M2dNUZQpThcFgz3RjYIXe/ZzZG5Kms3/dw==
X-Google-Smtp-Source: ABdhPJzLUNfETuMQzqfOBk+S2iPxgNCdu2AdZHEJwqStm+E/YlOTYPZkq+TM6iiBAnkYRV7nBWjKow==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr3009719ljo.165.1605376947704;
        Sat, 14 Nov 2020 10:02:27 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y6sm2045119lfh.99.2020.11.14.10.02.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 10:02:26 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id p12so14820405ljc.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 10:02:26 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr2218287ljk.102.1605376945980;
 Sat, 14 Nov 2020 10:02:25 -0800 (PST)
MIME-Version: 1.0
References: <46823b75d3c54a89a7192d8e1011e212@AcuMS.aculab.com>
In-Reply-To: <46823b75d3c54a89a7192d8e1011e212@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Nov 2020 10:02:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZbMaEFFftonkjDGMtFDzOEzUyhbkSzE9Th21zNGaRtA@mail.gmail.com>
Message-ID: <CAHk-=wiZbMaEFFftonkjDGMtFDzOEzUyhbkSzE9Th21zNGaRtA@mail.gmail.com>
Subject: Re: load_unaligned_zeropad() on x86-64
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 7:53 AM David Laight <David.Laight@aculab.com> wrote:
>
> The change e419b4cc585680940bc42f8ca8a071d6023fb1bb added
> asm code for load_unaligned_zeropad().
>
> However it doesn't look right for 64bit.
> It masks the address with ~3 not ~7 so the second
> access could still cross a page boundary and fault.

Can you explain more what you think is wrong?

It uses

                "and %3,%1\n\t"

for the masking, but note how that's a "%3", not a "$3".

And %3 is this asm argument

                "i" (-sizeof(unsigned long)),

which is -4 or -8 (which is the same as ~3 or ~7).

The other masking is to get the byte offset within the unsigned long,
to do the shifting. Again, that uses '%4', which is

                "i" (sizeof(unsigned long)-1));

so 3 or 7.

So on my build, the code expands to

1:      mov (%rsi),%rdx # MEM[(long unsigned int *)ct_58], ret
2:
.section .fixup,"ax"
3:      lea (%rsi),%rcx # MEM[(long unsigned int *)ct_58], dummy
        and $-8,%rcx    #, dummy
        mov (%rcx),%rdx # dummy, ret
        leal (%rsi),%ecx        # MEM[(long unsigned int *)ct_58]
        andl $7,%ecx    #
        shll $3,%ecx
        shr %cl,%rdx    # ret
        jmp 2b
.previous

which looks ok to me.

It's possible that it's buggy (that page crossing basically never
happens - only with PAGEALLOC debugging, and even then only in some
really odd and unlikely situations). So it gets basically zero test
coverage, which is never a good thing. But if it's buggy, it's not
obvious to me, and I don't see any ~3 issue.

            Linus
