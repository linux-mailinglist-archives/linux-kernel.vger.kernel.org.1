Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7D2CF5E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgLDU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgLDU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:57:05 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:56:25 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t9so7689845oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCRFwoQksFKYxL9oDoarBzLvwPjlXv3hZNckKayt7VE=;
        b=qtVhX699Z+sdbwQ0ORNcWDXHwHjkZyYC8BLl8PrsqffUGnX1Nflju5sQJ9vxci2hTA
         pNcPyzTncdV4ImSnFytm/qrKywE5ktZDoohXPdzQdTeAqgPRAU1WwMrvvATQO00FLhnQ
         ptLQcrME+z99/L4GzViD6O1B/mcnIBZQrr4jJgtErgbr/gSWh+N76dM+5eZp9P5wOx7i
         0JWz09RtGf3eWmo5MMtrrjFZMUGB+4QmOVxfIV5BCbiPsvUaWULkjXEFOBcGL9FRZk4t
         h2A5oz2Rt6X42vobKLOOuvZKsbrMZ1lPzlSpdNPN3mDpsk/CiiiB8WFsiFU9161Y66XS
         qTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCRFwoQksFKYxL9oDoarBzLvwPjlXv3hZNckKayt7VE=;
        b=cXBG+qkAk9NBwHMT8BBpSZuC9VAdABc5Rl7FeLmDd876OJCoyDIlcup0EpoZSRtX5l
         lwUzz7sI+KCbQnzM20Sfujxj97UhC5j1OKACvH6yuFzJHToPiiyEtPZdqug13Vrn6YBk
         oZMLj/TTtTh7p7nNR0NfB3DKYvsw4wP3yn3xvptM3ug0SDGl4OwxXrShjnc5w+aYRSSb
         jFYnPo33TnUjEM449xNrRBuNFF+SJ+b6c4HPVvprPvBEJqrSfZ/RPwdyKE8fWxjID3qF
         ld2knOeIB64blJUzwFNK6+RwLXygU+KBLgxfBabg4eU+S0CPWClUwSKsx+C+o07KRSQU
         GtmA==
X-Gm-Message-State: AOAM531dd1enTY+q/lMC5eW0uJvF3VvRlkrMZTsXRfJEFTBwXNNbo93k
        dGuw6P35WNiXDpP6cL2oe52FQUvzD96ppW86460=
X-Google-Smtp-Source: ABdhPJyXohy3tSCW8i4Y64blynsYCsiiFXP/mTHQmJppzn38tpXoDpmHXnpmSlNLMQD2uV987pardlFK657tYR2yRWM=
X-Received: by 2002:a54:4608:: with SMTP id p8mr4365387oip.5.1607115384748;
 Fri, 04 Dec 2020 12:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20201204165128.3747878-1-arnd@kernel.org>
In-Reply-To: <20201204165128.3747878-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Dec 2020 15:56:13 -0500
Message-ID: <CADnq5_NBqx5U+JAxSAaUD6qwCmZsnCzGk1mF9=rkPRPm0Ug0yw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fw_attestation: fix unused function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:51 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without debugfs, the compiler notices one function that is not used at
> all:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:123:12: error: unused function 'amdgpu_is_fw_attestation_supported' [-Werror,-Wunused-function]
>
> In fact the static const amdgpu_fw_attestation_debugfs_ops structure is
> also unused here, but that warning is currently disabled.
>
> Removing the #ifdef check does the right thing and leads to all of this
> code to be dropped without warning.
>
> Fixes: 19ae333001b3 ("drm/amdgpu: added support for psp fw attestation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> index e47bca1c7635..7c6e02e35573 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
> @@ -130,7 +130,6 @@ static int amdgpu_is_fw_attestation_supported(struct amdgpu_device *adev)
>
>  void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
>  {
> -#if defined(CONFIG_DEBUG_FS)
>         if (!amdgpu_is_fw_attestation_supported(adev))
>                 return;
>
> @@ -139,5 +138,4 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
>                             adev_to_drm(adev)->primary->debugfs_root,
>                             adev,
>                             &amdgpu_fw_attestation_debugfs_ops);
> -#endif
>  }
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
