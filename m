Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA92B9AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgKSSkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbgKSSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:40:42 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B132C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:40:42 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b17so7302499ljf.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au469p9zNDfgQl3YuPnVjJXrVJoWnWoruzOG8UjNgGY=;
        b=JZSAlZlPuBlxQ0nuN/uoo+TEedexwo/b6B3fshF+TpuFw8crNJAfWtrQ3Qg04u+Q/h
         mciY8jrsrbVTF0gl99ATsUZ17TzH9bpiyZdXaZsZqi4iuJAlDRGjqadzl/XcrIH5ev3Y
         9z+kb1x6C/lH/74ARZBFlQL+vvyu7NnZ/Knq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au469p9zNDfgQl3YuPnVjJXrVJoWnWoruzOG8UjNgGY=;
        b=MjvJBbhXi7cUpUxdcCogvWsnKzUvcbnqiJPIVN87yDI7jukvSisuvb3i/u6ZRg4llU
         U7VlNqid+KyHNj3tuNwBjaVrYLEgf4rKRDs9A8als57pOtfe20FxZtetrnT8RddXciOr
         DEXVSHGqNy1mpCmw9a+4zS/zP9Kvt8CYKX7N4AWFa+Grj69/hRyZopq50bL/TGCvstlS
         0FsNlIAeousfEnGDnLwHJrNbV+iQYnJarbAWVKGAn8vW5Q/KBQWf+AyshxAi5sxa+d2K
         fQ/2AtUqunI2FFF9z2U+0gMTnrWylVAyL4xixn6t+fvF9WSNT8l1sG0BAa4VJ9WT6wYi
         B1Rw==
X-Gm-Message-State: AOAM530CpN3astxVrLP/W7j+dLa4QAGN+Kuqzc5NsLBdLu6CRfH8ADov
        KZlA1DSkPS538c0Qw5OCHFcjduVEsluVEg==
X-Google-Smtp-Source: ABdhPJwPegYhnm1s5Iy1YMjUtnEcs377OCoKR1/E2m9MBUtWVr5eO2/oFkd2/N+z3N35iUzGdx7YyQ==
X-Received: by 2002:a2e:948:: with SMTP id 69mr7596854ljj.180.1605811240213;
        Thu, 19 Nov 2020 10:40:40 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t2sm50934lfc.21.2020.11.19.10.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 10:40:38 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id u18so9715543lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:40:38 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr5994156lff.105.1605811237959;
 Thu, 19 Nov 2020 10:40:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605642949.git.dxu@dxuuu.xyz> <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
 <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com> <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
In-Reply-To: <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Nov 2020 10:40:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
Message-ID: <CAHk-=wiG3jYsfPQBHabTmMagT71Uzx=wxq=Bh41A40zQ74pwEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> ping.

I'm ok with this series that adds explanations for why you care and
what bpf does that makes it valid.

So this one you can put in the bpf tree.

Or, if you want me to just apply it as a series, I can do that too, I
just generally assume that when there's a git tree I usually get
things from, that's the default, so then it needs ot be a very loud
and explicit "Linus, can you apply this directly".

              Linus
