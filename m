Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493152F3D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392138AbhALVfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437108AbhALVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:05:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA108C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:04:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so3985202wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v4xV9g2m1b67bsLcVGdEvyfTd+DgiyIQglAT13edfZk=;
        b=NtZkZGFam5ta+af3U6MCp3WsAKc45QXgaxIvvE/J4lBRovmutCyzaZNtW5KFIqspRE
         5lLlCaibg+H4qVOgS+AcHh4LXg3y1g40vcNGBOJvO36+/72O1APWlLNXI3tWOZCm/qtA
         mcn+mYRAQFP1THwRWWuXFE8Yn5B6C9tDCumvdnJzHJb9eRNOmSrVp60/E1qreV+6/4rL
         yEi5YBlNnpgPic0LcbO2R0x+HWorkovAmY9+06bHMYcKMp/+W3rpdsngtCSgf6pE5c+i
         8clNhp5JOyjsdzK9sOe32B8I7bhwisoeII0hYMc0sIp7hvIb0xR5TclA9q5zPqnMKFIX
         l7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4xV9g2m1b67bsLcVGdEvyfTd+DgiyIQglAT13edfZk=;
        b=AoOOSie3be6V5vw7ROIEmZh/VRiNGbXLoki1578vJmho52jJjpVa2J62WpVSkFi+GN
         G7EQHCtTtjg0+zy5g78iPpKk4cdxkhLt+ylMlADP3NX4jPrCgRR9Fd2qROuYcDGsNCXZ
         XhKzU1+BOBXBO/Yy0GBMpR4NEx6LLzPSw/fkL1jbd0IVMpKq2ExK1Hxk0zIx3ORM9j4T
         RUThis/TBa+m1BZM0+A3pxviITNzFaZcTbCvIeRN7wDiI9Cvt9zVvxLViuPmp1uQEpLg
         pNuzmMkpBimm2XTSIm1V7uMP7+X/kNw1W8LSv/VT+E8wrEZEH6Ccq01F0WGBIKdH2Ccp
         OSOg==
X-Gm-Message-State: AOAM5306Xn7ACWbTzUF/iBRh7wf/uOePMCv3CXQSWTNOne3o1FVrTv+W
        /Oj7Or8ImS/Hth+Ib78U5rU=
X-Google-Smtp-Source: ABdhPJx2pI+nhlLJi41E3ignw391szWh1B4zzxhhvVavwSBaKM+QRdRepzD46HilHW7CQNirUMMeYQ==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr681390wre.344.1610485497530;
        Tue, 12 Jan 2021 13:04:57 -0800 (PST)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id d18sm5449676wmb.30.2021.01.12.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 13:04:56 -0800 (PST)
Date:   Tue, 12 Jan 2021 18:04:50 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/3] Decouple config data for configfs
Message-ID: <20210112210450.dzipxaiu4e26hyak@smtp.gmail.com>
References: <cover.1610391685.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610391685.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12, Sumera Priyadarsini wrote:
> This patchset aims to lay down some prep work before configfs can be
> implemented for the vkms driver. The first patch in the series adds a
> new type vkms_config to track device configuration. The second and third
> patch add module testing support for writeback operations.
> 
> The first patch is developed by Daniel Vetter.
> 
> Daniel Vetter (1):
>   drm/vkms: Add vkms_config type
> 
> Sumera Priyadarsini (3):
>   drm/vkms: Add vkms_config type
>   drm/vkms: Add support for writeback module
>   drm/vkms: Add information about module options
> 
>  Documentation/gpu/vkms.rst         | 12 ++++++++
>  drivers/gpu/drm/vkms/vkms_drv.c    | 45 ++++++++++++++++++++++++------
>  drivers/gpu/drm/vkms/vkms_drv.h    | 13 +++++++--
>  drivers/gpu/drm/vkms/vkms_output.c | 13 +++++----
>  4 files changed, 68 insertions(+), 15 deletions(-)

Applied to drm-misc-next.
I fixed the extra line issue while applying.

Thanks for your patches,

Melissa

> 
> ---
> Changes in v2:
>  - add Co-developed-by tag
>  
> Changes in v3:
>  - correct usage of Co-developed by tag(Melissa)
>  - add enable_writeback_feature(Melissa)
>  - modify commit message(Melissa)
> 
> Changes in v4:
>  - split previous patch into patchset(Melissa)
>  - fix checkpatch issue(Melissa)
>  - update docs(Daniel)
> 
> Changes in v5:
>  - modify docs patch(Daniel)
> -- 
> 2.25.1
> 
