Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456F27451D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:19:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8675C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:19:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so3742549wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scqHhJ8H2F1OwqEQAUQOLL4YJrrUXBZObQzVzFZayBI=;
        b=ud7Z8q5Iaz3v0wMl9sijNgJWLoh+EObUkH3gLhvAfMqP9C5Z7tRIQ534KlkbFRgfv9
         z2DD3DE+h2jOvVD1DMpp7Y1TfCNZXb3e/BrPf6Sr0zloAVm3KaDh44i4BK5S/tHMPCRi
         Gw7bHVM0QAeBLqrCtD5cMYMkstDteJjuR0xOcOaTA7uku4h3iXT/0tP6e3rKoXGO+R2c
         V3A+DvvT8joCtcYJNKXIkwxk0jU3BDgnl0RHgDv4fPFby36cZsLUZC0jF+NADyZz2uqf
         ln8jFfTgv5P6BUOuXaEbGATW1CrKZT3e5d6Zw+PgRFlmgq/XViIJ6Sy3RNrGNnp8eOa9
         Rokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scqHhJ8H2F1OwqEQAUQOLL4YJrrUXBZObQzVzFZayBI=;
        b=uWP0FgbDimcpY/muqD/r0Obw9fkFEhEL40BQIIjteHbaTCkIHDcRKAWK4Zq2MKQAP8
         Cl+CRMXRzbKiVhDzJQqLP3qS7RZRvvfiUzIf2cHNNONsIlnT7IMCCWQ42/t4U7qD38cE
         /I0EEXNeEDznLB4QM4hDD3G/3YtvWMTMbqUY/JYceJftDLgDMYPhkqp8MfAmshW4uzRT
         IFrdIuNVZsglBzfudoaHqGuGYZLYaA6Lmy1PWr+rC5qJef2/+fZ/qw9C1bZ8N4MOSgjK
         Km1c53yndAJ72qlNI9QExSA9pwJgmGw89jtvhtJhoE1qS5khWwaxRHvRHB01JcKTfWK6
         xfCg==
X-Gm-Message-State: AOAM533jPAKJJruBuFceQi/i10ol4emwI2KLNMGGOcX4iKnc3GG2hL0e
        Zy/KHU3zANyzqb97eVIYtrAuLACivtK+hsX9CM4=
X-Google-Smtp-Source: ABdhPJwSuNJ2YKBapkwBsT/onLn/HzjF5NQVk8AzJyU5PzUKmm9KvtKj4eIV23ATNS6J6xa0M1JW8/GaRgVLmlXy73E=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr1562936wmc.73.1600787963365;
 Tue, 22 Sep 2020 08:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200922054743.2422929-1-natechancellor@gmail.com>
In-Reply-To: <20200922054743.2422929-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 11:19:12 -0400
Message-ID: <CADnq5_MP85Qqv9N6VYnyRYAACU82G+e1oXyESUYoqp=QMYEbYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify condition in try_disable_dsc
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 3:47 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
> warning: logical not is only applied to the left hand side of this
> comparison [-Wlogical-not-parentheses]
>                                 && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
>                                    ^                             ~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
> note: add parentheses after the '!' to evaluate the comparison first
>                                 && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
>                                    ^
>                                     (
> )
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:637:8:
> note: add parentheses around left hand side expression to silence this
> warning
>                                 && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
>                                    ^
>                                    (                            )
> 1 warning generated.
>
> The expression "!a == 0" can be more simply written as "a", which makes
> it easier to reason about the logic and prevents the warning.
>
> Fixes: 0749ddeb7d6c ("drm/amd/display: Add DSC force disable to dsc_clock_en debugfs entry")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1158
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

@Wentland, Harry or @Leo (Sunpeng) Li  can you provide some guidance
on what the logic is supposed to be here?

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 9d7333a36fac..0852a24ee392 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -634,7 +634,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
>         for (i = 0; i < count; i++) {
>                 if (vars[i].dsc_enabled
>                                 && vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
> -                               && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
> +                               && params[i].clock_force_enable) {
>                         kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
>                         tried[i] = false;
>                         remaining_to_try += 1;
>
> base-commit: 6651cdf3bfeeaeb499db11668313666bf756579a
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
