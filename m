Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E83E29D38F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgJ1VpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJ1VpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:45:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB5C0613CF;
        Wed, 28 Oct 2020 14:45:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d19so377085vso.10;
        Wed, 28 Oct 2020 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiuLglo/RooNrUdsk62yJO/eKT8250r1cbAiCmJYYP4=;
        b=FSQtUdM1SZB5DSgqJi9I/A4oUEsT8il9S6lD++yoK3rwBrCJaJyuXiYEf81lk65OJK
         uEY/yzCXna56iQn4yBF+3/ZcLtudz+wIQjkpIeQvvbOn7+R3euHQc7IB13ilB7It7YFK
         LSC6kH5oyL4k6YEokuVUKs09EG40s5Hupp9xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiuLglo/RooNrUdsk62yJO/eKT8250r1cbAiCmJYYP4=;
        b=LnFSv5T4KLRJ8za3ANqqwqilPS2DXO8v/XO7RuJjj00ODFDn0Cx7q7kN4tbeMMwUrl
         9ELQBPuhvE5ZwqY1OaVUMy2FbZb2P8zjmIIuPLPgGvXWkigpBn7QdV5oHbL4l0uQFTs0
         yS7WwJySpTR8bF6BVEHWB3Zs7v08Ih0MwplN8h71g6hSNxW9ZPM8x0DK8d/UTleYCYgY
         DSKjC0ikhnJHV73wuNOmenPLSFutwy5nFjySJ+OWIcb/Gk70uoguLNnRUXY3vw2+Xjr2
         rydNCa5cqPa2qAZKphKkhf9lXQe0Xav7m8RpheHY98bQseY9zeW1lAdAYH68yxB++CDQ
         OHAw==
X-Gm-Message-State: AOAM530GPKNvvnA2dlEAIfsYUWclsgocVbgHm44vKHN4h1+p2Ndbp+7P
        q2WaTOrplvkkIsH54TSrPcf9OIhmcdDO60yTpFJnnDmvRFYKSMFE
X-Google-Smtp-Source: ABdhPJxs1lICeCbecmA7Kb6hunQLw5cZyDwwkGGe2Xl6vC36f+QScSgTyLD5IxOjvCFLsKmFQ9uRNniWvFV1WVzsS10=
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr6099105qvx.18.1603862769484;
 Tue, 27 Oct 2020 22:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com>
In-Reply-To: <20201027123722.2935-1-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 05:25:54 +0000
Message-ID: <CACPK8XcgKTEEfPL54Spd_AQTdJVm=xt+rqbteaYygLQw-GKRcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 at 12:38, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> changed to use v2 binding in the commit fa4c8ec6feaa
> ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> For the proper initialization of /dev/ipmi-kcs* devices
> KCS node variables also need to be changed to use v2 binding.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Fixes: 09f5f680707e ("ipmi: kcs: aspeed: Implement v2 bindings")
Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 60ba86f3e5bc..89ddc3847222 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -139,17 +139,17 @@
>
>  &kcs1 {
>         status = "okay";
> -       kcs_addr = <0x60>;
> +       aspeed,lpc-io-reg = <0x60>;
>  };
>
>  &kcs2 {
>         status = "okay";
> -       kcs_addr = <0x62>;
> +       aspeed,lpc-io-reg = <0x62>;
>  };
>
>  &kcs4 {
>         status = "okay";
> -       kcs_addr = <0x97DE>;
> +       aspeed,lpc-io-reg = <0x97DE>;
>  };
>
>  &lpc_snoop {
> --
> 2.17.1
>
