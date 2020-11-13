Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4592B2529
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:11:18 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:11:17 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so12325018ljf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt9Ua8vaHCsnEec5qJVZpjsiJsbIoJubKs0EkxVSvXM=;
        b=UH4Ns0j3oz/U0Q/AWcISzh4FonO68SG6sdYoa7oIq9ACsV0mNmUawKpbctSaNQiYBc
         zpxN3i5S8qCvA7QJJmm87ul6PZNM7hr/C/GB3bjcMVBipYLYZfPaPVHizyldBazkY/67
         U5jlKI/ZFc9jk0znAMbqDY1ctQ8bMnKCvR9sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt9Ua8vaHCsnEec5qJVZpjsiJsbIoJubKs0EkxVSvXM=;
        b=knpgZDYOHDk+mRhxYU25CmmOAPFeVkefr9JR4nvljRB6ezILd17dpjdjFosfjQRzTu
         YuuGDaZPTNOD/8RLI86L9OY6VXi57KyW63Pb5Q1uLPnwid3Ytno0+ogZ7OKhsOFGNe7A
         WtnGfbT0pizZNXXzlDtp070KHebAUVOznUyw0R3JCxevTDKTr/Ks1xE0rGzJiRV0+35g
         4RHjuBlpD9P+4vQ+NCjmOXiinh8FuKmskjgH2+gyur2A0WerHfIeejgm9HK6wDQFBq+r
         Z0Teu6rQr1/s5WTMH3wj4MCMoCYPWj50bDjdfkdDmTltTVZ61DGntbWHVk4F2t9VepmH
         ljhw==
X-Gm-Message-State: AOAM531EsU2OWbUL/NVOovCU88u6Hx7K5VPBmO68LObSSfbaGuFKdMiz
        y+mnjLnfBg/jODBtNkA37fJ1RljtHCxnog==
X-Google-Smtp-Source: ABdhPJxu+aaIemXXQjVDlVh6mZEwnkgOI709Ry6aP1ThxrunFR87k4J3JPtn/ySBuFFhR2KH5+pVWw==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr1697877ljk.439.1605298275118;
        Fri, 13 Nov 2020 12:11:15 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p19sm1699392lfa.280.2020.11.13.12.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:11:14 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a9so14804095lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:11:13 -0800 (PST)
X-Received: by 2002:a19:8544:: with SMTP id h65mr1589302lfd.344.1605298273562;
 Fri, 13 Nov 2020 12:11:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
In-Reply-To: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 12:10:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
Message-ID: <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
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

On Fri, Nov 13, 2020 at 11:17 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The v4 approach preserves performance. It wasn't switching to byte_at_a_time:

That v4 looks better, but still pointless.

But it might be acceptable, with that final

        *out = (*out & ~mask) | (c & mask);

just replaced with

        *out = c & mask;

which still writes past the end, but now it only writes zeroes.

But the only reason for that to be done is if you have exposed the
destination buffer to another thread before (and you zeroed it before
exposing it), and you want to make sure that any concurrent reader can
never see anything past the end of the string.

Again - the *only* case that could possibly matter is when you
pre-zeroed the buffer, because if you didn't, then a concurrent reader
would see random garbage *anyway*, particularly since there is no SMP
memory ordering imposed with the strncpy. So nothing but "pre-zeroed"
makes any possible sense, which means that the whole "(*out & ~mask)"
in that v4 patch is completely and utterly meaningless. There's
absolutely zero reason to try to preserve any old data.

In other words, you have two cases:

 (a) no threaded and unlocked accesses to the resulting string

 (b) you _do_ have concurrent threaded accesses to the string and no
locking (really? That's seriously questionable),

If you have case (a), then the only correct thing to do is to
explicitly pad afterwards. It's optimal, and doesn't make any
assumptions about implementation of strncpy_from_user().

If you really have that case (b), and you absolutely require that the
filling be done without exposing any temporary garbage, and thus the
"pad afterwards" doesn't work, then you are doing something seriously
odd.

But in that seriously odd (b) case, the _only_ possibly valid thing
you can do is to pre-zero the buffer, since strncpy_from_user()
doesn't even imply any memory ordering in its accesses, so any
concurrent reader by definition will see a randomly ordered partial
string being copied. That strikes me as completely insane, but at
least a careful reader could see a valid partial string being possibly
in the process of being built up. But again, that use-case is only
possible if the buffer is pre-zeroed, so doing that "(*out & ~mask)"
cannot be relevant or sane.

If you really do have that (b) case, then I'd accept that modified v4
patch, together with an absolutely *huge* comment both in
strncpy_from_user() and very much at the call-site, talking about that
non-locked concurrent access to the destination buffer.

            Linus
