Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10E62B6E00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgKQTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgKQTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:02:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:02:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so4249994wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aB3RzbF3m+Z6/FqXxyXIhr+Vt8dqXl3DQEjdVHMAUy0=;
        b=bjFj8+TPtQ91/C4v+b7Q3YX2K36GbTX82dI9b4XJJyTVGANQGMae74PG7x4101XdKE
         YsUWmw7CIPHamCogS+tsfuM3qEL0q4Ur1cJaA/GPPBhNVajADE4yS0DE4HLaVGjSmAzC
         3MYk/b8xWFtlxRwxIOvSUvuA385V+kiL1S4dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aB3RzbF3m+Z6/FqXxyXIhr+Vt8dqXl3DQEjdVHMAUy0=;
        b=bE5EmLovGRbiOQBJfoum3rno73IuQSsKHGhvC2aNZnvKN74UroQzMKqEbmelO5fT/F
         31dR3DdQ7JiBhTR2Cb8072EHu6TfKX4xGp1BsaK7iFioujRi7n+uerRvHxNjTFtuYtlr
         q7vtd/INbL05n+poypZcK1UnMU7fXpO3XZOOya2YntrFr9Vgl764iiTfrn4lbKaN2rK3
         +0gSVaoIM/FIstTw8eK8mUdyn92pu2Y5kYllb9gF7ccVigykR7mtycEyNV51lJEi1jjY
         sI3O4bGjK7lVQKr1HDNXseO+LBqyMKQ7c+Bzti2rhraQN77m7819BbNtJcS3g+vMksRv
         GFVQ==
X-Gm-Message-State: AOAM5303Mcym17JYPAvrHApHDi6GQukV+tksWubxlCFAespT3XopME5M
        IyUDNVLGigqjndIlN5Ek9VOGEqUZC2kNRA==
X-Google-Smtp-Source: ABdhPJy33P35zG5c/C2euGoTdmYRuFwy2hKncNNGdVb5M/FEMoYCCXo0rdgmO/wiGFMvk6EwL//oAQ==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr542288wml.174.1605639754375;
        Tue, 17 Nov 2020 11:02:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v19sm5020653wmj.31.2020.11.17.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:02:33 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:02:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH 21/42] drm/nouveau/nvkm/core/firmware: Fix formatting,
 provide missing param description
Message-ID: <20201117190231.GQ401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-22-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116174112.1833368-22-lee.jones@linaro.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:40:51PM +0000, Lee Jones wrote:
> ... and demote non-conformant kernel-doc header.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'subdev' not described in 'nvkm_firmware_get'
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'fwname' not described in 'nvkm_firmware_get'
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'ver' not described in 'nvkm_firmware_get'
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c:71: warning: Function parameter or member 'fw' not described in 'nvkm_firmware_get'
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c:106: warning: Function parameter or member 'fw' not described in 'nvkm_firmware_put'
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>

Ben fyi I smashed this into drm-misc-next, seemed trivial enough to not be
a bother.
-Daniel

> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> index 8b25367917ca0..ca1f8463cff51 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> @@ -58,9 +58,10 @@ nvkm_firmware_load_blob(const struct nvkm_subdev *subdev, const char *base,
>  
>  /**
>   * nvkm_firmware_get - load firmware from the official nvidia/chip/ directory
> - * @subdev	subdevice that will use that firmware
> - * @fwname	name of firmware file to load
> - * @fw		firmware structure to load to
> + * @subdev:	subdevice that will use that firmware
> + * @fwname:	name of firmware file to load
> + * @ver:	firmware version to load
> + * @fw:		firmware structure to load to
>   *
>   * Use this function to load firmware files in the form nvidia/chip/fwname.bin.
>   * Firmware files released by NVIDIA will always follow this format.
> @@ -98,7 +99,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
>  	return -ENOENT;
>  }
>  
> -/**
> +/*
>   * nvkm_firmware_put - release firmware loaded with nvkm_firmware_get
>   */
>  void
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
