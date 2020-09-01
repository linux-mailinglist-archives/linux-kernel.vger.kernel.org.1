Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908CE258C49
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIAKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:05:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5DC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:05:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so635900oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
        b=cVTmSw6XX+UT6JUTH4rdPSJ9FNDlYkQZYUfvTr2XorsOE1gcdNjHOzTRgqjMvpA4Xy
         TsmOhTC0Xb1IGa6M2dfbBdowKCpxJ866AVZrI14hUdZEmiCll6cl3emPVLdxv6nSMdq2
         kqV0dP0hQxBQOU9KFPrbouWkY2RRe0sNwVjlm+Fi0S7vhwBaebaEb7gXqLl+HGDhJaOv
         Z893PplsVmLuxu4Qg5AghWQuMPM3Yki2X6UZhkcCMiAWTzre3QwjLxDhUhIXwTDMYo57
         TjPtLbMB6+ljoKyyBzxOv7VO7jk6WxlGmym/CuGp432h8bnzpkLQOQNCWDR8/zgVa858
         cQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
        b=Pt4lEED7FREqSjr0zUacn8EuEhWyOM5v2RLLfK1WimIi3KYe8jVt0SeVyhdUByuNwL
         6W/Wohq8ndWGCGPNDcSaFhqTxintvlm/cJsjrprIu60Iuy/9twAb+cZlnyglizpUr9NP
         PoVzR3xwgK4hE9yYPMfUkP9nM+vU9AaHdJiQKKFZ2dAZ8+NgLfVBgBwy+1FQpStS+r+I
         8CvgZPu1LgrCz7vD8QsxZFwyItm8HgGs9Tv0S1VfWsbdsh80Jg6c3UKrCEM+OCEHCg6d
         J1o5XJ5s0NO++fwyJOIDyNjmDZ15FaNWqs6vgvXS4EKabe7OgNUdsfUrdm6wGL7mxWaz
         4KVA==
X-Gm-Message-State: AOAM530/KL9fxhCFs58L1T68UyQOk1WyxTloEFWYhcB6qMeC/5hxSCt2
        OcI/NS3hv62ajHGwxWrPyVDxeWaH25gOn0ohs2hITMK6tzg=
X-Google-Smtp-Source: ABdhPJye06bcGhAWcYxufpzsaAsoo5AYygMhxy14Mms95Z97Cmb8t1iCi6Fk2wDJAHKUVMTHJ8UVPQHQTR7OYPMT4tY=
X-Received: by 2002:aca:4c09:: with SMTP id z9mr72588oia.175.1598954704359;
 Tue, 01 Sep 2020 03:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de> <20200818104432.GB5337@sirena.org.uk>
 <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
 <20200819111605.GC5441@sirena.org.uk> <s5h4koyj2no.wl-tiwai@suse.de>
In-Reply-To: <s5h4koyj2no.wl-tiwai@suse.de>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 1 Sep 2020 15:34:53 +0530
Message-ID: <CAOMdWSJ2VKhbnRDTNVuTKSL12k0qhryO7yznstAk8k_nBGp2=Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Allen Pais <allen.cryptic@gmail.com>, perex@perex.cz,
        tiwai@suse.com, clemens@ladisch.de, o-takashi@sakamocchi.jp,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        Kees Cook <keescook@chromium.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi,
> > > > These patches which I wasn't CCed on and which need their subject lines
> > > > fixing :( .  With the subject lines fixed I guess so so
> >
> > > Extremely sorry. I thought I had it covered. How would you like it
> > > worded?
> >
> > ASoC:
>
> To be more exact, "ASoC:" prefix is for sound/soc/*, and for the rest
> sound/*, use "ALSA:" prefix please.

I could not get the generic API accepted upstream. We would stick to
from_tasklet()
or container_of(). Could I go ahead and send out V2 using
from_tasklet() with subject line fixed?

Thanks,
-- 
       - Allen
