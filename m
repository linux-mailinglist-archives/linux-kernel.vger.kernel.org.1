Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181502D8382
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437777AbgLLAj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437765AbgLLAjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:39:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:38:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so15854111lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xr4FRvxtA+082XHCMW69w3j4ONIbhwKUNEnQE98L+nE=;
        b=jIKuh/XqBzXs5vsY4OZzFq3A0fVIz1CjKUZal6zi47c3DETqnAbL6ucxi6p6HtOsx+
         /cLbKEODEb0QiptPHMNFQTf+ChJYTq8DpEYimdnbQxcwuAqYvOAfpaoVrp9qGr4RniHn
         RjAaNk10uvX1fsKK15I9nm1LzuMkRK684iwCSZxJ0YZm4xcvh8vasLTAGduUf2fo6lfj
         XDAmw9UACslCicXyVQefY/mJ5u1FAZ0y6A/6fCJXtDlana8lm23i+VzYhTLhtVpKCU41
         l91kwz8ISQpbg+QCTX8sx98P1X8PjC9t0PmdALjWejSlwHqvGDMwR0EW17LtgwFPczLB
         5Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr4FRvxtA+082XHCMW69w3j4ONIbhwKUNEnQE98L+nE=;
        b=TJ7+3BBtlyXysHa4q1GyEI4aWBnpHOOCVaiLFNz0Ob1uOQX44i0Iib90LMF3yP8gsx
         ndREPhsRhIyrkH4pyw9ApZO/p90/kS4SPJ7GOO144nrrLoIeTDGl19x7BxPASBmOQKY1
         SqwpoU9aI5lkPUqHwm72XP9kRaXm1gUkzJJVotmZt+nZgxx2HuED+dcY0cHzkG/Pbvlm
         YCuKKVNZr/SBYetxDQe+PpXhU4upWKtMys6jGhXrOR6mFyEwjCvop20MOmcIDbqeZIwm
         aSyhvygMSKZVWFiip6WHfWFTfMSwzHNme4YJ8USnTmCtrRo5Sg7AQe5XZOP3JpVUypTY
         3/BQ==
X-Gm-Message-State: AOAM531kVIxZkeHOB/ucj0y6/rgEFv47yM2XT4fUrNAXu9D43WMO3H3d
        AehGD7Y6EzSWXe+gB7PCKOXACPRhE95xGWGWLePdwA==
X-Google-Smtp-Source: ABdhPJxkTfZYEwlJ7w/ureE1vTF+5HYVgP5WLYRNaI+OVPlnQ0rGVGWH/SskYk/6Tx0nEZl5fafywr8iMvSFsSE3038=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr5622421lfc.586.1607733515237;
 Fri, 11 Dec 2020 16:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201210135609.1372-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201210135609.1372-1-zhengyongjun3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Dec 2020 01:38:24 +0100
Message-ID: <CACRpkdbhm1D_5ziGsknzQwjtSi6fi6pdUXXAEYkt=iWogJ4AzA@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: simplify the return expression of cs5535_gpio_probe()
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 2:55 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Simplify the return expression.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Patch applied.

Yours,
Linus Walleij
