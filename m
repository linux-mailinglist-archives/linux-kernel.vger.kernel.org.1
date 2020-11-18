Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8F32B8698
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKRV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:28:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA19C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:28:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so3639166wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HS6nUspWVEnRH3DktJ6lTOTBrBar/ajeOsAdlwxAVfA=;
        b=YKzFgtkkMHlSLwlLC/Mkiiy5BraPDGwk2MuvSz2qMiEPCoLC/nICjiXxmVBQtcMNKR
         YEwOVxtQb5fA4gateHWy9KZG4GX7tF/c+TXVDQ0CRWHYQw/96bO5jk6Nj9kCVJn9qdYt
         ghPCbXx5vR0BY/kZW1Mo8vh77aT9X1lKadhRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HS6nUspWVEnRH3DktJ6lTOTBrBar/ajeOsAdlwxAVfA=;
        b=aH4SC+gcJxpyMcwICsjsiOh6cDeazYD8gZ3hxUcxzuu/vjUxoSH8A+3O6P2kKU5sGM
         C15zQNBJ1+4NW89mRNuNGRBOg40LJeVD3bB9H70tpIBOruaSQBCA/Gf6Ut4nc1YquZ2r
         igJl+0rYgOQwCwJw/CrLV3Fpr5bymybrrXyjKFwaUuJK2MI6cXiC6vy/VcN5shXt+RbH
         N/u2Mty0IU3MZBQHU6J2Gzxt8xImvBVq/bV7s8CiOYD5p4AGuxMhptDbqptkLCvBpYOD
         3FqUHfmB98AkriLxebTj9vGXUjn8QYpBvoFbz/o8Qrwv1hPxObBEL0+2a5eJtgBbA82d
         oamw==
X-Gm-Message-State: AOAM531vOQJySuNLB9WshNBAV8D+y6oB1BL8aEuqn3xSdw5U0U5jKDrt
        m58ulay6ru7eMMUYy1v0cTHxFA==
X-Google-Smtp-Source: ABdhPJwyxkCdrn5AqiDgzx2c3AYE8913FWq4KNbg5UOleL8BNb0m1507hLivk7jAW0U7Oh+xiLH5Pw==
X-Received: by 2002:adf:e607:: with SMTP id p7mr6648704wrm.93.1605734890452;
        Wed, 18 Nov 2020 13:28:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x2sm29456487wru.44.2020.11.18.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:28:09 -0800 (PST)
Date:   Wed, 18 Nov 2020 22:28:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/via: fix assignment in if condition
Message-ID: <20201118212807.GA401619@phenom.ffwll.local>
Mail-Followup-To: Bernard Zhao <bernard@vivo.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20201118114021.105502-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118114021.105502-1-bernard@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 03:40:19AM -0800, Bernard Zhao wrote:
> Fix check_patch.pl warning:
> ERROR: do not use assignment in if condition
> +                       if ((HALCYON_HEADER2 == (cmd = *buf)) &&
> 
> ERROR: do not use assignment in if condition
> +                       if (HALCYON_HEADER2 == (cmd = *buf))
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/via/via_verifier.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/via/via_verifier.c b/drivers/gpu/drm/via/via_verifier.c
> index 8d8135f424ef..3d6e3a70f318 100644
> --- a/drivers/gpu/drm/via/via_verifier.c
> +++ b/drivers/gpu/drm/via/via_verifier.c
> @@ -1001,8 +1001,8 @@ via_verify_command_stream(const uint32_t * buf, unsigned int size,
>  			state = via_check_vheader6(&buf, buf_end);
>  			break;
>  		case state_command:
> -			if ((HALCYON_HEADER2 == (cmd = *buf)) &&
> -			    supported_3d)
> +			cmd = *buf;
> +			if ((cmd == HALCYON_HEADER2) && supported_3d)
>  				state = state_header2;
>  			else if ((cmd & HALCYON_HEADER1MASK) == HALCYON_HEADER1)
>  				state = state_header1;
> @@ -1064,7 +1064,8 @@ via_parse_command_stream(struct drm_device *dev, const uint32_t *buf,
>  			state = via_parse_vheader6(dev_priv, &buf, buf_end);
>  			break;
>  		case state_command:
> -			if (HALCYON_HEADER2 == (cmd = *buf))
> +			cmd = *buf;
> +			if (cmd == HALCYON_HEADER2)
>  				state = state_header2;
>  			else if ((cmd & HALCYON_HEADER1MASK) == HALCYON_HEADER1)
>  				state = state_header1;
> -- 
> 2.29.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
