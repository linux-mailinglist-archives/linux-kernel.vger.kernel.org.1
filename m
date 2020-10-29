Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EA129F74A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJ2WAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgJ2WAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:00:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB03C0613CF;
        Thu, 29 Oct 2020 15:00:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c18so1204066wme.2;
        Thu, 29 Oct 2020 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40e4S00g1+jWvsqSMaAemc/LZ0HJCmIgIw3gyfOIGI4=;
        b=XTrJbqSgkFmHPKW2edfxxzsOZvUBsU/UirFXADLRS9z0KiFZyIw1i/iFsTqyvrsKhJ
         HS7ZbK9hQ64GBA40tdtuTcv1pEF/K79UEp55pPN7WQz0Or+UHoBtKHxQ2RwG6dbMx2pW
         axQlXzZFrBvxyCqYyu+zx68ol7HiNxdNYjNxJTjhr0vb7AtATSLls3qM4tz5nrAV9WnK
         jaoGQqXKH/vAMnnoI7+Px3lMJa6tOQlb+1GFwRzdyOhJxPmy5krwEvtHFAMlWafXMjGG
         zQH9hWNflaozahPEhSR+Q+OPZkVZPDvv/xPkyhbUfFm9lJdgl5Gi4OFaG8VOUhvoT507
         jUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40e4S00g1+jWvsqSMaAemc/LZ0HJCmIgIw3gyfOIGI4=;
        b=l90lzQXAriTOzAyvEtSnzALEdkaEW7DDQg0QlPc2AsV4lGuKJ3UcnxP6u7QO5dldlM
         3TiPismz/wtGMO9GApjoAy3VgTC/E28jQHfNqKOkIcDvGa4Y19Mhyadf1+/iGpWFUluB
         OfDQCFwqIj5JUkAH+Y2Ne0Bu1Ev+R1h77/ob6/C5iixpWafjSBvxA6uHXl8a7znab5Qj
         48P5naFbytI7eYv5D9ihror+RRDZivv0BIOvqkJneJGfY9cEIu9lCt4IgybbSUAwRby/
         PZvHJjZe6jfb1PLKg+3CaOLzAU88vlIWvmk+ifK1t/wKqznz0euc99A+c+CLdD4yQ1/m
         vfPw==
X-Gm-Message-State: AOAM5310dh+KrKvq+rDmvnWR+WoaapNQup+KOYIFzO5o+1b4z4KO7JcE
        7PDiSyVRyQ0T/BcsvC4N0e+iiHIq4eGY3D3wOiI=
X-Google-Smtp-Source: ABdhPJwpYSrUAdeoFRilgwZtoHiIfWS1NIhXwf789NWRPz40ExUzFgYDJVlEmXo1EaJsJMJhoIXHj6NroAtLXRAuhzg=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr1052308wmi.70.1604008809836;
 Thu, 29 Oct 2020 15:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028124316.109886-1-colin.king@canonical.com>
In-Reply-To: <20201028124316.109886-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 17:59:58 -0400
Message-ID: <CADnq5_N8FkB1bjhrfVi2EvRbKdDSgKOCm37zdmXACnTLSx6krw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: fix out-of-bound read on pptable->SkuReserved
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Oct 28, 2020 at 8:43 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A recent change added two uint16_t elements to PPTable_t and reduced the
> uint32_t array down to 8 elements. This results in the dev_info printing
> of pptable->SkuReserved[8] accessing a value that is out-of-range on
> array SkuReserved.  The array has been shrunk by 1 element, so remove
> this extraneous dev_info message.
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: 1dc3c5a95b08 ("drm/amd/pm: update driver if file for sienna cichlid")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index fa3842f460fc..0600befc6e4c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2279,7 +2279,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
>         dev_info(smu->adev->dev, "SkuReserved[5] = 0x%x\n", pptable->SkuReserved[5]);
>         dev_info(smu->adev->dev, "SkuReserved[6] = 0x%x\n", pptable->SkuReserved[6]);
>         dev_info(smu->adev->dev, "SkuReserved[7] = 0x%x\n", pptable->SkuReserved[7]);
> -       dev_info(smu->adev->dev, "SkuReserved[8] = 0x%x\n", pptable->SkuReserved[8]);
>
>         dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
>         dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
