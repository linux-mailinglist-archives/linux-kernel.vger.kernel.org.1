Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A728F72F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgJOQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgJOQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:52:55 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:52:55 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c3so2835770ybl.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMr40LI/hXcWSQOOPZsCuoJBcw+0XKBqS6dhgqIQMko=;
        b=SDoAAQkWLCC2CkjWAeHxvm15SKFsOztI8gbQF02ZA9606gUcHwv/NfHe/aWdYXy0f+
         IIE0nZgGXJfdssTpvo3/MzvXFGaks0dvKHV4q37EbIQ6BrHTZXU704YMuo6PbLuv3UUU
         JF66q1OHUVsABa2fRI0XBdDlKTcfCCmLfnsRq0Xj6PEPsp1f8zXXhx1fcf4nYXM6qqLN
         H3mCx56zOs41I0md0TPtr5kz9jgePYIiaUn/iBc8ERntQ3FPbE+8sSng7BwJiZ+ND2vm
         fOLBD3NmbEE9HMo0Ebq7Mg8PvMFcewF85ASCRWpQw9GkzTcNKUe/PSyIx9hb69Q52hFi
         3oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMr40LI/hXcWSQOOPZsCuoJBcw+0XKBqS6dhgqIQMko=;
        b=C6r78Z5+d5MWp7Zb4NdlFj7anumxF4S3NOGu3SRuhX80gmRycuQ2vuqxt4w+HVDzxC
         /7SlJ865VjzzRnKaO3BeanZwBBQD8Wv8bwKVol1crVFJIIft7u5KPwkmJrHnbJw0LlbE
         3imtn7uJUPkuR1uvpawuDf3JJWTD4/TCXCOX+EGXQKIDQt9qwr6hpSrx71P/3WkqAH8v
         lsWu7bxtxhJtpKX3qCv19BySnSDPQxyeHGK2HvkKUr+Ie1yoe7oE6wvBdYZJaDEQ0VGz
         S5qnRjSV3micawOmmvgXuiBvthqDuvGnIG+dhH2CE5ql8bvTmoWGv/IuSftGKTBj6ZMX
         8Frg==
X-Gm-Message-State: AOAM532mKveUXOj9YIo4siJY49yw74z5gLQ7dPfCMsdgBQ7h0jBUnQ2M
        RujStYW/YAE5bICGrrXFd+8lyVdERFN+yax7diusRQ==
X-Google-Smtp-Source: ABdhPJxCJTI4uchgyYaGQsVOXlattOcLY8lElgxdbtmYlmczpvbLirt51rqV00R+R7TNCDkQtdynZAIl6CZQmMot53U=
X-Received: by 2002:a25:380c:: with SMTP id f12mr7111559yba.32.1602780774204;
 Thu, 15 Oct 2020 09:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
In-Reply-To: <20201015114346.15743-1-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 15 Oct 2020 09:52:18 -0700
Message-ID: <CAGETcx9OxQKtYwYtHS7brKpUxfbcbd+VWju3tB1MSPR4dUYxQg@mail.gmail.com>
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and its children
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, f.fainelli@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 4:43 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> 'simple-mfd' usage implies there might be some kind of resource sharing
> between the parent device and its children. By creating a device link
> with DL_FLAG_AUTOREMOVE_CONSUMER we make sure that at no point in time
> the parent device is unbound while leaving its children unaware that
> some of their resources disappeared.

Doesn't the parent child relationship already ensure that? If not,
maybe that's what needs fixing?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Some questions:
>
> - To what extent do we care about cleanly unbinding platform devices at
>   runtime? My rationale here is: "It's a platform device, for all you
>   know you might be unbinding someting essential to the system. So if
>   you're doing it, you better know what you're doing."
>
> - Would this be an abuse of device links?

Feels like it.

>
> - If applying this to all simple-mfd devices is a bit too much, would
>   this be acceptable for a specific device setup. For example RPi4's
>   firmware interface (simple-mfd user) is passed to consumer drivers
>   trough a custom API (see rpi_firmware_get()). So, when unbound,
>   consumers are left with a firmware handle that points to nothing.

You can always create device link between the real suppliers and consumers.

>
>  drivers/of/platform.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b557a0fcd4ba..8d5b55b81764 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -390,8 +390,14 @@ static int of_platform_bus_create(struct device_node *bus,
>         }
>
>         dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
> -       if (!dev || !of_match_node(matches, bus))
> -               return 0;
> +       if (!dev)
> +              return 0;
> +
> +       if (parent && of_device_is_compatible(parent->of_node, "simple-mfd"))
> +              device_link_add(&dev->dev, parent, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +       if (!of_match_node(matches, bus))
> +              return 0;

Even if we think we should add this between parent and child (this
still seems like not a good place to do it). Matching it by compatible
string and doing special stuff doesn't feel right inside here.

-Saravana

>
>         for_each_child_of_node(bus, child) {
>                 pr_debug("   create child: %pOF\n", child);
> --
> 2.28.0
>
