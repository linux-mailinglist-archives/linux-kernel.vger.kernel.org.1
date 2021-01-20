Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04F22FDC46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbhATWQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbhATV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:59:22 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C10C0613C1;
        Wed, 20 Jan 2021 13:58:41 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x13so24880067oto.8;
        Wed, 20 Jan 2021 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VF5vWwpN0WTTAbK2Z2NttkJ6CJSQ2hghN1uL2Mgnxck=;
        b=EzLEez6jtnf8JtqyqlIg8YpCBuANBTWBSoj8Ej/TC9V2tBYlFwyxmJZuqSPAlc6cbt
         ogPDE2aMr5O+aq0yHHil4RauRfTBUTT6dbvO7YyyOOkZgTqwnOAECFNAMSvMpU98kiqW
         mRm3ACDVn4552fT7haLovkFYrXkvGJxcu+RcdSG3c3jkc8J5awkN8Ic8HPorz4MX+nVz
         A3yGeUy06y2ulZ1hAfHsJxWt0A+6CEmaB4zy6Ph0IrngaSC+wbqtuZzNsRQwPEupKIio
         xo5Cdc7zpO0ZcprKPmITjwAl+qQRNAnCkzsahb1nIHVTOdfqOrTMFQt4VmwG9CtZmCmO
         q6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF5vWwpN0WTTAbK2Z2NttkJ6CJSQ2hghN1uL2Mgnxck=;
        b=GSH3uhXQVnBbuznbSK6W6ACppb47J2uJ1WiA4EFyPyRus7/JIOXCN9CLBbuj4dY3gr
         5IE4jUbS6etisdRfzdClJXi+/7+dQx5m9WjFYYM4A2Fe7e5YXmhChZh+4i8hzd+JY+yg
         jRehIq2NqbZopyFF7PTPbXrZYKDwtArz301pkaqCdrEaG0IUUzfMKEZPXAQXYfxk9Zrt
         UJPHfpoFZGX6y57+1ZT+8EQFUuucT1yqt5ZMYIIhUyLQOaSg+gBRc93VjhPebOi5vfh+
         P76EHlEHLsN0Tmz2rhX9XlacWLN9c7Mp29kVXtBxwzhlMWcN8Ke6euOV2jU3pAMexUt5
         dPTA==
X-Gm-Message-State: AOAM531lDJHPsT5ncb9M2/xcUjx28s5WSXiuQLiScDckLrwRI732xGVn
        7GS11zQc8tzeg+GN+W7A6v718zVDxy9ixGN0/Bg=
X-Google-Smtp-Source: ABdhPJyfupROq9yYCDbZ/3+AmWCN8HnkiGrbhZkCpEOXQTQW6PaR5MBQJrTLWRFVQEhrTRJG6c/wfMxfAJsLqhNe4k4=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr8448651otb.23.1611179920837;
 Wed, 20 Jan 2021 13:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20210120092624.13061-1-colin.king@canonical.com> <a06aeb18-b02d-41cd-f717-6ff30ea48bb4@amd.com>
In-Reply-To: <a06aeb18-b02d-41cd-f717-6ff30ea48bb4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jan 2021 16:58:29 -0500
Message-ID: <CADnq5_Oypeyaq8YSHgPhouJcp7t8aSxT1Z0YxraWQV6aJm9uYQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake of function name
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jan 20, 2021 at 9:46 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-01-20 4:26 a.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > There are two spelling mistakes of the function name, fix this
> > by using __func__ instead of a hard coded name string.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > index c16af3983fdb..91d4130cd2cb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> > @@ -1602,7 +1602,7 @@ static bool dc_link_construct(struct dc_link *link,
> >
> >       link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
> >
> > -     DC_LOG_DC("BIOS object table - dc_link_contruct finished successfully.\n");
> > +     DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
> >       return true;
> >   device_tag_fail:
> >       link->link_enc->funcs->destroy(&link->link_enc);
> > @@ -1619,7 +1619,7 @@ static bool dc_link_construct(struct dc_link *link,
> >               link->hpd_gpio = NULL;
> >       }
> >
> > -     DC_LOG_DC("BIOS object table - dc_link_contruct failed.\n");
> > +     DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
> >       kfree(info);
> >
> >       return false;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
