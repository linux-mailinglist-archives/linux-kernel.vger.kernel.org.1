Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFA2AACA5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgKHRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:35:59 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD6C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 09:35:57 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t13so7151396ljk.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 09:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goAf5APyC5tyGd02qLYin25Wsnv/7V4lb6bl4j7KYBA=;
        b=OIlrQdfnTL/fOrmqEZO2uA/eSIGlvwCBqDCtTzbVRQ05lK6JyUU44d7XKswyLxEQ3e
         Qc313nvQHeiviQ9mtGjKiSEsja6bspSPukvcqZs/wbbgyFHTmRFN4OjNzZLs5LnDk8LV
         +fyX3PNYZX9zfRDZG5KlIVCyb8yDPO5cXRBw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goAf5APyC5tyGd02qLYin25Wsnv/7V4lb6bl4j7KYBA=;
        b=hk5IFV4SpngSw2LwLohpI1WthsLUq7IsnAStRLta+3rxlSoDAuuPgLNrH1Yv3/ZEF8
         TFP+gwIom/QcwJpPwH5+BE7HD2y1Di7XDRqqTEVUJI153WNvAIETnEkwS5zBsZsgjIIu
         omPa45ht75LTUN1/eala+tApbSyIdG6K/G6TLF565bWCXIPbX6+dlMqyEK8p0blhfTiO
         xz33TXan9xah+BJbLRSkwjR8ayhbX+XK1Pn6o5zffohtLX2jWf5YwfoePJjKieh8wqee
         G3yhhcSYIec0yq5lHt6Vj0oNzYCVczRZTTvWZyXC0ch+7LOCOUxSYISS59PX7qWHzkdu
         Ce0Q==
X-Gm-Message-State: AOAM531o5ALPXNKPulDWXuuVqke7NqUys/eWAV/gexcsylPXdsREljhd
        TGEGfLw9lreGtcipITvoVPpRJTcF1d0apA==
X-Google-Smtp-Source: ABdhPJx1R4Fo1WHBzUsg6IFYHSA6a2dtVSf6bxESqIxP1X4udRg5/iFD/jfW5cf9qQrE5ka9Xa5PKw==
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr4321484ljl.38.1604856955624;
        Sun, 08 Nov 2020 09:35:55 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c19sm1779731lja.9.2020.11.08.09.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 09:35:54 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id v18so7184654ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 09:35:54 -0800 (PST)
X-Received: by 2002:a2e:9212:: with SMTP id k18mr1536219ljg.371.1604856953961;
 Sun, 08 Nov 2020 09:35:53 -0800 (PST)
MIME-Version: 1.0
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
 <20201107160444.GB30275@zn.tnic> <20201108090521.GA108695@gmail.com> <20201108092333.GA13870@zn.tnic>
In-Reply-To: <20201108092333.GA13870@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Nov 2020 09:35:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
Message-ID: <CAHk-=whVvcAawxiKnoYLRvpPqzgtiqvV+ogBC=q2F0CBqNidnA@mail.gmail.com>
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the atomics-check SHA1's
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 1:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:05:21AM +0100, Ingo Molnar wrote:
> > So that mode change to executable was intentional, as mentioned in the
> > changelog.
>
> Yeah, I thought we don't make them executable in the tree but I guess we
> do, at least most of them, from looking at git ls-files *.sh output.

We do try mark scripts executable, but you may have been misled by the
fact that we then try to avoid _depending_ on that during the build.

That's mostly because some people still use old workflows with
patches, and the executable bit will be lost if you apply a patch
without the proper git tools.

(I think we've also had cases where people were developing on no-exec
filesystems etc).

So while we try to mark scripts executable, we then actually generally
execute them using an explicit interpreter invocation anyway (ie using

  $(CONFIG_SHELL) "some-script-path"

or similar).

              Linus
