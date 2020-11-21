Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D305D2BC0E3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKURMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 12:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbgKURMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 12:12:00 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63595C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 09:11:58 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id f11so17985658lfs.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quCrZw3xjQlus6dsPuthLkw5agQjB3m+LKm8h41dAL0=;
        b=ddmMBP4Ze9m33DVUykspjKY2KVNIw9KTrtgVsU/DE6Ka8lRHMfvRcSEul+eztgd45n
         6wZqm3AsD7SS7l9Yrdrs6TovA6f3BX5Rp7sq7IF+1Sm85JVxkuoQlE8H70DQsTp2A1jd
         V/q+DIdNv/g/HAzs26YWcNxjPnHpTrOdOZ2CA1Jb5yZWFoE2SXwv4iXxJ5fsKKLRjJTo
         jEebQ4b2oOi67818pbR9CxMIXGhJdWi0/4bhOpG3QSMj7wSPpaFXqvIwe8v5OPGa5mOP
         KRM8e5B5G8FU4OOzi3jXWnnT3dzCALuP9ZvqxFvxgfumGlIDWFWOy8yOl7eLrQtg02yf
         SAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quCrZw3xjQlus6dsPuthLkw5agQjB3m+LKm8h41dAL0=;
        b=ZodIsE3zS2uUUTBNTkF0Q4MExFraMuhDOGoy0QBWxislTsu8dlyCm9nzt5bnr+1ofn
         0gjbrZm8DgbhPSIwutRbW9PoRYNzat3K9LZfFSH7lYCwAvp4lmawHabK/VTdgxURFzaB
         iD6xYQ/u7oUoxRJ8T6RxhpKTruASvYK1kh0+hvJFENXcmjr2tRgc6I5Kvr027ZWwMnh0
         fuJm16uTlTOnxpym7+ENyT/VwDNf1YPQLnSlFpvz8zl0sp3qk9prI80Jq3L7pxecv+B5
         8Xt9LA6El1OGBywRsM4tz2i5cPp7k83e+2LzFPa4/26V8oZz/wlNvIau7b2a9TpAhKWp
         hfmg==
X-Gm-Message-State: AOAM532n9aNVaFU5rLGRz/Wu1BdLjp/5dDUm/uYBwovXPOyy5VX/Mz1b
        ILTrajQDYpFyrDWyMWUpH1+jhLuDJ+G7eqY80nxPGQ==
X-Google-Smtp-Source: ABdhPJyMNlwa4X7CQkWhvPpd88a2fJ9PtYFIy30vHt74u7V6698gYdMM3A7vxWOrDPJjPlcNcQktRKUdn+L0sTaJR5M=
X-Received: by 2002:a19:4147:: with SMTP id o68mr10708124lfa.365.1605978716421;
 Sat, 21 Nov 2020 09:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20201120233743.3617529-1-tkjos@google.com> <X7i+QcE8hhY03FX1@kroah.com>
In-Reply-To: <X7i+QcE8hhY03FX1@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Sat, 21 Nov 2020 09:11:42 -0800
Message-ID: <CAHRSSEypnwWwNNvs0giYTjOeUXJuAb-4MNTymVf1uUJr8aUwSQ@mail.gmail.com>
Subject: Re: [PATCH] binder: add flag to clear buffer on txn complete
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>,
        Steven Moreland <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 20, 2020 at 03:37:43PM -0800, Todd Kjos wrote:
> > Add a per-transaction flag to indicate that the buffer
> > must be cleared when the transaction is complete to
> > prevent copies of sensitive data from being preserved
> > in memory.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
>
> DOes this need to be backported to stable kernels as well?

It doesn't technically qualify for stable since it is a new feature --
not a bug fix. We will want it for Android S launch devices (5.4+), so
it would be handy to have it in 5.4.y and later.

>
> thanks,
>
> greg k-h
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
