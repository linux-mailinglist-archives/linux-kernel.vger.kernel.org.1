Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887F82C2BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbgKXPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbgKXPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:30 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F19C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:51:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so2841981wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6GM7HZKJOMbvnNyqxtbbQQmzhMuTNq7eU6NBsZKc41s=;
        b=oAAKjcXVvTnLxDN0CqGoY7CnqvAOMvs06bh0shxjr/VcQQIh21vrLpOc6xehdcudmo
         sYxEqBpPOaBZqlW7xP1ieh5OjWM1vZsxzWZbq9yy9kEmMyxK4a/OaY2I77gO99Xr3Uaa
         IzhxRw0NEPK6MjTbwvcrpDXmkjvO+PgVrGrjeokLWuaWpFTZ3Ml8dMam9VZ61Xx0XD5Q
         h44slbwH0ZxnvnLcu9pP8hLyOtsVhmBXvacaPwEeDCNajjXJm3P3iiRu4kqxM8WZePcC
         /eUxl3fGQ6aIrMOvfd9GOHmKl/Zr2hnMNBLFlA9BhkpLnEP44mj0QEYIKVppmKLg+VZ3
         ycHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6GM7HZKJOMbvnNyqxtbbQQmzhMuTNq7eU6NBsZKc41s=;
        b=OUpFuxSaRr+Pr0fkfmHgnGp6WlIM8ijgXAtz5DjicO9otuKdmmNrdwdCMrC1q/a3kj
         MLGfxB7y1Ht6FKhwBqDiwzzK5774XP/L8eKV3DBMd/NPaxRNQSuA//QuV/3Mkm+ZtxZz
         HVdRpqUTuOd606vMy0+KaGEBg/JTHdvNKLcBjgr5ibnIU61w+B/Yu5ibwQBETPtkLPOL
         MqrVJdNcEUSSe/h5LetR3JQ+TY82WP7WwYTF3uU/xQ+c37HZDzkGZ17/+7UlUnhftbJi
         U+Fjnsqk4n5ST9C+sm1AVC2dx5SZuAkYcG0sS1ZzgZcc5t2D5jjMbJ6fqCPPwWiCVIrS
         7hqw==
X-Gm-Message-State: AOAM5305S2o/pk2XspbxdbC2XGpRExlMi2HecqDmjAV2V3yCRC6kQmAK
        dp3en0exwCnaUoSHt1m0vk9yJ7fe0voRvMG3c88=
X-Google-Smtp-Source: ABdhPJwmRU0+C0x/7U2CChem3SlI4KM5YXcqfAcScbL2Aftb6WMTxqTsRomNDeRcZ+kpO+Zfa0vkSWlewKle4bEg6nw=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr5132469wmb.56.1606233088772;
 Tue, 24 Nov 2020 07:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-6-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-6-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 10:51:17 -0500
Message-ID: <CADnq5_P6pF+XeOn_ZjVe0gQMUXqbLAzS9qc1fR-D=CXaMTZVkg@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/amdgpu/cik_ih: Supply description for 'ih'
 in 'cik_ih_{get, set}_wptr()'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c:189: warning: Function parameter or =
member 'ih' not described in 'cik_ih_get_wptr'
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c:274: warning: Function parameter or =
member 'ih' not described in 'cik_ih_set_rptr'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Qinglang Miao <miaoqinglang@huawei.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/am=
dgpu/cik_ih.c
> index db953e95f3d27..d3745711d55f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -177,6 +177,7 @@ static void cik_ih_irq_disable(struct amdgpu_device *=
adev)
>   * cik_ih_get_wptr - get the IH ring buffer wptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>   *
>   * Get the IH ring buffer wptr from either the register
>   * or the writeback memory buffer (CIK).  Also check for
> @@ -266,6 +267,7 @@ static void cik_ih_decode_iv(struct amdgpu_device *ad=
ev,
>   * cik_ih_set_rptr - set the IH ring buffer rptr
>   *
>   * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to set wptr
>   *
>   * Set the IH ring buffer rptr.
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
