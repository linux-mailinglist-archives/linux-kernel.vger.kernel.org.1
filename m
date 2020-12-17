Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE72DD64C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgLQRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgLQRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:33:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19ADC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:32:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c7so29474436edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjsadC0SrvL7bfYGGmZtpCipLIKDSHj6M2hPm9pjfwY=;
        b=pMcQVkLKUWhaprhCG/UXYLaIKMmzRu4DQvDe8+jmuhj+0HVngx/EcqbByaFIE4UHO3
         2OW93xoso+ObXyUQB8aTFRcwR0v8J+X89D3hALp267cy5ErqO1r8OtL0Mo4p5bRCYHLO
         5DaerrSVLtqpecOuJoghu02mVfVTtAAtljqcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjsadC0SrvL7bfYGGmZtpCipLIKDSHj6M2hPm9pjfwY=;
        b=ACzL8QOVCbLyDyb2w+28WD7DJAXGDjMgzs/D8h1QeuGnjaPRpyMJiXwi/IuCxCLTZC
         hCRjZD0GDwJqiCb5CtBpQ32qAk5Z/qenyPeCKd8b5WQw1/Jqgu8rs/2peFxHW+bTXZha
         w3BhnhWulDhdv0bgy0GLPT5Dsc+vALMaBYeHECc/tiuo8/l8K2TUOHlC36whXqSiMHdJ
         DFNjLnWP2PQ6optmQ7nF/6kHO7krlmvnPGXpGmKDwbCX47i2m0KPCFRw6ZbvCo1F69r9
         jq/E2f9wYYMQAxLvAg5RHP60Y4jwDCdOdBhM4OLVmgY55U0ZjQ9BSGw2PLv9U/bSZ173
         hFLA==
X-Gm-Message-State: AOAM530OHkeY3tmIClBtdhsVYcOm0ZkrYvkHrTM3fKeHxd0P6emxLYFn
        wOQ7B4KnV3iuNjCxDEwWJvZ/MHBhTJ9/NpQBkMxjwA==
X-Google-Smtp-Source: ABdhPJwYpwYlQ4NdCgCt1hC6OM6uC7jWpVg5pJ2B+5S7M4oYSd2YkxyZO6gNjEMzAVoZf54t107jvSJ6lXXasFbvf5o=
X-Received: by 2002:a05:6402:2041:: with SMTP id bc1mr376539edb.369.1608226376626;
 Thu, 17 Dec 2020 09:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20201215235639.31516-1-adrien.grassein@gmail.com> <20201215235639.31516-3-adrien.grassein@gmail.com>
In-Reply-To: <20201215235639.31516-3-adrien.grassein@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 17 Dec 2020 23:02:44 +0530
Message-ID: <CAMty3ZAuej4+T9eBJDBqJF_t5Q5hXFb5dFNNsrOmqAoopEa-Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] regulator: pf8x00: add a doc for the module
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 5:27 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> pf8x00 module build was not documented.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/regulator/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 53fa84f4d1e1..9c6508e99fdd 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -828,6 +828,10 @@ config REGULATOR_PF8X00
>           Say y here to support the regulators found on the NXP
>           PF8100/PF8121A/PF8200 PMIC.
>
> +         Say M here if you want to support for the regulators found
> +         on the NXP PF8100/PF8121A/PF8200 PMIC. The module will be named
> +         "pf8x00-regulator".

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
