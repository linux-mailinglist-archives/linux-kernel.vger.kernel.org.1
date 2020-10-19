Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1BF292BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgJSQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgJSQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:52:18 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:52:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so324558lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cWK+DL6XyfhBEyDFclHAiApf+xy/GsC3/T+E6jZJ9g=;
        b=R9ehEU9wWrfJofck/gWfeOapDJ+wkaO4ulGVCO8sIZ3YBH2eN9GJjaYyyOf3ujJKY9
         PPz94Zq0X6qKiMN7izLsoNVCxZshQHrXyf5bHfmqTYDENfuyVspXiCpk4YvRP5JLuOxV
         dYtRkSEcYli4JP71OK2MlqOla27EN1rL+AqzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cWK+DL6XyfhBEyDFclHAiApf+xy/GsC3/T+E6jZJ9g=;
        b=Qis+uvTEpGtpKaPd4FP8PNkwHUD3mcrQS4WeJbMfC63xJuLMbiMJWgDPbSF05yh0d+
         6xRoyQIq9XChaeKDmGTz4OqeMnUCX1c+o4xjDLHy6+vkRAn3XE1u94mScRJefIDrafmD
         jQOdk9E2JHz6LsOPhB7mXWue8ttkiESNcJQ7i3pFZV0vNj5gVZzAWn+4CcZMeuApAgbL
         /t+k7RDiiD5PMqP9mxYMOaeIvcP0BSW40mYloQkm+ob5yFMI2/s7ZheFWdAd13fx9dI9
         GL1Gj9bFmJMBoUwuU1vxbJI5TB6OmC1wdXOiN1iwMe/oEKdt4sFSEpPYNcASAHaWdHfi
         U5ZA==
X-Gm-Message-State: AOAM531BDhKnKbOYCAL3o4uw+cdrrlVWG48gQr5VaDmVwOgW43vT6Con
        hnOyCSFlUEY3exvD3BUaI4fQh1s/wrX0fw==
X-Google-Smtp-Source: ABdhPJyVexXPnHdFugMt1KILUT+XkpmeX2mwtCAbSrBMXXnEzXFv0592M+Cm53SBIRL2xcFDrw2drw==
X-Received: by 2002:a19:146:: with SMTP id 67mr175549lfb.75.1603126336294;
        Mon, 19 Oct 2020 09:52:16 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i124sm53725lfd.236.2020.10.19.09.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 09:52:12 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id c21so855979ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:52:12 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr368068ljg.314.1603126331829;
 Mon, 19 Oct 2020 09:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201012141451.GA3425471@gmail.com> <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
 <20201019032400.GD3249@paulmck-ThinkPad-P72>
In-Reply-To: <20201019032400.GD3249@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Oct 2020 09:51:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyQF4voB8GHa2VjzS6H-k41ZHda5+dFqKrDcUY28FqGQ@mail.gmail.com>
Message-ID: <CAHk-=whyQF4voB8GHa2VjzS6H-k41ZHda5+dFqKrDcUY28FqGQ@mail.gmail.com>
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

On Sun, Oct 18, 2020 at 8:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On CONFIG_PREEMPT_COUNT, got it.  It would be OK for RCU to use
> preempt_count() for some debugging or specialty kernel, but not across
> the board.

Right - that was what I thought you were asking originally.

I don't think a driver or random piece of code like that should ever
use "preempt_count()" on its own - partly because the rules are
subtle, but partly simply because drivers have no business with those
kinds of low-level things.

But yeah, for some core stuff like RCU, using preempt_count() for
debugging etc makes sense. Just not to change _behavior_, because
preempt_count on its own is almost entirely meaningless. It's just one
(local) part of so much state. Again, partly because preempt count
isn't necessarily always meaningful due to config settings, but partly
because there are just so many other things like "are interrupts
disabled" or "are we in an NMI context" or whatever.

And in some odd situation, depending on exactly what you do, maybe
preempt-count can be exactly what you need, because you know
everything else about the state statically. "preempt_enable()"
obviously is one such thing - the whole point is "if
CONFIG_PREEMPT_COUNT is on, then the _semantics_ of this is 'increase
preempt count', and if it goes to zero, and we should reschedule, do
that'".

So it's not that preempt_count() is meaningless, but it's such a
specialized thing that 99.9% of all code really cannot and shouldn't
use it.

           Linus
