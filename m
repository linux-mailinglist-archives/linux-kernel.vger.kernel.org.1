Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39C92AE43D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgKJXl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:41:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C2C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:41:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so341759wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pdkh/TeTcrXxzoVGpfeQkjHXwIVJvI6CvhggFLBmmww=;
        b=XAz6xZx6IiaLP6fwtSsrDqcYRMbP48Rf5PQyV4pDB87jtLT8PyQ0dNfW36QUykMTw1
         3Fzac6jcVjJsS60Y8JRs8m/FKepN1dAo+5QAkVqdV47CDE4Z7/GK0I71vsLIX+z6h5ef
         dXqiiDpPjc8SbFSMA0dY0ndYODjGmD5MtRatYWW9LfAPsmKAZhldRYuMvqHfm6Js8OJX
         J5XIvEQftHc90oPzAuXAGpt9zsocCThBYGpR72zKLFg6CQaTlhPYevjQXlj/nwSCKfGG
         670VGz+jqFg3qu0reYpcwFkaBa2uv6lLW+sgSsllZ/3gPb4tQAIjX5HNfy4IefYukKu8
         1jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pdkh/TeTcrXxzoVGpfeQkjHXwIVJvI6CvhggFLBmmww=;
        b=A+eyYzNF9p6UOxMWKY2WTW9sQXMOAe9bb3xypwYRo2UOIlCRAPYOgpUS+LfxHXXQU6
         N9SFNREXaza/CulxrePw/+oh9THdiU1VisTomgr265eWyEdx8WMRIvV1BGqkrxFmFKJi
         HIP1Uxhul0/GOPrxLycTd1bsxTYA8hoe7D0wVHsF8Cdn0hZZ42NCvXCGFSNNh9Nib2xv
         hlU2YteCIO1ci8Et5QVjG9l+Suu16Ro8aIEEfjz4PgoUf1n+f3285iDhRVFNU5/sT7K7
         juwadvVWCEd+jR1eTZk4yt7n9wLBdR+cFWuo4C1oTutfyp8ilO555GtvxbLfXqF1yUYl
         Ki5A==
X-Gm-Message-State: AOAM532elBp8Twc7NaCW6d/AEXPT/fli1F9iMkV3YWcKOO42EHZrBcOU
        mu5bMI+PKApXETBjuT3VUgFbtwmuZiMLhDViWRU=
X-Google-Smtp-Source: ABdhPJzeu5w+TynfkV7VT4+0sa/ezxBAw1TViZtEDSSQSGysBaGHrLIZy5hejH8ygZn40cmW5xEziElua9cukTJC9+k=
X-Received: by 2002:adf:e350:: with SMTP id n16mr27364477wrj.419.1605051684728;
 Tue, 10 Nov 2020 15:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-12-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:41:13 -0500
Message-ID: <CADnq5_PcMUpn6zupcGjaWt53aF97QpgM9gqzv=NEacGVH7cOKA@mail.gmail.com>
Subject: Re: [PATCH 11/30] drm/radeon/radeon_ib: Supply description for
 'radeon_ib_get's get param
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_ib.c:61: warning: Function parameter or me=
mber 'vm' not described in 'radeon_ib_get'
>
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
>  drivers/gpu/drm/radeon/radeon_ib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/=
radeon_ib.c
> index 9fd55e9c616b0..c1fca2ba443c9 100644
> --- a/drivers/gpu/drm/radeon/radeon_ib.c
> +++ b/drivers/gpu/drm/radeon/radeon_ib.c
> @@ -48,6 +48,7 @@ static int radeon_debugfs_sa_init(struct radeon_device =
*rdev);
>   *
>   * @rdev: radeon_device pointer
>   * @ring: ring index the IB is associated with
> + * @vm: requested vm
>   * @ib: IB object returned
>   * @size: requested IB size
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
