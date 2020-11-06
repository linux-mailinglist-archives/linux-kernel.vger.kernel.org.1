Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1632A9D94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgKFTJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgKFTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:09:54 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7ACC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 11:09:54 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id s8so2032248yba.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMdG6BPnDo6XPbXbEsnKscK3WeJAWiKsTI6QrLTod9A=;
        b=X/TJWDXBEYcOALQLiBtbYBjoIu64gTaNXTHO7zCrQCIDudKDcTCd2+5xoK+NqjLKdM
         8JqudzVLhv+fcwFrS6yxooI09utAw/AudCW+nTXYRkHDB37AKrUrCgKv7sJTRvXeQfS0
         mQXOVyjsgcrG6WCZlXI+dN1z1LhOMJRlgQhgC9CaWv0TAKmaPt8fAUXbLFjhVMgsokiO
         D7uqZYRxOZJm1CQTbkTarrdzMk/O3gZSJyhaf9sgFcLUP2+RomLHaF8Drr2mL2FW6wcG
         fCW2y5H+8IywC+kUWkxreYy0E1IPH+noc4ld+7Nc8F28xeGSOdSJIhV6Zso8l/VYvTjI
         VgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMdG6BPnDo6XPbXbEsnKscK3WeJAWiKsTI6QrLTod9A=;
        b=CwW/UESxqFaUqjkZMdODMimOgdoDkHHRsonWNIoowf2DfR292CW6nRRNooiPoafVmi
         i31IJEy3TTFV2Ld2HV0MySRegHZ9Xc1ZAU3vpH2yeS3+zt4OTzs4fymkzq+cDZRXaBXS
         JvHcqo+YfkkLVa+ZipjuUF/F5TfFbdELtpqo3dsf1jJzfA6APR94SUF3J1aKnRBjPeKL
         Gd3Pspj+5rNg7fg/cIvdrttEqESy3AlzLcgBgW6612lZ2Asa0OcSD9va+8UUAwbgE2No
         Bc6SvsuMTB24f0JdBHshWXPeI64H7CiHhYbobXFXDMH5xMPAkkD5Pl12HYqrL9nMq/s4
         73Jg==
X-Gm-Message-State: AOAM531sF3UkUvm7TLnZ+5JFKNRmcdpMZCoNhrqnBSo1U39vDi9VDD50
        YaD1OfZiUAuKkn0aypHsq0QfCdvTUHZ4I00XTsf/dw==
X-Google-Smtp-Source: ABdhPJxJSQvV81Unc1Qwmu0t208rjWZkc4or0DrYtyo+3EQJic6kQjUU6srTIJGB46Pi1EVeIBLp8sz5EoAD5Cp9Gec=
X-Received: by 2002:a25:f817:: with SMTP id u23mr5025809ybd.466.1604689793394;
 Fri, 06 Nov 2020 11:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20201106150747.31273-1-broonie@kernel.org>
In-Reply-To: <20201106150747.31273-1-broonie@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Nov 2020 11:09:17 -0800
Message-ID: <CAGETcx-abGAgYrHM0jm6hVkrJ5KvfhK6gCZ4Y6RY0msPJDCuQg@mail.gmail.com>
Subject: Re: [PATCH RFC] driver core: Ensure DT devices always have fwnode set
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Mentz <danielmentz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob and Frank

On Fri, Nov 6, 2020 at 7:09 AM Mark Brown <broonie@kernel.org> wrote:
>
> Currently the fwnode API and things that rely on it like fw_devlink will
> not reliably work for devices created from DT since each subsystem that
> creates devices must individually set dev->fwnode in addition to setting
> dev->of_node, currently a number of subsystems don't do so. Ensure that
> this can't get missed by setting fwnode from of_node if it's not
> previously been set by the subsystem.
>
> Reported-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>
> *Very* minimally tested.
>
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..658626bafd76 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2864,6 +2864,10 @@ int device_add(struct device *dev)
>         if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
>                 set_dev_node(dev, dev_to_node(parent));
>
> +       /* ensure that fwnode is set up */
> +       if (IS_ENABLED(CONFIG_OF) && dev->of_node && !dev->fwnode)
> +               dev->fwnode = of_fwnode_handle(dev->of_node);
> +

I don't think we should add more CONFIG_OF specific code in drivers/base/

If you want to do this in "one common place", then I think the way to
do this is have include/linux/of.h provide something like:
void of_set_device_of_node(dev, of_node)
{
    dev->of_node = of_node;
    dev->fw_node = &of_node->fwnode;
   /* bunch of other housekeeping like setting OF_POPULATED and doing
proper of_node_get() */
   // Passing NULL for of_node could undo all the above for dev->of_node.
}

And all the subsystems that create their own device from an of_node
should use of_set_device_of_node() to set the device's of_node. That
way, all this is done in a consistent manner across subsystems and
avoid all of the of_get/put() and OF_POPULATED set/clear strewn all
over the subsystems.

For example a bunch of subsystems don't do of_get()/of_put() correctly
when they det a device's of_node (I sent patches as I found them).

-Saravana
