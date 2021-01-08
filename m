Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C99F2EF943
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbhAHUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbhAHUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:33:21 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD57C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:32:41 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id q25so10919426otn.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZGAGOsJpJjZqUYW6PU7CazkH5H81ceN1e8mI8rt4VI=;
        b=nJuITnuSVPeavYDgKi8TG/nJy7vDXXaFfmuBKDCljpXG9nITBPuM/QDt41RUp5hbDj
         r0UjdfoFdS1G9ioSGGvntgxzjqZ7AoXy/lfg3ZHbbvBpYmkQQtFwtQ9rcNTSoVuF8/bQ
         ZgI7K8sMePIz/aZVvQmh2kRSdEFPeV841ynQAPCpn8TBLR3RjV/EHUMBzbf6EcALgqv2
         EkJsSGAaVuNjXy68nuR2LpJXSP3/734KNPikw9/kCq4rfXSssNuJnYn5P4DQHxNwjiK3
         LNBMsFkSFfhcgjcH1+JN4WmBw18OPdLdIn7UgPMYqPV8isOg7xlrl3ygHJ0s1rQEjVaq
         obdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZGAGOsJpJjZqUYW6PU7CazkH5H81ceN1e8mI8rt4VI=;
        b=ewtcSTIWB4GQyCcEvQQ//LCCAxbJlXvYYuWXf6VHg9bIGLu/XyI8NoJ1DEpFpdhhHO
         oMxD7P4vi7kTlE5vxEJGpSHrOJWFw2ategaLfu8VNVr+pODD4eB3neL7wSf7yzjq3R+S
         JvB1ZU5D2wXH57Gmf3W+RwRfoMk7itlHO9C9f+UPqUf9DagiAo/iBNeGaAGFclgBuKmh
         PESabCCjI3YgT1NN10fqDAumggpURP9N3rWbBhFgdnfo4u5Xb2TfLYuteTt/NtNXmyQC
         u0BVPUbuwbXWMKAfozHOsb0lmIB839e4zXmvFAhuD4ZBAQiJynr+AMbcpmPkZOCj8Y/E
         fY5g==
X-Gm-Message-State: AOAM531uHL8KpnruMzWRW4tmszn831uZ57PEOSYUot6Y2SC9fCurthyC
        2pfsE3rHUNQcR/JjcQdzPPaQupvCLQRWhSYOwQt3lPLN
X-Google-Smtp-Source: ABdhPJw2e7tM9dZ6PxxIsvuWPlW8hepaa14kG2Jo6Pc6Z5dpIY7WWRyBJBt4soUNikh3ixfk8iiXE13WaWRMpkuBpKo=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr3979159ote.132.1610137960612;
 Fri, 08 Jan 2021 12:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-7-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:32:29 -0500
Message-ID: <CADnq5_Psm9Z+DkX87+QVuytFMj1iL1DX-i5o3=NJDbbJhipxEg@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0:
 Provide description of 'call_back_func'
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c=
:1371: warning: Function parameter or member 'call_back_func' not described=
 in 'get_powerplay_table_entry_v1_0'
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0=
.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 741e03ad5311f..f2a55c1413f59 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -1362,6 +1362,7 @@ static int ppt_get_vce_state_table_entry_v1_0(struc=
t pp_hwmgr *hwmgr, uint32_t i
>   * @hwmgr: Pointer to the hardware manager.
>   * @entry_index: The index of the entry to be extracted from the table.
>   * @power_state: The address of the PowerState instance being created.
> + * @call_back_func: The function to call into to fill power state
>   * Return: -1 if the entry cannot be retrieved.
>   */
>  int get_powerplay_table_entry_v1_0(struct pp_hwmgr *hwmgr,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
