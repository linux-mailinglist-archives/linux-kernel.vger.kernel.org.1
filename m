Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3602CACA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392405AbgLATq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgLATqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:46:25 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E7CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:45:45 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so6718865lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/M5sq8m9uvKK5PKK/f4c5bWAEpZYZ9s5kuoJr0joz8=;
        b=E4Vx2uxfPTg32ESNrWp1AAzvAKPsV8LN+N1EYBZ3jnxC7A8nB2r0wwgEnesuu2uhWP
         utbhBLDa3dGPuHGV3e+LOuWyXyx+dLDv/3Mmd18NFnHGrCvrwuxH8R7cCCH/PGUvOj0P
         zg6uVr7B8E3yEZV/f7CRB32/GcXqzL1nHi8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/M5sq8m9uvKK5PKK/f4c5bWAEpZYZ9s5kuoJr0joz8=;
        b=bxS3a9B6GnpEcbN+4C2aZ/RmFHiSsIDyxEvkns6I3ZL8LzMKASgDACfsMlcLkWohH8
         nZM1i8FUO1kFsrnDpStdCEJQ0K9ByVFrcHUT5wqI6LZubuC3pIrDFiGlMyYcDDYAqHV1
         2h6C3u3MqE7gYtRJlag9P7s4Ibb+aecOkNZdImE1Bq5679eOoMu4BNjyxgj76v2cTp0N
         fdw7qGGR9ZAtODILM7ylOlxWpj7NAVIJhqHE/5Np/xiDH83dG/NPSnRmmN4MRbR4f8/O
         XGGpAKne5lPMFNRPx3nNRIfZmHu23/YZ55Fm4g2u/ZyL1rZT0WcR8XuoS2Fn/BC1HUKG
         PFDA==
X-Gm-Message-State: AOAM532WVdkMtkmY11cMNiq1A4MNZpXoDUsBy2j9+fDXD6zRBxAyN66z
        gQkP2/ywIkqA5SeMIMOOtXNKgBp+xBirlA==
X-Google-Smtp-Source: ABdhPJx3xXcXklYNWUHb2iba2qSKHePe/q5dL/6tt/+x4dk0FDdAKSG3wCrsR/xgEA6H2FUiTqBcLQ==
X-Received: by 2002:a19:c701:: with SMTP id x1mr2049685lff.516.1606851943148;
        Tue, 01 Dec 2020 11:45:43 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b79sm58969lfg.243.2020.12.01.11.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 11:45:42 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id s9so4999330ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:45:41 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr2130216ljk.102.1606851941584;
 Tue, 01 Dec 2020 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos> <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net> <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
 <20201201073906.GP2414@hirez.programming.kicks-ass.net> <20201201075633.GK3092@hirez.programming.kicks-ass.net>
In-Reply-To: <20201201075633.GK3092@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Dec 2020 11:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTsvLivVr05CbfUEUv+maq+qyvsfXTA0W278f_JbJciw@mail.gmail.com>
Message-ID: <CAHk-=wgTsvLivVr05CbfUEUv+maq+qyvsfXTA0W278f_JbJciw@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So even if an architecture needs to enable interrupts on idle, we need
> it disabled again when coming out. So we might as well have the arch
> idle routine then be: STI; HLT; CLI; because then architectures than can
> idle with interrupts disabled can avoid mucking about with the interrupt
> state entirely.

But that's not what the code is doing.

Go look at it.

It does sti;hlt;cli;pushf;cli;sti.

All for no good reason - because the code is structured so that even
if all the tracking and lockdep is disabled, the pointless "let's
protect the tracking from interrupts" is still there.

See what I am complaining about?

                Linus
