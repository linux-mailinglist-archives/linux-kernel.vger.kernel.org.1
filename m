Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAA2CF226
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgLDQns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgLDQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:43:47 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F8C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:43:01 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id h133so403172vka.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2827Z3XOh+XnEroPsCQccYwh3m7efG10aQgHlA1ySA=;
        b=JYZU1g+ZlShEvQrrKWBiYO9iBQR9lb1CAooVruB5LFjgcYFN57A0Z5Vyg0QfmpRgPI
         mWA5CIgBn5zwwntKCAzMxCOKmmTG35klow6QnerENNCPXmnsGiIbKnhelkt6KNA/nELx
         o9rBEIY32vBcPqkvXGeIcJrpW5gwGxgRRwG2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2827Z3XOh+XnEroPsCQccYwh3m7efG10aQgHlA1ySA=;
        b=axrPsrItZOniu0LX0sAO6Mr3naU3IxTX0YXdMon7brgdl3BiGvkA8MVc5PZkp0VJEe
         v9ao71y81pNIHZMOVSSIsD3WztJawR9N6fvydTlXVoEbkkTjCQgabIx3E+w2NQDzl61s
         9qCFP2iu73RCJlmqe9JW5eHX9gNc4If9EuRj5MzcmpUVmcpq0RP5WtK+yoRQBcxuo20E
         WsU3Hm51xZNoSorHqHTZf15O2JeSUResKM0WNy4RLUiqQKb1Bumj4CrLF0DSBwjCR0nc
         8ZbOGSP6BU5n2xxP8LYnQyKLzqYvwIMuaH7FD53a/4bY1f7Cxd4BemXgF7fbVPU6d5Kz
         8GYA==
X-Gm-Message-State: AOAM530kp6LCUKUp2NuEcafqv75g4HCUm4O/6WrhRFaUfGCyV6XjUxI1
        k6x4lDrQvMzVHfeUfdWLJVx+gUzuT7Kfag==
X-Google-Smtp-Source: ABdhPJwZVl4/sec6CrM/LCy8A9uD1j/G55ODBUHF2KHnTqMd8SzACrazTxWGwTEW3/e1HwhnYhMgRg==
X-Received: by 2002:ac5:c894:: with SMTP id n20mr4506918vkl.15.1607100180228;
        Fri, 04 Dec 2020 08:43:00 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id g3sm478776vkb.54.2020.12.04.08.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:42:59 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id f16so2043516uav.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:42:59 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr4096249uau.90.1607100178761;
 Fri, 04 Dec 2020 08:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201204095539.31705-1-andreas@kemnade.info> <CAD=FV=WLcEBv7gaA3MOVYmxJ3d2Q+mo+Amkex=0eu_19jMtjrA@mail.gmail.com>
 <20201204171428.0a011188@aktux>
In-Reply-To: <20201204171428.0a011188@aktux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Dec 2020 08:42:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vynttaz00yqbihgK0HxyrPt9b0i0-8Ft6-4NEPc_NkeQ@mail.gmail.com>
Message-ID: <CAD=FV=Vynttaz00yqbihgK0HxyrPt9b0i0-8Ft6-4NEPc_NkeQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: fix idling of devices during probe
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 4, 2020 at 8:14 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> > > Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4")
> >
> > From the description it sounds like this problem has always existed
> > but the async probe just tickled it reliably.  Seems like it'd make
> > sense to tag the "Fixes" as some earlier commit so you make sure your
> > fix gets picked to kernels even if they don't have the async probe
> > patch?
> >
>
> Hmm, maybe
> Fixes: 04abaf07f6d5 ("ARM: OMAP2+: omap_device: Sync omap_device and
> pm_runtime after probe defer")
>
> But on the other hand to stable branches only such patches are applied
> which solve pratical problems not only theoretical problems. But maybe
> it solves several random issues where nobody took care to debug them.
>
> That would be since v4.11.

I guess maybe best is to include both.  Then if someone is debugging
why their async probe is failing they will notice this commit, but
they also might decide to pick it earlier just to be safe...

-Doug
