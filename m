Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519827C8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgI2MFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbgI2ME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:04:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E290C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:04:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so14598003ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuEHP21dhMBh5T4WXO9Xuu69AATfQ0zf7NJ5Z9eebL4=;
        b=wueAy6HOAcQyM2KhegOErfUpHxD3ely0mqmCcGRxYnv3LowQpHQRGXzC6yDv0wkNb0
         q/2L+bZxK2En+oYdP4J/VWWKl8wZrbIWNov3utIVNEkmeyiqR2Zfiu3/KysFtIrl9kHG
         NobTiJSZKFQ+c9ivq+xh2OC4JdKJnV69ciBMS8lZGV1csYb1uGJWIH2RWSMYKMw/sLVv
         fhBlEFeu6iO9KS+6RWx43LwE0GC59Su6pD6RHyNpeAoI2UzfHYyUc2mqv1GYjVVq+RW0
         rEGEy9sugD7TRBKcyGXGQHBwlHP0NrfzO/KYAH6NjJ+2XAQzINGCTrM5OgPtod+o4TPM
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuEHP21dhMBh5T4WXO9Xuu69AATfQ0zf7NJ5Z9eebL4=;
        b=PQbH+kfXRJFIZfmFkpeKouux6xX2rK/Tw18s4E+TdSnxs9zGk7U1Tkxza+SvWfLM4W
         P68d0w3bZjQwue9sa2EiEVvyM+XCyAsSpw5gFlrAD8XQj2etElwSqAsuWHlWecZkc4i1
         Shin7xqeGGC5hiqQbBaueTKRhkkBLx5f7DnZTSYKm7nKdytOm/lUgj6rXL1NLVINwln0
         u3VSYqtZgAHD6u1ranSa2j7aDMhgGbqAVs9NEzXX43eA5YvoLKGeam3Nuvs1y59wFa1x
         UkAFn4B9ZUEPN0+zSGWo6cPm5EceALWCLy06lvLEcGTXjP+KdE59iyHNP6M1SrM1aTXW
         fR1Q==
X-Gm-Message-State: AOAM533vROh+G+O99/qAOcaeLyEGHQopGAo5+05+QtNZJ2coUZO43KBo
        c+isu8kVCdDHUu6utbSoGl9UTl9KJP+G5xil3DmEaA==
X-Google-Smtp-Source: ABdhPJz7awWKdkxeqGhj84kwINNLUBgCSDG/lRgEu5OC3wXnNTaiMCnWTwxOEKPk82plp2jM6wXgrPtvn8DqUzUc2Vo=
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr3426532ejx.226.1601381096838;
 Tue, 29 Sep 2020 05:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200928184515.7345-1-krzk@kernel.org>
In-Reply-To: <20200928184515.7345-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:04:46 +0200
Message-ID: <CACRpkdZ9vbsFTsT4A+BH=8x++Uc4EujnMd9DTMvRfQ7QPnLU2w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,pfc: align example GPIO hog
 name with dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The convention for node names is to use hyphens, not underscores.
> dtschema expects GPIO hogs to end with 'hog' suffix.  Adjust the example
> DTS in the binding.  No changes to binding itself.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied!

Yours,
Linus Walleij
