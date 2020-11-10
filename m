Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152262AD856
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgKJOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgKJOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:11:49 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE36C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:11:49 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v144so17665120lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpEnlnWHjDYLqMoNrHt/KysUsi09ROrhJWtHTDCWRGI=;
        b=BDkgs4woTqGqDFzLsQFt4eu4Kw92iGzSuCTQeQElSxv66BP10wEsrSFhEWFcyZ8k+1
         PY2O0/GuW4gT1FhsqFZJi3uxOBoAEcecE1Zua8LkaBKmPibKBYDWknfrRvfVCBmfE15S
         WHvzbxRGlltekn5L7pZkl/bAllYsZT+H9vsyI8xK8CTZujcKHBkTnRDmIdOUVT8QoiXK
         PjOG6C3zAZa4FamO6GIFICx+i4z8QX3Yia4XxDo5GyTR8msPcqbZWUG2rvPmTTAzgugE
         URxSZbvHY/vHKL/LjDwynre8bcWqE/RPy5l8pxFgc70rkWm08TN0LEKlQTfEiA64FeZ1
         PQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpEnlnWHjDYLqMoNrHt/KysUsi09ROrhJWtHTDCWRGI=;
        b=Jw2k7d4aVGVJ8vrbzDvRCA1Qb8i21XQ4cXG4sPXCzlAf213L1Ahp1oCzgJRYGv33wO
         KyIcRrzKXrer9xqqQ1jJHwmF3Z/v51o0QMTzgY9T6ONZAqQgapBFjJupULH6tYbQoedg
         DVfTFv+Qsw6iCXko89bWaUJHytATMTQ2Z3FudTTu1KnLIGbejrdulPh5GxQC05M6Ea52
         AgQ+UlEX0Na+VUV1vYpDhquAiqTWkc9EIpfU9GJ18Sv/E/hbF/i0JQC1wJmtVdiiKaK8
         nZKOA+0NMIkHpG2o00LzWCvkdoUNhDUKcZTqGPQZH/a3Fm7qINk1WGArvoy+djVzcWHF
         onPA==
X-Gm-Message-State: AOAM5326VirKyv7LI0RBoXtCcJTU9KKjnxMadyjKklATHe4AnymRHkvK
        pA+0nBK4Te16YFA9nQyRcubqYs0hUkSTqfDfbIJUBg==
X-Google-Smtp-Source: ABdhPJzvVokIIH3qqB2eJVY8gRVEaKtrnAHyEY9b7k7GNoTkcxcN1g1p9HGvhDxeQyifSTCtb1kd1CZTXmDi34FpIYM=
X-Received: by 2002:a19:5e0b:: with SMTP id s11mr6995400lfb.502.1605017507860;
 Tue, 10 Nov 2020 06:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20201106093118.965152-1-gregory.clement@bootlin.com>
In-Reply-To: <20201106093118.965152-1-gregory.clement@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 15:11:37 +0100
Message-ID: <CACRpkdYJHd47-vpuXjb8s0Y=Y=w+QaAMEK+=STqRFbESXJ8M-g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Extend pinctrl ocelot driver to support other SoCs
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:31 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> Ocelot SoC belongs to a larger family of SoCs which use the same
> interrupt controller with a few variation.
>
> This series of patches add support for Luton and Serval, they are all
> MIPS based.
>
> The first patches of the series also updates the binding documentation
> with the new compatible strings.

All 4 patches applied.

Please consider converting the device tree bindings to YAML
when/if you have time.

Yours,
Linus Walleij
