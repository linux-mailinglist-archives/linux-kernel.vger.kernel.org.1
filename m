Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2529F27F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ2RFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgJ2RFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:05:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42510C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:05:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g12so2854284pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh/de65EzS7o32eKzyxijzJut257PQrXipgp+9EhbPc=;
        b=OzqupX9v8mSg3E42wKpXhrJrFQNkvdggypyI4Y9Z/OCTCwGBaWn4Eb74pVX/cybGNe
         FUXbeXY45gHU0PWCVCMgcvtWM21EW4hLacateikEp6Bt6hzgfShzm63wXTSwL1/QGPAl
         0mhIKOqI1K6SiZjmwbf9jjYBdwDcXrW78OgrVgxdqyFZrnrr6X1UwOOQELbBEzIxtgXN
         WzFgrAbFByJRMoWczs7eX4y8qe4ExtUWkUFWrn4keiJ63LVBZp74BzcneYBLXZfAF2Gv
         rmHKeA47UCPFsZ14VTqPfgWKFSdmcWGfPebs85VOGDnLZr09LevtQONnZe5iUpZ7ANDJ
         BJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh/de65EzS7o32eKzyxijzJut257PQrXipgp+9EhbPc=;
        b=RYA69+J5rX0/WLUy+T0s4NSnHNvvYkN0tJCR/HSqXKK96vsZZQiWLun6KGinWf0LpQ
         7GSJLDBrGZXi2z4K4jARoS4FbLTTvmS1wINUJv8h1QXOkJrfndNp2VgoERq/yN9HF9eX
         IH2jZrZQ0tLez/eBUaxWU3JvFVUjWw7uVvVjsT3aFRjkuAhP3n2XZJWydsqvylmPx7PB
         Pc5gm+7sStJsS62BTL3h3jzxP2yJhB7QpCNZ1tRDEw4bxcL/lyBfVNEzYgHRygEkY3yV
         p7c23WevrVjYnUbS6lkLx0zG+XrcBXpqwpB4MMJXSpgatR/Iz26MUUU+2I3zLgxScxSC
         9iUA==
X-Gm-Message-State: AOAM532kMAZ8kCvJ2GBz3JLEuWdXCrz++AGf2QcNnhGttxdxKr9eZpe1
        MgcQR+Vhy6r8BNFV28R1njt1YhJppYdtsH4Aaeg=
X-Google-Smtp-Source: ABdhPJwHGL9fz2dOaR7k6Rw4wVzY8TT0eFChuBS+mXJ9guh5YXyN6CUYRHONFz/2SI5YQQFYcwGhsvMYHolBx+bBh5s=
X-Received: by 2002:a65:47c2:: with SMTP id f2mr4869716pgs.4.1603991100865;
 Thu, 29 Oct 2020 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201029100647.233361-1-coiby.xu@gmail.com> <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com> <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell>
In-Reply-To: <20201029152719.GC4127@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:04:44 +0200
Message-ID: <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary CONFIG_PM_SLEEP
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 29 Oct 2020, Coiby Xu wrote:
> > On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> > > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> > >
> > > Have you compiled this with
> > >     % make W=1 ...
> > > ?
> > >
> >
> > Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
> > disabled. I'll run "make W=1 M=..." for each driver after adding
> > __maybe_unused in v2.
>
> No, thank you.  Just keep it as it is.
>
> The current code is space saving.

Perhaps you need to go thru __maybe_unused handling.
There are pros and cons of each approach, but not above.

-- 
With Best Regards,
Andy Shevchenko
