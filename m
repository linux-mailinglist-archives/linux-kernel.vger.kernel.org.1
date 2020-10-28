Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A354F29D339
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgJ1Vl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgJ1Vlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1837C0613D1;
        Wed, 28 Oct 2020 14:41:52 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u62so1064165iod.8;
        Wed, 28 Oct 2020 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KYUIsk757yjfOxOTjonub4YNOxpUYnyLgvt2WlwCKA=;
        b=CAj6eWB0sS+KsIEA8xhTCYPe5pKspk9Ybsrx10g+8JQkR4ESP2zrbUkymyWAqsq/xs
         yp0cbkj/HY3yu/hbdX4Sbi7hBUS3W+lUF2jmV7VixEZ4x8skpPJoCA3dbKLvdbUHvdM7
         GZiHCfEh+1ocFVmHvVqBqL37mcGEqztbBVIG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KYUIsk757yjfOxOTjonub4YNOxpUYnyLgvt2WlwCKA=;
        b=MXTICkLPfqFjkb8yuGoQGug3wVNzBnA39BfluSHDMGKB7r48MEW5fHKK0q1O/xrtHS
         LuZj82Ph61QmZkYHQamobpztEGNNnEHb+FmXeZuboEd4BI+CTos2gekZpViNygBsx1Yn
         NyM1OW7p9K44j5/lXG5WFdYtwifXFn7b6IwmgIEGjWnUpp6pXcEhnJH6YjQzWG8Y2PDU
         xWxC+msRwSrct8fyCmj+AOIklZP+XwGSzwsZz0uBaq1gLMlCEpDQv/3qu0u5JH57XLv/
         IFTTNqRkpaQCTeNcR7iefaZvXxp89TSZQZCrnM0bprgpZxDjenA1lhV35X8SNDnMNmYa
         sskA==
X-Gm-Message-State: AOAM533Hy2AeOeSV8L8hwcnITlagSfs/Fl8Kuh1EHsC6+r2jUprdfKdX
        TseDO6I7vCmAk7ggr+4UbDXKxsM8aB0zZwZkiuCxVcm5H/abrw==
X-Google-Smtp-Source: ABdhPJxjYiVx/jlqIHQCiS7hEo1CokIeLOSw3uzWA56UCJv3gAepbfgYpwPTPl37ADtRKOhjzlpQ7YzLLsQdjIMDdXw=
X-Received: by 2002:a05:622a:d5:: with SMTP id p21mr67362qtw.363.1603862906529;
 Tue, 27 Oct 2020 22:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201027123722.2935-1-aladyshev22@gmail.com> <20201027123722.2935-2-aladyshev22@gmail.com>
In-Reply-To: <20201027123722.2935-2-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Oct 2020 05:28:13 +0000
Message-ID: <CACPK8XeaWbrWBKonxqW0Gu2AnB3mXBNXsEDmsEP_hzT1e8gX1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: amd-ethanolx: Enable KCS channel 3
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
> The KCS interface on the LPC channel 3 in the controller
> is used for the in-band BMC<->BIOS IPMI communication.
> 0xCA2 is a default host CPU LPC IO address for this
> interface.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

I don't have any docs on the platform so I'll wait for a review from
Supreeth before applying this one.

It's a correct use of the bindings:

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 89ddc3847222..2a86bda8afd8 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -147,6 +147,11 @@
>         aspeed,lpc-io-reg = <0x62>;
>  };
>
> +&kcs3 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xCA2>;
> +};
> +
>  &kcs4 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0x97DE>;
> --
> 2.17.1
>
