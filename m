Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6472B228D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKMRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:34:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21CCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:34:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so8970133wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VAyRswQxOnE6Ap+njfI0flgqY+hikjcd7/92aKeFkMM=;
        b=HMR+27u7jJk5vhJ569WZ7eXznF+zmqX6C4McpG7f9LD7IlIFIqEwlBmnaep+Fihfew
         dTgAP2gtCdi3y1dsiowwSsbWfE1AVyQvA+9uoFSv5qfzXt7xzvMOd4wNMVJQZahzBGdG
         msy7+qg/YCdHrefph+iKduSkyVhYSog4ejmUj5I47Ln3r/eTtag3+vkqq3RjKGQXaLdh
         T/bkq1TxX3CZMFTHMD6Pei63UPmFcy8kBCvF3HPC/cIOuDck1UuMB7iUdBOHdO1mtg8S
         4rmcV0lQZvMn3bpo95XEBjWMO1yyz31E1IXmZj5FdOmxUuyJsskugHd4xEbJzBf/4OhR
         ByrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VAyRswQxOnE6Ap+njfI0flgqY+hikjcd7/92aKeFkMM=;
        b=hBlyPWKOtyfnEmZWd7J7HFE92fdE7Ka1AABEUx1C4Y6spacyLwAvqNQVuOsjN6jCYz
         1AWIPhCafYVFPb3ExawEwdrYTd4+szcXFEEqArS5+073DH8DrqlUrB1f5IWuN79usMMS
         9CBbdYf32bVPTlmyzbH9sKtbcJlQ2Ry3j06Ujel13ZqXBezwKzSOh6OQnQFfMthfCPjF
         Pz1bpqgbstZ8xMFoP0UAmRdXJFak5SansMgBYuanDVjTAXs1TwP64PaK3AKLm5jzo1p2
         pG6OJHkAW4dKWkgIBvqKyPeXlpu/YYLZRFfnruW+90Q2hdfz1w/6isEtJlsK/BA7jfJf
         wq3A==
X-Gm-Message-State: AOAM5316nrlDdQyWn2GeNI/dBPeQDB/BvcMe01pRyk+IUZXqopSUHVIE
        90BnQdWkSkTQDLf5gexeV/8661X9VeP7nY9vE10=
X-Google-Smtp-Source: ABdhPJy4iOo+ylGkeKNUPzwbvjwMLxPrnmH/CR+FHDNMKer1Mk+qrvdkkKTV72Mkm/NtsbEFHTufjI2HFoejyctSz+g=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr3554153wmb.39.1605288878659;
 Fri, 13 Nov 2020 09:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-38-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:34:27 -0500
Message-ID: <CADnq5_MxBB7Zqa-L=PVXuWzhGAQOtMttn8juh8hVrO7zLfnzJA@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/amdgpu/smu_v11_0_i2c: Provide descriptions
 for 'control' and 'data' params
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

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:225: warning: Function parame=
ter or member 'control' not described in 'smu_v11_0_i2c_transmit'
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:325: warning: Function parame=
ter or member 'control' not described in 'smu_v11_0_i2c_receive'
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:325: warning: Function parame=
ter or member 'data' not described in 'smu_v11_0_i2c_receive'
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
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm=
/amd/amdgpu/smu_v11_0_i2c.c
> index 7fb240c4990ca..5c7d769aee3fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -212,6 +212,7 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i=
2c_adapter *control)
>  /**
>   * smu_v11_0_i2c_transmit - Send a block of data over the I2C bus to a s=
lave device.
>   *
> + * @control: I2C adapter reference
>   * @address: The I2C address of the slave device.
>   * @data: The data to transmit over the bus.
>   * @numbytes: The amount of data to transmit.
> @@ -313,7 +314,9 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_ada=
pter *control,
>  /**
>   * smu_v11_0_i2c_receive - Receive a block of data over the I2C bus from=
 a slave device.
>   *
> + * @control: I2C adapter reference
>   * @address: The I2C address of the slave device.
> + * @data: Placeholder to store received data.
>   * @numbytes: The amount of data to transmit.
>   * @i2c_flag: Flags for transmission
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
