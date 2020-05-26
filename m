Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAE1A87C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440544AbgDNRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730885AbgDNRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:43:15 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD22C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:43:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w14so510285vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZBKEzRYAyg5odmunBQOsTiFt9lto96h1rTRyPjawxE=;
        b=KXdEFUHQ/cPw/On0HpywTjxWBv2Kl9+8JOpMZ0YwgNBjShSMLESi6v38xldXdXcoDo
         swBFJzn6XXeE9pPFIUcxTkCBiwWd+3MdvT9FqCjU7JaqzG9P7NRgJ+azAwMdVIiMt7Ua
         konJGMRxSG75SDL1r/1P/UCcxmZChLHmqJvE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZBKEzRYAyg5odmunBQOsTiFt9lto96h1rTRyPjawxE=;
        b=cxjiaD4pai4WyYjOjo2MjaihErfG+8mZ+va/gexEu5Kv02ls5zDwKWqzTJ3L2FZUjS
         /KspQ/9YfnATpyjtPkiVjU7seXt7BhhqLEeKHXuSFQR5w4F1KdqGlurTQXV47uL89zaa
         KnC97K+f+Fr5+5Uzft6pUDS6Ms/YxVkUcC8BZf55+EMLNSxkqMSWN9cIf03ZlmpsOYD3
         lGsgq77Ax/GcWiYnreewPxazWhT7h40Sc6PjLI6iuFv5RMEXF6e1KYGGzIR9+oQIT3sv
         1JFYo6yCBtgiKDP0WsZgTElXzcEQ7mmwDyqBRd4tuuOpz3GL013eyzxz/PdJDfKWpuyh
         GqKw==
X-Gm-Message-State: AGi0PuZz1GtGTwzTvvJ4WslqLYFuNFNNzEA/sStGqyP7V3M1t/baoFUU
        oAi0KE76IAHHvwqFHmzKqMIk1+Bw0jI=
X-Google-Smtp-Source: APiQypLlzQ1YVuXrAykTzg3r6F+8M+ZCoiCzibHov2a/SKt7wBU9Ii0Y3lKwqcQCjDjo4UYZQyj4Yg==
X-Received: by 2002:a67:fad9:: with SMTP id g25mr1173491vsq.49.1586886193342;
        Tue, 14 Apr 2020 10:43:13 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 204sm4359818vka.32.2020.04.14.10.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 10:43:12 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id r7so529577vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:43:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr1113097vsf.109.1586886192238;
 Tue, 14 Apr 2020 10:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.1.I1b754137e8089e46cf33fc2ea270734ec3847ec4@changeid>
 <6566837cdb0e8db522c53daba8baf49c2ca79376.camel@perches.com>
 <CAD=FV=UOzVmwpoxd4QTSPiG9nt=YjUYZdgmK=SKU6vTFWcf=bw@mail.gmail.com> <12eb64714f3a7ae33912c468191a471d09ade504.camel@perches.com>
In-Reply-To: <12eb64714f3a7ae33912c468191a471d09ade504.camel@perches.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 10:43:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbJz0TYERDygtPDbM-TjOpDnua2qJJPSYKmSj1Ja3hoA@mail.gmail.com>
Message-ID: <CAD=FV=XbJz0TYERDygtPDbM-TjOpDnua2qJJPSYKmSj1Ja3hoA@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] drivers: qcom: rpmh-rsc: Clean code
 reading/writing TCS regs/cmds
To:     Joe Perches <joe@perches.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 13, 2020 at 2:35 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-04-13 at 14:18 -0700, Doug Anderson wrote:
> > Hi,
>
> Rehi.
>
> > On Mon, Apr 13, 2020 at 11:21 AM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-04-13 at 10:04 -0700, Douglas Anderson wrote:
> > > > This patch makes two changes, both of which should be no-ops:
> > > >
> > > > 1. Make read_tcs_reg() / read_tcs_cmd() symmetric to write_tcs_reg() /
> > > >    write_tcs_cmd().
> > > >
> > > > 2. Change the order of operations in the above functions to make it
> > > >    more obvious to me what the math is doing.  Specifically first you
> > > >    want to find the right TCS, then the right register, and then
> > > >    multiply by the command ID if necessary.
> > >
> > > Though these operations are only used a couple times, perhaps
> > > it'd be useful to have static inlines for the calcs.
> > >
> > > > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > > []
> > > > @@ -67,28 +67,33 @@
> > > >  #define CMD_STATUS_ISSUED            BIT(8)
> > > >  #define CMD_STATUS_COMPL             BIT(16)
> > >
> > > Maybe something like:
> > >
> > > static inline void __iomem *
> > > tcs_reg_addr(struct rsc_drv drv, int reg, int tcs_id)
> > > {
> > >         return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
> > > }
> > >
> > > static inline void __iomem *
> > > tcs_cmd_addr(struct rsc_drv drv, int reg, int tcs_id, int cmd_id)
> > > {
> > >         return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
> > > }
> > >
> > > > -static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> > > > +static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
> > > >  {
> > > > -     return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
> > > > +     return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
> > > >                            RSC_DRV_CMD_OFFSET * cmd_id);
> > >
> > >         return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
> > >
> > > etc...
> >
> > I won't object if you really feel passionately about making that
> > change but at this point it doesn't add tons of extra readability for
> > me personally.
>
> Just a suggestion.

I tried it and after looking at it again, it definitely does make it cleaner.


> > I was kinda hoping that Maulik and my series could
> > land in the next few days since having 16 patches outstanding gets a
> > bit unwieldy.  I'd rather not send out another spin of my series at
> > this point since it's just a bunch more churn in everyone's inboxes.
> > Maybe after they land you can post that as a follow-up cleanup?
>
> If I remember...

http://lore.kernel.org/r/20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid

-Doug
