Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA902B2659
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKMVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:13:30 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90924C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:13:29 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v20so12490427ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdcBPMR2uUFyIBEWl0Rb/mcnVvNgZlfKO/WKNKBB2O0=;
        b=UrTbGreXYH8GN8bfvkwx71xoOiM9KEsmx6c7ub4kcgrhKOLk9OMSBny7uL9pOoWvAb
         pFGaS6YpyjkW+C15b7fxwoLqwOBEX0SlKaFJYQFeSaltMPteWVtxLdxFeMO8FD93zbC2
         8qoLIcFAywPWeqUfBrnfBNdQodwQoy2fxRC/a4NZzKneNouXGzXj81ux6glnnom4905l
         LULCZey4+2TkRJC7/3W+NkpQcHkm3IHORKO9dpN3EZ0S54UPUzOObRCgnRi0QHUPu0Pm
         eVwz2wrgS6N/1eLlmId0X6ktpfwylXWzb6yvH1PqQ/EcxiqWL7z3CCBeFiPmDNTiOFh8
         sUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdcBPMR2uUFyIBEWl0Rb/mcnVvNgZlfKO/WKNKBB2O0=;
        b=uj8EaXpat4MBMRjNGhsFnoLiUmrE2OLVoGe4KbGQCUL5a3qGBFYDSlrL2uJ82v+smA
         PilpuZke07B89L7gK6qKOJ+A5VEjk4fRE1rq1kh8Mn/kO3AeJ9eF+8AxkrFsIzo+cSws
         8B/KfO/Gfv03IMGCsDDUywoAEcu1JByRtRl4TYVhWu944RTpxqBb4BSYpmQR0es6iLNF
         99bOhM44PNCtrD6tRGEqJzq5D3Gx+C+o0XPV049pCmxL1MdJNpSHDZeNPro36B/5WmWp
         StQbPoJdk5a4gvflJsC3IQEmh8Kt4slppvdOfJoFmt9l7I/aN4ALpC/ICXBxkGFWPDGU
         C7Xg==
X-Gm-Message-State: AOAM531PQN9r+KNXzGSZE1I0xIr9mQsqIGN6U9jV4SBbDXo7eEK0Vm/Q
        /I19gpKqj+SG7fsS2h1ZWUvg4MJ15PMzHr+c35qJQ2JANiI=
X-Google-Smtp-Source: ABdhPJxi+DHEytqtWO7EmLwlKPk3qZCMAGE8itaJEtri/XxIgHFbEJvwtHI7U6ENdaIOzuegYQ21ayo3HjmZAx/fh6s=
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr1929767ljj.301.1605302007750;
 Fri, 13 Nov 2020 13:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
In-Reply-To: <20201113210730.GA1992396@bogus>
From:   Roman Kiryanov <rkir@google.com>
Date:   Fri, 13 Nov 2020 13:13:16 -0800
Message-ID: <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Rob Herring <robh@kernel.org>
Cc:     paul.walmsley@sifive.com, miodrag.dinic@mips.com,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, thank you for looking into this.

On Fri, Nov 13, 2020 at 1:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 13, 2020 at 12:52:33PM -0800, rkir@google.com wrote:
> > From: Roman Kiryanov <rkir@google.com>
> >
> > The only user of RTC_DRV_GOLDFISH is
> > the MIPS flavor of Android Studio Emulator
> > (goldfish) which should be also retired.
> >
> > Signed-off-by: Roman Kiryanov <rkir@google.com>
> > ---
> >  arch/riscv/Kconfig.socs    |   1 -
> >  drivers/rtc/Kconfig        |  10 --
> >  drivers/rtc/Makefile       |   1 -
> >  drivers/rtc/rtc-goldfish.c | 216 -------------------------------------
> >  4 files changed, 228 deletions(-)
> >  delete mode 100644 drivers/rtc/rtc-goldfish.c
>
> What about the binding and MAINTAINERS?

My bad, I will update those files too.

Regards,
Roman.
