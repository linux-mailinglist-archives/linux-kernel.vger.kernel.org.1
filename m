Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86492BB1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgKTRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgKTRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:50:53 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F8FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:50:53 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id v8so4955525vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOtOZIdB1J63uMVqmafZXssnYnw/QhcY3B9kUUaTAQE=;
        b=V1Y5a3dYeL7JPuo75mNvRhJBHLwVWgvC9S8Ms49FQmNLUJlvKpEU+blayiNdldDUJ+
         wfDjYdxoQq2wFuX5+qp7waGd9RBvqUSW7X9FXoZj1aaG0typlIwmF9PXaW3zUNTkul5H
         vGAgtvZGd/AEjE25ldkEPQJMe81DAgH+szGds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOtOZIdB1J63uMVqmafZXssnYnw/QhcY3B9kUUaTAQE=;
        b=GdUS5DqMoRqIa6+nNiJBn9d1JaF6qM5hnZBKCBltvE8fOQGzsC6bh3Aq4c27k4bV/8
         ZhBZne1DDI4bXqCe112rwNF9Z2OfAcG8PwSk6n6GykxrbBG34AASJ+kb3wTNend25Dou
         GliQbURElAX8L1z6hvto6XUbMXVHUfDBzqfc0JtRUsK6QURjODWQueTZCHwFA+1QJyak
         pJ8Uqo5VxFK7L2bXtWQyCsLKVN2noeP54JMM3dSrdJDI6rcc4JcDGaWtiuEYeLmlpko9
         /BIRZYetGkZyJ6W+GpCvALOdtYq7O8+FaEWyHz5uyeXh6S+aoR5A9/2payF+JWE0zyUx
         WuUg==
X-Gm-Message-State: AOAM530lMns1xx8hKPy+Ak8u1mbfvIFNFcI+A5rKAKg6vY9uCfr9DEES
        Xv81mPfSpMrn76B4301ndxu2CsZNJzGHUA==
X-Google-Smtp-Source: ABdhPJztku4ba6oFNzFcF2rrgYLyM/Mp5ah2INEbY3OusPJCTAIuoCtS1NpvrJvom0pwNFBC40o1Ww==
X-Received: by 2002:a67:f243:: with SMTP id y3mr13783746vsm.56.1605894652211;
        Fri, 20 Nov 2020 09:50:52 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id m205sm476501vkm.9.2020.11.20.09.50.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:50:51 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id r14so5425068vsa.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:50:51 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr13264633vsa.34.1605894650734;
 Fri, 20 Nov 2020 09:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20201120074508.3236616-1-swboyd@chromium.org>
In-Reply-To: <20201120074508.3236616-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 09:50:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WhbAQMm4u9kj7ZrdxSRDX1dWxdopuMx7TGx+wafC1Rjg@mail.gmail.com>
Message-ID: <CAD=FV=WhbAQMm4u9kj7ZrdxSRDX1dWxdopuMx7TGx+wafC1Rjg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add prox sensor to LTE sku
 Lazor boards
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 19, 2020 at 11:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
> @@ -13,6 +13,14 @@ / {
>         compatible = "google,lazor-rev1-sku0", "google,lazor-rev2-sku0", "qcom,sc7180";
>  };
>
> +&ap_sar_sensor {
> +       status = "okay";
> +};
> +
> +&ap_sar_sensor_i2c {
> +       status = "okay";

Technically you don't need to mark the i2c bus as "okay" upstream
because it's already "okay" in "sc7180-trogdor.dtsi".  ...or perhaps
you should add a patch that changes that and makes us match
downstream.  ;-)
