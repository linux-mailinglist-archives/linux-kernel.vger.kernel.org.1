Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B629624A5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:29:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67DCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:29:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t23so26506038ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ucx4xNdWj8FubzUE0bmaleq0wJD7oc54mhfoqeYf2XU=;
        b=PZVp1PswyRXxCcgWvuKOSwlVQZBQvHZ2i0WHC1F5lG9KLnaV2o27YRbvSFunZ/JKvK
         mtgP5VfEGtE2D4DxhhvVTkFSbYR9+lTz9ypXY02T7yZXJ7DCTQS7ULB+8jR+HEBxcotf
         /qvROjiNoyAJdF1jyZpqk0YvFPc5J+ljOAkbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ucx4xNdWj8FubzUE0bmaleq0wJD7oc54mhfoqeYf2XU=;
        b=jgV0L14GFmxs87OPNM2NhRyDV1vsQbTWWLZY8aL3GLWmG1Me+4x4dhEixgNn3OhVIj
         WuWbxv5opU88k1nb3rFiaJENhweCecDJc5q1Afr5JfkNmMpokbsJrVIeVfx3ozputDvS
         y06p2uWa2BoGQ6wgvNzgSCZQWrHNRiiReGKkYF0laeA/gzu0REH1HIeexgyBnoOzSqRE
         aQPOx208EGl3pKDw7r7wlyR3W0xCakjHRlNp/TCDEH9mz5CQgW9Cj9+TOc9ntm0uhSoS
         GwrHqhRLPWy+IOkG+a/5zJMcW/73W6uyc6o1tgjWoy/zS/LQKMcBscm37SMNKio1LMsb
         NJ7Q==
X-Gm-Message-State: AOAM530KXbY/jmGR4EAIgpWgYfJggzhRwCltCH8l6gqov1yviBN6exNZ
        Jm9WW9oryYEdo8f/WqMMX8izFYyvim7LoA==
X-Google-Smtp-Source: ABdhPJyFInPxOv3SRwgoL4Zo/RuQF5f3AWnbPBiUL1JDy3M/aUqoWNIW8tTgy1z6jox1iJhWpLK4UQ==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr12188640lji.196.1597861773303;
        Wed, 19 Aug 2020 11:29:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s4sm7449921lfc.56.2020.08.19.11.29.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:29:32 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y2so17467375ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:29:32 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr12035161lji.314.1597861771678;
 Wed, 19 Aug 2020 11:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200819094437.GE1891694@smile.fi.intel.com>
In-Reply-To: <20200819094437.GE1891694@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 11:29:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsW9Dh7zCwbct59GOL0CudU+k4C3pa1P1xUxzzSbJoUA@mail.gmail.com>
Message-ID: <CAHk-=whsW9Dh7zCwbct59GOL0CudU+k4C3pa1P1xUxzzSbJoUA@mail.gmail.com>
Subject: Re: -Werror for `make W=0`
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 2:44 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Maybe silly idea, but would it make sense to enable -Werror for default warning
> level, let's say W=0, at some point?

I'd love to, and would have done that a long time ago, but we just
haven't been able to depend on the compilers not having random
warnings in random versions.

And making it a config option doesn't work well either, simply because
that will just mean that bots will randomly fail if they set that
option, and if we make it harder to set developers won't have it set
anyway, and it doesn't help much.

End result: using -Werror works wonderfully in controlled
environments. Not so wonderfully in the general random mess.

That said, I've been so aggressive against accepting new warnings that
I've considered this unconditionally anyway, and then dealing with
compiler version fallout by just disabling certain compilers and/or
certain options.

But it would almost certainly be pretty painful.

                     Linus
