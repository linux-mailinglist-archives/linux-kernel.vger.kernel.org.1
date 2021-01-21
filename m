Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A572FE8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbhAUL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbhAULYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:24:01 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA66C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:23:18 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h14so1251551otr.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2rMzfq0UH/F+eLfm27e8RT4cWjxNkuh3W9X3FO/pmE=;
        b=BAG2wgYYSoqHd+DzOqnaf2XloG6h8bisgVdttJVNDSeHpO2T60TTr7oftDgacbG++z
         FWPFJ7hdHVj7asQbzl1FiKoOBR4iGZhMKOoPDtWwob5eImQXBXeKj3EvrZWVEkeJQQKj
         fuvuKpu9YR6biF7ybZJEkp7YQ/ov/XcCHaV6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2rMzfq0UH/F+eLfm27e8RT4cWjxNkuh3W9X3FO/pmE=;
        b=o/+r8zcOm3qB5QweHMCORmlXrWPhQleIhRgdW+9oPBwtYJgmNL6aU71PBpXlezggoc
         tOjOGgPknKV/mweN1ziDEaYzUHfPQ4rOY+sggosAoxkCcfLtiwhUhJKAQQU2JghFMY6a
         crYkPrTY52CAe9euGZyp1t5t0XEL/XOYf+zqetOTAKS0pU63smwU/PYsyAWKi3jPseDD
         UPUm+z/5fW8DJOwKnAJhsJsK190Kc8UvYVwITE0x2RwyE2HpXGwnbwtk7uy+vbz9dLd6
         TXsnRD+BzrB71dgn2ZSzVGmYDxOK+uqwP6gqs4thEgV6zkoIFfq8+Tkmx5edi2t7oRNf
         62Jg==
X-Gm-Message-State: AOAM533LLruOyCFBJrtw0BhBnMs+iiFPNWwcAEYOXuhyD4xR6FaE3Tnf
        P4xJ0a8bAZSQbEnRr9MZxKydbNQ0wnfUW87W0mSOJrhqYTfNXw==
X-Google-Smtp-Source: ABdhPJwuTGzWQAuFKkuYSb3G3c5sxDjEUQ9z8aWWFLseIzCwQa2p+C86ONLqWh5bBBra+SI82M1uIeUTsaA8ArqC1t0=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr9879029otb.303.1611228197779;
 Thu, 21 Jan 2021 03:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20210121030909.1126643-1-zhangzhijie@loongson.cn>
In-Reply-To: <20210121030909.1126643-1-zhangzhijie@loongson.cn>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 21 Jan 2021 12:23:07 +0100
Message-ID: <CAKMK7uF=scYJ=gyS=xjYz25mdDzKA0QHSyPndfSBweE7vfDkWQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm: Improve the output_poll_changed description
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 4:09 AM ZhiJie.Zhang <zhangzhijie@loongson.cn> wrote:
>
> From: zhangzhijie <zhangzhijie@loongson.cn>
>
> this callback was used by drm_kms_helper_hotplug_event()
>
> V2: (Thanks for Daniel's suggestions)
> - remove the FIXME below.since with the drm_client
> - infrastructure and the generic fbdev emulation we've
> - resolved this all very neatly now.
>
> V3: Add comments that This hook is deprecated
> - new implementation methods instead of this hook
>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
> ---
>  include/drm/drm_mode_config.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index ab424ddd7665..fbc0da25d7c5 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -103,14 +103,13 @@ struct drm_mode_config_funcs {
>          * Callback used by helpers to inform the driver of output configuration
>          * changes.
>          *
> -        * Drivers implementing fbdev emulation with the helpers can call
> -        * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
> -        * helper of output changes.

Not sure why this isn't clear, but the above is important information
that we should keep. Maybe good to fix up the formatting to make it a
hyperlink, and your addition here is fine too, but the above is the
important part really.
-Daniel

> +        * Drivers implementing fbdev emulation use drm_kms_helper_hotplug_event()
> +        * to call this hook to inform the fbdev helper of output changes.
>          *
> -        * FIXME:
> -        *
> -        * Except that there's no vtable for device-level helper callbacks
> -        * there's no reason this is a core function.
> +        * This hook is deprecated, drivers should instead use
> +        * drm_fbdev_generic_setup() which takes care of any necessary
> +        * hotplug event forwarding already without further involvement by
> +        * the driver.
>          */
>         void (*output_poll_changed)(struct drm_device *dev);
>
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
