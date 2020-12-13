Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746D42D8CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392923AbgLML1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 06:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgLML1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 06:27:22 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94550C0613CF;
        Sun, 13 Dec 2020 03:26:42 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so4949420pjl.0;
        Sun, 13 Dec 2020 03:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiB/9WTUgU4k/cf1D0blDI9YAXhtbx3zQedTzR+o/44=;
        b=Q39cbSGJNxB7lNbK8VSBdugLFAqITRcxO5zVgeyE5kdwfTpPgOc2INZ1pyzUFoQh1y
         tUhGBX+d2U/ThdHvcwJPW4v/O9C34HsjzrCGUwCcdLDNWoF3K6WpbChyvgUNyvPDB47j
         hPjkMtcbWSfpj//r1NvWwPjfB/1LuJ7yB3dP7fVxHQINRJl/cAR77mNmxUiKPqTpD1P2
         nVBL1E2FQtNurAj6gU5m9ZQ3Fjj0oIitNmIix1jgMDTh2AJgkGWufl4qzYYEH0Ahl5Dv
         Q6PcAxESb0StC6/Hz6npHFTKxLHjhUEhr33RStPxZXUe+iwHiNfwgQ5RFtTWKDyoemZZ
         /rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiB/9WTUgU4k/cf1D0blDI9YAXhtbx3zQedTzR+o/44=;
        b=X3rly3nib5HQOKhuUPqS4/FncqrjcfF2PLPn5Msdaoi+Jpm+Ho7GzDoNo8yMzsiG4m
         pw3QgANbRiUw6A1oUVFB1D5YfgiU0j/ytpqlEZadgolZGiolHBp099A7aGKzAgn1Z8qo
         iiX3EK0+lBc90+dJRjf4WPxyxHd9jZR2zbG6//tKFr3VZ1VNMjP3ZCIS8K0w8rlssmxU
         xRRT+gQs8dx1Fhdz3ZsnkaPkZPwYtfTu8QizLv5gNFXxRPzuegEGaF7B+uuv+IfoLDWt
         ogpJqD0DZOPiWYdWjrsTc2RxK3QOP9REyDvv0YfCdSo14FQ6GgDCNIXgNYmUvICKlm9k
         YXFw==
X-Gm-Message-State: AOAM533fXJPw88Jsa27t4GEt3Ch0ZpI1gwLzfQGyIWObMXr4Lk2B0tyw
        UyK0jaHI2al5OZz+0W94c61EEiB6ljiN6V4CTJQuPiNkqHA=
X-Google-Smtp-Source: ABdhPJwiXtXy2oACWVRlcBjf9y8PHvLNGqnrluOTNM7ptACjV1zVSZgM0Rd9w5rg3AWZmxqci4j6W1Ugz/T97lZlbXY=
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id
 v3-20020a170902b7c3b02900da76bc2aa9mr18484847plz.21.1607858802089; Sun, 13
 Dec 2020 03:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20201211211916.6259-1-semen.protsenko@linaro.org> <20201211211916.6259-2-semen.protsenko@linaro.org>
In-Reply-To: <20201211211916.6259-2-semen.protsenko@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Dec 2020 13:26:25 +0200
Message-ID: <CAHp75VeV2jdDYCqnsXEL_iQDwMdGf+chHg9CQ22OpoFsXuEZuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: drd: Avoid error when extcon is missing
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 5:22 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> If "port" node is missing in PHY controller node, dwc3_get_extcon()
> isn't able to find extcon device. This is perfectly fine in case when

devices

> "usb-role-switch" or OTG is used, but next misleading error message is
> printed in that case, from of_graph_get_remote_node():
>
>     OF: graph: no port node found in /phy@1234abcd
>
> Avoid printing that message by checking if port node exists in PHY node

if the port

> before calling of_graph_get_remote_node().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Changes in v3:
>   - Split patch into two patches: logic diff and style diff
>
>  drivers/usb/dwc3/drd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 3e1c1aacf002..312a4d060e80 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -463,7 +463,10 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>         }
>
>         np_phy = of_parse_phandle(dev->of_node, "phys", 0);
> -       np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +       if (of_graph_is_present(np_phy))
> +               np_conn = of_graph_get_remote_node(np_phy, -1, -1);
> +       else
> +               np_conn = NULL;
>
>         if (np_conn)
>                 edev = extcon_find_edev_by_node(np_conn);
> --
> 2.29.2
>


-- 
With Best Regards,
Andy Shevchenko
