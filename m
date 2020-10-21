Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389E29545F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506354AbgJUVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506347AbgJUVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:41:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39EC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m20so4195190ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42fZhoeQdoxXUwMs9vm/S9uMV+R37X7ol7j8YABZkOk=;
        b=DxsDk4HgbLW4M4frkHHB/CiaLmbEcaUyqGZ1+X0ugQ6VJBChfGNTkz/gz7UnaeLJoH
         nNMxJsRxNGwLlIpo1tqcmfhcwCk5ltHAJyKASr0YPTo958r0IlouBbnBAr24RuN82pJk
         rDa105I5A3UQ/1OVJOVicbS4THqDoQnBdzJX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42fZhoeQdoxXUwMs9vm/S9uMV+R37X7ol7j8YABZkOk=;
        b=M2eE4yktlCu/d9Crb6ZHzva4alZk8otH7RswlPP2r3NY27mNM14hC9m9Re9Rk6u62W
         6bAIideXZZ0Mt7vmU5kx3S6K7ecUh6/glHS8Kl86xxdbc877n4W3Dh4rJ+MgM/bedJc6
         9npuy9/x+qGrQw7VT5D4uhAwHivIEdVmbwn58ey+uNOlgCQl+FxuCdvmaBQ2mIeTmDvH
         LRRGMjSolcpzeWrouh+A2ZCABVcSyn+466fqCrAkn8je/FrHBHszao9PiavrezmwnHoh
         yZlRpdNZsFHpwxaWEL0K6mQfSA0NWQhgmEJFGyn6enoCPSoQczyE8xx5PUFnBKPWzBwU
         Bayg==
X-Gm-Message-State: AOAM530JjBRzVoUj+inK6PpsfVNVvbQWnlQ6mqOnhx5+Ylbk6rpJTOjR
        qFAHvrPirnXNnINHvzP9MEMUhq1Hs0Ew0A==
X-Google-Smtp-Source: ABdhPJwU65ulTeixMmsmsZax8xlpFcfcjmgVKd6zMQH5i/iN3zHOOJX4GbEm1qMf/CNxGiVxJC/3qQ==
X-Received: by 2002:a05:651c:1282:: with SMTP id 2mr2306279ljc.284.1603316508081;
        Wed, 21 Oct 2020 14:41:48 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d7sm632571ljg.140.2020.10.21.14.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 14:41:47 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id i2so4212361ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:41:47 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr2001721lji.70.1603316137422;
 Wed, 21 Oct 2020 14:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201012203226.GA11861@1wt.eu> <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
 <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
 <20201021032725.GB396@1wt.eu> <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
 <432132f9c678dc5093fd85055e5b708584018a0d.camel@perches.com>
In-Reply-To: <432132f9c678dc5093fd85055e5b708584018a0d.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Oct 2020 14:35:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9Oe=NCG_S1X-rSFwkWe=vK7GYUHp22PFWa2W47WnzKA@mail.gmail.com>
Message-ID: <CAHk-=wi9Oe=NCG_S1X-rSFwkWe=vK7GYUHp22PFWa2W47WnzKA@mail.gmail.com>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
To:     Joe Perches <joe@perches.com>
Cc:     Marc Plumb <lkml.mplumb@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Amit Klein <aksecurity@gmail.com>,
        George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:20 PM Joe Perches <joe@perches.com> wrote:
>
> While secure solutions are useful, I really wonder if
> "George Spelvin" is a real person.

It's not his real name, no, but he's a real person.

I do have his real name from years ago when I needed to confirm his
identity for sign-offs (I forget what for, I think it was some dcache
name hashing thing).

So I can confirm he's a real person who just wants to keep private,
and is competent when it comes to hashing and security.

                 Linus
