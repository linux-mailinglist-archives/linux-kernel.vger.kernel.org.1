Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E902A5DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 06:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgKDFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 00:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgKDFYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 00:24:36 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0AAC061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 21:24:36 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id m188so16989495ybf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 21:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buN3yjcDVw2EqJ25Tq35AKInemBS4RdgzKO0/bnuCV0=;
        b=vGQK7djcDS/vNaV/RFygyk6BcAPnZeGUiJr98CqLcH+RYPVJ/yBESFnCxIjeuEWOW1
         LGYlitQ43kLbGBTGE61hNppZSYY8ODnBz4EBlgDJQoYb3lXFefTwuyBD+qWUEWA20kY/
         mKU5OzRX3PafYBJhTaI9c2HztUi/ouQUKGSt/IEadXPaVlHyqWL3DnXFx+UWE3FJN3zF
         xpaJBxuwpdjVluNGaBFPLflssP44NTFHs+H2AdJ20Q/11WOo3CaRANK2IX+hDJo9pgNA
         peatOEWjxQqOqoQTlHe3FaB4qytV3Psl3ZN8yCUunlA9lGE4j/aH5x/c2+cGkerqrg5o
         Bvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buN3yjcDVw2EqJ25Tq35AKInemBS4RdgzKO0/bnuCV0=;
        b=l7XwA77ezckzwjfh8ysS2okN8H3VTisfSJEb978qt52h5A7JU6ZxAhUVwVKMAEhosd
         ead8fdbeIIbd92BfBa+gDxc5oniKWUoYZFe5ALlZDa1rECrXFo/nbU2eOfelfTkh+why
         zhxq7H0I3e4rjwfpHf4o2OvCkmnEeGddoH3NYGKVL9MpZi3xGyH23aHuIuxhbbaN7tP3
         fWPVhiPPvCPV33YpgjbZQnnqp8n2bXkviQbs7Xgqx/gCMKImZ8jy7HYh5H7/HJztpg3j
         V67zTKWE6/K1kGTE4I87VESylU4Hn6byr3E/7qvAaAKXyuhdWNb0WQNgazHjp1gaOlhP
         IpUQ==
X-Gm-Message-State: AOAM532UKNfZASHe1kCGGYi1eQ2FK9lsoAVxFrMo9YcnZAN6p+1yI6m3
        ATwhUGFECWnDQ+YglyfRxWESrkNcDhvKOSzYGddJUISe
X-Google-Smtp-Source: ABdhPJw4X2EBy/BQHRpdZVm/uRRy4mcbX1p8iCmDTcWFjekoSJMzV7O+PEmPMEB3ZtzQZllP8TXOHZJGepiAiFfsN+A=
X-Received: by 2002:a25:338b:: with SMTP id z133mr36026198ybz.33.1604467476017;
 Tue, 03 Nov 2020 21:24:36 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <f474396f8f47c303e3a3ac90a582c116e38e50e4.camel@perches.com>
 <CANiq72nnpdPSngjoOf=imLxZ2g0A7ZXe5nRjF0qf5AG1UCfXyw@mail.gmail.com>
 <8d02497f4565c3154d3f7bcf2968b56ccd945ab4.camel@perches.com>
 <CANiq72k11+VO-igyHRakJEGuSmsDJyQCpYDVeNxZwRt62yCFXQ@mail.gmail.com> <1de8953aba13bcd4c9643bae61af2081e33f071f.camel@perches.com>
In-Reply-To: <1de8953aba13bcd4c9643bae61af2081e33f071f.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Nov 2020 06:24:25 +0100
Message-ID: <CANiq72nsOOdRxVYNo7KetNKOD+8xZEsn3v8d1iOydvVRoTqOHA@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

First of all, thanks for taking the time to write your reasoning.

On Wed, Nov 4, 2020 at 5:17 AM Joe Perches <joe@perches.com> wrote:
>
> The current kernel is v5.10 which requires clang 10.0 or higher.

For building, yes.

> This patch is not to be applied or backported to old kernels so no
> person is going to use this patch on any old or backported kernel.

Agreed (see my answer to Nick).

> If a person is going to use clang-format on the current kernel sources
> unless they are developing for the current kernel.
>
> They are going to have to be using clang 10.0 or higher and therefore
> also will have and be using clang-format 10.0 or higher.

No, they might be using GCC as usual and installed clang-format from
their distro. In fact, I'd expect most developers accustomed to GCC to
try it out that way, and also most of them to install compilers from
their distro, not from the webpage, unless they need a newer version
for some reason (e.g. new warnings, new debugging features in the
kernel, etc.).

In principle, clang-format (as a tool) is not related to building the
kernel. We may call it "x-format" and think about it as a statically
linked binary. What I am saying is that aligning clang-format to LLVM
(now that LLVM has a minimum supported version) is not a necessity.

We can still do it, of course, since there are new features for
everyone and anybody that complains can install a newer version from
the webpage. But there is nothing that forces us to require it. It is
a decision that we balance w.r.t. new features. To put it concretely:
if there were 0 new features or big fixes in clang-format 10 compared
to 4, there would be no reason whatsoever to require users to download
a new version.

On the other side of the spectrum, some projects require a concrete
version (not just a minimum), because they automatically format their
entire codebase and want to avoid differences in output between
clang-format versions. But we are far from automatically formatting
the entire codebase.

> Take it or not, apply it or not.  I don't use clang-format and unless
> there are improvements to it, I imagine I'll continue to use emacs
> indent-region and a few other reformatting tools instead.

Again, I am not opposed to the change. In fact, I am eager to improve
the output of clang-format so that more people get engaged with it. I
was just surprised you asserted so strongly that nobody is using
clang-format from their distro.

Cheers,
Miguel
