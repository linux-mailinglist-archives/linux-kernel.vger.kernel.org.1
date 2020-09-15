Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3945126AC78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIOSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgIOR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:29:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F4C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:29:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i1so3880701edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlyX5qFvMN3KiboyllxLciToK2Eq4o7JzV2O6OwBIsw=;
        b=jndKH7zPjuT+Yy8CprIBxo1iTRcTUheSW1BJZMKuVBjDMhYq0L3y4DaJALchKU0bWV
         /DG6HGyrAEcz92/BEzogfoheUq2NoOqWgUDoFeeALWTSjU7t6cmDtPMvcMOFw3IakuWp
         gTraMfBlRb4r8fMQ5MmQhdTGA8v2635Dv7yTHmUW7c4FifhvFkeow+fmjxnyULOz9cNa
         h1HY7N4mglhjyAyOCRnfI4Cdt1T65RO98WM5J4PiOI3ffCzhLE0AI3h6weRFWLf3hKMm
         EKJFo5+5hvJXNo5Y4rFLV8xJX6gMUJcVSH99V+Jsd8X0JKE85PLJ2LMkkl1g2xhe0pJp
         aGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlyX5qFvMN3KiboyllxLciToK2Eq4o7JzV2O6OwBIsw=;
        b=kTkt59nZQUNJR28+UG8coHuf6k4MinDostFdgSMhqTtxCZpvD6OVaT9/cNQAju8eaK
         aYKoDNsr4R1Ktb/ndN5WwXHqdQZS1uKlWPnMXl0ttIx5MxQW00mQ2+b8QO4gT3BAUPlv
         IIeAnGOzI5SxmPYYHHuFZgahk2Ypxhh5fG6pGqqTzFQm1WOJp+5vUiOp3v2Ad7CdIFDA
         ktQOeGsGxP/VM8LOJTOMx7FZyDb8oVYw2ahc/U6/8ldNkx7rzI5zMArFoWGJ7EHmuUGi
         1boL3/ZuBFzmzpbVSalVrQy6a7do+0flCtCj8kLX5xcUZDHn/3NkV4GNnuCbhlVPIcZW
         lWtA==
X-Gm-Message-State: AOAM533/ky/a9Q4i12b+LwGIwm8gk6gwHTRFXXC9cduUViLrLzc0LCm/
        8oIDEyjTnNP5QDmNShdYJv/9U6PL+ZWaFZcDmiJ4EQ==
X-Google-Smtp-Source: ABdhPJyTXQP46Cu/TV0meUS7Ki8Jvai2uP0B7f5/avU/VxUKH5b+mSAJAXEN/96XuLNIG/fdWfb7f8IfAIdjG+sZPvs=
X-Received: by 2002:a50:e78f:: with SMTP id b15mr23870682edn.104.1600190989874;
 Tue, 15 Sep 2020 10:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200915162049.36434-1-colin.king@canonical.com>
In-Reply-To: <20200915162049.36434-1-colin.king@canonical.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 15 Sep 2020 10:29:39 -0700
Message-ID: <CABXOdTcnAzFh81GuJ0Niqu6t2pF5AmwgFoXHf766XcXct_F+5g@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: cdn-dp: fix sign extension on an int
 multiply for a u64 result
To:     Colin King <colin.king@canonical.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Zhong <zyw@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 9:20 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable bit_per_pix is a u8 and is promoted in the multiplication
> to an int type and then sign extended to a u64. If the result of the
> int multiplication is greater than 0x7fffffff then the upper 32 bits will
> be set to 1 as a result of the sign extension. Avoid this by casting
> tu_size_reg to u64 to avoid sign extension and also a potential overflow.
>
> Addresses-Coverity: ("Unintended sign extension")
> Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index 9d2163ef4d6e..33fb4d05c506 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> @@ -658,7 +658,7 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
>          */
>         do {
>                 tu_size_reg += 2;
> -               symbol = tu_size_reg * mode->clock * bit_per_pix;
> +               symbol = (u64)tu_size_reg * mode->clock * bit_per_pix;
>                 do_div(symbol, dp->max_lanes * link_rate * 8);
>                 rem = do_div(symbol, 1000);
>                 if (tu_size_reg > 64) {
> --
> 2.27.0
>
