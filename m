Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043EE2A3F57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCIx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKCIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:53:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382CC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:53:27 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id a9so17538683wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+IjpalJWI+KVSSWMFebRdhxN51bp7Jm+rN1WjquNubM=;
        b=P2N5AVQniKvMDUMOuAomruk07hnPtWloZR5sr5cExJ48iCm3EJJBUtCePmMskFLONg
         Sz3HTTbByKNp3kAidqJX+o5RdlGTr2Is/fcPxZkDQ4486LmifmVaPlwgJ3QJMuVk2q/9
         Fz2Kq3lYptAMx3dV3DLHGqASImsYpJzi/hplMO5Zc+qpBqernKs3En1NdxRqz+bvGyIY
         pDfZq/EiB5qykwdI/prxTtdFpSzlUmSxM8LJpI6vOj3uZSFe3fsRLzekEnC25WHKj2Bi
         9w1yjTdyPwEui2T3Rv3+5GOD9LLsqQZBa+PsUhCiJ+w6J3o2AkIJhek0+YKOXdQyPkFv
         79cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+IjpalJWI+KVSSWMFebRdhxN51bp7Jm+rN1WjquNubM=;
        b=blB6ODXc2O9e/uUBzF4eWDveaJFtCQDhJKhQyQlUgExcvipbFGuewQTuhl0QCYlLta
         IJUGvt+hmFDw4Wo1zHLLbqjPzxidA/ZmkFYz9EUaVnlIanMLZCNGagSHCublNVBzYTzL
         n1NHBOrEXi9pbduDWt8rrkYJx9QjfLb+bQ/nhfF48FGkIPGBTr2WtgfBCxcAhPvRnXK5
         iUFSmFzbxrT7d3SObv3MwgBHPTHul2WgY5ESVzgDoEJs4xCwdlGqdcxvkssEeXQ1CgGr
         v1qvsPPdNOA2m8gRiCN+EltLJa7agzo/cnJCaATYH1GGLb3Ekiq4VMUdMScfvpnWAzMg
         be4w==
X-Gm-Message-State: AOAM531WNBBdmlUj8OV08lCSnWHSHSGyj56VvnW4smqE5MyorPW9k0Ac
        AIwJpW5BJ3mpZUThazxruNdG8Q==
X-Google-Smtp-Source: ABdhPJylM8htsHwN3G0Kx3IEDKL6WpuD00P0+11WaDP6IUEf6ShPkz6BUK26aUoHsXRTkXOwqPBduA==
X-Received: by 2002:a05:6000:107:: with SMTP id o7mr24580674wrx.354.1604393606478;
        Tue, 03 Nov 2020 00:53:26 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y4sm25004498wrp.74.2020.11.03.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 00:53:25 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:53:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Fonts: Replace discarded const qualifier
Message-ID: <20201103085324.GL4488@dell>
References: <20201030181822.570402-1-lee.jones@linaro.org>
 <20201102183242.2031659-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102183242.2031659-1-yepeilin.cs@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Peilin Ye wrote:

> From: Lee Jones <lee.jones@linaro.org>
> 
> Commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for built-in
> fonts") introduced the following error when building rpc_defconfig (only
> this build appears to be affected):
> 
>  `acorndata_8x8' referenced in section `.text' of arch/arm/boot/compressed/ll_char_wr.o:
>     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
>  `acorndata_8x8' referenced in section `.data.rel.ro' of arch/arm/boot/compressed/font.o:
>     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
>  make[3]: *** [/scratch/linux/arch/arm/boot/compressed/Makefile:191: arch/arm/boot/compressed/vmlinux] Error 1
>  make[2]: *** [/scratch/linux/arch/arm/boot/Makefile:61: arch/arm/boot/compressed/vmlinux] Error 2
>  make[1]: *** [/scratch/linux/arch/arm/Makefile:317: zImage] Error 2
> 
> The .data section is discarded at link time.  Reinstating acorndata_8x8 as
> const ensures it is still available after linking.  Do the same for the
> other 12 built-in fonts as well, for consistency purposes.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Fixes: 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Co-developed-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Changes in v2:
>   - Fix commit ID to 6735b4632def in commit message (Russell King
>     <linux@armlinux.org.uk>)
>   - Add `const` back for all 13 built-in fonts (Daniel Vetter
>     <daniel.vetter@ffwll.ch>)
>   - Add a Fixes: tag
> 
>  lib/fonts/font_10x18.c     | 2 +-
>  lib/fonts/font_6x10.c      | 2 +-
>  lib/fonts/font_6x11.c      | 2 +-
>  lib/fonts/font_6x8.c       | 2 +-
>  lib/fonts/font_7x14.c      | 2 +-
>  lib/fonts/font_8x16.c      | 2 +-
>  lib/fonts/font_8x8.c       | 2 +-
>  lib/fonts/font_acorn_8x8.c | 2 +-
>  lib/fonts/font_mini_4x6.c  | 2 +-
>  lib/fonts/font_pearl_8x8.c | 2 +-
>  lib/fonts/font_sun12x22.c  | 2 +-
>  lib/fonts/font_sun8x16.c   | 2 +-
>  lib/fonts/font_ter16x32.c  | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)

LGTM.

Thanks for keeping my authorship.  Much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
