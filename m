Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8530A2BB638
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKTUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbgKTUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:03:08 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A8C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:03:07 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so11305453ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfEptDpP1YtMPX3UYhi5HrsU1kyxo4HUkBqW2ybT0os=;
        b=P98qZn1jej1Te8QHhY/hWPSL0DK4pikDWmko53l/2JZ482i8q/9KwabI+EH4dt7hzV
         FcX5ExTubtcVdBIKylljQHIbzssTlivP6hsID6WKbLWm5UiaVzcEJmKGYr1kxMKLwYDL
         tbQRobTIlAac4nAvxvpxU+ZKcGuWm8BC83aTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfEptDpP1YtMPX3UYhi5HrsU1kyxo4HUkBqW2ybT0os=;
        b=mPSLUbHINgPWixEV0iue2y/EnieON9+k9QXm0Z7fT3f21at5ZO/WtCnCwGWUT4mP2R
         Gc84VKMtu4v/UAFReCM6OalSnWHOXQMNmIrPJ90S8gXp+cgoxUCMcgOvzUyK0wiIRYHd
         /L30k9pPXhqCHWzPsTZVvnwAW9ren/IJBvxEXP7lwk1CsMSXxvsN6Qc7ZCtDXdSUrJ14
         BOqxt8LP6zDyVAXZthirycZglw458xIFq57TriwUQXbDFnXR/5J+RrbFDMGtpktJxWXG
         ll5UPd6D1fmys7MGzOLcexngEoebJNi35tyl4r298DHvutsDvXLpFuVjQWgLdnTEExIJ
         K9qQ==
X-Gm-Message-State: AOAM533FOQJ0xh9lExsF/JzL3MwplylxEYYY1JtiJGgzrJvD2wbtVrhe
        kajMuJaBtNK0Tn9z4MAHZEOf/kjEdvuioQ==
X-Google-Smtp-Source: ABdhPJwjaq/lGBBitHb/v66mabRsrmQeu4Uoo2irSFIK9CTTyryqf0qIfyggbe2Szhmc4zg3zDv0Nw==
X-Received: by 2002:a2e:9b96:: with SMTP id z22mr8113779lji.163.1605902585756;
        Fri, 20 Nov 2020 12:03:05 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 17sm452207lfr.52.2020.11.20.12.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:03:04 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id l11so15219699lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:03:04 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr8126506lff.105.1605902584160;
 Fri, 20 Nov 2020 12:03:04 -0800 (PST)
MIME-Version: 1.0
References: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
In-Reply-To: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 12:02:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrayP=rOB+v+2eTP8micykkM76t=6vp-hyy+vWYkL8=A@mail.gmail.com>
Message-ID: <CAHk-=wjrayP=rOB+v+2eTP8micykkM76t=6vp-hyy+vWYkL8=A@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring fixes for 5.10-rc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:45 AM Jens Axboe <axboe@kernel.dk> wrote:
> Jens Axboe (4):
>       proc: don't allow async path resolution of /proc/self components

This one is ok.

>       io_uring: handle -EOPNOTSUPP on path resolution

But this one smells. It talks about how it shouldn't block, but the
fact is, it can easily block when the path going through another
filesystem (think ".." to get to root before even hitting /proc/self,
but also think /proc/self/cwd/randompathgoeshere).

The whole concept seems entirely broken anyway. Why would you retry
the failure after doing it asynchronously? If it really doesn't block,
then it shouldn't have been done async in the first place.

IMNSHO, the openat logic is just wrong. And that "ignore_nonblock"
thing is a disgusting hack that is everything that is wrong with
io_uring. Stop doing these kinds of hacky things that will just cause
problems down the line.

I think the correct thing to do is to just start the open
synchronously with an RCU lookup, and if that fails, go to the async
one. And if the async one fails because it's /proc/self, then it just
fails. None of this kind of "it should be ok" stuff.

And that would likely be the faster model anyway - do it synchronously
and immediately for the easy cases.

And if it really is something like "/proc/self/cwd/randompathgoeshere"
that actually will block, maybe io_uring just shouldn't support it?

I've pulled this, but I really object to how io_uring keeps having
subtle bugs, and then they get worked around with this kind of hackery
which really smells like "this will be a subtle bug some time in the
future".

       Linus
