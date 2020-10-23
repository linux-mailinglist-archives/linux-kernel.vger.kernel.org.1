Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1829761E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbgJWRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753792AbgJWRvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:51:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81699C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:51:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x16so2476968ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjWltIsY/Tc/YTJZanmOnMdRvb0TAEPFdspWZ6zBj4M=;
        b=ThO1o259d6kg56YqDsLmT8MiBOJwLSiD9qKO4kwi21uldYbpY5uyCtH8bMuSvipaQl
         CAjmtz5HofISRTDvt16RteSXYTCR0nmL/dTW8wJ3RA9FrZ/uL5lQDuHg90R5IKGG2JeY
         BhpUEEHod/4CuMNQE9mr91H2mLES9qJx1qZ1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjWltIsY/Tc/YTJZanmOnMdRvb0TAEPFdspWZ6zBj4M=;
        b=naMjTYrYW4J+D30rzcQf72OP1koKJRGMCgTKzSew+IkWuQM5e+ejReTPL5IZH8pjBy
         86cyiNBNvdpo1eXMKKPsDJlLJOXnPJYYVVyqmL0epTtJd1OjZEOxdfgQcEPaf6D/orqU
         J0FviDyWhwT/XsirhzHRCRpRLLhFM2JIODs9vkykqHTlmJcEOLTflB6YZT5CHE+JsOWm
         M2wXoOdYM4R/d8DdXfm3AXnm2IIvc6oio62EpdP9tz47NbJjAxcR9T+IlFLxKHmvVR48
         zDI1wFHOevm1G4GuFOlRnzWVXNE8R+vqvDG2j073wZaIawKrP8TZKQ3zgYORZZFDah47
         x2dw==
X-Gm-Message-State: AOAM533EGAeAdmyqv36a4o4uxCwHOsPxqCU91qsWUVi8x4ki2S/HnMHu
        QfR+kg0MSjcTF3hPL3oOYUy8yog50Rcl9A==
X-Google-Smtp-Source: ABdhPJwPvrPZinv4iElrxfbfvAfILdpMVz86rhkB7Tpzm0cJ+7X0LP4Atml4/Fq5IoJOwnt46lU15w==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1239513ljk.372.1603475474713;
        Fri, 23 Oct 2020 10:51:14 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l6sm201432lfc.8.2020.10.23.10.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 10:51:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h20so2456180lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:51:12 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr1279720lji.102.1603475472083;
 Fri, 23 Oct 2020 10:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com> <CA+G9fYu5aGbMHaR1tewV9dPwXrUR5cbGHJC1BT=GSLsYYwN6Nw@mail.gmail.com>
In-Reply-To: <CA+G9fYu5aGbMHaR1tewV9dPwXrUR5cbGHJC1BT=GSLsYYwN6Nw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyp3Y_vXJwvoieBJpmmTrs46kc4GKbq5x_nvonHvPJBw@mail.gmail.com>
Message-ID: <CAHk-=wjyp3Y_vXJwvoieBJpmmTrs46kc4GKbq5x_nvonHvPJBw@mail.gmail.com>
Subject: Re: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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

On Fri, Oct 23, 2020 at 10:00 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> [Old patch from yesterday]
>
> After applying your patch on top on linux next tag 20201015
> there are two observations,
>   1) i386 build failed. please find build error build

Yes, this was expected. That patch explicitly only works on x86-64,
because 32-bit needs the double register handling for 64-bit values
(mainly loff_t).

>   2) x86_64 kasan test PASS and the reported error not found.

Ok, good. That confirms that the problem you reported is indeed the
register allocation.

The patch I sent an hour ago (the one based on Rasmus' one from
yesterday) should fix things too, and - unlike yesterday's - work on
32-bit.

But I'll wait for confirmation (and hopefully a sign-off from Rasmus
so that I can give him authorship) before actually committing it.

              Linus
