Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB32819D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgJBRkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbgJBRj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:39:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01543C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:39:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w141so1999652oia.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp+ijFDMry/YfM3bsfdMuX5+VO1ZJC8qC7RSZxuxAQA=;
        b=s4cZ2Kb1gYyCmUkt5f1hPb7TmPF66FQYU6yIuBI0+JWital4kySGPB4DjnKx/WtAl7
         xY/o+k0HxKWC4gpace14zLRECeE75w7Ce3rvVjcLxaqzZt05HW0HQdFq/JTebUTH3JaB
         cEhIgMoijnqESClPu2krERbJJnCWp85t1oHdfd36CNegEIORZa4ElLn5Bp77Z7kLpT0D
         YVs36NFe4zWWSq6ugJVyJuFRT8dkZgp9nh5xBFD3PrxTq6YOgzG3zQ2o4KT9fIDyMmCx
         Y+N7QvE295N14fsCNJyiQIFUJ6tXAhfa9sCdmk66Jmp0BOczgsgBdAnHssN1E9u+rXr0
         9h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp+ijFDMry/YfM3bsfdMuX5+VO1ZJC8qC7RSZxuxAQA=;
        b=TfgIwM7miVvtnYt3Zej59xNwQozVF3+Up1vUZdRuFWD+cZPL+OVzZd+gkSI1TehgXt
         x7HMp9GD0MS5o/yRGPsni6MI3XLs7D/rcgNjDsMyDXYg7kCCzHNfaTV5YhBlj2t0d9Hm
         GFapICDPyzOWG4rB6gtq/O1J9xuCJISXa7uIcJa6P8IWKJbQ0iOLvJxfjy0oJGjUnCBw
         bj6gzzPQ/RuFB7l5u7ArcQjwm7TuY6AwH7GrEGp4WVR7kccO0T8BISfnX/KyQ27UFKMR
         huS8HcNzTdVBUr/Tz6u0TvwvOGXnKcY3c3/n698LDYwsBi8ZXYrzYeG8oqvIh6aDAR0w
         v0/w==
X-Gm-Message-State: AOAM531O8ahXHJgdZc0nOQeTdF/AfU1+jvV1HGA7F2az8E9afefVeMhz
        eMd0dxtC2Xz7K+Zz1Dh+OCMVZZfQlycRu1cIm4CQkA==
X-Google-Smtp-Source: ABdhPJxu17GvNUQlcDx+v0FLO7qmNEsKrj99gLGETVGgTp45jKL1FOSO3MY/x9+RMPKIsZ5Ao/uMalNQ+DYBK0+NTeM=
X-Received: by 2002:aca:750c:: with SMTP id q12mr1905895oic.154.1601660395383;
 Fri, 02 Oct 2020 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200909195640.3127341-1-robert.marko@sartura.hr> <20200909195640.3127341-2-robert.marko@sartura.hr>
In-Reply-To: <20200909195640.3127341-2-robert.marko@sartura.hr>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 2 Oct 2020 19:39:44 +0200
Message-ID: <CA+HBbNH6rBM6naA9iTAq2JO1tC9D81+7f-Q5XxhYVF-vYoo+oQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm: dts: qcom: ipq4019: add more labels
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:56 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> Lets add labels to more commonly used nodes for easier modification in board DTS files.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes since v1:
> * Drop include that does not exist
>
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 3d056aada8d1..7bf1da916f25 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -190,7 +190,7 @@ gcc: clock-controller@1800000 {
>                         reg = <0x1800000 0x60000>;
>                 };
>
> -               rng@22000 {
> +               prng: rng@22000 {
>                         compatible = "qcom,prng";
>                         reg = <0x22000 0x140>;
>                         clocks = <&gcc GCC_PRNG_AHB_CLK>;
> @@ -310,7 +310,7 @@ cryptobam: dma@8e04000 {
>                         status = "disabled";
>                 };
>
> -               crypto@8e3a000 {
> +               crypto: crypto@8e3a000 {
>                         compatible = "qcom,crypto-v5.1";
>                         reg = <0x08e3a000 0x6000>;
>                         clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
> @@ -396,7 +396,7 @@ blsp1_uart2: serial@78b0000 {
>                         dma-names = "rx", "tx";
>                 };
>
> -               watchdog@b017000 {
> +               watchdog: watchdog@b017000 {
>                         compatible = "qcom,kpss-wdt", "qcom,kpss-wdt-ipq4019";
>                         reg = <0xb017000 0x40>;
>                         clocks = <&sleep_clk>;
> --
> 2.26.2
>

Hi,
Is there an issue with the patch preventing the review?

Regards,
Robert
