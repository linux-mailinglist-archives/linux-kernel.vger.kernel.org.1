Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33DD2B265C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKMVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:14:37 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA9C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:14:35 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id f11so16088538lfs.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KviX0rcak+ARccgKrmiOPUL4xxtYUmjKoN9SOQyA0lM=;
        b=WAUFm6kpKWLUNLFWWPtEeh8AyXuo9ubgQGaxugOKLHZppGH/FvHrzp6xLsLE3WqOGb
         mE0tmYNDMRvCwecB4a0vPxOEYfF2JvNRy7T188p4baruaXy1fF5uUMo8JbqAclLdCs70
         8LSAEVfV3Lr9haDHgZnTmtUwFwhbHYXCeswqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KviX0rcak+ARccgKrmiOPUL4xxtYUmjKoN9SOQyA0lM=;
        b=enRQiHZc1yPJA65qSiwemi8vvLj7hOJeH9rm6yJUB9wSR5JfohW82W6ChV8ym7TYUt
         G7Oh2QD6KeY+tllcGSuo64LhErSRAQ3bJAJxNZ8Q1zksla1I3AFZg9HWX8gqVEmiJ9NX
         ZvaCsQbxoxulRF80i9+EMQNXDH8c6jHOGNcD9AI6r9QmyHVaKaQnsk2z0BGuAEgHto+V
         dWTlBax1VXZgS0kfoGxaV/B9RBMT0ovds5WRAiLG/GKgSZwcBPG0YD73lvka9vD7ujkC
         u7mO15UsH9N2+gKqYw9bPteYbjCj+l8dPsk/9ureont1wS5ToeTN8goNygk+Y4HZjH7g
         n8fw==
X-Gm-Message-State: AOAM531xZlB8D1wXNZI7qQqt9vFxA33IfrOuBu/o/yKNqX2QRgPyIYRH
        Zuz002t+9KEaCJB0KgaalcODc7bz9jKznw==
X-Google-Smtp-Source: ABdhPJwZ1jftg6N6tn3ObC6Qa/ohNzNENzWI1TQY7vYeDCmPNnLBjr277sHMYGhSOq/cjGV04v3oEg==
X-Received: by 2002:a19:458:: with SMTP id 85mr1464341lfe.249.1605302073711;
        Fri, 13 Nov 2020 13:14:33 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s5sm1705456lfd.58.2020.11.13.13.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:14:28 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 11so12542578ljf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:14:28 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr1706774ljo.371.1605302068145;
 Fri, 13 Nov 2020 13:14:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp> <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
 <20201113205746.htvdzudtqrw6h7oa@ast-mbp>
In-Reply-To: <20201113205746.htvdzudtqrw6h7oa@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 13:14:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLp=6=nu1Zkd3cG4FepUWu2TyrBR1YpLLO8Y_WrrKyTg@mail.gmail.com>
Message-ID: <CAHk-=wjLp=6=nu1Zkd3cG4FepUWu2TyrBR1YpLLO8Y_WrrKyTg@mail.gmail.com>
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

On Fri, Nov 13, 2020 at 12:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> (a) is the only case.

Ok, good.

The (b) case is certainly valid in theory (and we might even
traditionaly have had something like that for things like ->comm[]
accesses, although I think we got rid of it).

But the (b) case is _so_ hard to think about and so easy to get wrong
- readers have to be very careful to only read each byte of the source
exactly once - that it's much much better to try to avoid it.

> But I think if glibc's strncpy() did something like this it would
> probably caused a lot of pain for user space.

Oh, absolutely. The standard strncpy() function has some very strict
behavior issues, including that zero-padding of the *whole*
destination buffer, which would be absolutely horrid for things like
fetching pathnames from user space (our buffer is generally close to a
page in size).

In fact, the kernel strncpy() (ie the one that doesn't copy from user)
does ado the whole "pad all zeroes at the end" exactly because people
might depend on that. So the _actual_ strncpy() function conforms to
the standard use - but you generally shouldn't use it, exactly because
it's such a horrible interface. Only good for very small buffers.

> The hash element example above is typical bpf usage.

The core kernel does have one very common string hash case, but it's
for path components, and never the whole string - so it already has to
deal with the fact that the string is very much delimited in place by
not just NUL at the end, but also '/' characters etc.

So no "copy it as a string from user space, and then use it as a
block" that I'm aware of.

              Linus
