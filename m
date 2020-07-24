Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FE22C642
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGXNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF01C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:24:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so5164226lfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrNd1IsGR4tP8PBdHAFs3AhICen6bv/rNf6zgNWwFI4=;
        b=PioAJypK5ctFm6Xpj+L40YBoTd0JCG/mujuTgjgFt5XPDhLDMYIHuNZ1Gru3Xl1cPw
         7QsYFW1PVV5ED1ho4LpWE8uqv8Z1+5PChli2H7RVUs0JgrT8x7uwT4Lq0A3FdXAmcj44
         +bUSSrcbH3I9fbldqLNr+s4TKMTp2PmVV8Jrmqzxhd2A7paYkowMApdmShipQCBDSvzh
         yb0grHRbq8Nu7Q1KGGdJcrjfFpv6kx3Iw/gU5VAeYZCfsHjzBHM2vKM3zjVchhsFf+U3
         3AOEgFQm4R6pgWiA8g7HC+rAurTwKgrRSxTtx0XunZCr3Y7toQi+k84kbOIoajdoL302
         C/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrNd1IsGR4tP8PBdHAFs3AhICen6bv/rNf6zgNWwFI4=;
        b=fGKVu4FE70nRmLtrjMcMsYhhSIeokULKi+LzQFlnE/OF1TDOkcWoEFp2NjyysKlJIq
         utmJJo/ufUrbRH9ERRGbFXgumDcZpofHzBRudOd+OJOabRgUp9LbWyd9AY01BilxxFOc
         LaL1nRCKhUU866LJ217MnAdcWLGORAgVmMFSR8P5iHYax47EOvgfojja0NjuuleU15vG
         jkmW/PeyIDkB6e//P7Vssrxp1QAI9nmPW7srnqcRl5dm3mIwQYxiHCFyXzCLXnDI0tCN
         sNlcVEJhO88cFs/IHPANJblDp5UB0FVnRpGNgBjiB50hebgmmgV4uTwlYCj5UKBnwanF
         hAaQ==
X-Gm-Message-State: AOAM533ZvAgrXpXNDC7xwAViHBKUlslY+edTbfncja00MNHtD0u9qadU
        L3OC9qidwjvVAQ6VRiW+bHVnXk5txHrzo5BVVJ0pTA==
X-Google-Smtp-Source: ABdhPJzQ+DJRA0iFuI99YTbcfAz/FjMxLPDD4nS06PTBDi9IeLSDtUNouRu4oWlAKHjrLeLOfNOoXu4MPSQg8iNP4Jk=
X-Received: by 2002:ac2:4d16:: with SMTP id r22mr4986311lfi.21.1595597058699;
 Fri, 24 Jul 2020 06:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200723084622.31134-1-jorge@foundries.io>
In-Reply-To: <20200723084622.31134-1-jorge@foundries.io>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 24 Jul 2020 18:54:07 +0530
Message-ID: <CAFA6WYMCs-50WnwqqhefE9b_aXaORq1e3JdZJAjb04tHKvqP0A@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] hwrng: optee: handle unlimited data rates
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, ricardo@foundries.io,
        Michael Scott <mike@foundries.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        op-tee@lists.trustedfirmware.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
> timeout on the call to msleep. Avoid this scenario by using 0 as the
> unlimited data rate.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Sounds good to me. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> index 49b2e02537dd..5bc4700c4dae 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -128,7 +128,7 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>                 data += rng_size;
>                 read += rng_size;
>
> -               if (wait) {
> +               if (wait && pvt_data->data_rate) {
>                         if (timeout-- == 0)
>                                 return read;
>                         msleep((1000 * (max - read)) / pvt_data->data_rate);
> --
> 2.17.1
>
