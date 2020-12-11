Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFE2D80E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395313AbgLKVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbgLKVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:15:16 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E6C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:14:34 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id p7so5561846vsf.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txHS+fz8k2KCZchJH18l2B/VJee2wpafojXlxjFkEbg=;
        b=otkvC/jwZ6/TwBEwk8oFLDidR9riZ9p5DgsQkEY3PN512N5dW2pSmXvH/2N7I2vxfE
         8hrJlwATglONGcw7U9+YNlWby6XrsVNAUrJcoMNeSqks0ep3SVuf5QAGkZpxc0NvAqGs
         TA2xVTwilegZknQ/fogGir5d+Fz25s0R5fcYSSXNTOXA93R/Upxy/TZiKmITWpLx0ez0
         14ME01ASVtVMrUz/sDeqBSodRBDowO1Lyp1wi6TifzWPEHt7tbvJvLUlxRebS2+e+5ww
         V+yP0s3Wq6w96sl1UgCMEXrUB2p5HUr0MCPKdavJGFM40pOfqHpvGl4jd+vXry+VCkAz
         FXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txHS+fz8k2KCZchJH18l2B/VJee2wpafojXlxjFkEbg=;
        b=dIr87CL9CpiJ6PvQQT8omwG4WFgGCk8qi+ueEbfjPS+7qy/YcO0C6DfECczaEmn2b0
         eWI4R6I4aWfJVh5BJYHy/8y/1Wn+C4z8AeVB8WGFldjpXu95YNFFx8kR1zs+OxJCzO7I
         yFkyzBH2k7o9KJxh79R4TBa4ee/VT5VxAvcuWqMA6ldFJId9DU4HgmSMdUI+lD0CKmVm
         4bA2qQKILQfygCHVUjZnpp4LUBMI/pi/uuNXlkfaU+NyVRRO7uSSQ8yymKVzTJERISM1
         grXDJrAeWBXf4pLp3Cqxg1w3Dd6CO9K/LlmAAJ6FTIMPzhqVWbva8yUYdbFnqoDZmxJE
         PuwA==
X-Gm-Message-State: AOAM53112oXyjWR36QIEvz/Nc97diukwn6NxOiPx0AIFzMELfYCnU6AM
        g/VSVo7l0ghlT9VFn86zLcyQuxfkar0D+/tl5l2e16fu6LrLJHfu
X-Google-Smtp-Source: ABdhPJxo2FKH409N1kD1rgcfWzlRx8HLzrM1OluGECInBFfXh1oOzQaZdd9NzAeVfCXlNd9u1KtZ/e5R5s9rCd06iqk=
X-Received: by 2002:a67:32d4:: with SMTP id y203mr14611389vsy.30.1607721272917;
 Fri, 11 Dec 2020 13:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20201211142421.15389-1-semen.protsenko@linaro.org> <20201211144936.GT4077@smile.fi.intel.com>
In-Reply-To: <20201211144936.GT4077@smile.fi.intel.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 11 Dec 2020 23:14:21 +0200
Message-ID: <CAPLW+4nBeWAmgzUU7dvEYiGBN6=GxZ4+nFZQ3+jaM=OPrDDyTw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: drd: Avoid error when extcon is missing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 at 16:48, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 11, 2020 at 04:24:21PM +0200, Sam Protsenko wrote:
> > If "port" node is missing in PHY controller node, dwc3_get_extcon()
> > isn't able to find extcon device. This is perfectly fine in case when
> > "usb-role-switch" or OTG is used, but next misleading error message is
> > printed in that case, from of_graph_get_remote_node():
> >
> >     OF: graph: no port node found in /phy@1234abcd
> >
> > Avoid printing that message by checking if port node exists in PHY node
> > before calling of_graph_get_remote_node().
>
> So, this has to be v2...
> Anyway, see below.
>
> ...
>
> >  static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> >  {
> >       struct device *dev = dwc->dev;
> > -     struct device_node *np_phy, *np_conn;
> > -     struct extcon_dev *edev;
> > +     struct device_node *np_phy;
> > +     struct extcon_dev *edev = NULL;
> >       const char *name;
> >
> >       if (device_property_read_bool(dev, "extcon"))
> > @@ -462,15 +462,22 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> >               return edev;
> >       }
> >
> > +     /*
> > +      * Try to get extcon device from USB PHY controller's "port" node.
> > +      * Check if it has the "port" node first, to avoid printing the error
> > +      * message from underlying code, as it's a valid case: extcon device
> > +      * (and "port" node) may be missing in case of "usb-role-switch" or OTG
> > +      * mode.
> > +      */
> >       np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> > -     np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> > +     if (of_graph_is_present(np_phy)) {
> > +             struct device_node *np_conn;
> >
> > -     if (np_conn)
> > -             edev = extcon_find_edev_by_node(np_conn);
> > -     else
> > -             edev = NULL;
> > -
> > -     of_node_put(np_conn);
> > +             np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> > +             if (np_conn)
> > +                     edev = extcon_find_edev_by_node(np_conn);
> > +             of_node_put(np_conn);
> > +     }
> >       of_node_put(np_phy);
> >
> >       return edev;
>
>
> Why not do it slightly different, i.e.
>
> -       np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +       if (of_graph_is_present(np_phy))
> +               np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +       else
> +               np_conn = NULL;
>
> ?
>

Thanks for the review, Andy! I'll address this in v3.

> --
> With Best Regards,
> Andy Shevchenko
>
>
