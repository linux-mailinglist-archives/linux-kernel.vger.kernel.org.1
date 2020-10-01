Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA827280887
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJAUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:37:31 -0400
Received: from services.gouders.net ([141.101.32.176]:54561 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:37:31 -0400
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 091KUwWs015548
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 22:30:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1601584259; bh=tcXFYCXwIwCI0zr467EPsI+J2hd/fK6huawfTzULyJw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=AKREcO2asXJreCy9VrTtaXZChMh6tzgROkz4be+8YT1CVAw5Es7Cqk8FFlrgOU3Xm
         Zd40zGKx7rkZQZaZiscSLEur5ojqxqHE7gWeplJtTnlK/FuNINwlbZWSOD/Qdr1dDe
         DXmProSAompmQKNdLEOCBIOh5a5YSbC9hvjypFpA=
From:   Dirk Gouders <dirk@gouders.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6?= =?utf-8?Q?nig?= 
        <christian.koenig@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix NULL pointer dereference for Renoir
In-Reply-To: <20201001195525.3477-2-dirk@gouders.net> (Dirk Gouders's message
        of "Thu, 1 Oct 2020 21:55:25 +0200")
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
        <20201001195525.3477-2-dirk@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 01 Oct 2020 22:30:51 +0200
Message-ID: <ghh7rdy9hg.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Gouders <dirk@gouders.net> writes:

> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> introduced a NULL pointer dereference when booting with
> amdgpu.discovery=0, because it removed the call of vega10_reg_base_init()
> for that case.
>
> Fix this by calling that funcion if amdgpu_discovery == 0 in addition to
> the case that amdgpu_discovery_reg_base_init() failed.
>
> Fixes: c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 84d811b6e48b..f8cb62b326d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -694,12 +694,12 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>  		 * it doesn't support SRIOV. */
>  		if (amdgpu_discovery) {
>  			r = amdgpu_discovery_reg_base_init(adev);
> -			if (r) {
> -				DRM_WARN("failed to init reg base from ip discovery table, "
> -					 "fallback to legacy init method\n");
> -				vega10_reg_base_init(adev);
> -			}
> +			if (r == 0)
> +			  break;

Grrr, wrong indentation here.
But I will wait for your review before v1.

Dirk


> +			DRM_WARN("failed to init reg base from ip discovery table, "
> +				 "fallback to legacy init method\n");
>  		}
> +		vega10_reg_base_init(adev);
>  		break;
>  	case CHIP_VEGA20:
>  		vega20_reg_base_init(adev);
