Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220742D2242
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgLHEsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLHEsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:48:35 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E59C061749;
        Mon,  7 Dec 2020 20:47:55 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so11198700qtp.7;
        Mon, 07 Dec 2020 20:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gr6ueobMh+vnmyt2bfamggoZ4Oj0RVzF8cBiEWbccuM=;
        b=M4ETzUHqiw2eaTNSI9rZ+u8o2w+3aoosIwYtTxO9c7WrK1T/cFwFlHnelv5cZm225K
         6U+jTJ9waGexRwSBEX/SQJJxuk01rr2tRrX1X1QuQewX8rmCfyf+lXLPKYi5xZd+GuMO
         vaBV8HlczfHnchnB7n7Ev4kqCJ5lC2UfCLj6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gr6ueobMh+vnmyt2bfamggoZ4Oj0RVzF8cBiEWbccuM=;
        b=VErcmIoF1i/r5aXw/XWPJBRFouIBcF6BmCEZKWdC5BCAazX8sm1TeC9fbu6RvQQZ1j
         THYHYwTh+GAoTruT1zxET/E0PnDhHtKbzqqcclan2ttGIzT6xFm7le6FHqbvwzPcL86R
         MjG9E0iQsFY8ZL9GFPd93sw97oxUJZSgV9jNOSssCrUt2KfvwY5b7mnQ/MaSmtljn/1S
         PBNA69viOPqJ3jLGGzIIKE58bm7Yx6TQMUE2Bsl+LrUR0QmvV3efNMZpHwt3gD2KONMl
         z0adz/XYZzf2iAGZNW4hzOuV595S8LE7p5AB4YY941Qs6u5/GFbU6IM+vCAdwjRCBjlS
         Vwgw==
X-Gm-Message-State: AOAM530oPg5prGzPybjkGqp0GZG0eM9EVvbv3Ulm42GD2zuA+LGiZ/Qy
        sZosQHlvboW5VUZw3GC/XkpKSJwsCTUDic8cmt4=
X-Google-Smtp-Source: ABdhPJyyLcbrhQrxezdnGCGZdOwsDBSb8fGGduYb0qreiYG4sPtDKFBaIlNbf3rbOUR87HODmd1ZbBjHuVrb2J3mZLo=
X-Received: by 2002:ac8:5cce:: with SMTP id s14mr27174884qta.135.1607402874438;
 Mon, 07 Dec 2020 20:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20201208012615.2717412-1-andrew@aj.id.au> <20201208012615.2717412-7-andrew@aj.id.au>
In-Reply-To: <20201208012615.2717412-7-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Dec 2020 04:47:41 +0000
Message-ID: <CACPK8Xfx8gtJWncrnyXyqBwzce4pyT21RbA4JzM7GSp_yPsNKA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] ARM: dts: rainier: Add eMMC clock phase compensation
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 01:26, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Determined by scope measurements at speed.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

... assuming the bindings get acked.


> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 21ae880c7530..ab8d37d49f30 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -186,6 +186,7 @@ &pinctrl_emmc_default {
>
>  &emmc {
>         status = "okay";
> +       clk-phase-mmc-hs200 = <180>, <180>;
>  };
>
>  &fsim0 {
> --
> 2.27.0
>
