Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3262B2AC576
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgKITuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKITut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:50:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 11:50:48 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so6179479wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7UsYe46mocZoiCW+LF/Ym4Xr19zPlHHTun9MNgIDCa8=;
        b=bybJ1v3lnBrzYGFpKlM8KIAAxeZO8q1Oj7X8NR+yivBgB3ixHhbgfh46GvZw5Y0dw7
         R8ihdHrEF3VsPyVSczQs4CAjGr4WkHKZ60Pv8DXtW66G6KXcT58C2irteDqxc1Aqh/wl
         Yol11CKM3Qe9MlcKppFvLjC7pfs38gbMYpfl+awnoULIWf33EGa7hXtfpRZFnDPWu7pj
         C5ncll0eVyXlN4yFDmpfth2nkGZgRUMJkpmUWxVXdyADslDIR/lPs7tx+/0qTbI4sGVu
         9kCyUxOI1uqm1Mot8d942RRhA8Kr54/1FWeghNbwxFPc3IivlhHE6lWhFgATSgYK9V2D
         UnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7UsYe46mocZoiCW+LF/Ym4Xr19zPlHHTun9MNgIDCa8=;
        b=sFxirG++onykGZygPDR40mbyzZRlEeFRruLmLEF7aHREq3xUghkxcfBJZZGlcJ0CeU
         vvtkPVhc2LeaYl8CiCRhW5Q4L6g8WpO8clZwGYgNdLBvBv3c9qm9cKxu+GhlWkLiEw70
         /zecW2IR8wxhp3iOfSVUcfEDFnzwhfErmFqcsA0rXkgff7eOKHVuM6j6EdnInpSAgN2c
         4ctx6BRM6U1K0Z1CRYaKWSq7nP4WGw89fk8CGgaH2t2BnKZVaZsrI9W8ZRAt3yvPimyZ
         aEiG36dKfffj5xpe8+U3uOzJct4Xa91OFkwB+WCZVXVZRjP7+J+/d1fSYa+m5viRM7Nu
         +g6Q==
X-Gm-Message-State: AOAM5326T1NJU2WmeM2183YwCoQn7oOafA4A3NZ/WLNHK2clxPCey3Ys
        50B9yKAKP1RVLeClwMX1tQZ3VB0abkXEcTBr8TU=
X-Google-Smtp-Source: ABdhPJy4DoOooRT9xNcJhrIB9gh/ZyN3Y3XCDpxRFi0KiF8dwateu7LjMMrJAFMH6yt7UiqG83IN4HHaYGrXoQHc54I=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr21010982wrn.124.1604951446950;
 Mon, 09 Nov 2020 11:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-18-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Nov 2020 14:50:35 -0500
Message-ID: <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
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

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Function parameter or =
member 'dev' not described in 'radeon_info_ioctl'
>  drivers/gpu/drm/radeon/radeon_kms.c:226: warning: Excess function parame=
ter 'rdev' description in 'radeon_info_ioctl'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index 0d8fbabffcead..21c206795c364 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -213,7 +213,7 @@ static void radeon_set_filp_rights(struct drm_device =
*dev,
>  /**
>   * radeon_info_ioctl - answer a device specific request.
>   *
> - * @rdev: radeon device pointer
> + * @dev: radeon device pointer

This should be:
+ * @dev: drm device pointer

Alex

>   * @data: request object
>   * @filp: drm filp
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
