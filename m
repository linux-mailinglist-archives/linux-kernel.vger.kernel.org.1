Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5228C46B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgJLWAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgJLWAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:00:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A07C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:00:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a5so18296185ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZP88hWdyPYfMQc3Gq4wc10y+MzcOPD23qmu//8HLrs=;
        b=hOv7CFc72tk1kSII2gE7/DFn7DjSsIh6z+lxyDJrj+X+/Jc3fTPq9KD9SxQDmUnEm5
         9L3SXP2tJJcBSuYiOM7RUlRp0F/oOIh8n8HNjC+QSiOLeFExYG/rGE+GAR1pbETjTrKG
         63tp1qkzEGUN15i+wj5ucnb7Ue4HIfPbNq++4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZP88hWdyPYfMQc3Gq4wc10y+MzcOPD23qmu//8HLrs=;
        b=HNzsc82X/WKTfisvLO8tIaKsVwiQMCHSuIMOLHKldbPi2FD2C7eyfDvxrOcjw+b7cW
         2YUp7VqOgpbpqafZJxmp6CtYLKReEfidL0XfDq7QDZH/hbNeRpRhVPH3mlfoh1v8hT5Z
         1EhjTT81L8IeTAoH39+ejFRFJ8f0Y7eMXmY6YRN0A5/pQsMN2gmUtYVEVqrsCE+Grxg5
         IZZqNHmQtaQxOyWNAmV1zJ9Gjrk2OhDdehjx+iCSDsNKJB2KyPAuTJMLOQ5lN+vdEzz4
         KQXvgQKIuLiTv6zYfUMIXJUiw5GSbm7GssEb6yKsZ5MW89dDG9hvIx8tXRyTbxWut0yj
         erlg==
X-Gm-Message-State: AOAM530AgJf2Dgs6RSKUPw+DZ1LFFVMmDHCwPCkFMLUGqWzMW3MUK7pg
        jeqk3TF2tadwoaV0IEbD2P5PMdOvPMbKGw==
X-Google-Smtp-Source: ABdhPJztmMdrB66u5RSdV/C0XA9DePY9XO4ILa+YQaETRFhzc7QIaLav9WdVE4MzMl2S58RgZNmRYA==
X-Received: by 2002:a2e:808f:: with SMTP id i15mr10058477ljg.10.1602539999255;
        Mon, 12 Oct 2020 14:59:59 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n125sm2993787lfd.7.2020.10.12.14.59.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 14:59:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a4so18285964lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:59:57 -0700 (PDT)
X-Received: by 2002:a2e:868b:: with SMTP id l11mr5122615lji.102.1602539997423;
 Mon, 12 Oct 2020 14:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201012141451.GA3425471@gmail.com> <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
 <20201012214405.GI3249@paulmck-ThinkPad-P72>
In-Reply-To: <20201012214405.GI3249@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 14:59:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
Message-ID: <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.10
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 2:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> So that RCU can tell, even in CONFIG_PREEMPT_NONE=y kernels, whether it
> is safe to invoke the memory allocator.

So in what situation is RCU called from random contexts that it can't even tell?

> But either way, please let me know how you would like us to proceed.

Well, AT A MINIMUM, the pull request should damn well have made it
1000% clear that this removes a case that has existed for decades, and
that potentially makes a difference for small kernels in particular.

In fact, my personal config option - still to this day - is
CONFIG_PREEMPT_VOLUNTARY and on the kernel I'm running,
CONFIG_PREEMPT_COUNT isn't actually set.

Because honestly, the code generation of some core code looks better
that way (in places where I've historically looked at things), and the
latency arguments against it simply aren't relevant when you have 8
cores or more.

So i don't think that "make preempt count unconditional" is some small
meaningless detail.

What is so magical about RCU allocating memory? I assume it's some
debug case? Why does that debug case then have a

    select PREEMPT_COUNT

like is done for PROVE_LOCKING?

> I based my
> optimism in part on your not having complained about either the patch
> series or the pull request, both of which I CCed you on:

I had already raised my concerns when that patch series was posted by
Thomas originally. I did not feel like I needed to re-raise them just
because the series got reposted by somebody else.

                Linus
