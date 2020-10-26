Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4854299747
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgJZTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:45:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38150 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgJZTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:45:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so887501plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvmyfAS3FNKDIUlMjXBNYKBYoK/vtIij8n9c082Mubc=;
        b=Z12aKn10RT7C+3vv+Dd1Qd3nDVfwmXeae7+m3xHAdCx85aOB2Ws7HE+ACqBhBXrMGV
         NehOiNBdl5lbTfi1yIOBt80NUA5Po4VsqhAyaAOC51MuHbfbmvuV709wMQ6aBx/IGyUm
         3henAzzU6ESqHqwQmAGqRvS3m7nsVrOozE3NPK7k28PGVWxMoWzGfImr1yTV7feWcRvA
         t+prlzoIShFvDMMoupo9RG21asc7kOD82jAGaZhwMF2V/nf9yPC/fU6weKMXF1kVLV0q
         6eeylUw0wdGM+y680r9NV7ySMUaHEz1uVz1BHfbcAwTyqkRcCeq0ZIgxkviZFdzsdXc5
         pIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvmyfAS3FNKDIUlMjXBNYKBYoK/vtIij8n9c082Mubc=;
        b=QHcqpZau/8m637eO9DPJqWkZ0HFAcFkU/VdG4yUqaOcyTrZuzJIlB0I5jSByqflC8p
         b1ZNvcxXnJQ9ZDs5OQqNwDX/UqKwMOXr+6UWNg/Pz52QlIZdSs/yAJpwRm2Hxu6T5dRW
         D4yIhN0sQe/5KSrGdN//FzNUAvLQ1FYrXadNrqfLvL+dpJjUpZbWGNP8RSrVFlF2DPKp
         8EtBpQSU2BP6lSzIWMeOS9Yctp8tj071/7VclVkZAV8+bcwzzUVbvfWcxIFlcJm0UPjo
         Gi72I2krjixqUlnSrjVUelog7SKFfGi83NsJBVzgcfw5ALfiT645lu/e0Vea7WrmxCdv
         JVqQ==
X-Gm-Message-State: AOAM5336kzDw51E4HbhTBYbykY2jNbZFa3h4aLFh+aTzFkooTk2oMWai
        Z8LFRADeFHb5z+6OBQbzx5yuHrLviLVPLpByQGmb8g==
X-Google-Smtp-Source: ABdhPJzo8W8E/m1R7rra7IFPqewUOrGPxKXu7J09tIasrTWLM5xWrumM7TFDDFkiXzDRs8Myt1FX1umkbCmB5lyZAZI=
X-Received: by 2002:a17:90a:740a:: with SMTP id a10mr18182181pjg.32.1603741500883;
 Mon, 26 Oct 2020 12:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201026194110.3817470-1-arnd@kernel.org> <20201026194110.3817470-2-arnd@kernel.org>
In-Reply-To: <20201026194110.3817470-2-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Oct 2020 12:44:49 -0700
Message-ID: <CAKwvOdnb+nC+5SHjqU0gqwD2kaEptE6EjGtxxgmr36Ts19rNTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/imx: tve remove extraneous type qualifier
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:41 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about functions returning a 'const int' result:
>
> drivers/gpu/drm/imx/imx-tve.c:487:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>
> Remove the extraneous 'const' qualifier here. I would guess that the
> function was intended to be marked __attribute__((const)) instead,
> but that would also be wrong since it call other functions without
> that attribute.
>
> Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/imx/imx-tve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
> index ef3c25d87d87..2a8d2e32e7b4 100644
> --- a/drivers/gpu/drm/imx/imx-tve.c
> +++ b/drivers/gpu/drm/imx/imx-tve.c
> @@ -484,7 +484,7 @@ static const char * const imx_tve_modes[] = {
>         [TVE_MODE_VGA] = "vga",
>  };
>
> -static const int of_get_tve_mode(struct device_node *np)
> +static int of_get_tve_mode(struct device_node *np)
>  {
>         const char *bm;
>         int ret, i;
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
