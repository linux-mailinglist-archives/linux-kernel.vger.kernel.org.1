Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C197290CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409657AbgJPU6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:58:41 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:33680 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgJPU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:58:41 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3528520030;
        Fri, 16 Oct 2020 22:58:37 +0200 (CEST)
Date:   Fri, 16 Oct 2020 22:58:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Li Heng <liheng40@huawei.com>
Cc:     tomi.valkeinen@ti.com, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] video: Remove set but not used variable
Message-ID: <20201016205836.GB1496366@ravnborg.org>
References: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600957106-13741-1-git-send-email-liheng40@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=ta2fmmrRsy9J0w49oKkA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Heng

On Thu, Sep 24, 2020 at 10:18:26PM +0800, Li Heng wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/sis/300vtbl.h:1064:28: warning:
> ‘SiS300_CHTVVCLKSONTSC’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>

Thanks, now applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/sis/300vtbl.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sis/300vtbl.h b/drivers/video/fbdev/sis/300vtbl.h
> index e4b4a26..26b19f7 100644
> --- a/drivers/video/fbdev/sis/300vtbl.h
> +++ b/drivers/video/fbdev/sis/300vtbl.h
> @@ -1061,8 +1061,6 @@ static const unsigned char SiS300_CHTVVCLKUNTSC[]  = { 0x29,0x29,0x29,0x29,0x2a,
> 
>  static const unsigned char SiS300_CHTVVCLKONTSC[]  = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
> 
> -static const unsigned char SiS300_CHTVVCLKSONTSC[] = { 0x2c,0x2c,0x2c,0x2c,0x2d,0x2b };
> -
>  static const unsigned char SiS300_CHTVVCLKUPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x2f,0x31 };
> 
>  static const unsigned char SiS300_CHTVVCLKOPAL[]   = { 0x2f,0x2f,0x2f,0x2f,0x30,0x32 };
> --
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
