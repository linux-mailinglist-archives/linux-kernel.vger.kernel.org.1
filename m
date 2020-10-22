Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC329663C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372061AbgJVU4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896678AbgJVUzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:55:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED8C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:55:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h21so3130057iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDqQ1zUFMtHdEQX/XnB1xFyEhicaRQXlC/XVGrEZwa8=;
        b=VyEe68XlMV50b/P9pS/svd5VOtStgjDnCFZMZjKTTx7pdFDDhzCENV4HcxJM9i+Uuw
         LiDRngh7O9Fhy7t3czR8G9POoGKJpzUcMMpE1KWlgBTNmSNaqB++disNaWd9E1RwFlbR
         mGcwn/ktt+GC/IvkgbcVni01WjvOc/MWsa+mCzzp38xtrKCPVsJKBs2zakxjrmPEoly5
         4wSESx7ApniV/x9orqnTmBy63HxvP9CrSQwEyhWS0mpkEEWpcKIZ2X9Kl99vLuruKYpo
         Q8HWU9xP/cvr2EBSZCnacbWsDa8VuNrqvliEVRVD/1BzqJNXTLpIX7MCpYtmnfhCSqko
         95HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDqQ1zUFMtHdEQX/XnB1xFyEhicaRQXlC/XVGrEZwa8=;
        b=aVBdpDljsHHdE58zJNlaMS/n4oOTgsqujC4BuAkUtBhgHO3K48bAVOwk+FkCVWNt91
         0L01NofEWqklShJECRAMTXNkH+UenB7aNcejfluVdomTV8YmIiSXoipIsMKzvEE9+Ph0
         xLUCjgzSzwzcbWEt714FBAFLS+5kU7GS1kX1FU5jbm1aJ1AIvn25sz7ovCwBBwYkpweJ
         viugQp/kJE+6mbtOMqjKGNBf8OwCcFZ2L/DUt5By68YnkxrRDc0A7OY2Frl0HZSwrfJh
         xZ1BGFPpyTB0B5qMgauIPb3PHeh4NnWvnYapSR1cDMrqUTfQUzJ8dtnJwjvbwYhH4sVa
         9FUg==
X-Gm-Message-State: AOAM532tYpt2VFqSAnlbbWvEjB75/kBHm+x4B2ie/SvtoEc30/nRHyPq
        YdM9YPvWwj+vKOULokzNUDHqKlPiYvlrrwfIDBEFsg==
X-Google-Smtp-Source: ABdhPJzNAEoDdzk8im6Rre99ntzZ1ceh3FOZU/YY1017p4KAHNCXoSiYj9RA6tXJM5tmAF3CrywzIjbpBzUeroOsy8o=
X-Received: by 2002:a02:ec3:: with SMTP id 186mr3173967jae.92.1603400131365;
 Thu, 22 Oct 2020 13:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com> <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
In-Reply-To: <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Oct 2020 02:25:19 +0530
Message-ID: <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
Subject: Re: mmstress[1309]: segfault at 7f3d71a36ee8 ip 00007f3d77132bdf sp
 00007f3d71a36ee8 error 4 in libc-2.27.so[7f3d77058000+1aa000]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        X86 ML <x86@kernel.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        zenglg.jy@cn.fujitsu.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 22:52, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 21 Oct 2020 at 22:35, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Oct 21, 2020 at 9:58 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > LTP mm mtest05 (mmstress), mtest06_3 and mallocstress01 (mallocstress) tested on
> > > x86 KASAN enabled build. But tests are getting PASS on Non KASAN builds.
> > > This regression started happening from next-20201015 nowards
> >
> > Is it repeatable enough to be bisectable?
>
> Yes. This is easily reproducible.
> I will bisect and report here.

The bad commit points to,

commit d55564cfc222326e944893eff0c4118353e349ec
x86: Make __put_user() generate an out-of-line call

I have reverted this single patch and confirmed the reported
problem is not seen anymore.

- Naresh
