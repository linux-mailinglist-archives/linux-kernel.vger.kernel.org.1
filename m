Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BDB2C2D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgKXQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390077AbgKXQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:37:05 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CFC0613D6;
        Tue, 24 Nov 2020 08:37:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so7150268wrn.3;
        Tue, 24 Nov 2020 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D8z5dUSRrl31L37ZHuzIVMwY+qduRSvxquBzIWeK1EA=;
        b=CP0mL9qyVcg3I0wRgcqt4n4v/oW5jFZdIR00tPbAx/omKbEV+qAUIQLgGdOqJrQSjd
         h4/W2NkDS3Xyv7HgYsadJ9ugSljPPtKoSTMz8/vkpYaPI/74khn8dtm8vF27VIIxbXvB
         Rzf4TTJZZ8UPEpU3WakrVDpcEw/YVeZdKayQx2mbBl/+T6nBLhPZBtgkkX9punvKAiF6
         syOjvrD//GOdyumN24EIkwCrIUAaj0MND21hfUfj7poC3RXk4HVX1LFKrAOJ3uBn1Z7w
         Bc1UOLwpDnwVS21NQHgnP2PUVMDjHISxPpG4c0zUHjeuhRjXCaLBhDh/PNIDOaLymj2b
         /9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D8z5dUSRrl31L37ZHuzIVMwY+qduRSvxquBzIWeK1EA=;
        b=PbVtpBnP2yIN3r8F7BdMYlDvjmI3vH3/YBpcDqqKj+uvUgSOp3m7td5xeIPeKA5Qxe
         rMVLkXg5M34apoSwmJO1EctuDrtPRFf98oea9LGw/pZLqnJ32+vsGq2nQ9xH1oH+90Vb
         9QxcVg2yBjEA5CT0ORixGnllCPLoq0+eCjgngkpPxoM+nA2nLat9ieNaMXm0e8T8sq7Y
         UqsGOY1jXfYvfizMw6s6kntXD5ZP4mul+QF70boLLeQkzaeT/toJilqA6uLXAuefL48Z
         U5N4b6wAvMQk7THYCRRYYcWOy4ktDMl6VJAMTiZuLdGjnc/phbBVu5m6q3g42F+cCJBo
         sr+g==
X-Gm-Message-State: AOAM530ntJrY2u3WLhASDBssc2egS9TyAP/2K0xMXCt+5yBNOW8lFBo4
        ZNEdFIoHRrYYWctyIuM3EGF7HyQbbpO5Lv6nNDA=
X-Google-Smtp-Source: ABdhPJzfxDMC7ETJE9yWHcvshWf4V3ciNOuGH8E1IA2nDwH0ep/3485i7wz8onEl34b1p3KBHYSz6fri9+kQaZZcCLw=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr6416532wrn.124.1606235823983;
 Tue, 24 Nov 2020 08:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123105417.198314-1-colin.king@canonical.com> <DM6PR12MB26197807564F833B9A2E18E8E4FB0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197807564F833B9A2E18E8E4FB0@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:36:52 -0500
Message-ID: <CADnq5_OHzmR4SE4GXukZX2Z2byqYkMRy-G2EXUTvz+yuwsE6fw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix spelling mistake
 "smu_state_memroy_block" -> "smu_state_memory_block"
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
        "Gui, Jack" <Jack.Gui@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 23, 2020 at 7:42 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Colin King <colin.king@canonical.com>
> Sent: Monday, November 23, 2020 6:54 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <da=
niel@ffwll.ch>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.W=
ang@amd.com>; Gui, Jack <Jack.Gui@amd.com>; amd-gfx@lists.freedesktop.org; =
dri-devel@lists.freedesktop.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] drm/amd/powerplay: fix spelling mistake "smu_state_memro=
y_block" -> "smu_state_memory_block"
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The struct name smu_state_memroy_block contains a spelling mistake, renam=
e it to smu_state_memory_block
>
> Fixes: 8554e67d6e22 ("drm/amd/powerplay: implement power_dpm_state sys in=
terface for SMU11")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_smu.h
> index 7550757cc059..a559ea2204c1 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -99,7 +99,7 @@ struct smu_state_display_block {
>  bool              enable_vari_bright;
>  };
>
> -struct smu_state_memroy_block {
> +struct smu_state_memory_block {
>  bool              dll_off;
>  uint8_t                 m3arb;
>  uint8_t                 unused[3];
> @@ -146,7 +146,7 @@ struct smu_power_state {
>  struct smu_state_validation_block             validation;
>  struct smu_state_pcie_block                   pcie;
>  struct smu_state_display_block                display;
> -struct smu_state_memroy_block                 memory;
> +struct smu_state_memory_block                 memory;
>  struct smu_state_software_algorithm_block     software;
>  struct smu_uvd_clocks                         uvd_clocks;
>  struct smu_hw_power_state                     hardware;
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
