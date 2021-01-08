Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774D2EF94D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbhAHUfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbhAHUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:35:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577CC0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:34:59 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d8so10931741otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7M0YCmEHu5CIrepeBj4TyE7lC8HZna8Bt9bEIhFkg+w=;
        b=H16nH0qzvZKed06io439zey0XEwMylyF38K7O6aSNayFnhq35M1CchxnYvRGrDpegv
         NtfcEndB2YssXdqOttI6BkZ5L4StlNAhqxDC5mJNyXVA2992QXsoc6E9kNN8tlrHckC0
         /JcKFOF6uQNsw18JOefc8WrtopTBTvWEKMR8EMkeGenlnMYojTvo1NSFCtfj6TdvB6UX
         4izxRDXqJT6T0Hg6R/H0s/DSO4vznyBbP1rekbdlFfHQpCGytv9O8tQxehoxOhOE2sam
         FcjehcG9+feIVbxLhZgNd23OI2ADQO/M13+rppXreTSPJqF/ylh7TKkaqrngabA1Y3ql
         4Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7M0YCmEHu5CIrepeBj4TyE7lC8HZna8Bt9bEIhFkg+w=;
        b=EAN07XkEdUbrVLoy70Id8uQ9yobtgA3um9C2JYO2sFWOHrDOsruFqapnM/ACAv/NUX
         bQcl7tqP2pM7EQ/fOGInVqWAylM6sAKanM/2xwEtZ1nPJFQ8BAPtAKJCcBxzOHKU5F+0
         DvLZrtwatQKczeW3oHR4+FlG6HuZAPuaTDzXX+mLVFbYXNJ0hYAZe1VRZYKeotGpaKH2
         yDu8aM+sTALzd3GVjM9+XHrRRJpwgfndt+0mqBH5iy+44ZT6S+sJZVcSJfdexeH4Pdzq
         6+eoxdS2m9ayz+vEcejMQSCiErXrx3g74fHwcuFehnfbIvbAF3iw+JJgOkPCpLSbnLsJ
         ziuQ==
X-Gm-Message-State: AOAM533wh48flClVjRbS9BfR5sXs/PflBh/rMHtX+GoJz4jP+8TuRtg2
        jrG2WFjJ9svmJhvowJ+d87JNFxTqjqSFY/Dao6k=
X-Google-Smtp-Source: ABdhPJx8SnzY5lS/rofxEhI+zgTdmQPyLxveqpi/jaQiaWQGAcqVTzqOKoMPs+UC4BHaEJZ7n4PW8NfhDOysRj/o0pM=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3791588oti.23.1610138098760;
 Fri, 08 Jan 2021 12:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-10-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:34:47 -0500
Message-ID: <CADnq5_N2PuJemMY71672+g7=maNFN2=Ab-JvAni3qOQhokNYBQ@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Fix legacy
 function header formatting
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_hwmgr.c:781: war=
ning: Function parameter or member 'hwmgr' not described in 'vega20_init_sm=
c_table'
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index da84012b7fd51..87811b005b85f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -771,12 +771,11 @@ static int vega20_setup_default_dpm_tables(struct p=
p_hwmgr *hwmgr)
>  }
>
>  /**
> -* Initializes the SMC table and uploads it
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    pInput  the pointer to input data (PowerState)
> -* @return   always 0
> -*/
> + * Initializes the SMC table and uploads it
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * return:  always 0
> + */
>  static int vega20_init_smc_table(struct pp_hwmgr *hwmgr)
>  {
>         int result;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
