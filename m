Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A622D059A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLFPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 10:14:59 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DFC0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 07:14:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id e7so2016652ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewLQDP/8tzLVIjOAB6Z6yBX/hdvnuw9WqxClNkbxi5c=;
        b=ebMvmXZOn+SFPjj7tRKJ1Hg0BIRHg5+xookwP/W5cirHmg6iPhktYlp+2gAc/z1Igl
         MCoTL162aPOs/YSVqaV0dJrwuDgHM5bdjWcAIzUXlE6Pk+3LhVuueQ6wQwomppL7QwjO
         ROSha5rWv1unSTc2Pc5V1ZB98hP4dbvBbKEnXWxo71XL3t0qAzPPG6KuQuy7DBnql3Tb
         k7b2HPg1EQ1z5e44YOZl4aHSugKhI8bnOi4ndXsp8b6R3M/IaCS71yF6cRzAzsHm8ief
         25QVaE93St2D3e04vPrWiBVZlJskrseHCpXsx1k9oLI3L5QFsHtCKJPy3zrZmtY1ITS0
         4cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewLQDP/8tzLVIjOAB6Z6yBX/hdvnuw9WqxClNkbxi5c=;
        b=t0HwQNVqi2cKR+LzcxGMVR6pFATr97eVhloTLEKHux86kHHyee/FT7bU2J9Lrfvo0Y
         MIBPhPtexPHa/LwX6pM/1yCmttayuD1njka6DSt9C3IKlpUwYZ2cexXYO+fzdd0Rz9+f
         29HmissBqBX5yvCLiX/MO/wd/y/X4icSd0DNqE+5koDC65s1RqO9dpu3L1/7VkVJSP61
         ZLpT+jRLFNM/FhIdGmnmPGWfUkRXukaoPBo+0isOrdtvhyAzGjL6IevJR0VSpNDoTizQ
         9QmT/9w2KfqhtEqLqxYsDzNirxmJYVvz0pU0VI9JUNI4u4bzppx0pLU52Dll+z+bWaF7
         HiBQ==
X-Gm-Message-State: AOAM530v7cszlXswy0nRhMOWeNZtPHwfqUES6ZEUtQENokvQI5pR7SzI
        +pJK1d0WhBYWPmivTCK2uBLrKXAVMSbmDKl2FRpQUg==
X-Google-Smtp-Source: ABdhPJy7Rh18d+1pv9wJ41IJ+1/SLO4A2I29ybUTEusEbi5vnUDxLdouW9sCljOvQyHl/r6VEcE/XS780edAEcMoGYo=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr6851536ljr.104.1607267651173;
 Sun, 06 Dec 2020 07:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20201205053328.9535-1-digetx@gmail.com> <20201205053328.9535-2-digetx@gmail.com>
In-Reply-To: <20201205053328.9535-2-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 6 Dec 2020 16:13:59 +0100
Message-ID: <CACRpkdY+fLhUD4cpM7X96Z7XjtXBkoVDRN6pDBUk+PjrQjTxcA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: input: atmel_mxt_ts: Document
 atmel,wakeup-method and wake-GPIO
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 6:34 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> Some Atmel touchscreen controllers have a WAKE line that needs to be
> asserted low in order to wake up controller from a deep sleep. Document
> the wakeup methods and the wake-GPIO properties.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Looks really useful!

> +  atmel,wakeup-method:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The WAKE line is an active-low input that is used to wake up the touch
> +      controller from deep-sleep mode before communication with the controller
> +      could be started. This feature used to minimize current consumption
> +      when the controller is in deep sleep mode.
> +
> +      The WAKE pin can be connected in one of the following ways:
> +       1) left permanently low
> +       2) connected to the I2C-compatible SCL pin
> +       3) connected to a GPIO pin on the host
> +    enum:
> +      - 0 # ATMEL_MXT_WAKEUP_NONE
> +      - 1 # ATMEL_MXT_WAKEUP_I2C_SCL
> +      - 2 # ATMEL_MXT_WAKEUP_GPIO

So you can add:
minimum: 0
maximum: 2

I suppose?

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
