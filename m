Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5382B992C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgKSRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgKSRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:20:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC27C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:07 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so9419177lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdtThT2vJGo6Wdq53TPlyIKnQQ6EAzbrw7SbM7qAaa4=;
        b=KtKkL/bDLeFxOu5LQGzpdhHGbQcQiZojE1Hwikc0m0D212LbNnl+k45phZKTDGy1eB
         96t/WiI8l4XGutRfemSkL6TPvDyFyWWNpvGV5SPJIJZa3sFF0WeQwNdrSR4OGyrEHFFp
         mLVxA8UY9dwUahqDuuxY6hmT6SvIWpNxxB4w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdtThT2vJGo6Wdq53TPlyIKnQQ6EAzbrw7SbM7qAaa4=;
        b=VdVItZADSqlhus/kvVzZ5FHIXK+NN8axs2CuaXJx1rsueI17uCx9ORkSYG3Usgl7JY
         6ZpbsBDnbeMbUM6pnISjZuQwD35lPH5g30XB8Du7A1uIsrPezJDpqK72oakEdxpsY3IF
         Fp7zcBc9t9/7mtT0eBbXP/lfCA4Rb0aoVX2ODfvpxyjYLHlkmGll720Elo10r1rP2Nz+
         9h+L/y6munYpEmHAX8QZGbk6MRp31MdN0jojZ7jcBv1liN4U3KV+IoDZyqzgGCm7gYiv
         9oaBHInKImU+BhuYDO0xS+zhNpUGPNpMxGjXWbo7KlV648OVpZa1i9k+pvtTsmDH6fhM
         pI/Q==
X-Gm-Message-State: AOAM533wqH21hcs1lBWwL6de2f8IQMLLVQLd01bQM+m91t33YLWxkBeE
        d4gNXxQkSlIJ/V31e1T4G8sUre/0hHrOzA==
X-Google-Smtp-Source: ABdhPJyK4N2sVtSk0e4Aq5btYjbasUTeqpdWY3OngrkivsALxTM2f2vJe7pE8YpfIjdYzWXZL8VUaQ==
X-Received: by 2002:a19:8346:: with SMTP id f67mr7499300lfd.569.1605806404853;
        Thu, 19 Nov 2020 09:20:04 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y12sm27016lfh.120.2020.11.19.09.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:20:03 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y16so7107366ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:02 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr5940506ljk.102.1605806402308;
 Thu, 19 Nov 2020 09:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.028261233@linutronix.de>
 <CAHk-=wh6+VXQASpG+X_v8E25X9mARyHULeOfHk1RsNFMMWHafQ@mail.gmail.com> <20201119084601.GG3306@suse.de>
In-Reply-To: <20201119084601.GG3306@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Nov 2020 09:19:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtYWV_d-hH=iZYF1nhwvB=1wvJvE1fNEXSEDhomvHuvg@mail.gmail.com>
Message-ID: <CAHk-=wgtYWV_d-hH=iZYF1nhwvB=1wvJvE1fNEXSEDhomvHuvg@mail.gmail.com>
Subject: Re: [patch V4 2/8] mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
To:     Mel Gorman <mgorman@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:46 AM Mel Gorman <mgorman@suse.de> wrote:
>
> And not start thinking it as a security hardening option.

It's probably the reverse of a hardening option, since it will cause
mapping of stuff in known and controllable virtual addresses.

Although any kmap'able page is likely to already be something you can
read anyway (ie page cache long after security checks have been done).
So it probably really doesn't matter either way.

The only thing that is certain is that it's going to slow down
important code-paths.

             Linus
