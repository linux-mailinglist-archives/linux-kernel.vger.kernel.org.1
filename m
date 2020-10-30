Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9129FCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgJ3EPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3EPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:15:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:15:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p22so1670281wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqWBGxp83tXBly8ZHVM6eJ0MtxhFupmftKu7NV/OBXU=;
        b=IC4UPPAraPaFBL01yPA31xu/1JnYIZLD2Zb8bHtgPnFS1fkrboUlvaF7A1g1CETk1U
         aA4c51rNES2T7YczUU3hL21wRB7DXzJz3MEPy7XrTmw0Jt3V3Mse/Kj8DKOtyMmIl9GJ
         i/OYoRR8ZYklJTFxTYilS3tSY0Orf5nONcbZ0s+hotGD+cw1VQCL7V9eZgh7pdO0zi2D
         nqjeYX2EpcgR9v2E0gijfUByEDDqRo0f8Q1XrQX+23XrR4l0CBoxwt5wzNVctkRBpCYR
         Hx33UJdV7HQR+MCZ0yWv4GQxGsehskZS981FlGT986u1b0Kxmo9wFVOuns36BJuyohH/
         u3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqWBGxp83tXBly8ZHVM6eJ0MtxhFupmftKu7NV/OBXU=;
        b=qMvv365jno03NoUmiDcEA3j4OdMuTl+rbHbRbOwJDv8lXuS1exJmM/4UivnqfHo0of
         KMKtC2vHkXZS50MHFg/9cBUe6f7RNkENpFmKc713TkcoRECn9vTswzZb3suY4rxUj2Ly
         P8b9Kjq5oXFTMDo6qFtgNvHYojvJg764otYjiqh0p/eQjbbxNrX0WzTrpQ8l4EEBEkq+
         NiOrch/FCqnwYbNLcSX9eeP2sybI8mEdsUx6pfBGC8YCKj+zZVPASIvDO1BUXbtpciYO
         h7vfxb4ou7p7wiNZjQWSpMeMfyghVyUznl0TR4qZW9FPmtw5S0EDtxS+epokth1RUs97
         vpkw==
X-Gm-Message-State: AOAM531Y5kR/qqnyGj7UCGRvixt7FHbig8fzfsVWMdjqBUMWUSK6ZlqT
        0IBDTDNCQdI/L+sw6tpCTubkPCKrNtQpV5dLUKs=
X-Google-Smtp-Source: ABdhPJxEbj4ViG6nx+9BHcArb72+dptqPezIyx9BdE/F9YYCz5xQc1TZuRt+lxUttX6q3ieThBBuPMwGgeNM4Sc8HwY=
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr327725wmj.39.1604031350500;
 Thu, 29 Oct 2020 21:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201029094346.14185-1-unixbhaskar@gmail.com>
In-Reply-To: <20201029094346.14185-1-unixbhaskar@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 30 Oct 2020 00:15:39 -0400
Message-ID: <CADnq5_Ooq5zdskLceuBgkFoYux3mTkhTsv=bLWLadoMH6Mz22g@mail.gmail.com>
Subject: Re: [PATCH] drivers: amdgpu: Correct spelling defalut to default in comment
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Oct 29, 2020 at 9:17 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> Correct spelling in one of the comment.
>
> s/defalut/default/p
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  CCing Greg becasue it touched drivers file. Trivial though.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 8cd646eef096..cdc8dd220a77 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -556,7 +556,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>         bool disable_hpd = false;
>         bool valid_test_pattern = false;
>         uint8_t param_nums = 0;
> -       /* init with defalut 80bit custom pattern */
> +       /* init with default 80bit custom pattern */
>         uint8_t custom_pattern[10] = {
>                         0x1f, 0x7c, 0xf0, 0xc1, 0x07,
>                         0x1f, 0x7c, 0xf0, 0xc1, 0x07
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
