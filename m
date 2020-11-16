Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4CC2B547D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgKPWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgKPWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:45:18 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26410C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:45:16 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so27400302lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7vyOUozImZ/Vj6DXTZgOyHzaqJaJ4bTWScJHjraJD0=;
        b=UK6m4rwwMQ+ZiM7rMbtI8OVsV31axi0ur3CjKSJorDnX1Gst0vzal/kaV9mEG4xb6D
         2Z7bmH57dHM/vYCD1/L0uTpBBl/ODRTMR8a8eUslaEv91c6Lhx+ef9GETZduzNNe8Z2i
         UNtU6XfCvlAoO6DnIeZq9EkSU2GJlYvyOQDM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7vyOUozImZ/Vj6DXTZgOyHzaqJaJ4bTWScJHjraJD0=;
        b=hxNT1GsSZRF70QejWXOPrQOVThJNDHoxlAI9C2sC89cPJGLn0gLvG9rb58E8+/HAAY
         V8kPvObqEpukn1kplyuVKd1AXynN8W2WkrrrTjgJ+PI5cWeb3LBoDYU4znvqlNOtjx34
         /ixkF00vjmkyt05MnDYhgNnVii6nltsCWXslL1aUdKeY7p/oZuxY/aVHYeva4QDxJusR
         DX9/QF0ED4430XGowtaffJLwrR6BReFvsVnh55dA2NEtC+UaEP7hReVbHVqhqd7RdJlm
         Uc0vyStFehLil0DIoMn2YqPt2ukzobKlvfGw0nT/js/ROoLcI2yQ7ur6cZUpYDjvwqv0
         X4pg==
X-Gm-Message-State: AOAM531q9vnYxJ+aqypNoDRwxPXqk+t9URAFJlsd2zQ9HjKe2Y/31X5i
        cBigb7dzi2EQFIMaGDLCSpIfdEdqTeo2ZQ==
X-Google-Smtp-Source: ABdhPJy8SeFykKTs4SebYyFEleQKbZk5ZyVtfBuUTOWOPtT5ca/ZfkAosIvkeuu2HDnypnON5tJviQ==
X-Received: by 2002:a19:915:: with SMTP id 21mr617898lfj.528.1605566714136;
        Mon, 16 Nov 2020 14:45:14 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y6sm2921507lfh.99.2020.11.16.14.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 14:45:12 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id v20so21985208ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:45:12 -0800 (PST)
X-Received: by 2002:a2e:3503:: with SMTP id z3mr616470ljz.70.1605566711829;
 Mon, 16 Nov 2020 14:45:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605560917.git.dxu@dxuuu.xyz> <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
 <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
In-Reply-To: <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 14:44:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEgTXYgLXg8YxRHnH+eZno800pEp8caskKgDCgq55s+g@mail.gmail.com>
Message-ID: <CAHk-=wiEgTXYgLXg8YxRHnH+eZno800pEp8caskKgDCgq55s+g@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>, Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 2:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I've verified that at least on x86-64, this doesn't really make
> code generation any worse, and I'm ok with the patch from that
> standpoint.

.. looking closer, it will generate extra code on big-endian
architectures and on alpha, because of the added "zero_bytemask()".
But on the usual LE machines, zero_bytemask() will already be the same
as "mask", so all it adds is that "and" operation with values it
already had access to.

I don't think anybody cares about alpha and BE - traditional BE
architectures have moved to LE anyway. And looking at the alpha
word-at-a-time code, I don't even understand how it works at all.

Adding matt/rth/ivan to the cc, just so that maybe one of them can
educate me on how that odd alpha zero_bytemask() could possibly work.
The "2ul << .." part confuses me, I think it should be "1ul << ...".

I get the feeling that the alpha "2ul" constant might have come from
the tile version, but in the tile version, the " __builtin_ctzl()"
counts the leading zeroes to the top bit of any bytes in 'mask'. But
the alpha version actually uses "find_zero(mask) * 8", so rather than
have values of 7/15/23/... (for zero byte in byte 0/1/2/..
respectively), it has values 0/8/16/....

But it's entirely possible that I'm completely confused, and alpha
does it right, and I'm just not understanding the code.

It's also possible that the "2ul" vs "1ul" case doesn't matter.
because the extra bit is always going to mask the byte that is
actually zero, so being one bit off in the result is a non-event. I
think that is what may actually be going on.

                Linus
