Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268D4285E13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJGL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgJGL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:27:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E393C061755;
        Wed,  7 Oct 2020 04:27:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s4so2209693qkf.7;
        Wed, 07 Oct 2020 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHSgzvUJzj+APwFwvwmmcNiA4VcGl2fPcumULSWSX8E=;
        b=c/ECYqqttNUHkb/rdwaudk7Ge5bDGTkXWp+GuaXmR5nf2B1B7OR04YMDqmQQUcZrml
         kyC8FbP0vVlCgoIrJmAxt6crEpI+f4zYVvEiIGAAPzn1eGkoZ7ESi/YLMUFBRpPjv+Hu
         B+7EnimfWa4SIazl2fO5wUAkMWh4e2twcqfzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHSgzvUJzj+APwFwvwmmcNiA4VcGl2fPcumULSWSX8E=;
        b=WhxXCTabdvx0VCMB7iozbgO3326q/2Fjz3kX/TcjAm6mkISTkUQhcB5XQ9myP2xwdh
         jKvpLwm7JFwx7AKu4k5/I00vxDi4Up81JveU0rJDT0RRUSO/fsEGDly8IlzgDqYTLloC
         wMTsmEXKodus8W8sbyux180gRx5otGxyLjHj9n905iXnAvWRZ5Dhr+PXGEox+Ua04Ixq
         C/7zH+mbI10nzidKnkYP6GqFu5AXqLdHSm0PNdnwkJ757Tn+xMG8WngV4N7loz87Khd2
         pW0IvcjrjReuqe74D1Let4HaASv8dFSK1N9gQ0Bh8Rncdpsa0aQkcRbppkIZc4aeZs+w
         WrVQ==
X-Gm-Message-State: AOAM531rA/uiU1Ob42jI54FB0fjyFEWDZ+k2Ysic/9s3e777b2ObjRlV
        7+FBIjbO0+V+2ubXqq78/xbefIg3qu98K2QIq4g=
X-Google-Smtp-Source: ABdhPJygdE+BClw6ls4Og5yZ5qX4nBMePZyf8d4tQiZAmni7tHPrS48fCxUgkBF3nEu7mFLoy6cRw85nRlHoGhT68vU=
X-Received: by 2002:a37:2c06:: with SMTP id s6mr2271040qkh.55.1602070075400;
 Wed, 07 Oct 2020 04:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com> <20200930040823.26065-4-ryan_chen@aspeedtech.com>
In-Reply-To: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 11:27:43 +0000
Message-ID: <CACPK8XcmA49S4mJmkmoyTyJ=cWkgyXLrXC-mbWVSO0M_tZAZ1w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: add ehci uhci enable in evb dts
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Add EHCI UHCI enable build in aspeed-ast2600-evb.dts
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 89be13197780..2772796e215e 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -237,3 +237,11 @@
>  &fsim0 {
>         status = "okay";
>  };
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> --
> 2.17.1
>
