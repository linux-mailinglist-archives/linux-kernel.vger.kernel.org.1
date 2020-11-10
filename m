Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936772AE469
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgKJXwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbgKJXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:52:29 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FFCC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:52:29 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so169316wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5DnaoUF0p5jGghI91j7sY8mMsHYnXiRGnd6iIqVaCI=;
        b=BfO13MKXIQHCpL8tnKxxIwv+Q7ALe4KlLDC4/v3XD6yZgEgSrXris1Gqyd49dvnjvo
         xjGn5jmV6yyHGM+hhqcXzRVIrThhv6lCsUhHXALI4MnUGZ7fWKCPM3qZ5qhDbmn0ixyn
         Xj2gFmceiwJ0/sGZj0+5Vf/4KHoaboA5JZD6A5utOM9v7/JjFEVANMJjo723uO9R3rCl
         0843C2ZN8Py0VIkGHA4c/qMbKqV7hEyVvk6O4hdqARDw4rxxDms9iPCNTSGEXBJEhT7Z
         qolN5bUbvEyQjcTSso9WO5wwV5Gl0REaZoYJ1ltAx9P+dyLOWD2ClWjwrfU3AryYhGcY
         jMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5DnaoUF0p5jGghI91j7sY8mMsHYnXiRGnd6iIqVaCI=;
        b=BCOmjIPojZ+ojRFgFjqEuKs/Zq3ZI4xfM63Q41A0zo25I9j4F1cNSNnSHYvJHSoZx2
         /Es+rIkzLf+S8seWfN2Tx1XIsKYdauz5XutHLwmYIbiOg/yykXovV+bTC2Z0het4zEMe
         CEh9RjT3oTP+TgXJy//z4Mtb3WPlxYAgZA2LnbsvuVAdbo9oNNM2zZKRz6J7mVy42x06
         uhVRJxoYZ9W3ynfYqjIkxtVZZDNcu9RrmR1qCFbhS+RCTeUp6h8G1ldr+hscXMlTM2LM
         j4cGDRREmnaHdvH2j2j5O8oRl3N4cObcrI/BT+b7/ISNz78pIWUBTTywlo2vILV6CKtv
         93vQ==
X-Gm-Message-State: AOAM530HxMid1g0T+2s7IbfEVq1PqStKeKoJt9W0eSCL86LRteCkHa37
        WtXESAoPHXGpNut47e/Cstw2jHQ03cMCeKDbIKg=
X-Google-Smtp-Source: ABdhPJyH7zLqqCWsjHjLSvt2XDyB2UJe1W2H+wypyxoMhN3QyfBm6hwmu+EpFhdllNTCpSZYDJFDNrYghMhR/8RTXzk=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr587600wmd.73.1605052347807;
 Tue, 10 Nov 2020 15:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-14-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:52:13 -0500
Message-ID: <CADnq5_MJQgyf_Xu+Qi-=6a9-V1x7YiVY0R+jWM7x_GvXxAdVhw@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/radeon/radeon_mn: Supply description for
 'cur_seq' even if it is unused
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
>  drivers/gpu/drm/radeon/radeon_mn.c:51: warning: Function parameter or me=
mber 'cur_seq' not described in 'radeon_mn_invalidate'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor fixup.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/radeon_mn.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/=
radeon_mn.c
> index 97b9b6dd6dd3b..3c4c4213a7b57 100644
> --- a/drivers/gpu/drm/radeon/radeon_mn.c
> +++ b/drivers/gpu/drm/radeon/radeon_mn.c
> @@ -41,6 +41,7 @@
>   *
>   * @mn: our notifier
>   * @range: the VMA under invalidation
> + * @cur_seq: unused
>   *
>   * We block for all BOs between start and end to be idle and
>   * unmap them by move them into system domain again.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
