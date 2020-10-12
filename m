Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1562B28C246
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgJLUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgJLUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:25:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:25:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a7so18554702lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfcqLq/Q2Q+LgDM1Q+NUMewMRiWVku15EIvtQmnRlUM=;
        b=KlA471ZjZnTKzg072srlhuYdkPkUnnwLmVOnoJk/WiuOfFJg/56wHZ+7+9mfHrmb8d
         +afVcsr+hsa32yBQSxV8afUbSC1yfRNDQBzyvgfcEf470FR63eczSLy9EVMLsFfU9v+Z
         RZd9a8kDNgwiw0fu8bItOJTFGycStiLK7t6tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfcqLq/Q2Q+LgDM1Q+NUMewMRiWVku15EIvtQmnRlUM=;
        b=g2nhCQ8v/9gTpRhysibKc45L1XBQdIe9CtEUbXkAhTfwgvx8m5S7v6aecKU88GSr3C
         JxVTkeP4rINWQo6Uljz+tUiVv6fr6B4lY+MwU4mlFeY3s0BXZR5awMrFCmCWppqPnpzA
         ucq7c3U0xuUTaHUN7i6o5anzJXPWe/ZWgfE0uIfOfz+0TALSIyqh3f3iZAZrUmtjlcLH
         F45PtmM/802R0O1I0rGtI3j9KD9FBdsdYXPIETDb3cnzuq4mi/+Xaqi5PmX0c+Qcu0u8
         TIkB/IGMohSaxfV5vI/GxhniocOxfrz1ZRz7RffhFiBwo5wtqrSJNi+bANNKuaV8naNC
         klnQ==
X-Gm-Message-State: AOAM5330SPcw7EFrKV2vrdPVMJrwLxq+sV+4sfRXw200xdnmH91Cm9Dk
        0cZpNiSz6O5lHm8fEbUJe3P2NFtWE5+ztw==
X-Google-Smtp-Source: ABdhPJxwM0y3BHquHxGDS/Za5rjGsuIqVdU7CJ1wIID+yIeZqrftM88y0ZH42jc7X3LnXEHzxvDjEQ==
X-Received: by 2002:a19:c1d7:: with SMTP id r206mr7819713lff.87.1602534327585;
        Mon, 12 Oct 2020 13:25:27 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p14sm1625395lfc.40.2020.10.12.13.25.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 13:25:26 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id c21so18085439ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:25:26 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr10249694ljg.421.1602534325702;
 Mon, 12 Oct 2020 13:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201012141451.GA3425471@gmail.com>
In-Reply-To: <20201012141451.GA3425471@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 13:25:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
Message-ID: <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.10
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest core/rcu git tree from:
>
> RCU changes for v5.10:
>
>  - Debugging for smp_call_function()
>  - RT raw/non-raw lock ordering fixes
>  - Strict grace periods for KASAN
>  - New smp_call_function() torture test
>  - Torture-test updates
>  - Documentation updates
>  - Miscellaneous fixes

I am *very* unhappy with this pull request.

It doesn't even mention the big removal of CONFIR_PREEMPT, that I felt
was still under discussion.

I don't absolutely hate that code, and I'm willing to be convinced
about how little it matter for people who don't want to have the
counting overhead, but I refuse to pull it as some secret hidden thing
that isn't even mentioned in the pull request.

Honestly, I did not get any strong arguments for why making the
preempt count unconditional was such an important thing.

Yes, Thomas pointed me at a couple of uses that were garbage, but even
the people involved in those seemed to agree they were legacy garbage.

So why was this preempt-count thing then pushed through like this?

                 Linus
