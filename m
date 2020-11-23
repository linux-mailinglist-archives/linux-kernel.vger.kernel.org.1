Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724B2C0FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbgKWQHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389904AbgKWQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:48 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44EAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:47 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id r5so9389088vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h1uRxI+FAxlFdCzQqRhFzGu/VFJH9a8yX1Pv1mpupxY=;
        b=nwsLqXy/5k+8M/TiI8Ak9AnCg9omfJmI0EXqQiMHYdHOZAusx11RgBB1ILtlsnLJQH
         CAz+48vmGYPdJEZbUwlyU0fSa2ugIM9AZo/V7fPvvAs86hP+tKQV5AB+rTy86Y0GQRj8
         KTLVS4UbhQgdCJCYzKoT2fv/P4WBMFU6ZYEC96nqyzEyyqI1O0v0Et0E0g9TcLbHEvPY
         lyMJNcf0C6kW1ahr9Aji+PtITR3pjfFoH9Jwl+Ujl0F1c6KAWOfYEnZ0qA6C15pYK8wt
         9ruYbuPnIcvRAgYO8L5SSe+QsagozKtyPQqI7sOVpc2M7FyaT857NOl3nwsenxcviEhi
         EWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h1uRxI+FAxlFdCzQqRhFzGu/VFJH9a8yX1Pv1mpupxY=;
        b=G7FD5j6qu7GBDHr26jLdUtgI2PwrnAXeyZC3KqQfnUcRN2bx0SGRo30EB5LIEbGADT
         7HjUHoLb5qO4/aZ/4h4GGkB8zetF9aJGt0Qi+afFQCzqoderNcEO1pYWcAj8z2W60MhZ
         7O9qzHHGKfG2gPfdCPzVRPkaJJkihs5xH3blP7LT1Mu5bACxVnO5cr8hll3v+3xRIehH
         Kq1V4QhzNlUA0ON5QMh8Q0LphKr365eVh7OLrLbFlE6RUCMyQtJm2R+3zIE860wtGE32
         3FjtUXH/8bxbEyebV7coVM5TOy8UnAUCY48HKLQxr5SL9HBOxDccsnHTObMI9w4z6SFx
         N93Q==
X-Gm-Message-State: AOAM5324SZbMl0H2Xr3RQDdQBnys+LswQqsUs2CdlFhP04bCCub7ARmK
        p3c7JO1COvmDx2vdVJHC8iYSTQo+Fo4KPLiCb+AK5Q==
X-Google-Smtp-Source: ABdhPJzm3rcFOegJPTrbS+PyxshN7G6VRkXDMBv85G4d+Xd0s4bXDt0IBRyKr5R7NMXAoktvK0uDNc1N6R5tq7L/GQU=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr20204149vsd.55.1606147667002;
 Mon, 23 Nov 2020 08:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20201120162344.485921-1-krzk@kernel.org> <20201120162344.485921-2-krzk@kernel.org>
In-Reply-To: <20201120162344.485921-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:10 +0100
Message-ID: <CAPDyKFre-8=tTShjRF+Pm2cQkGnN3HHcO42SgmCEfRzLoHDNTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-st: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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
>     drivers/mmc/host/sdhci-st.c:512:34: warning:
>         =E2=80=98st_sdhci_match=E2=80=99 defined but not used [-Wunused-c=
onst-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 4e9ff3e828ba..962872aec164 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -523,7 +523,7 @@ static struct platform_driver sdhci_st_driver =3D {
>                    .name =3D "sdhci-st",
>                    .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>                    .pm =3D &sdhci_st_pmops,
> -                  .of_match_table =3D of_match_ptr(st_sdhci_match),
> +                  .of_match_table =3D st_sdhci_match,
>                   },
>  };
>
> --
> 2.25.1
>
