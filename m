Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E23429FC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJ3DsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgJ3Dr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:47:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D0C0613CF;
        Thu, 29 Oct 2020 20:47:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i21so3074852qka.12;
        Thu, 29 Oct 2020 20:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IV173zBqFl+Nd3q2klgfVNAcerg3fmVbHR0gIkMTLmQ=;
        b=jRHMIHN7cvodtRtpitWz1f5G94/VR65Hri+wxGanETse+Bq/fYMNmEcGIu4h6d8QIO
         d46EzUegUSyNUJxpCEEBzlpqGWxAwXPP9rpqiYVd5eDJgmVpfdXdX4MRPzHfOTvClHib
         D6O+IYm801uIXGf0zKtPqQSw13XeiwUnDBib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IV173zBqFl+Nd3q2klgfVNAcerg3fmVbHR0gIkMTLmQ=;
        b=R/X2ZOAQ5nK5vFP6/QLKiBWWditom7aIJ8nTV6X3ese8jq7J7gpgaTxxuH3CpMglLF
         nLpLyQiZNVUdNH4mObMJCUxjRLQxEeYRYNKn1mYS2SiAPUet9xyiCP6+FUh9NsL/358C
         VbkLW+tq02AlgfcvlESR6iY2LMZt0FgWEU1DAmr/3TzDX88Im5gD5uzTq44Ss+B7IRPO
         n6sTQTZ3YWcYphVeBaoxvcJ8hbPD7g5HPt9KNjdcLvzaNNbm3FbhH6Xl3sFe8rFgxPYm
         Ne3Y59qLvQckvtGhek4wsV2ANGVqVhzSmB0NUJCx1C5da1LKqb1ET0uzrB17TyVkS8F8
         GXbQ==
X-Gm-Message-State: AOAM531C6sOsD3PKgG5G9tGVwfbZ8+FopmluvaWh+oOmA5484SbLlqCx
        fNTUkV++TOrRquYmT5w+FDU5I2GGwq+HKPLvLSk=
X-Google-Smtp-Source: ABdhPJz8dFRcEhMlqq1wlKnf6IBKOhndQxJdT1pNedv0ylUO8Z0m31UekBTKZL0DBjBeNhb37UXzMHszpOp+nnkyREQ=
X-Received: by 2002:ae9:e90d:: with SMTP id x13mr436553qkf.66.1604029678730;
 Thu, 29 Oct 2020 20:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
In-Reply-To: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 30 Oct 2020 03:47:45 +0000
Message-ID: <CACPK8XcJ6oWkj04kb3cjNkYY4q48Vk2p7zitCDp1_Q8etjFb1w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed-g6: Fix HVI3C function-group in pinctrl dtsi
To:     Dylan Hung <dylan_hung@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 at 06:28, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
>
> The HVI3C shall be a group of I3C function, not an independent function.
> Correct the function name from "HVI3C" to "I3C".
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Fixes: f510f04c8c83 ("ARM: dts: aspeed: Add AST2600 pinmux nodes")

I have a few device tree fixes for 5.10 that I will include this in.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> index 7028e21bdd98..910eacc8ad3b 100644
> --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> @@ -208,12 +208,12 @@
>         };
>
>         pinctrl_hvi3c3_default: hvi3c3_default {
> -               function = "HVI3C3";
> +               function = "I3C3";
>                 groups = "HVI3C3";
>         };
>
>         pinctrl_hvi3c4_default: hvi3c4_default {
> -               function = "HVI3C4";
> +               function = "I3C4";
>                 groups = "HVI3C4";
>         };
>
> --
> 2.17.1
>
