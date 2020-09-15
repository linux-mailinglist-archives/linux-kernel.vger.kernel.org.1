Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5226AE10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIOTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIOTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:48:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061CC06174A;
        Tue, 15 Sep 2020 12:48:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so5495432ioe.5;
        Tue, 15 Sep 2020 12:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fGhed9mPU3AlLJtziogWkkqXl0cMPf/jKBqBlDhHMI=;
        b=DmwYLllf5OvNfoEaZJoc5KqqkrAQ5j1Bio57xsxMGb/UsQosPFQqVMzOnWsXZJ/2rD
         qvB2iJCxyEvdC5fy+QrgQXs6g8DOARjUH/pFBw4haAs5MZhOjr5LDTnIZhLEKx23cSoD
         Hds5eZ/XvCFHMTQdY/jpemwt+uXWr5CoDQvwDX8pydG//jFaLD5eErLoe4vrzVh8X3Hb
         JLJRaaSDrTjhZbRjbxIXvPRvNxZ1ur5nT3eEWrwgmKJbqi/u/I7gKXOG9Rj3cFtXkE6V
         ZLV7xDNVhIlGzC9Qgque/b7jvo1doWRq+Rs2JL3SzIaSuHaCOKjdKYcfNhZ79v0qdCSy
         uxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fGhed9mPU3AlLJtziogWkkqXl0cMPf/jKBqBlDhHMI=;
        b=gpeFhoofPNcSDgPwBD44NJQVUHNn/RamBNxc38bVcEKicYC9zItGAo/TnyTStIelai
         MPsgn1Tggx8xl4tYDdlN82wtkzPp6b28iKHY1/JeKF+UXfeOqDM6hPS0j8pW5mckfLAR
         /x/lvV3CIrSDaOe1ihNHCc+i7nO9P8vpOo6C4zivnl3fO1GYarHlolyozWg0NiT0wTjz
         yeHn1ptGiyy8soT7gI8Y4q0GwNN6lE5zq/WvcSNDp2Kh4ROMjJS4lP0fFVokrMR9mOyE
         X7MphaEJP4rEU47yh9CBQpBHTeeK6mk1NzFncfQf0VpPk06dRMxFIJlTWVwgTAxBWWEJ
         dQpg==
X-Gm-Message-State: AOAM531eAjNBAlby2PWAPUQ0h6xM7H7lcNtmjvFhXkk8w8dUyqXNMFHa
        iubCjcFSkELOxRAxILd804BAwz4TlAAn8XiSQwQ=
X-Google-Smtp-Source: ABdhPJxJAoQkU96DjsousCZdQWkXFEiW8H2qRmO+OChvtyeOFoOWPDOSDTjTuGQWaGOQXdjeXDo0xEK1rH2WmkdHUp4=
X-Received: by 2002:a6b:be44:: with SMTP id o65mr7609979iof.53.1600199338320;
 Tue, 15 Sep 2020 12:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
 <20200915193510.GA2362311@bogus>
In-Reply-To: <20200915193510.GA2362311@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 15 Sep 2020 14:48:47 -0500
Message-ID: <CABb+yY1yZrtzA=1uVnX7tvWrMM6UYkFkoDb_38XksOXhVRzO+g@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mailbox : arm,mhu: Convert to Json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 03:25:18PM +0530, Viresh Kumar wrote:
> > Convert the DT binding over to Json-schema.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V3: New patch.
> >
> >  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 86 +++++++++++++++++++
> >  .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ----------
> >  2 files changed, 86 insertions(+), 43 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > new file mode 100644
> > index 000000000000..4e840cedb2e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM MHU Mailbox Controller
> > +
> > +maintainers:
> > +  - Jassi Brar <jaswinder.singh@linaro.org>
>
> Ideally, this should be someone familiar with the h/w, not the subsystem
> maintainer. Sudeep or you in this case?
>
If you are ok with the content of this file, maybe I am not as
unfamiliar with MHU as you think :D   I wrote the original doc/binding
that this yaml is translated from.
Maybe Viresh/Sudeep should be the maintainer of the mhu doorbell bindings ?
