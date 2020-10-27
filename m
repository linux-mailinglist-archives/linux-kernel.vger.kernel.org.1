Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7C29ADA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbgJ0Nm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:42:29 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40236 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbgJ0Nm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:42:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id q20so480116uar.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+IdqF2kWZIatsMkx1rqiXPdMLtc7lqC33V+nAVYFq2g=;
        b=ff5RdpQJhaV4ad0Bhm5iTZaXGjMLJa3FTFpEVKmQVPt1yF0CAiJWvG1uTtz3dn8UtR
         1MEwVbDSo5SIeWCSiiHh+H0rN5GwHuCvBfMJn9Lg3NY2PLyyip6lA4gIBGD7vAsqiV0F
         JLBtIXbk5N/jrfVLZow9hdeN7bO/8/aM09TSVOOuhJ2v+QjqxNoUBSySyi8q0xW/6863
         86L8AF5RvSOSn/LtJ+Aex1Cn7PMcMm2biTHJfBnmFRKCoMYlqcjva4l6N+tpO26vLFGY
         EAh/p8X0Wb9MfVqOY/f5udHdQHFH+3RbcoharLIWefHnE/83sU2vK0NTI6uPGVPHUJ1I
         Y+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+IdqF2kWZIatsMkx1rqiXPdMLtc7lqC33V+nAVYFq2g=;
        b=CA5OMl+UnjNK8eypg2ZPznV7fyi18WsjP4ajpBNCE91YBp4+9o0hhevgm0frlJkmXL
         rr8GZrn2O6VhgyOzzjDLQmGe21QQKZbo9eBRpSWdlZS3KeWV8BiNDZG2u4RdGm7In+Br
         dp7kQaYvqDcuS80oMy09aWzs/NRp78QGUeOXBiNrD1/qyWJW87RkeX3e87auZdWQexZA
         CLfCFL2a+4TnAKDlAPWj9rnCgIRJQOJlQ2f2SKJ3FPvYYuVXcsaXm/LSpaGiYlN4P5ti
         jEGMEf4yXV5DYlQZFHyrIF204oAhOs35oMK5PNABeAo9WSz4ZZtOBGbdSEGGroG09ilk
         i//A==
X-Gm-Message-State: AOAM531bCNxWHQtb237b/3EB2ljfAuz2d9XIRKRajbsfIY81BD8lYjvw
        OvGTQM1xpdXfNDcaqHJsHHfKwIQCm0DR+H7G39fGcQ==
X-Google-Smtp-Source: ABdhPJydS4TU6Ck4NDs6SP51ULZcsklQhQKBsqxjHnxoU9bm2tESho4QIrSHx4R+sjyHmElDzzy9KvfQ/sbozjW1+0w=
X-Received: by 2002:ab0:8b:: with SMTP id 11mr1259317uaj.15.1603806146520;
 Tue, 27 Oct 2020 06:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201026153810.89512-1-krzk@kernel.org> <20201026153810.89512-3-krzk@kernel.org>
In-Reply-To: <20201026153810.89512-3-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:50 +0100
Message-ID: <CAPDyKFo2DjMzozdr5PAr_A8=Oq_06_mmpTQAFd-sJ-=_=XHeOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sunxi: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via DT table so it should be always used and
> the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant for sunxi).  This
> fixes compile warning:
>
>     drivers/mmc/host/sunxi-mmc.c:1181:34: warning: =E2=80=98sunxi_mmc_of_=
match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index fc62773602ec..6310693f2ac0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -26,6 +26,7 @@
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -1515,7 +1516,7 @@ static struct platform_driver sunxi_mmc_driver =3D =
{
>         .driver =3D {
>                 .name   =3D "sunxi-mmc",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(sunxi_mmc_of_match),
> +               .of_match_table =3D sunxi_mmc_of_match,
>                 .pm =3D &sunxi_mmc_pm_ops,
>         },
>         .probe          =3D sunxi_mmc_probe,
> --
> 2.25.1
>
