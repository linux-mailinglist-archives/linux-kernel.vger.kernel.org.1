Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE132297316
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbgJWQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbgJWQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:02:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:02:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so2703656lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVCIDlW+4rSCxQwC/0UuCHmyl6vLpGQY3YbrIv0lS7k=;
        b=GD436E2U3ELljPkL4nM1PYvlFMy+YQnW7aen5YTspfRl7ksFgb2HDAmkn6V4t+JDaG
         dMMQj13VpeQs7o/RmxbX2tP6MlGCxWLIBdmEqKZM5NLiH7YFdLHZUROFosyHo2YrU1Oc
         /mkd7zfPG7SEUfxCAGBxjhO9Vpkj4+BC/pLM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVCIDlW+4rSCxQwC/0UuCHmyl6vLpGQY3YbrIv0lS7k=;
        b=TAil8hk5w20vEe4/rOkUbg2nBE2F62+Rza++0K9ZjtvdyC5/NypkGOwvXYDIdeBTZf
         TeJcZAFf61k8mYkPi2xp6ZXOonQMKFS0vFBgekdy4I1BZ3xX5303cBx8L0EmOGlUd8yf
         8Oii4/YwRHJ2Q87dRM8yzZuN9ZH5MV2riRflPaZFwafUWtLEF0oaL9HLWzN1Andx0cJV
         fQYx6rbK8IrnviP5/00Nq+plDjSsgDoeyGry3TzudKx4opwypBjZKYqaO5cN/WzF3i06
         J+mg7C+wIFTzQOelLCbdP7IfBIyswo5mYgX9FNh8tcdVRBQ7I1JOFgPZbZ7KGzSrDgTu
         zqfQ==
X-Gm-Message-State: AOAM530EBRLgOSCZGACvOjtdPqnaNHurZu2+0d1rQL5Iax/k+naM5q4H
        tzdxlBsEoyzEqbaHC0tf5HYnuK6vbA7dNw==
X-Google-Smtp-Source: ABdhPJzxh9ihT8j4vKGG88K+sksmZsyQVzxHHFPucyKHPfIbnZyNE0IGa0Z9jsk6rRcbmlpohg+BLw==
X-Received: by 2002:a19:760d:: with SMTP id c13mr968821lff.197.1603468933041;
        Fri, 23 Oct 2020 09:02:13 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s7sm204757ljc.10.2020.10.23.09.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 09:02:12 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b1so2682835lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:02:12 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr1227378ljh.312.1603468500894;
 Fri, 23 Oct 2020 08:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
 <20201023050214.GG23681@linux.intel.com> <356811ab-cb08-7685-ca01-fe58b5654953@rasmusvillemoes.dk>
In-Reply-To: <356811ab-cb08-7685-ca01-fe58b5654953@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 08:54:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFb3wk0ff8jb3BCyoNvNJ1TSZxoYRKaAoW=Y43iQFNkw@mail.gmail.com>
Message-ID: <CAHk-=whFb3wk0ff8jb3BCyoNvNJ1TSZxoYRKaAoW=Y43iQFNkw@mail.gmail.com>
Subject: Re: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        zenglg.jy@cn.fujitsu.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>, LTP List <ltp@lists.linux.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:14 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> That's certainly garbage. Now, I don't know if it's a sufficient fix (or
> could break something else), but the obvious first step of rearranging
> so that the ptr argument is evaluated before the assignment to __val_pu

Ack. We could do that.

I'm more inclined to just bite the bullet and go back to the ugly
conditional on the size that I had hoped to avoid, but if that turns
out too ugly, mind signing off on your patch and I'll have that as a
fallback?

             Linus
