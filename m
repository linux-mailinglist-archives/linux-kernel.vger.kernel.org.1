Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBD2978AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755351AbgJWVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbgJWVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:11:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:11:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b1so3695927lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXzCbMmS+pANPvGGOB4GzLFNuZZfqJXRrvXjWTUQXbM=;
        b=g0+Cq3Y2VhGGQSD9XXlMuRRYh8aZT17ZxEyY+io4SUKPWIrpX7Wagw+2y6I7NgfhjW
         QNWyw8TkCDrsyFCw3qZOHy6PHywxTR+nPRrWdFTBx8SX7CuhDluDK3I2uwzGorIa8Pt7
         rCld7UmTscJPXgBdhu/Nkr2ZGRQI4pDmI62sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXzCbMmS+pANPvGGOB4GzLFNuZZfqJXRrvXjWTUQXbM=;
        b=I5LtJTY3nGnX5qlkvxtX1cGPvk+5ZfFfg/rlfZ9UPrVcnOqouwKX9LhwLaTYKq1q6B
         rf3e4LjXj/5b2rYLc6ZWbBQcQsdrZIioPf1n7ORq4hnLEhwDPU1fjTFcdyfl+mirAzIw
         7j4oGGIGR3KTrmzpQDjP+VhjhQjGu9mPhc0E1zBEKOEulNv2JXsDyjXd3oelqpF6rYSr
         hcvAFVRCctycW77RbFI/3sxMmWt+UyYvHxO/uVNB2ZLBsviNyVHtnhWzboXH7JyoAusO
         5keunrjeWmKOYIS+EUq5gE0V9+bHvr8mV6WlM8/QtiEc5G65nS6ZNw1Y7roBPj/dXoqh
         FHDA==
X-Gm-Message-State: AOAM532Elgv3Hgvfcd06cKcl7ibWNvwXkhlTFOf6B1e1Gb9Aozq2WhRH
        woTJj6z50cZMYzzQyxm+bRn7qyPxw0FRlg==
X-Google-Smtp-Source: ABdhPJwKo18pRLAWpk7DNTh3o8xuSduFz0YZaYJccgJV8ZKeny1s+597drs/pZ8QTThm4fxYR+zV2A==
X-Received: by 2002:a19:6e46:: with SMTP id q6mr1477021lfk.413.1603487497303;
        Fri, 23 Oct 2020 14:11:37 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id i3sm242522lfe.23.2020.10.23.14.11.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 14:11:35 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m20so3011614ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:11:35 -0700 (PDT)
X-Received: by 2002:a2e:898c:: with SMTP id c12mr1737838lji.285.1603487495150;
 Fri, 23 Oct 2020 14:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
 <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com> <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com>
In-Reply-To: <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 14:11:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
Message-ID: <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Peter Anvin <hpa@zytor.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 2:00 PM <hpa@zytor.com> wrote:
>
> There is no same reason to mess around with hacks when we are talking about dx:ax, though.

Sure there is.

"A" doesn't actually mean %edx:%eax like you seem to think.

It actually means %eax OR %edx, and then if given a 64-bit value, it
will use the combination (with %edx being the high bits).

So using "A" unconditionally doesn't work - it gives random behavior
for 32-bit (or smaller) types.

Or you'd have to cast the value to always be 64-bit, and have the
extra code generation.

IOW, an unconditional "A" is wrong.

And the alternative is to just duplicate things, and go back to the
explicit size testing, but honestly, I really think that's much worse
than relying on a documented feature of "register asm()" that gcc
_documents_ is for this kind of inline asm use.

So the "don't do pointless conditional duplication" is certainly a
very sane reason for the code.

            Linus
