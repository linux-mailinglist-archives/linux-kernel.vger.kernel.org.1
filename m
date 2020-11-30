Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98EB2C8624
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgK3OCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:02:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46333 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgK3OCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:02:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id z23so7673044oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpexAjBJAyZrDgAGfMwNi00O6hIz7S/DLY11+w4U+I0=;
        b=l9dw5sxXWZHLmosMl7XTVGiw6sQtwHNKzJjLesrAHHaHpaXzNxGTvuyoXJCUQXLqIr
         1BuKcSFS+oy7tXScnu9J5fcgl3RPRUYzNwPjpKpX6IxrogpJDS7oFGjCJ48mSX+znGFx
         go5pT2nH3SUmdq3uLMakSZ8gU1C33O5nrt6JdY5Qzm1vcAv7K35nRjwKwHP0SJD6R+0U
         /w4ztdTG8pHA4fY1o1YZ3Kw9UQOUbSkxOt5a6abffkLqqYcvO55xFRjQQzvSSISuqwmT
         ZBBp2/Z7FExIX+EbY6gHap00vnOr9FbJKqDEcN+EMMNqF2jSEKI5mDAfHdtUNE+VkKiW
         0Srg==
X-Gm-Message-State: AOAM5316YTYBGZrVFisglYkcCccf1ZY7zZAAKTDKFy6DDqll0M6FBGeb
        JUdogr0WNdttiqYvaHc02CJBTCZ1pcxgZSxhJSM=
X-Google-Smtp-Source: ABdhPJxxi8NYNwOVXavihejz/dOZoI/4q3BrhEsZRPvZ2sv76AHB5tQ59KEKOyOAmkQr9gLfb8mLN+Bx4SctgV0K9E8=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr16679673ota.260.1606744894558;
 Mon, 30 Nov 2020 06:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20201127104630.1839171-1-thierry.reding@gmail.com>
In-Reply-To: <20201127104630.1839171-1-thierry.reding@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Nov 2020 15:01:16 +0100
Message-ID: <CAJZ5v0jGzLHD2vRYOvi=E3XjYuAH9+r8p46c+d1Ua7Uu6TZhOQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix a couple of typos
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 11:46 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> These were just some minor typos that have crept in recently and are
> easily fixed.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1165a80f8010..5e3600eb3ab2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -468,7 +468,7 @@ postcore_initcall(devlink_class_init);
>   * with runtime PM.  First, setting the DL_FLAG_PM_RUNTIME flag will cause the
>   * runtime PM framework to take the link into account.  Second, if the
>   * DL_FLAG_RPM_ACTIVE flag is set in addition to it, the supplier devices will
> - * be forced into the active metastate and reference-counted upon the creation
> + * be forced into the active meta state and reference-counted upon the creation
>   * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
>   * ignored.
>   *
> @@ -491,7 +491,7 @@ postcore_initcall(devlink_class_init);
>   * Also, if DL_FLAG_STATELESS, DL_FLAG_AUTOREMOVE_CONSUMER and
>   * DL_FLAG_AUTOREMOVE_SUPPLIER are not set in @flags (that is, a persistent
>   * managed device link is being added), the DL_FLAG_AUTOPROBE_CONSUMER flag can
> - * be used to request the driver core to automaticall probe for a consmer
> + * be used to request the driver core to automatically probe for a consumer
>   * driver after successfully binding a driver to the supplier device.
>   *
>   * The combination of DL_FLAG_STATELESS and one of DL_FLAG_AUTOREMOVE_CONSUMER,
> --
> 2.29.2
>
