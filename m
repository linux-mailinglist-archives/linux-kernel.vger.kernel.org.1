Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C72AFCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgKLBgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgKKXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:34:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD9C0613D1;
        Wed, 11 Nov 2020 15:34:23 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so2697450qtq.12;
        Wed, 11 Nov 2020 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnLt8VXQwwM0iYUheRJOiNo0F+wh49CPTe2gDfhO7W8=;
        b=bSYQInO/99sJwYtrycfWh2p+Q1AZAdK+UIgIk/sTa62d96oToAujYSzo1mXEwXkD0x
         Or98pU873ZtbSXzDUetksAxIxA8zGSGCwDFCX0xOZXe4XlLkar/ov+O+MJUH0X/TYCwh
         TB+35Ly2xbXJ2r9425YbecqXgoDl2Saf2L13Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnLt8VXQwwM0iYUheRJOiNo0F+wh49CPTe2gDfhO7W8=;
        b=bubYkAQQ2cuOXidjk6GFArtXkONdraieirPbWXJaI0MifTIrbxhWckTpLnIVaHdEQ9
         srlj1bqKqfhJDU5KjcXSgZ4/Lo2gXva2Jrt3YAvddaTGD3LPLD8RBDqjN6v5y7NPwx4z
         gjAaY9UhmzazTZyiwZaFsqvyJRdVWXxtQSczdCKPIaeXG8Po2aX9VSBD/T9r5A1SqAeG
         ddY+5l4bp+hYv57patiudwlSgfWpUKaj4ztk41A2FspdNWznh9w/ENFGGHvBQ6e0amGH
         OuVhmsPrietcPp/CYIRVDYhcufICxpwR1bIvichY+Y5RGQ4doSElCnz6QCdVGax/TE3L
         Zy7g==
X-Gm-Message-State: AOAM530aSmsRNSr5RLy2B5c0anX4xrftg+eY4Rjx6f2YosZAIYD4eE3H
        SXp/lnF0GXJSnJoWwZI7FWLTEHc3nDjj7eoXJcw=
X-Google-Smtp-Source: ABdhPJwcjoyijjlf9fwP/sU1FX6AbUsAS3hkkdBB32/dHqXA3RyjccEybxC7rChDrlK0oiWb72YIjY8nc0FZJRARCAg=
X-Received: by 2002:ac8:5854:: with SMTP id h20mr25684587qth.176.1605137662938;
 Wed, 11 Nov 2020 15:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Nov 2020 23:34:10 +0000
Message-ID: <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series adds the initial version of device tree for Facebook
> Galaxy100 (AST2400) BMC.
>
> Patch #1 adds common dtsi to minimize duplicated device entries across
> Facebook Network AST2400 BMC device trees.
>
> Patch #2 simplfies Wedge40 device tree by using the common dtsi.
>
> Patch #3 simplfies Wedge100 device tree by using the common dtsi.
>
> Patch #4 adds the initial version of device tree for Facebook Galaxy100
> BMC.

Nice. They look good to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Is there another person familiar with the design you would like to
review before I merge?


>
> Tao Ren (4):
>   ARM: dts: aspeed: Common dtsi for Facebook AST2400 Network BMCs
>   ARM: dts: aspeed: wedge40: Use common dtsi
>   ARM: dts: aspeed: wedge100: Use common dtsi
>   ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-galaxy100.dts     |  57 +++++++++
>  .../boot/dts/aspeed-bmc-facebook-wedge100.dts | 120 +++---------------
>  .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 112 +---------------
>  .../dts/ast2400-facebook-netbmc-common.dtsi   | 117 +++++++++++++++++
>  5 files changed, 191 insertions(+), 216 deletions(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
>  create mode 100644 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
>
> --
> 2.17.1
>
