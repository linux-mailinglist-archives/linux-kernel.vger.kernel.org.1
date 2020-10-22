Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE56F295783
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507702AbgJVFCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507695AbgJVFCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:02:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5610C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 22:02:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c194so455044wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 22:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wrpDjbP4w2xCq7mdzj75yVVv1DI/Z3nNPuhthG3gKU=;
        b=dZDXR6TkXw2gxAmMluY+wCv51B853jen6oLPQSb3pqaYX1NYXPCBu+tBYr79b1KxxH
         yDiwdTtKWgVb55jLnnlwao1splHVI/kvnrvnmoLPxh6MyMVdyjHeClDdM1O3KnH37/wH
         nSUJRQXbChgevvcfgH9083sSEYrHT8svseDw/KihzWi1JiopHkBZ+PLZjyiV/pxe3/HR
         mukUPHM9yVVdu35GhFjnSQ6y6qCnLmH+f/rWAJ25qOs2cHrl+0MgQk4Jc48+/iw4loGZ
         l5WrOEOtg7V5LIWx2fKr6ZOFOq/Do4n0fwB1NyNQa2pS83IHcW1v/DSJmGS/vgddw7Ci
         E/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wrpDjbP4w2xCq7mdzj75yVVv1DI/Z3nNPuhthG3gKU=;
        b=MxeX3oxpGsfnmnmU3xORYqbbwNS8xrtp7tigxgycsP52Wyq8HkAdOmi+CMOWHEggCM
         0TuUw7MHF5uO9+a+5EqE4zORPGsYq+LfgkppbNwyY6g67/+ES8YjNjWG+mYKXDsEMGD7
         h5d9/8R1rNqKGZjE9A5yFQj5ZqYfG/IDG1JK1CNbKhbpR0B4PLk+VWuuyiIz2W9l/x3p
         ZtOpjaciRrTR8OCEFRDgWt0JhgVQNneS+FkiITMeL6YhggqA9cvTM4A0cMg5drCuDH6A
         tlhUXKdW5YiDSO1FdoU3vqop3LvuLGbaLPPhHTPaSho9RfH/5pp4rKe3yEWp79QKclkY
         hSMA==
X-Gm-Message-State: AOAM530N6ci+twa6r3unRkcweysrTOsyKbmxVcItO6Uc/CaczNwrDtNu
        K6rCeY97R1JroLsIvkYrsWLfvRb9dgNDrGmOQ5g=
X-Google-Smtp-Source: ABdhPJxMFoQB7LByS4OaQ1rQSqobrtazTFawEDpuosydZ97IIqDtpTgXrJT1bdZ4KeaMqoXWb3c/tqEul4MnOhdibCw=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr207443wmb.56.1603342970516;
 Wed, 21 Oct 2020 22:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6CDB3D2D9BB1A93DCB856F2AD38C59F93F05@qq.com>
In-Reply-To: <tencent_6CDB3D2D9BB1A93DCB856F2AD38C59F93F05@qq.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 22 Oct 2020 01:02:38 -0400
Message-ID: <CADnq5_PAefQhvb=Yh9=uzrhnHtV9-5Lo01ervN32cSqGGDS9_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix a possible NULL pointer dereference
 in bios_parser_get_src_obj()
To:     estherbdf <603571786@qq.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 8:38 AM estherbdf <603571786@qq.com> wrote:
>
> [Why] the func  bios_parser_get_src_obj () is similar to  bios_parser_get_dst_obj () which is fixed by the commit<a8f976473196>("drm/amd/display: Banch of smatch error and warning fixes in DC").
> the symbol 'id' is uninitialized and it is not checked before dereference it,may lead to null pointer dereference.
> [How] Initialized variable explicitly with NULL and add sanitizer.

I think the current code is safe as is.  get_src_obj_list() will
return 0 if *id_list is NULL and bios_parser_get_src_obj() checks if
number <= index.

Alex


>
> Signed-off-by: estherbdf <603571786@qq.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index 008d4d1..94c6cca 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -190,7 +190,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
>         struct graphics_object_id *src_object_id)
>  {
>         uint32_t number;
> -       uint16_t *id;
> +       uint16_t *id = NULL;
>         ATOM_OBJECT *object;
>         struct bios_parser *bp = BP_FROM_DCB(dcb);
>
> @@ -206,7 +206,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
>
>         number = get_src_obj_list(bp, object, &id);
>
> -       if (number <= index)
> +       if (number <= index || !id)
>                 return BP_RESULT_BADINPUT;
>
>         *src_object_id = object_id_from_bios_object_id(id[index]);
> --
> 1.9.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
