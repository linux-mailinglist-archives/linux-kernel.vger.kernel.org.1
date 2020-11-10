Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECE2ADC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgKJRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:08:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B38C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:08:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so3835520wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MP7B63t+yoSacKBIptO0FK7JGIG1SuX3J5XEKrv0R1g=;
        b=D9I8wAmHqyj+i4Uu96Y3bxWuJs3MnB2WC/JIbN6DbaOyTMwPBbA8ODwB52W4GvoAvb
         xjwHAsANSAGGzyuDDR2ls0rUkeKCWRxVeGD2mQ7+87wnFJY1f1Xj7q8BEKXwyOsggHqj
         /jOye5LWn2xuMbLaJXVBSRRIK/x1KzVpyGXSft/jLaN+nvChjCPfUezvtfph5j3Tpfxo
         hyNOdkuc7/0CG1lFxptmNQHEAIg4rGEVXTdauIOMcqOYTucImAz69W92OP7Q39DUWOL+
         a/qheGe2KBsQ6aKDhC2R3Ww4LoiShOAxnyTBR93S5YVs59wd+vD68cE3Cg5g0VY5Hiyx
         F1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MP7B63t+yoSacKBIptO0FK7JGIG1SuX3J5XEKrv0R1g=;
        b=XaOQsVO9nvNe5Y3hzLpyE3Umfb/+aSWr7tZhSHHxucfBw2AWnWKW6iEAfbuersGf3c
         McN8zvvvr39WT3q38/82oX7iMUqg9QlC8knbKIaUP2+sJ8AlaN5aZCwIC9NTQ+iL/4V8
         uaAfaq21wITHGmMGDOz2d+FjwgE2baHt+gUColeqDjkNEGWJFdXKKvGO+cPIjqwssuRn
         3ykpIdsA73SlW6jhm2AlEe1WG7yLaJ7R+F+UWIMRe5BgW/FJQaxrV7lsqiOXq1b00r7M
         AcJXnRZLZXJEyW62a8512udNqu5gmcpGiJwM4NhDLM0IEiY8j7iCdtqoB7IvxN6vQr8u
         qJpg==
X-Gm-Message-State: AOAM532PcD86EFo4S6DgRrXrAUtbBa1e6ohWxgZZQtXQD1747N8xkY8d
        wnxDHQZEyWGbXcbaINwHri8kpVzt4bVUfWgVX+4=
X-Google-Smtp-Source: ABdhPJy+/O/G/wQ1/tkGUAuIUq6m+EmoOJdfu31KWO7h4nmLps/WriPVMU3WAjYlWrOfFv9oDEtJ/9IVu/k8k4eKnzY=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr42687wmd.73.1605028100187;
 Tue, 10 Nov 2020 09:08:20 -0800 (PST)
MIME-Version: 1.0
References: <1605008098-33391-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1605008098-33391-1-git-send-email-tiantao6@hisilicon.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 12:08:08 -0500
Message-ID: <CADnq5_NcF1-mmGQAuGjOE65wvjmxwZSRqovi2M5Kp6-gic-BZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Use kmemdup instead of kmalloc and memcpy
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:57 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Fixes coccicheck warning:
> drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c:255:
> 36-43: WARNING opportunity for kmemdup
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> index 740e2fc..1e79baa 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> @@ -252,12 +252,11 @@ static int init_powerplay_table_information(
>         phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
>         phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
>
> -       pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
> +       pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
> +                                                  sizeof(PPTable_t), GFP_KERNEL);
>         if (pptable_information->smc_pptable == NULL)
>                 return -ENOMEM;
>
> -       memcpy(pptable_information->smc_pptable, &(powerplay_table->smcPPTable), sizeof(PPTable_t));
> -
>         result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
>
>         return result;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
