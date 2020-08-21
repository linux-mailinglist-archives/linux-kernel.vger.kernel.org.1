Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0324C908
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHUANP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 20:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:13:14 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BDC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:13:12 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r197so32465vkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fW1Q087C3iBkzSEJJ8rBhdiCQ75ydi82R0DkuBMVmE=;
        b=JDnN2KxHICU7mm1H4JMCGP0USSTHF246OD6RakBl6ItMd4XWgsQl6MV9sU+5gVf3BO
         8OZywIkjqhxHXKZMZvFXtQGB7F3PW4bfjm6AEXTiFSa788v2U17nI54KOdhbxLgeDFXW
         jAGei6iodA7Qt/UrXwZaRW815eeNe/zl8KMak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fW1Q087C3iBkzSEJJ8rBhdiCQ75ydi82R0DkuBMVmE=;
        b=UfyleAbBCFksjgpUWjLZjkESOe7/Rg26NYBJ2fRsAP3eRVh4JGVr7LwXoau0wcj3tS
         35iKXgXgEzpXrq7L3ybBsHbWiFQRPGTsgcJTSQvh1uUIyY4DNYO/mOaPkiiFoasW9kCy
         v9GifNtmv3ka2gF3HENV1seJXSfoW7/9Z6dJYXeE0tnPad5GzA0DdAcMD9a9loW0nQ6+
         kUVLsiejRA89bFAGObfbwkkBgQgvNsArlf+So+b598qZrrAiMqse/HfbSk4zpULVNCoW
         81gbdW6JcGVvDMCQ3q8bxyYyby7GUVfjJXzw30fE0VFHfbi81LGdwFvCNVbf84VpzCK3
         VP8Q==
X-Gm-Message-State: AOAM531JVnwZ2Vv/yqoKXMAhY9nMBG91vT3oc4V00WINHjJs6EOqYzUV
        h7/NetPTaphOfwK12KH/LeF5eAHPU+FLKnNMl1gtUg==
X-Google-Smtp-Source: ABdhPJwjwRO6/j0Eu+XByE6acrayAh1Yc1q66vPAJYhHEFhWRkl8RXtNj/f4B8RB+n2xuUa1YMS3UI9t7X/0Ns/jHTY=
X-Received: by 2002:a1f:2444:: with SMTP id k65mr277318vkk.33.1597968791845;
 Thu, 20 Aug 2020 17:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
 <20200820170951.v4.3.I066d89f39023956c47fb0a42edf196b3950ffbf7@changeid> <20200820102347.15d2f610@oasis.local.home>
In-Reply-To: <20200820102347.15d2f610@oasis.local.home>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Aug 2020 08:13:00 +0800
Message-ID: <CANMq1KCoEZVj=sjxCqBhqLZKBab57+82=Rk_LN7fc3aCuNHMUw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: atomisp: Only use trace_printk if allowed
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:23 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 20 Aug 2020 17:14:12 +0800
> Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > Technically, we could only initialize the trace_printk buffers
> > when the print env is switched, to avoid the build error and
> > unconditional boot-time warning, but I assume this printing
> > framework will eventually get removed when the driver moves out
> > of staging?
>
> Perhaps this should be converting into a trace event. Look at what bpf
> did for their bpf_trace_printk().
>
> The more I think about it, the less I like this series.

To make it clear, the primary goal of this series is to get rid of
trace_printk sprinkled in the kernel by making sure some randconfig
builds fail. Since my v2, there already has been one more added (the
one that this patch removes), so I'd like to land 2/3 ASAP to prevent
even more from being added.

Looking at your reply on 1/3, I think we are aligned on that goal? Is
there some other approach you'd recommend?

Now, I'm not pretending my fixes are the best possible ones, but I
would much rather have the burden of converting to trace events on the
respective driver maintainers. (btw is there a short
documentation/tutorial that I could link to in these patches, to help
developers understand what is the recommended way now?)

Thanks,

>
> -- Steve
