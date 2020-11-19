Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10252B8ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgKSFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:18:14 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEFC0613D4;
        Wed, 18 Nov 2020 21:18:13 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so2297954qvb.6;
        Wed, 18 Nov 2020 21:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqZSptQt27MJXF+QZPVZ7r04kV7IR2mYe4GqqPa6IEE=;
        b=TKzahsrNBrqKjnKyDEivIbVJkMZS8RSwV+0GvMgueNjzBlMPDIaREBkYIDjwypWiT+
         QhlRvpGGsMXvrM09LdEh+CiAF2BU8+mUSRJP66L9xoi38ariG+czv6aPlQkvbWxDSo6e
         /vmLVCVISKYw4gUvl0iHqdP+g2ZKdrxDwlBvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqZSptQt27MJXF+QZPVZ7r04kV7IR2mYe4GqqPa6IEE=;
        b=LQRCaQA1YgHAlxj+D8A+EflT5FYN7gaTxSQWOJKNF/F1JykKwYSwi3GvthsH+Dg8HZ
         qeHU37+FoKrbSmpdKbufTgiKww363sXjkfkNxkFdVg5rEE/oNhfIRLeLFWJi/NmmoYbp
         wpHhaM2LZPtuwWlusW/dGbjVvv/ecgHAFN64Fvk0h1Ri/jIPNJdXtW40YuVihPJvQKXc
         gKuQAQSwyZDSncDbVOvAbERw84gJzHnNO5LwDzANFbJL9Ahpo02MvzqkH6+dbTGr4zTT
         wTYsB1kUrfj9aduNsaaFbLWdZ/wTndAFk32iyeFiVfMnpGdXynYbm+BTmatflCQgvtT6
         gxGQ==
X-Gm-Message-State: AOAM531dyWUMilw08aparqLTHyVDZSMf3b0uOcQZf2/w99Ufo04XZ7dn
        EqupkyLETPvEwZuco4Hf6rvrZ3PKOkTdPpp0vtnOTRr+X2AC2Q==
X-Google-Smtp-Source: ABdhPJw/SAZ1gn3TFv6uB9mAMXTyHDmcqQqrp9QINmtcapIeeLWmWk6j34yHR/RZuXmPgs7hMBWrUoKmp/tl4N3D2z8=
X-Received: by 2002:a0c:aed4:: with SMTP id n20mr9290736qvd.16.1605763093184;
 Wed, 18 Nov 2020 21:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20201022014731.2035438-1-andrew@aj.id.au> <20201022014731.2035438-7-andrew@aj.id.au>
In-Reply-To: <20201022014731.2035438-7-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Nov 2020 05:18:01 +0000
Message-ID: <CACPK8XeU866qVx4hdv4s9ZM99WoWDL9Ek+SBbOQMqTsxV+8Hdg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ARM: dts: tacoma: Add reserved memory for ramoops
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 01:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Reserve a 1.5MiB region of memory to record kmsg dumps, console and
> userspace message state into 16kiB ring-buffer slots. The sizing allows
> for up to 16 dumps to be captured and read out.
>
> Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index 09b561429579..04efabe70d9f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -34,6 +34,15 @@ flash_memory: region@b8000000 {
>
>                 /* 48MB region from the end of flash to start of vga memory */
>
> +               ramoops@bc000000 {
> +                       compatible = "ramoops";
> +                       reg = <0xbc000000 0x180000>; /* 16 * (3 * 0x8000) */
> +                       record-size = <0x8000>;
> +                       console-size = <0x8000>;
> +                       pmsg-size = <0x8000>;
> +                       max-reason = <3>; /* KMSG_DUMP_EMERG */
> +               };
> +
>                 /* VGA region is dictated by hardware strapping */
>                 vga_memory: region@bf000000 {
>                         no-map;
> --
> 2.25.1
>
