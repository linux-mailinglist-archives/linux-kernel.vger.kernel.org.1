Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D222FC654
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbhATBRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbhATBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:15:51 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:15:07 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id p128so5286174vkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 17:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Brf3WO950D1Q6AZvZIOD9DGe8ISGSWxrv8pGr/tlzMU=;
        b=EtQvUWk7uKUBuqxqWiTn1+cdCMqvcZrSNSg8dh7GOx17/dg+ptQEJHeRtha9a92jku
         Sn4hT0kwZn4e12PMw3rDhCetZBM8MM8v7kohIMohZhkW/CdymAyhbCA0f52O1Ks4nr/a
         Oc9MtFvU5z1xziTTFDR9wDfpEybEbAsofBCBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Brf3WO950D1Q6AZvZIOD9DGe8ISGSWxrv8pGr/tlzMU=;
        b=LIE/zEIB5E0M36j5qfl7WfTPS8Hmvi1rcE/5Rn1sA9aWtqdo4Mm7f2WeQp8kIIoQEL
         vOx5p9o6A5/dcZVLj5m/lzE0/PI3Bro35ZlVmIscmchSY/OyncrFktYojEB7lHtHbl8K
         jrqew9slVq4dElKbICXZvK7Dy9zRN6DmEBXmmynUGCdqNIAB+YvkTaXcURPZGUYocRsT
         +wlAMCU6doEFfaD3cb/Wf1WBErtLZ5jFYAuHxwbVaKa71kHeXxi8jhkCVYLtF4rO/QIc
         863oDu5QwUE83Fx1PpS/hTM0dQYS3tK7auG3nU6YSN2/wB4JogGrk4gqCrezOj+/ky5z
         oHGg==
X-Gm-Message-State: AOAM530Z0L6I0ubtt7FqcZ7hGStjxyU9yZ9CPGIPjkLIk9lviZaP1ze9
        XKKc4euAPwuUXzgiPfwn3NvxvggGyldqynaBlaajPw==
X-Google-Smtp-Source: ABdhPJxzzWtdGxD8t0BxB6bMkRuGxNx8eneoxGE+jzu/u6mGGowOJfIQW7qV2QQ0cP//HwTe3jP7meGJRcmxG+Rw7eU=
X-Received: by 2002:a1f:1c4c:: with SMTP id c73mr5018609vkc.22.1611105306635;
 Tue, 19 Jan 2021 17:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20210116052623.3196274-1-grundler@chromium.org>
 <20210116052623.3196274-3-grundler@chromium.org> <20210119134558.5072a1cc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANEJEGsd8c1RYnKXsWOhLFDOh89EXAUtLUPMrbWf+2+yin5kHw@mail.gmail.com>
 <CANEJEGvoSWDWN19PnYJB9ubKgfyEvX4g=rvi9ezEJ9n+NUevbA@mail.gmail.com> <20210119170546.189e12d1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210119170546.189e12d1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 20 Jan 2021 01:14:55 +0000
Message-ID: <CANEJEGu0LVdFN3caZ9ya1h4MWAQrMWw9gzdjJZ+t+9Y8mB2NRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: usb: cdc_ncm: don't spew notifications
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 20 Jan 2021 00:59:17 +0000 Grant Grundler wrote:
> > > > Thanks for the patch, this looks like an improvement over:
> > > >
> > > > 59b4a8fa27f5 ("CDC-NCM: remove "connected" log message")
> > > >
> > > > right? Should we bring the "network connection: connected" message back?
> > >
> > > Yes, we can revert Roland's patch. I didn't see that one.
> > >
> > > > Do you want all of these patches to be applied to 5.11 and backported?
> > >
> > > Yes to 5.11. Only the 3rd one really needs to be applied to stable kernels.
> >
> > Sorry - I was thinking 5.11 was -next (and that's incorrect).
> >
> > As you suggested below, only the 3rd one really needs to be applied to
> > 5.11 and other stable kernels.
>
> Cool, would you mind reposting just the 3rd patch separately, and
> tagged as [PATCH net] so that CI can give it a shaking?

Done :)

> We'll go from there with the rest.

Awesome - thank you!

cheers,
grant

>
> > >
> > > > Feels to me like the last one is a fix and the rest can go into -next,
> > > > WDYT?
> > >
> > > Exactly.
