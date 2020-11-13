Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293882B2483
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKMTaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:30:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A4C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:30:06 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v20so12119608ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSxNzIRXq2hQf++iAIuMzFXpOxmVx5Tx4jehTl6QJNI=;
        b=ZQII+Ulq7va1iJz0uKz+Z7hnZH8qARd99V8Do3e4eotny4nigLldBALMq6FH4lN4Qn
         kL5Ndq56lqCg+PeXvwgLb5ngyslCFgjPXecUcCCmuHrlQTPYkg3DoLeoBR3C56mr3Dny
         tDGvFHyGHz+YvFUfBrXkbhprIdhyLZ97ngD3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSxNzIRXq2hQf++iAIuMzFXpOxmVx5Tx4jehTl6QJNI=;
        b=kNKd/ZFY5YLjRoiJ6Ijwe5LvqUj1Jl+9A2+kYCqrpJKnszRwhyRM7C1OwFTl0wMoGG
         2RXLskFJ7lkiPNZglzolcy0Jnfke3i7Cb1Wxp51A054uIk3UybykbnvT4YKT69bsk/0u
         Rv1Z2uJ5sZT+Qy5VEta2dCW/lqswvBIYVi6KvcTvlHIs7fhTgJNrZD85hqaVbPSW73rf
         nCTSt/E3ZuRlYu680hZbblTc9sqJ2W13iNmhSOGSUmqCh9b/RUoJ7qR9Su8DkmLtBPuL
         yDCx9bBPBTp7HoygUkaq21OQ4sA9k8AHwLxFJ6gHDK/BuhKSZ0VuqFUeTL6kFQyYWJPF
         X/zg==
X-Gm-Message-State: AOAM532feWOw6SX8//4db8KuvQuOpY+xmgFQEwZHiy9N4XaQcCNKGQpC
        Xpz9lvjWxpuw7ChhtG3muytfCDJZ2KlL4Q==
X-Google-Smtp-Source: ABdhPJzfur3kLcTBPpUhoDmoLKfXt98ppjSM28f80QipUthh+4qpGoF0JGUW+1rS6PD/CwqCRpG7gg==
X-Received: by 2002:a2e:92d5:: with SMTP id k21mr1626176ljh.244.1605295804577;
        Fri, 13 Nov 2020 11:30:04 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e9sm1729985ljp.119.2020.11.13.11.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:30:03 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id a9so14611949lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:30:03 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr1336702lfk.534.1605295802640;
 Fri, 13 Nov 2020 11:30:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
In-Reply-To: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 11:29:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbcq6N_vqGqfy3MVv-6D36M9-iCY0634Sz0xN_vnX+Kg@mail.gmail.com>
Message-ID: <CAHk-=wgbcq6N_vqGqfy3MVv-6D36M9-iCY0634Sz0xN_vnX+Kg@mail.gmail.com>
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
> You misunderstood.
> BPF side does not depend on zero padding.
> The destination buffer was already initialized with zeros before the call.
> What BPF didn't expect is strncpy_from_user() copying extra garbage after NUL byte.

BPF made the wrong expectation.

Those bytes are not defined, and it's faster the way it is written.

Nobody else cares.

BPF needs to fix it's usage. It really is that simple.

strncpy_from_user() is one of the hottest functions in the whole
kernel (under certain not very uncommon loads), and it's been
optimized for performance.

You told it that the destination buffer was some amount of bytes, and
strncpy_from_user() will use up to that maximum number of bytes.
That's the only guarantee you have - it won't write _past_ the buffer
you gave it.

The fact that you then use the string not as a string, but as
something else, that's why *you* need to change your code.

            Linus
