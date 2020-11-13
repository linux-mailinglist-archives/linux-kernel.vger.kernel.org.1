Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12AF2B2358
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKMSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:08:27 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:08:25 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i17so10730635ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pmbyi1BI0q8tI1Ro2UrRWmfEfcF3PlqRU4BeSYwO1T4=;
        b=HzaDSemThjnRC7T8nRrEMTCcXuTgeVsRwQxedVexs+AySItS/75Fj/C6FBS9pN0AnK
         y1shSgDrHsLcD4AQfyvbVOH2ES/4qAw8LoxsjLQ8WLIfZaC4XaCaVZblBiD/g3fr7LuS
         wi2yaRNK/lhscMht3k64fYeLrqkB55RYHOyDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pmbyi1BI0q8tI1Ro2UrRWmfEfcF3PlqRU4BeSYwO1T4=;
        b=WjjoWyvgxpMKBeZjmF+Kh8yZrKMz4YNm4ISZwlLQyHwabLOjZB7Wi/RnZVL1/OBmbo
         /bc6B672c8ZeY5s1UqHJIw9DPUX6FO2IAOtuizv+dpawGz+p2E0ifuff1NXTOQ5SB7Vg
         4PkQmBu9uXFExfiyeilm41wDhftMBlCiHbXz/24Wcj1ow1XYbzyzZ/K2D6S2P9VMmUlz
         kczbrauQkm4PTS/VSzdnjiY1yCt+jcfYZRl22Prb1IBIUx4TogF3ilBWv3gDqYB3KuS/
         HQBRii5ZUfdDnhbYL8p9EevUJvbsjVCxmXXVjoaRg2pWs7enzE41etbXYrkyY5rlym3x
         OkSQ==
X-Gm-Message-State: AOAM530oMmxAE4MLqBcYjvt+vBCbBINIZGHPzAXCZjEvnj0Q/Fn83W96
        ZwxtFRNzG/mhRx9vYIpHJTz9UA9TwzTcOg==
X-Google-Smtp-Source: ABdhPJwkjKwV5stSH1+eLYDTPX907gZGypDewGwA4bTeWxd2oOWZU6I5tiFmTXXupZDL8Z04OlrwiA==
X-Received: by 2002:a05:651c:10d4:: with SMTP id l20mr1466214ljn.389.1605290903769;
        Fri, 13 Nov 2020 10:08:23 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c14sm1639617lfr.105.2020.11.13.10.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:08:23 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y16so11835695ljh.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:08:23 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr1393175ljn.421.1605290897954;
 Fri, 13 Nov 2020 10:08:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp>
In-Reply-To: <20201113170338.3uxdgb4yl55dgto5@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 10:08:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
Message-ID: <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 9:03 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Linus,
> I think you might have an opinion about it.
> Please see commit log for the reason we need this fix.

Why is BPF doing this?

The thing is, if you care about the data after the strncpy, you should
be clearing it yourself.

The kernel "strncpy_from_user()" is  *NOT* the same as "strncpy()",
despite the name. It never has been, and it never will be. Just the
return value being different should have given it away.

In particular, "strncpy()" is documented to zero-pad the end of the
area. strncpy_from_user() in contrast, is documented to NOT do that.
You cannot - and must not - depend on it.

If you want the zero-padding, you need to do it yourself. We're not
slowing down strncpy_from_user() because you want it, because NOBODY
ELSE cares, and you're depending on semantics that do not exist, and
have never existed.

So if you want padding, you do something like

   long strncpy_from_user_pad(char *dst, const char __user *src, long count)
   {
         long res = strncpy_from_user(dst, src, count)
         if (res >= 0)
                memset(dst+res, 0, count-res);
        return res;
   }

because BPF is doing things wrong as-is, and the problem is very much
that BPF is relying on undefined data *after* the string.

And again - we're not slowing down the good cases just because BPF
depends on bad behavior.

You should feel bad.

                Linus
