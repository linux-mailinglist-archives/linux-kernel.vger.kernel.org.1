Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A241A2A2278
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKAX66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKAX66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:58:58 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE50C0617A6;
        Sun,  1 Nov 2020 15:58:57 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so8162581qtb.10;
        Sun, 01 Nov 2020 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0kRy+Nx/QnWYbnmGzwht3fo9mypVSfVLNNpjvfeF7Y=;
        b=brNJSku0bPKWosQMJXoWRGAomXJHS//QnKnot+pwva9tggddcof7eebITAxeSQqISR
         0shntSkFIew5/XuK/at+g071ttN0u3P5qb6hi9WbqpHd0NH8ZbFymxybJDYkZitbEodF
         b6d2g1d8MRMbKxo2Tnlnr4HmIfKWHriMjW+hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0kRy+Nx/QnWYbnmGzwht3fo9mypVSfVLNNpjvfeF7Y=;
        b=Va9Gw5fiBW7gWZwm8r+QAxMUvV/ASBmahocRkKvHqXWg7E92eJtCIX6pNjCExIInar
         xJgNHKXQAIDNfUHM+413oQ4JA/Y9XDn5kbbdI1dF5yd2LTJO/XDin3EMhqwNCc25fjFe
         dqLTe0ol/g8NGz0w/qr4AX4qG0EzeDW3jb2oqgzAsehiASbaxGrcu7qazbhUSYfyC7n2
         vKL7OvsWPzwM5JKMFqy8kWQM1A5PAtAslu4W5Xwy+xN96z7yWemrMLs1RRfUiU+9HQlf
         +YcWfda1+CcxLN4bOjOF0qJ2O4QhEvsiK58ZySpvUhD+oSVyTjjaw4gpwNLIU6oVOO3M
         O+uQ==
X-Gm-Message-State: AOAM5338Vj9kUof8NL3y3tuJra/3kQwXn4kLmrArWIMhXucshry7v905
        1WXVqm+S78oMPEM1tXS11idi30GwxQ2JeOahUXmV1Nuk2Nw=
X-Google-Smtp-Source: ABdhPJzQB5EPcYDgX2QkiYwah4UMZ5U4K0vEkbXYMHSrPooTsRW4trT5qeGhOH4iMIk8EMMTIgScxdMc83Ni2J3YO6k=
X-Received: by 2002:ac8:5854:: with SMTP id h20mr12022217qth.176.1604275137155;
 Sun, 01 Nov 2020 15:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20200813190431.3331026-1-vijaykhemka@fb.com>
In-Reply-To: <20200813190431.3331026-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Sun, 1 Nov 2020 23:58:44 +0000
Message-ID: <CACPK8Xe8cfQO2=+66_xE3gVWnqThWqPkhVuELpOowdaXORZCbw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: tiogapass: Remove vuart
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 at 19:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Removed vuart for facebook tiogapass platform as it uses uart2 and
> uart3 pin with aspeed uart routing feature.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index 2d44d9ad4e40..e6ad821a8635 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -82,11 +82,6 @@ &lpc_ctrl {
>         status = "okay";
>  };
>
> -&vuart {
> -       // VUART Host Console
> -       status = "okay";
> -};
> -
>  &uart1 {
>         // Host Console
>         status = "okay";
> --
> 2.24.1
>
