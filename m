Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDD2C8BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgK3R4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgK3R4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:56:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE384C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:56:04 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d8so23346041lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbq0m7bxZzQitlIErT/PTR+nZa+c3i98rlqgqI7f0x4=;
        b=TvkNI90tjx42gNC+T62tFenXRkYkTlaBYXMQ6gJ39q3HuhLN01tX9LwKCNYfM0B4mA
         0r1yUwYeWhqJWMntToK7/SvjFBwASe+5JMvINPU1hmNV0cUo/kkuHbiTk4D9iDr76Vep
         +9KiJnHRNgKjbt8aagc6sCfPJGGoxTabCpm0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbq0m7bxZzQitlIErT/PTR+nZa+c3i98rlqgqI7f0x4=;
        b=NPt3WDTwT+LTu/ZnJHC9d+C+Vm3iogA8qyYqy907TMBqcPvpR2IT4AHObRq5/cMUH9
         J4XNeKt7SYwrE6kQ5y6Frth/+2VmeJXUId5IqGGNghvgqjWX7oyjOCPZwSEEyB0GUrLq
         onxBBny1Wyxbtw5kY6fIhPaBZ4SQSEaArpnVCSnTsoDG/131IfYgDaI5fBrbSbw8lgIZ
         HDnc4zHM7/IjUnnAFZmPO6THiDnVHPShbMZ+/wdKHC42F4qHakoq5mzEVbonCzUbQh0P
         SccQCnQED8kw0Zbyt4VkZDJuBUDTMAkc/nlpArx+fp1dcda43fZFD5TNeMDYohH5X3jR
         MNsg==
X-Gm-Message-State: AOAM532EnRxQQGmdFy90ULfJ9fDYHLXAn6xZZEbQql4swFRyqEh1vvdr
        fYllkRgis2JFtdXGvIyB2+UfTYLEEe8hxg==
X-Google-Smtp-Source: ABdhPJwsjTK69w2oX9/Kcj+JBN7fARbo1XjjLhnJTTaTGrddtxW/rurpVlQCa1bxBRNGRNKSu0wNyQ==
X-Received: by 2002:ac2:42cf:: with SMTP id n15mr9955869lfl.461.1606758963015;
        Mon, 30 Nov 2020 09:56:03 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x20sm2538302lfq.86.2020.11.30.09.56.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 09:56:01 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q8so10272204ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:56:01 -0800 (PST)
X-Received: by 2002:a2e:50c:: with SMTP id 12mr10009271ljf.371.1606758960857;
 Mon, 30 Nov 2020 09:56:00 -0800 (PST)
MIME-Version: 1.0
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos> <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Nov 2020 09:55:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
Message-ID: <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
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

On Sun, Nov 29, 2020 at 11:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The idea was to flip all of arch_cpu_idle() to not enable interrupts.

I don't think that's realistic.

> This is suboptimal for things like x86 where arch_cpu_idle() is
> basically STI;HLT, but x86 isn't likely to actually use this code path
> anyway, given all the various cpuidle drivers it has.

Well, but the thing is, "enable interrupts" is pretty much fundamental
to any idle routine.

Idling with interrupts disabled is not a sensible operation. The fact
that on x86 the sequence is "sti;hlt" is not just some x86 oddity,
it's basically fundamental to the whole notion of idle.

Yes, yes, I can very well imagine some hardware doing a "idle until
you sense an interrupt, but don't actually take it". It's not
_impossible_. But it's certainly not normal.

So I think it's completely misguided to think that the default idle
routine should assume that arch_cpu_idle() wouldn't enable interrupts.

             Linus
