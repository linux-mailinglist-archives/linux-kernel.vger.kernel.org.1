Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C22F3DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393681AbhALVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbhALVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:54:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC9C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:53:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h10so2218124pfo.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olxCUvxpcXL3R2GLrBwENG3ouQB8ZYtp3GhVSnmKZuM=;
        b=dGJqu63Q0ptoAgat6qwOgZD/Q2sZqyW2KSQRD4lnZ9JqupU/ioxwsfD3sRrRl0vEMU
         N06qMEAwo5jbV8aZcz68fUKiYeFxBwKGsZHcm8V1wVbe5sqniVcue6n3wIZkG7YTm7YB
         GGxVVgW1n2/LqKLtn9syy711cKx/2mqBGUoqFbPIe+OQM2U/xnAJHTB1bo+T9jx3N2cr
         s7qkUZ39pEkaScorHtIFO7znCq2lXZKbdTunwd5z6m562Gy2LpYQ4Vv9U89HnuMvl5H5
         HPmEqBkC/qqb1YBXP4C39fRmZaBMWou7gop+ve1NG8w85U/y8h/qugKhJE6dgTICANr8
         U+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olxCUvxpcXL3R2GLrBwENG3ouQB8ZYtp3GhVSnmKZuM=;
        b=OZw8la+eN3dmaXt/41PyedwDtBpiBI9n74PfDovKwb7NeJm+Iw8nu01wbU6uJXVunf
         Zb4GCE6AayiEmSsc/pp6fHl9FenXxi1jjmUG6u7Vnc+WlH0Xd6n+g/HOj/5Nr6ST+eMj
         qUTA9IC4Xehk/G6P790xjpX9zY2ov65pUH1L/4htWQDGdrvvuLJZmEJiBb6i7hU5ZMf5
         HbvlTqBgQszD72HGK+L+QOd2xqHJ3taV74kWINgXvMiSax08rlBsKXP9zq0xXo7SzPC/
         nLuq/oOJi5BiWOgtlspal31VqFhHrm8Ydn7VedvgcY7JOV/LwDRwjHxw/1xwbGJWLDgQ
         tLfg==
X-Gm-Message-State: AOAM533owd3IsHONvGw6QcOtnJzYyRw6yv8uqPUMghiiBl7lC9lVEOB2
        LAQhs3hFmjpZAq+WTiN8ThwlWbbBB+TRcgc/ss/ltA==
X-Google-Smtp-Source: ABdhPJwnyvSOaEHzXE4P2/VjL81t8j2dQDpxGhYwPvXWxnuOMj7eF1tyZv98yZynzfTpOxWmLtuDuQX95Y2KwbyZnWc=
X-Received: by 2002:a05:6a00:796:b029:1ad:6394:432d with SMTP id
 g22-20020a056a000796b02901ad6394432dmr1280433pfu.36.1610488421716; Tue, 12
 Jan 2021 13:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <CAKwvOd=yrVKBn9TN2cP8SiB7A8=c2g41PyodKGJu+xEQwAmnDA@mail.gmail.com> <20210112213703.GA1376568@ubuntu-m3-large-x86>
In-Reply-To: <20210112213703.GA1376568@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jan 2021 13:53:30 -0800
Message-ID: <CAKwvOdkA5kmXhKFDFTApLyT5LcUX2-Xr6vJJ0b8wePunMpLu0g@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:37 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> > if real_ptr is an unsigned long, do we want to use `__ffs(real_ptr) +
> > 1` here rather than ffs which takes an int?  It seems the kernel is
> > missing a definition of ffsl. :(
>
> Why the + 1? I think if we use __ffs (which it seems like we should), I
> think that needs to become

This came up recently in an internal code review; ffs and __ffs differ
in output by one.  See also the definition of ffs for alpha in
arch/alpha/include/asm/bitops.h.

Also, I just confirmed that:
```
#include <stdio.h>

// include/asm-generic/bitops/ffs.h
static inline int ffs(int x)
{
        int r = 1;

        if (!x)
                return 0;
        if (!(x & 0xffff)) {
                x >>= 16;
                r += 16;
        }
        if (!(x & 0xff)) {
                x >>= 8;
                r += 8;
        }
        if (!(x & 0xf)) {
                x >>= 4;
                r += 4;
        }
        if (!(x & 3)) {
                x >>= 2;
                r += 2;
        }
        if (!(x & 1)) {
                x >>= 1;
                r += 1;
        }
        return r;
}

// include/asm-generic/bitops/__ffs.h
static __always_inline unsigned long __ffs(unsigned long word)
{
        int num = 0;

        if ((word & 0xffffffff) == 0) {
                num += 32;
                word >>= 32;
        }
        if ((word & 0xffff) == 0) {
                num += 16;
                word >>= 16;
        }
        if ((word & 0xff) == 0) {
                num += 8;
                word >>= 8;
        }
        if ((word & 0xf) == 0) {
                num += 4;
                word >>= 4;
        }
        if ((word & 0x3) == 0) {
                num += 2;
                word >>= 2;
        }
        if ((word & 0x1) == 0)
                num += 1;
        return num;
}

int main() {
    int x = 3;
    unsigned long y = 3;
    printf("%d\n%lu\n", ffs(x), __ffs(y));
    return 0;
}
```
will print:
1
0
-- 
Thanks,
~Nick Desaulniers
