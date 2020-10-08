Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E729286EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgJHGdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgJHGdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:33:17 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BDC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:33:17 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id y1so17244uac.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lluFhrYB3PEvXC7CXE2TI2ye7nUNlCyHKSdtn268RHs=;
        b=Uap0QwGe0bVpSyDIMIQCU35AKa7J9SWbQxq4Chum27zoWrYm0yc+uCdxq3Os950AOP
         x8NW+2M/bu9wAG5+y29o7oqGlRwUQFTjW+YXpMMCZbZN6475NOGMu3dGaQJ6rgQXkLnl
         UfemFBwE3dwvFmsX8J68Y7M1D4Ltf0Aw/uovjKO5q6u+P6YeqD1TeJFPR3MCW7vQqZ5e
         7EnDOFQXrzf2NKBFkTcva8BC7cMT+Fy+xtWvX/6mggAlZJY+8K/TlWUrnFhKpEKQtYPs
         c6uzitFCHLPSXdoln1wx0HdD+WWfco61zakkolLzk7N217qF7k9/ZPPmO4GVfTGfx7Zs
         vR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lluFhrYB3PEvXC7CXE2TI2ye7nUNlCyHKSdtn268RHs=;
        b=L1vcNTWk18PQioymsKg7d7d2kJQmjJFzl7exSsswJJwTQ51eQX9c7CfQIXI7oS7eKH
         KC/0M4FIuXaXBhe3TjdmdiGc9mocvgEH+uBFH4TMmBYKwNmEIBDcTK6y5Xr/k1vZNDLG
         OccqHEJ33bQp2poJMhsRjRgGZluIv2wW//Yw0u22WIDXbVRWOQ6rZuTA8Hc7f25Lzvsa
         +3y1IjrDlpx4ECiYKNVKL4X8nc+vD6A97C1oJUixOQAHKZXh12IHZvoTITz3TiagT6fC
         mqiwLTM+SxyMsV3vDXeggVcISYfS8jB1kyoFnIQm/TSyodl17rNwHpkX23o3wpLIbjwL
         yqOA==
X-Gm-Message-State: AOAM530h6ChAngghFeWU8z3hT2fxRc8UVMFrxkgzfZC4uolG2Wq2YxfC
        Cs2pNXN8F2iKH8jXTrGGI8OhvxvxuDc1WRy3nN6X4Q==
X-Google-Smtp-Source: ABdhPJx+JgKbahMVZ03FJfQUtlBPU0ys6TF84oj1TdEQhmAc5Ww45cf+EbI2/l+liFuUa4xS5QxDNygwT10mFfdKtB4=
X-Received: by 2002:a9f:366e:: with SMTP id s43mr3791903uad.69.1602138796259;
 Wed, 07 Oct 2020 23:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-3-badhri@google.com>
 <20201002133952.GA3411859@kroah.com> <20201002134041.GA3412330@kroah.com>
 <CAPTae5LBeY1qifPmGce+6Cu2hjVx=QZazk53Y=n6RPPRAuozLA@mail.gmail.com> <20201003155726.GC1509449@kroah.com>
In-Reply-To: <20201003155726.GC1509449@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 7 Oct 2020 23:32:39 -0700
Message-ID: <CAPTae5LiLKosJyLndf-T7wCuXKs6tL=vGpqtdqxfgyPMOFZ4wg@mail.gmail.com>
Subject: Re: [PATCH v9 02/15] usb: typec: tcpci: Add set_vbus tcpci callback
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 8:56 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 02, 2020 at 09:08:00AM -0700, Badhri Jagan Sridharan wrote:
> > Hi Greg,
> >
> > Yes I tested it on usb-next before sending it out.
> >
> >   630 |  tcpci->tcpc.enable_frs = tcpci_enable_frs;
> >
> > In https://patchwork.kernel.org/project/linux-usb/list/?series=356837
> > i.e v9 version of this series,
> > Patch 7 i.e. https://patchwork.kernel.org/patch/11804847/ is where the
> > above line is added.
> >
> > I restested in combinations [1]  [2] [3] [4]. All of them were clear
> > cherry-picks. I didnt any merge conflicts.
> >
> > Maybe you are applying patches in a different order ?
>
> I didn't think so.  Can you try applying the patches, in order, and
> building after each one to see if you get the same error or not?

Tried this as well. Not sure what I am doing differently.
Also was manually looking for "tcpci_enable_frs" in the series
and it's first occurrence is in:
"[PATCH v9 07/15] usb: typec: tcpci: Implement callbacks for FRS".

Just sent out the v10 after addressing a couple of comments from
Rob Herring.

Thanks,
Badhri


>
> My usb-next branch is up to date with all of the recent patches.
>
> thanks,
>
> greg k-h
