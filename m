Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359A29D90E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbgJ1Wnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389471AbgJ1WnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:43:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE403C0613CF;
        Wed, 28 Oct 2020 15:43:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i7so730627qti.6;
        Wed, 28 Oct 2020 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjGFPMz23GeVlRYE79yV94NhJ+KQ8xemp1yemHfgYCA=;
        b=f9aolMCoETy+r8HT4s3ma4ObPD5sntGlOcNjtkyBnJfoWL4TIHpS47ar38wzs+Unn5
         lmXlw3dDHAzsoGSvuqJ1e/1JEtBZ5dbzUSJc2w8ujNW4LnXiwLy1Ri9R0tHUuTFPX6j0
         i5noJ3zdd8nHt82DrHtCzFdUW4GlYBJJs0LEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjGFPMz23GeVlRYE79yV94NhJ+KQ8xemp1yemHfgYCA=;
        b=DAh8zS+yRAhTaeIEF7yp3W+yD0dm7YrOO7BBVCmY8fXp/Tk7w2KOPAfNp4xgK9Xzd6
         nRecNmbao5IPnqaTiiF2SkWSXuQ3r4yfbr58OFC+hYKxehCgWo+yq1c5AFHFy4l7kfab
         dlpmTTW4j7rJwk4rbOuYLE7b+wuWs6t6hmoZxzFhEcvmwCEBYqgi77+quS7Jib7BK++4
         CNb8FEOHPlI8MRWE8NPJITYOUncSZsRFTvVSiQANveUxtlxjThks7QyhoCCCvTPGqI+e
         3b/Ih+Vwvi+9OvU3ONIK9/m8EVVFQ38xEKPfKrMb4fAEZmS1/NSr+decLK0YfaW+JcJq
         eP1Q==
X-Gm-Message-State: AOAM5307is6P9gipmvDqMcpwN7eJ6AgnAfixm5LnslXyX4j4S9l+dF1i
        ena53E6VTr5JBVm++gMkLx3lXYqmut90+kuFTP33Qrh0k3ZT4Q==
X-Google-Smtp-Source: ABdhPJzh4xRpIRTmAWBzbR+sxgmkiQthr+b6gtWBimSB7/2L7ZAZVIQHzhpOjgAFO4+k9KA9abyW8Ww0SFRootb7al4=
X-Received: by 2002:ac8:5854:: with SMTP id h20mr5549863qth.176.1603862939691;
 Tue, 27 Oct 2020 22:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com> <20201027123722.2935-3-aladyshev22@gmail.com>
In-Reply-To: <20201027123722.2935-3-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 05:28:47 +0000
Message-ID: <CACPK8XdDZTYuOb-0QvpStAO0iZH+Si4t2f3sNjPjmPwLrGMc5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: amd-ethanolx: Enable devices for
 the iKVM functionality
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

On Tue, 27 Oct 2020 at 12:41, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Enable the USB 2.0 Virtual Hub Controller and
> the Video Engine with it's reserved memory region for the implementation
> of the iKVM functionality in the BMC.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 2a86bda8afd8..b93ed44eba0c 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -13,6 +13,21 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               video_engine_memory: jpegbuffer {
> +                       size = <0x02000000>;    /* 32M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +
>         aliases {
>                 serial0 = &uart1;
>                 serial4 = &uart5;
> @@ -220,5 +235,12 @@
>         };
>  };
>
> +&video {
> +       status = "okay";
> +       memory-region = <&video_engine_memory>;
> +};
>
> +&vhub {
> +       status = "okay";
> +};
>
> --
> 2.17.1
>
