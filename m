Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762CE2FAD09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbhARWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbhARWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:02:48 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:02:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x78so9594791ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zumUIy9oq3c425eUVST4wJD5csI9JUzk2QZ8OmfbAnc=;
        b=Yo5Gg8UTepfDRZ/i1xpsy4Mpf2PqreW1jRKVkhStFNYMcHkIvvl7uKf0NDbnoUCH9K
         1dG6y09tKrXhb4WEaSoXL5zDbhU2TLyLOXExny1os4qH3LG+NoXoSvH63bJtQ0UO/hON
         4ApMI9Ucv2UG2G5i1t3aWuVWwVB0G9TdycK7qIGUnrrQRkvBtCOzLojO75skKtnDdl02
         Br/ALA5LiKPxtxkaUfBrxJT4etBZ2ueMep9G9WjJaB5yAF2SwmOJn+1XP3hR0ACa7VPa
         vHb7Ot98fy5t1cHh9mPCnRIkh23qzqTGBPtq8ch9ufbyTyIGHzyLmDTZSaMnwn5PKh8P
         iIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zumUIy9oq3c425eUVST4wJD5csI9JUzk2QZ8OmfbAnc=;
        b=DOaXQVEoFASxhxMkwfM2O9OHIqlyjpRgZKCWHn0P3g6dg9swb5JhvqXVW6/RgpqUKX
         1+fgRdYIuUdtsRkpuL62l8mFffJZwsWBooY7LRCRL3CBTcgMdDDiNF83/k1FfSFVfop2
         nzeMGDYP2dM9Gcp2FCb0gp6xtki8+7kgh7akpKCXM7nh/9j7Ihkd/co+Mgf19MQSDl99
         6gvbwMvlPqLAvnv+7/KhbgkPbafDuyesUMwxSexbfBsgeX2CJG2kRyP9Pl1YOc0vocF+
         AclKxMGaVs/n8qO9wZBMt0SIyVr9k5UmQklDlMnuD42RMhrDqLfRvIv6dwqLGqv0XEl4
         sgow==
X-Gm-Message-State: AOAM5320eiFowPTStI3pfWGglf70ESAIXyJtLmu7thNJ0ru7XSa0q8AS
        mizK54i6Ee9gT5pFAvwImQ+N6ASd0/8hKM18tACEwz/XUws=
X-Google-Smtp-Source: ABdhPJyFG3FD8YyERyVDj1CgHKq7b3LpJu7wRK3tMy/NMXYqTAJIEUzQOfGydKZeX1tBVgIw529QdO8lCAEGb71PNzA=
X-Received: by 2002:a25:4047:: with SMTP id n68mr1677312yba.466.1611007352096;
 Mon, 18 Jan 2021 14:02:32 -0800 (PST)
MIME-Version: 1.0
References: <17705994.d592GUb2YH@kreacher>
In-Reply-To: <17705994.d592GUb2YH@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 Jan 2021 14:01:55 -0800
Message-ID: <CAGETcx9Bk0-nF+wnNXyLpgx7Ny-EchdUpXOYeBmhxTNF+mCR2A@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend device_is_dependent()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:30 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the device passed as the target (second argument) to
> device_is_dependent() is not completely registered (that is, it has
> been initialized, but not added yet), but the parent pointer of it
> is set, it may be missing from the list of the parent's children
> and device_for_each_child() called by device_is_dependent() cannot
> be relied on to catch that dependency.
>
> For this reason, modify device_is_dependent() to check the ancestors
> of the target device by following its parent pointer in addition to
> the device_for_each_child() walk.
>
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>
> -> v2:
>    * Improve the changelog.
>    * Add a comment to explain the reason for the extra check.
>    * Add tags.
>
>    No code changes.
>
> ---
>  drivers/base/core.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
>  #endif
>  #endif /* !CONFIG_SRCU */
>
> +static bool device_is_ancestor(struct device *dev, struct device *target)
> +{
> +       while (target->parent) {
> +               target = target->parent;
> +               if (dev == target)
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * device_is_dependent - Check if one device depends on another one
>   * @dev: Device to check dependencies for.
> @@ -221,7 +231,12 @@ int device_is_dependent(struct device *d
>         struct device_link *link;
>         int ret;
>
> -       if (dev == target)
> +       /*
> +        * The "ancestors" check is needed to catch the case when the target
> +        * device has not been completely initialized yet and it is still
> +        * missing from the list of children of its parent device.
> +        */
> +       if (dev == target || device_is_ancestor(dev, target))
>                 return 1;
>
>         ret = device_for_each_child(dev, target, device_is_dependent);
>

Reviewed-by: Saravana Kannan <saravanak@google.com>

fw_devlink_relax_cycle() needs a similar fix. Want me to handle that
as a separate patch to driver-core-next? Or do you want to combine
that in this patch?

-Saravana
