Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316362B923E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKSMLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:11:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42760 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:11:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id v202so2902217oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOC8pFPFR7Gsi/M7h9ymoRYiNwsRE1Z4BQJLMUMH9QU=;
        b=RTAgsW7OuBUtyEudIL9CHX63IOuhbDOiW4nRB/YgCr0DwPgjjgDnDF9AAFRImWHeQR
         L3re2vkJBL+cLTszipvrzh+yUB3ltUKNpTA5UvIoql62ZH3Kr9KQL2RXw3CyrXmev4Df
         3ixLg1XnKZxVAdNU24dnqHtVsyiwI7nBc/+NIERm+gEE3/jui8FGwvphCJaM5b8FvZ4f
         Hx7S/aFDEGp659L+DR4bR8Gecg528v7VWFiHH41/KTJHjxtP3veBnu9THifd2OBSBijQ
         7EluEaBhfmUBaf9hxMZ27BCBZ949y11yEDzah2GqNsPAFPaylUiiaUgno9r0DQJZItYx
         tRtQ==
X-Gm-Message-State: AOAM531nebWJP96qOP9YIhmqfRghHRgRmWIgDxr/2DhygPTvSp4l5ccZ
        6TGqI6umHlU5PP17dpUq7CDUB/gNQr0IiK5Q3Ak=
X-Google-Smtp-Source: ABdhPJx0yEeQbMGaBJtmW3PYauXd/uEi//nQfvs3XqTKF0luzNHCwUcTVZSpcd2gcPgFKLyh5cX7N/dTe8hCaI9caIg=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr2660823oig.157.1605787909600;
 Thu, 19 Nov 2020 04:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20201119110036.19959-1-aisheng.dong@nxp.com>
In-Reply-To: <20201119110036.19959-1-aisheng.dong@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 13:11:38 +0100
Message-ID: <CAJZ5v0gRmmkxG7aLRHXw1Gx7GGd1PyZ6LNqChuQCVKPV9X_8zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: simply go out if the same device_link is
 added again
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:18 PM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> It's possible that the same device link may be added by parsing the
> function dependecy in DT. e.g. clock/gpio/regulators.
> Simply go out for this case.

Why?

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c03bdd3a268..7d91d4074136 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -567,6 +567,9 @@ struct device_link *device_link_add(struct device *consumer,
>                 if (link->consumer != consumer)
>                         continue;
>
> +               if (flags == link->flags)
> +                       goto out;

But this prevents rpm_count from being incremented if
DL_FLAG_RPM_ACTIVE is set in flags, which is necessary, because the
supplier's PM-runtime usage counter has been incremented already.

Moreover, every attempt to create a stateless link must cause a new
reference on the existing link to be acquired, or the removal will not
work correctly.

> +
>                 if (flags & DL_FLAG_PM_RUNTIME) {
>                         if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
>                                 pm_runtime_new_link(consumer);
> --
