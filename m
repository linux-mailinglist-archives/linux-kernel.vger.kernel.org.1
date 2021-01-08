Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0E2EF98F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbhAHUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbhAHUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:41:46 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFAC061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:41:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 15so12796587oix.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTx5LeKnYnLkoXQznJaUS7zKYcrqt2Ko/4Y7E5dK00A=;
        b=jAy6YwGlsJ//Dekv8mtyYzo/NOupI6elU0Ai5x+r2R1hFetfM8tITa+D1i7ST3thr4
         cTZsFHuk9JEYWbf9fMG/to0c6/u+hhWaRKSmtsHTgw41P7CKXiVuamhIFeTTBnbcHxpR
         g46VhK28DNWSBFLZPTJU5+IhqDZC+tpUO5nM5N8AS4YbNg7rm72ihtQZaWs1x4p+FQAH
         Cb5m5KJf8h0GzvhI6lmvi48JT7gqWQXqMZkIJBsYpCL0FtpXo9x2KkbwBFQf6fCJ82Vd
         sUELUnpEEWt3QBjODjgCZ1Vy0GeYvz9Lph+ZYbMgncjviMQqASH/dHv7ilqqHUNQNi6M
         9vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTx5LeKnYnLkoXQznJaUS7zKYcrqt2Ko/4Y7E5dK00A=;
        b=XgTnHl5OkXDp+QGxt8mK6rlkbyIGrxzHXgSROWMjaiZUntNBU7hEphiR+vnzTdiH8p
         SYwxTck27Q0TQWmZ6p7ntuU3V2mtyTPQgel6LXWo0BVXlPnZywCQVuRHMQkHveoHeCXw
         c5/4f0kPxhb/BroMANOs4XKAooAO5mVfWwBoh0fXhBt37fkeSxbBB1SntaxkOZ7xTxqL
         XV+D+nUxsSn85s1IaRf437O3+B9OkXJxGpij05g9DLyzw3NjvhaEF/QafaWfyOHf8UD0
         6nvmvTAVOVsikFkgTe4HAjnNrcKuF6Erxn5Hv55mY5gU5ekfCfm18rm48kyRrldWWhPu
         OttQ==
X-Gm-Message-State: AOAM530buwc6KlksMgmnYZ0nOKOzEGYulWpnGmnRAX3pP/ID6GAOuuRP
        MJCF9ndlThv3OIyF1lfj9k9fZ8JxmeLR75vHCLc=
X-Google-Smtp-Source: ABdhPJyMJEylrNAKV8TeNc4u2T6Iys0/IgPNC6RbdUIWbjrpijkT/O0KdlEJzF3eOSPP/7hjLXEwa5ssrqanfyVtO9g=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3437896oib.123.1610138465292;
 Fri, 08 Jan 2021 12:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-18-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:40:53 -0500
Message-ID: <CADnq5_PLki2Hx16Zjn-9Z2aVMerN5pCJs2vMJ+c=hRJdmyMv_w@mail.gmail.com>
Subject: Re: [PATCH 17/40] drm/amd/display/dc/bios/bios_parser: Make local
 functions static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Igor Kravchenko <Igor.Kravchenko@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2588:16: war=
ning: no previous prototype for =E2=80=98update_slot_layout_info=E2=80=99 [=
-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:2692:16: war=
ning: no previous prototype for =E2=80=98get_bracket_layout_record=E2=80=99=
 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index 23a373ca94b5c..f054c5872c619 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -2585,7 +2585,7 @@ static struct integrated_info *bios_parser_create_i=
ntegrated_info(
>         return NULL;
>  }
>
> -enum bp_result update_slot_layout_info(
> +static enum bp_result update_slot_layout_info(
>         struct dc_bios *dcb,
>         unsigned int i,
>         struct slot_layout_info *slot_layout_info,
> @@ -2689,7 +2689,7 @@ enum bp_result update_slot_layout_info(
>  }
>
>
> -enum bp_result get_bracket_layout_record(
> +static enum bp_result get_bracket_layout_record(
>         struct dc_bios *dcb,
>         unsigned int bracket_layout_id,
>         struct slot_layout_info *slot_layout_info)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
