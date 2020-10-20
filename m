Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B24294556
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 01:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410477AbgJTXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390906AbgJTXIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 19:08:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC3DC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:08:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so170950lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=804yy30m7cIel8Pt8XOnYXbNmTdfMOTv3pJtVeOnIlk=;
        b=cSM2YMl8e2MZjcTaoGG9WcZDsEzWBrsw329A1sjs2dXOTA0gveple05afVNHAe29hB
         NMtdB3PC1/HQ+sdTwbM0w/IRKAN72UspgwgVSPSe1MJ6CrSzsuM3iRNmpwIb3PFFLm9t
         LKVbGvRPVhrE8mTTaRsGOlRCuVZeYCiEYAmVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=804yy30m7cIel8Pt8XOnYXbNmTdfMOTv3pJtVeOnIlk=;
        b=oPPbmhdO2Gni79H9OQ6fmnAEACqpbe7kiY1RxjXOe2pTCj974U3NpX0pUn1+b2Iz0I
         uDsJuy2zAJrcN3/yhU2ChaZEN+3xp/HVkq5H7dtGXI5UkzysebmaprXKZvye+uggbiue
         1VbqCQCqSJyjCo80gYWSq+D9LlmJajOiZkjqpLQ0FpR71MpsnRRAE8v5vBvwXUr3fqBa
         HArhxGU01WcVVIGXOIMtOFEz4CP99nhNMUASOs56cDl2C65W4rjGjYqRLqzplaFwMv9e
         mQCWKuG0Nc9NfoJ04m7TeMlwVrPCS5CaSnAwvoKIwfdXPTWhMnO9JKIcDBOYgL1w7yny
         1iGw==
X-Gm-Message-State: AOAM533KIGA2Jy0KKrALck/jGdmRsoL8Df2XUoVonclCYxpVBZ7s09bR
        Ak6STV/tl3ANP4wOSUEG8RNWH2hBF1S64g==
X-Google-Smtp-Source: ABdhPJy+OxOBeKNLGv3WwB0V8RIwSmBg5teDn6A2tknhOmMXsJBbfb/O09nZLsylT94iEObgr/G15Q==
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr117396lfi.89.1603235308500;
        Tue, 20 Oct 2020 16:08:28 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g14sm65743lfb.307.2020.10.20.16.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 16:08:27 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id x16so223143ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:08:19 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr192860ljh.312.1603235298969;
 Tue, 20 Oct 2020 16:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012203226.GA11861@1wt.eu> <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
In-Reply-To: <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Oct 2020 16:08:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
Message-ID: <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
To:     Amit Klein <aksecurity@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Marc Plumb <lkml.mplumb@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:26 PM Amit Klein <aksecurity@gmail.com> wrote:
>
> Quick question: is this patch still planned for inclusion in 5.10-rc1?

It doesn't even build for me, so no. It clearly hasn't been in
linux-next or anything like that.

Hint: grep for prandom_seed_early.

              Linus
