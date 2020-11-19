Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5A2B8AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgKSFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:17:46 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F8C0613D4;
        Wed, 18 Nov 2020 21:17:45 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so2297631qvb.6;
        Wed, 18 Nov 2020 21:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pS7KdQ8JkGLBhZmDEyT+dB0u8xhj5n1AeXL63Pha2Fo=;
        b=izmRNWMIYthZ/HU5FjfWgpUBzj4kR1JnWFFMkGF9fWC8m3Bry4y2YWkKQ9kTZ0JfNy
         x9a3amTxT60ls9Yh3gdyZ3rBj2ZWoanrxWybhglwkU01JtOK0XRXo6cqVATtUuUZrWym
         8OWum+pJbyXSqxZZ24YYML/AGcCmc3nAosQgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pS7KdQ8JkGLBhZmDEyT+dB0u8xhj5n1AeXL63Pha2Fo=;
        b=TiPV7L2wB05GL45CSb/46Ku4oeWJq7MZLNiqfVKGhEyXPku8pzpSGF3hmZK4RMSk2g
         PGHzB7PX3nKqOu5lMw+YSZxXwP/P844HLaxfZhbQ7RJt/q/QH6DoJ9GsAV/QVrURkdvd
         DHAsjyvZ7YJhTPBJO0zQluiCyJ7FwKfo8tIw1kQ4DCPDP3tNDYJzgVzccQ5olItJxjbY
         YSnL+7ZGIkjVMdKe6h7ojbGHLv4Dk7oFE8kAfTo66zhW+DODhcwePdrCU67trmwzNbTo
         7GP04J9w2pANoiLZw317dahy9GEOEB0VKkT0ZlR5OhzoyDQbYbmaoBpdGARSEGUQKzGx
         UmKA==
X-Gm-Message-State: AOAM530jMqE7r8ksHkRGpmyjxj6I7LhVf8PSOTowEzKrUr9C6hgPyNnb
        iAAyRVschwx8CwoDX7MQAuEeXAVV4Ph2TUZ8hYM=
X-Google-Smtp-Source: ABdhPJx5L4CA73TSB0ya3N3l8FjwQz/kudIn9JyskAAXeCrGCIE68jEVLG6uaVFZcwqsCyDdVssgOLVsAX8WYXEvCFQ=
X-Received: by 2002:a0c:c984:: with SMTP id b4mr9219438qvk.10.1605763064832;
 Wed, 18 Nov 2020 21:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20201022014731.2035438-1-andrew@aj.id.au> <20201022014731.2035438-6-andrew@aj.id.au>
In-Reply-To: <20201022014731.2035438-6-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Nov 2020 05:17:32 +0000
Message-ID: <CACPK8XfaF_ZzhL1mQxK5Rcpkq9UmBtas+MzxJvFTFC3Bm2UGuw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: rainier: Add reserved memory for ramoops
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
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 802027a3c43c..8431cf1b32e6 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -55,6 +55,15 @@ flash_memory: region@B8000000 {
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
