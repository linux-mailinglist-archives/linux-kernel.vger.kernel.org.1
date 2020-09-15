Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44A826B029
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIOWDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgIOV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:59:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:59:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y1so2707781pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YF93KykULk2q5SO2dhkeGC6nTzzjF1T7ZBcBgWuMdD0=;
        b=cHEsQkyAuZtJJ4kGL2oYhkKlwgH11p9PW3+MSR4L0+qFRHnHrOeU8s2p6lY+R86R/0
         K8xG5B9HM9dfH+e1s0VDYhl5WR9fDhxFg2mJAEwjBozXAN5ZJkxdoV6CUhKne0E9uU1P
         vZF1pSuwtdEVL5w7Igca4OP/XWOWsxGCrM5KqBBoCfoLkreXEfvYg/1i8RU7p6uDVyj9
         QTZVOvHAVBFEhoCJBidp6OXmNoGedNiQvJAzYIgA8t/cT9DeFtYDkANx+cgkDxjFhRX+
         aPLtNOLB/oVIX1wSm8i8PrWWGEg2Tu+Y5EdmBss1LE2HjpRkUHhKbK0LpssHYoEhuScI
         E7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YF93KykULk2q5SO2dhkeGC6nTzzjF1T7ZBcBgWuMdD0=;
        b=L31fZKJqJSM5ZGKxLphAtE1OTlGKk/CnwhdiKXfkk9eTcbIb6b8ZqOajeMMjQ1I/Ci
         OKJ0OLjhD6s3KIS1SC5vef6X+B8wE1hv4vq6Pxi1ZCIC4nOK1F2HrC1BjLrVxDXH3RLz
         bz5n+S6S+2+Ni/sHbV1OvCdJdkLvGv9IbdmeqqXlhy7GazIgLQtzb/9+XTii3fd1dXrY
         2SlWPV3KGv7HdJYw0yPbapbFVPogD4KwSDH6ADkbyBUCuBldu6Uqw3r85Ajx/IhsT2s7
         hgyNjVevFshlrOyl9lwav1mXshirqM80+J+ugHXRQx5plPgnU1n4vknap4sTrvzLT9EL
         e1bw==
X-Gm-Message-State: AOAM531stq8azYza97qhRo8Sw4kLjMIyfEZwpt0K+iw8G8HapYI3yoH+
        SZh4ega9ihp3vxyFXXSjNXcAJviFUAOxz0NYY6woxw==
X-Google-Smtp-Source: ABdhPJxUgCPGqirdbzsiBzK4MwmxJlpiKLnjXqMbGwpbWfpMrcWY+3ISOHKsezeVobinH8svOjX9QkMseQ8aET62foU=
X-Received: by 2002:a63:31d2:: with SMTP id x201mr16686038pgx.263.1600207172344;
 Tue, 15 Sep 2020 14:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic> <20200915215054.GA1104608@rani.riverdale.lan>
In-Reply-To: <20200915215054.GA1104608@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 14:59:19 -0700
Message-ID: <CAKwvOdnctit9cQ9Na8kO5TXbZh-3ZV5x1=GLHhRVdBUK23HjnA@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:50 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> >
> > (Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should not be
> >  returning, ever. :-))
> >
>
> I think this is because panic() is varargs, and clang doesn't support
> gcc's -mskip-rax-setup. The normal ABI requires the caller to set RAX to
> the number of arguments in vector registers.
>
> https://patchwork.ozlabs.org/project/gcc/patch/20141218131150.GA32638@intel.com/

Thanks for the report.  Filed
https://bugs.llvm.org/show_bug.cgi?id=47538.  Do you have an account
there Arvind so that I can CC you on them?

Yikes, it looks like gcc 5.0 supports that.  We'd better get to
implementing that lest someone try to remove the cc-option on it soon.
-- 
Thanks,
~Nick Desaulniers
