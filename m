Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C12F040B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAIWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAIWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:15:19 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BCBC0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:14:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 23so31721583lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuGxm3GFcBsNFb4VCYjv1V+efk01JzJKthlrfnQST3E=;
        b=bUPsrc89m8tMUAGi+l2QVNYeEH/XAGp8VALJgeDbfiWuE5UE4mJMJ74pbL+6B5lPaY
         PPvNNGMBkWYpZlxHYz2480aZPc8p168tngGCnarSiN2Fb7oZhGas6hcyXlxnVWycYBJv
         9R3BwGIz801vzLERNgcyn1L83FB7JWHH45BGMOU30x9tBFDOliYomSCX5cJFGiHo27XA
         hMI6s+B3GJN6HKBzmG9MTBoNrefM8ZWi5WS5Rs2in0ui2FlyypeTnvYU1Z9yY9qxoqN0
         6ITuUigNRrV/CS56Q/HJEnqEwhJ5IsEN/q5NlDyOgmUSplQ3rp2dAt7+Y2gtQcwTqqDf
         q6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuGxm3GFcBsNFb4VCYjv1V+efk01JzJKthlrfnQST3E=;
        b=E1+emYiuPPxTm3WWzCrW4hVRL3dg04bG2rXzkorL5BvJ0Ufydy+tSWdAdjLwdV8Oq7
         lAyaaaRGCDdDlAEvbIIMuYXre22Dt1VOkkSwNSgJmSBn80xRmJs4jrEMyZMFUvWgNM81
         hDx/rXSB2iRVT664FpH0dN9o/Gg7krTZ/hKlHac6/m6IjHoAq69l8B+l5S0V4QFTLeBF
         x30W1AjDI1Dsh+xAn90JnXg9dPf3qpVhtdjQQ8pQaKm8IS3+5tHjKW8pO7QuhYRJwP32
         HjsIXe/AIef11YGXUckD/DQkqtsfUdxmjPwFt/AdY2LefbhXJH1CwdlVEowbveX7VW7d
         jyLw==
X-Gm-Message-State: AOAM53369w2AT3gmsx/BGeTL9QbpFhDeiPLlXE9sdBXtK9jkBJd7d/3W
        9UeTuy/rB5reFfpD/znzGG+8l7r0mdTfF2KjAK9arA==
X-Google-Smtp-Source: ABdhPJw2WqwJduUqNY8DC7qF/2q+9O/eVsIl2egJyl9nuRFKtSZWNQDD5y2ipQevex7TLwS1jqOuJf0xiGv0JFXZy3U=
X-Received: by 2002:a2e:586:: with SMTP id 128mr4663265ljf.273.1610230477212;
 Sat, 09 Jan 2021 14:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20210109140204.151340-1-angelogioacchino.delregno@somainline.org> <20210109140204.151340-3-angelogioacchino.delregno@somainline.org>
In-Reply-To: <20210109140204.151340-3-angelogioacchino.delregno@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 23:14:26 +0100
Message-ID: <CACRpkdaB4ejWUzBpkYWtRC=_On0tw2H1=3beaVmnLkjncUzn_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: Add bindings for Awinic AW9523/AW9523B
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

thanks for your patch!

On Sat, Jan 9, 2021 at 3:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org> wrote:

> +#PIN CONFIGURATION NODES
> +patternProperties:
> +  '^.*$':
> +    if:
> +      type: object
> +    then:
> +      properties:
> +        pins:
> +          description:
> +            List of gpio pins affected by the properties specified in
> +            this subnode.
> +          items:
> +            pattern: "^gpio([0-9]|1[0-5])$"
> +          minItems: 1
> +          maxItems: 16
> +
> +        function:
> +          description:
> +            Specify the alternative function to be configured for the
> +            specified pins.
> +
> +          enum: [ gpio, pwm ]
> +
> +        bias-disable: true
> +        bias-pull-down: true
> +        bias-pull-up: true
> +        drive-open-drain: true
> +        drive-push-pull: true
> +        input-enable: true
> +        output-high: true
> +        output-low: true
> +
> +      required:
> +        - pins
> +        - function

Is it possible to just $ref /pinctrl/pincfg-node.yaml# for some of this?

Yours,
Linus Walleij
