Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CB4281A27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbgJBRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbgJBRw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:52:28 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3504DC0613E4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:52:28 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id v60so1739781ybi.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lW22Qzd9PGiP/2qzJ0inuLN63Dw7cetpUVChJaty2gE=;
        b=Hrn+Czu+Upto30ahHpqz77XC0AVbryq8MDWS/Cg35v6e3+jm93XxMW799+oo0wmJCX
         mMXHudebFmP8Ys+9w/RQcPL2f7Mnerj3jbyFp39ZwzbpbQE1w9F3wldwtqRqjU7NFCl5
         DXY7Fpi9XYkfpBnirOpPnGDsydsDjA/wUrp9tqJoR4VEgWXIW8BnE1IFn0tUNE0dYY3u
         KBLk/lWz4ZJ9bIQPBTjtRV0ygVvrkbXa9VWbhIV0G+8a0IkdILlriUf7qDpDEIHsrO5g
         7lOOgb1hg4imG+RF8Ji9cqGBdhkknr3GVqfkmxdR+nREoCNPAFqg5UdDt8J+8Svgc4V2
         kRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lW22Qzd9PGiP/2qzJ0inuLN63Dw7cetpUVChJaty2gE=;
        b=ZA7Mn7i0SPw1GEYSR2lfqdvWbgZf7XiIxR0Y6dr3O83kwjKjq3YIn14md/XJqfD67H
         8VX5n1Rlwtb9z86HhL8XjXE7Ij0XpfvSOMmkxuo1lL9afJvWvpg2KS06Fea0hhujg5hp
         koKUOAgxQGS+0/Y/jjRqTxdMEvLayjMYAiEIrWUATSRTuG39sq/pKzJUujuVrIiXGBuZ
         dnWv0lg+w3YH9UaGhUSWGB7pD+dk9a6Ije2gpGF3XSduRHtCuWGQ/bz2IKk2+ZJS8wRe
         Enjvzu+cTbeeNWJFl23wsWSc4CytB3ibBviVEDZ58hAAjGiGuC3kytlj5lSeHMkevhWF
         57QQ==
X-Gm-Message-State: AOAM532uJLMgJzutVKAXCiPWrxT9xhl1bYXeG28VOxAPo1QHIQvqTMaZ
        Xx6fBZiB5ELuWRnIia5clsPFtrTdrxccTsACQmv6kQ==
X-Google-Smtp-Source: ABdhPJy4XhKvg/fcRsKDUtj8ituzDGpU4LofV1mA+byx9rafxRXok/qNPb40BvV5nKhx2JlN6+fH0sxc/b6LCow6y+k=
X-Received: by 2002:a25:8041:: with SMTP id a1mr4363493ybn.412.1601661147077;
 Fri, 02 Oct 2020 10:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com> <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
In-Reply-To: <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 2 Oct 2020 10:51:51 -0700
Message-ID: <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 7:08 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > adding all top level devices") optimized the fwnode parsing when all top
> > level devices are added, it missed out optimizing this for platform
> > where the top level devices are added through the init_machine() path.
> >
> > This commit does the optimization for all paths by simply moving the
> > fw_devlink_pause/resume() inside of_platform_default_populate().
> >
> > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/platform.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 071f04da32c8..79972e49b539 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
> >                                  const struct of_dev_auxdata *lookup,
> >                                  struct device *parent)
> >  {
> > -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> > -                                   parent);
> > +       int ret;
> > +
> > +       /*
> > +        * fw_devlink_pause/resume() are only safe to be called around top
> > +        * level device addition due to locking constraints.
> > +        */
> > +       if (!root)
> > +               fw_devlink_pause();
> > +
> > +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> > +                                  parent);
>
> of_platform_default_populate() vs. of_platform_populate() is just a
> different match table. I don't think the behavior should otherwise be
> different.
>
> There's also of_platform_probe() which has slightly different matching
> behavior. It should not behave differently either with respect to
> devlinks.

So I'm trying to do this only when the top level devices are added for
the first time. of_platform_default_populate() seems to be the most
common path. For other cases, I think we just need to call
fw_devlink_pause/resume() wherever the top level devices are added for
the first time. As I said in the other email, we can't add
fw_devlink_pause/resume() by default to of_platform_populate().

Do you have other ideas for achieving "call fw_devlink_pause/resume()
only when top level devices are added for the first time"?

-Saravana
