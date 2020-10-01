Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D652809A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbgJAVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:50:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE024C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 14:50:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so117139ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ui0TiYE6BQjp1gb1Mj+s0rYJAJidELgaZUHnu7+Z5c=;
        b=HOPadHlQ74CxLmVRKNVLjnVYEO8Xwa+bOcyuWUcdFvQgYY3hP3I3WNLRbFAlGPORG6
         mJI+GDBxOzgRGmIzrHfxSTVNA2SI1SbYjgw6qRqWow9TzlAHEx6IPYl5bGF9APB5Hceu
         n22HFKsgjUar8jdxnjmbN07mhd0mq5hXhUAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ui0TiYE6BQjp1gb1Mj+s0rYJAJidELgaZUHnu7+Z5c=;
        b=RQf3zX7m+NQcZEWUAKgT9JfXMxWxIQxPm4kNWYTdQybm2OWlYWagfIb2ZUCJsPQyM5
         ERWml6i/XqMR9pcfHgf0dowvbVYOegR/PoTmzWIjksgjBJ3bqX7kUtgeMfB5WOKYI/yK
         qH8BqxkiXhAtkd7+tcyOZCdR05ADdAjPgWuLYIA55/hABBqMqsfYOKXZWUVWFoewpvZ8
         1BFFQ9WkAdWUP3/s/ZemxXac3OdHCW08cOxafsl2TQ/6kjBxg/DZRc3lnMpahRfgSxNd
         X0jdTLBnja7x7VBlv+ME/jH1iR/+ffa0v1yzAI56e8ae1ryEcoWUZQeD/gmX7rXTLhiW
         W3VA==
X-Gm-Message-State: AOAM533Dhe2GYex120eL0PFZ5oMQgs+cx0EYk6GXVr5t4nkBg/ET5lUE
        RI1pOkTlh0x5UbD94iwpoJMquCCuaECyIg==
X-Google-Smtp-Source: ABdhPJy6GJPZ4AOCJpTcjxMfHVFVMq8jnK8UCXtk87hjeJgCJNriysysRyA+XT9p50dRUCCiQEinbw==
X-Received: by 2002:a05:651c:506:: with SMTP id o6mr3152520ljp.233.1601589004655;
        Thu, 01 Oct 2020 14:50:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j20sm720083lfe.181.2020.10.01.14.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:50:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u4so112776ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:50:03 -0700 (PDT)
X-Received: by 2002:a2e:6f0d:: with SMTP id k13mr2752865ljc.250.1601589002954;
 Thu, 01 Oct 2020 14:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
 <8f467220-3ac8-c8fc-33fe-8d86904571fe@linaro.org> <CAE=gft5FoWpscS_9CfuCNSZxsq_CUu_AShQ=tLiW=NGL8YG5tQ@mail.gmail.com>
 <d79de840-25cc-0e8e-15e6-3cc2fda2e38b@linaro.org>
In-Reply-To: <d79de840-25cc-0e8e-15e6-3cc2fda2e38b@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Oct 2020 14:49:26 -0700
X-Gmail-Original-Message-ID: <CAE=gft4eDRBSuAQmiZQs3LegVyERWAJSmvmHKEY1N=z5HSViJQ@mail.gmail.com>
Message-ID: <CAE=gft4eDRBSuAQmiZQs3LegVyERWAJSmvmHKEY1N=z5HSViJQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvmem: qfprom: Don't touch certain fuses
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 9:30 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 01/10/2020 17:27, Evan Green wrote:
> > On Thu, Oct 1, 2020 at 7:17 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> Hi Evan,
> >>
> >> On 29/09/2020 21:58, Evan Green wrote:
> >>> Some fuse ranges are protected by the XPU such that the AP cannot
> >>> access them. Attempting to do so causes an SError. Use the newly
> >>> introduced per-soc compatible string to attach the set of regions
> >>> we should not access. Then tiptoe around those regions.
> >>>
> >>
> >> This is a generic feature that can be used by any nvmem provider, can
> >> you move this logic to nvmem core instead of having it in qfprom!
> >
> > Sure! I'd prefer to keep this data in the driver for now rather than
> Ofcourse these can come from driver directly based on compatible!
>
> > trying to define DT bindings for the keepout zones. So then I'll pass
> > in my keepout array via struct nvmem_config at registration time, and
> > then the core can handle the keepout logic instead of qfprom.c.
> >
>
> Yes, that is inline with what am thinking of as well!

Oh no, I realized this isn't nearly as beautiful when I try to move it
into the core. The low level read/write interface between the nvmem
core and the driver is a range. So to move this into the core I'd have
to implement all the overlap computation logic to potentially break up
a read into several small reads in cases where there are many little
keepout ranges. It was much simpler when I could just check each byte
offset individually, and because I was doing it in this one
rarely-used driver I could make that performance tradeoff without much
penalty.

I could do all range/overlap handling if you want, but it'll be a
bigger change, and I worry my driver would be the only one to end up
using it. What do you think?
-Evan

>
>
> 00srini
> > -Evan
> >
