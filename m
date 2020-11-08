Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AC2AACB9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgKHSEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:04:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 10:04:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so7616413lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UVYtUHZTYf9HsQcD8FoaWm/HXd3oXUq8KPCJuQEWFA=;
        b=f38a4VKBjOY149JngJ3E8ASaRqJrb+pjWg99gtelvuBtWP5zrjncJGSrdC6pHLXjD/
         8plRXLc+5tQFiCJODF/cTnl0z5+uVxCVfhpWGH8E8R3z6UH0O/kiKpzZ8shQcOEu1bDF
         8f8hJVyEaZQ8jHU2EvLOCcQUqZ/2YnI/qwaqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UVYtUHZTYf9HsQcD8FoaWm/HXd3oXUq8KPCJuQEWFA=;
        b=LR5ruVptXgcDnPcuJ8koA8aYJCv0eJ3NVx9642bdUX8Fmnkcg+3G3niMA1+98eDmPP
         y2cD7q3/VB1autJYkH79mCfu6MWy4yam/QE2Os4Fiq9UQto6ARgtQDeB10M1aZtvi6E7
         qWTP6oThKG36BzekRXezrXSb/HOKQMTfDQ5Y+UJQmYi4gcT+eTafkc9mx5PT0D+LBPpX
         R7uGFcc8N21GltM1SmHnLOwkppm6xZiP7m4zitQkL9V7EFfOyi1UzHXJtG6aDpPjPFoa
         bP0jchNCnBm/VxH1qIcWCNG9RIk7+TCmmaJREzr8JamXTCWCLbgbYUrAlf1fmPZ428ok
         Nj/A==
X-Gm-Message-State: AOAM530j09oVcTvQ8pqPU0Tq1mHUUiLj/ystAz7QkyRy+LiHUPGj+6cx
        fEWvErHlWo+Dmo/zoAlFmoqzwZVwDTsfHA==
X-Google-Smtp-Source: ABdhPJzlfvgDkgh8ICgqSd0hc+pRHQgZY76s+87ybdXm3XsBZli9P8cgNz2cIFT1gMXKT6B7grTSdg==
X-Received: by 2002:a05:6512:3495:: with SMTP id v21mr4135138lfr.134.1604858692949;
        Sun, 08 Nov 2020 10:04:52 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t22sm1768725ljh.89.2020.11.08.10.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 10:04:52 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f11so2658641lfs.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 10:04:51 -0800 (PST)
X-Received: by 2002:ac2:4211:: with SMTP id y17mr4357547lfh.133.1604858691523;
 Sun, 08 Nov 2020 10:04:51 -0800 (PST)
MIME-Version: 1.0
References: <160484899473.4262.9790266201913163807.tglx@nanos> <160484899714.4262.9283526258177769567.tglx@nanos>
In-Reply-To: <160484899714.4262.9283526258177769567.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Nov 2020 10:04:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3_NkjfHmhTSMsHVxVji1+Fp_f_SByFRspR+KW4uqWWQ@mail.gmail.com>
Message-ID: <CAHk-=wh3_NkjfHmhTSMsHVxVji1+Fp_f_SByFRspR+KW4uqWWQ@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for 5.10-rc3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 7:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single fix for the futex code where an intermediate state in the
> underlying RT mutex was not handled correctly and triggering a BUG()
> instead of treating it as another variant of retry condition.

I'd just like to point out that the old code was *exactly* the kind of
code that I've been ranting about forever.

BUG_ON() is not a debug aid. If it's a "cannot happen" condition, you
don't write any code for it at all. And if it's a "I'm not sure this
cannot happen", you either handle it (like this patch does), or you do
a "WARN_ON()" with proper cleanup.

Using BUG_ON() is never the right thing to do, unless you can explain
why the condition is some kind of fatal corruption thing where you
cannot do cleanup, and cannot just ignore it.

And so often - and this case doesn't look different - a BUG_ON() will
cause serious kernel issues, including locks held that may well cause
fundamental problems downstream for users even reporting the BUG to
anybody else.

This particular BUG_ON seems to be three years old, so clearly very
hard to hit. Or possibly very hard to report? Regardless, please
people, keep the whole "BUG_ON() is evil and wrong" in mind.

                 Linus
