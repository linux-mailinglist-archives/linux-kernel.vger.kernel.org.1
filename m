Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E792C0FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbgKWQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389899AbgKWQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:47 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEFFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:45 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id l22so9396043vsa.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=neKh8lc/wWos/iNaP8WSL7zrCvHB4dIxwGX7kKDy85c=;
        b=X4/ndsvPJR55zi/T+mrVut+IzMdLDitkajGBydN3gJteOBSqBgcIuZH9mF45Y67vaq
         1gKccgOB62Z9XgsNCq/Ay2OvAOrOR6s/TcaHSuDNO7brAhgYvEHfd84S30mfqLArc4/E
         8C+43j7OMYCOe0x+Au0GlRkL1kjSgSej0a7T6LCa2VKXxLW0CufbYDiblEGpC+VMIDqu
         aejy2CYw9dx+irfcuMvUp2sC3aSknWuGzIJ8FhqUUrc7he4sltOqHUDmdPap8OuF1Eid
         OpQwUzTZkaYjTbZ6U3ocwwE2jfCfJTLvV47TlnvZeG81gCuC8yb7BeVwfs3ismfeKx3k
         jBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=neKh8lc/wWos/iNaP8WSL7zrCvHB4dIxwGX7kKDy85c=;
        b=FA2+4mfp+H9GA85LmUGCGpJrEAm4SOofb222Yp2EMh9Gk3p9OjRDi1kQrKFMb5AzFj
         6Mg+7sRn79jjF/LY5BDog9oE73SUxbq5r/8pSQBIPB/fZZg/7rlLZSZZ8xwLj4/FccFQ
         2eaI6KbxXOPX3NWAYKz3U12//icNQ6i+b3cLErn9BVXTVYY2yU8/EVEewiixxkY3iF+4
         iGFFTdPEuzmYWf7XzJ62Ws3cWTxBN5DLXX8vkGClhZAiM0JCUWXyZcDyap7yy5SlpuJ8
         nHS8U6tQtp2gjOAevQ8zU51QsjZyGeLAvTmRcgxGHHYqac/TsJBd7cIFB0SL2fpL+4fA
         FkuA==
X-Gm-Message-State: AOAM533ruvceninMbQMDHWawl/3G6EqHy0UErO32VS4DLG72GecDE4h3
        JmjsGSRX6/e35ucoCQ8PhRiWHi3uUw30nqjntFcKQHYZu604TQ==
X-Google-Smtp-Source: ABdhPJzFbhfleAS+9gkcRzDUsZi7EZdlN+F5L/n8QkIAsP4Pj4lw3JGZlZwy+vVUWrPBZ8jTWJW+IeLLgwIS3Iosfqw=
X-Received: by 2002:a67:ce8e:: with SMTP id c14mr375404vse.42.1606147662757;
 Mon, 23 Nov 2020 08:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20201120162344.485921-1-krzk@kernel.org>
In-Reply-To: <20201120162344.485921-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:06 +0100
Message-ID: <CAPDyKFoqpmSWh5-m0m_XB14w7w5RLCYZmYSkuNv1pCiQgYKWVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-sprd: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 17:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
>
>     drivers/mmc/host/sdhci-sprd.c:723:34: warning:
>         =E2=80=98sdhci_sprd_of_match=E2=80=99 defined but not used [-Wunu=
sed-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 58109c5b53e2..f85171edabeb 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -788,7 +788,7 @@ static struct platform_driver sdhci_sprd_driver =3D {
>         .driver =3D {
>                 .name =3D "sdhci_sprd_r11",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(sdhci_sprd_of_match),
> +               .of_match_table =3D sdhci_sprd_of_match,
>                 .pm =3D &sdhci_sprd_pm_ops,
>         },
>  };
> --
> 2.25.1
>
