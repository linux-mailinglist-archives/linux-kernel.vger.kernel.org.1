Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBD2FF6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbhAUVOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbhAUVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:13:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA2C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:13:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m25so4549313lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb+yS6a18O5VfaxpCUEMmL8LlEDI5AuUqrKys+aojR8=;
        b=ImbDU+3ZJgYqxPTG8HId64dX0M2hX5bGDe/oCBXQsayIVueCw7xXuhPmBIvLOxEpFA
         aYstTbpPrhXwGCVIW8NURQCMNm2QhmHwZ7shG6s6dK4zGeUTkJxh6hqn+/lecEERKyhO
         lWaOMV6eJWkaGyf7pktFflDmSH/lOZ0ggPiH2CjRzO2/UrlvGkiEenaAeDaXwO5K9Spe
         8BDrIr7QRqXz8zjm8/oMCItLO7EPg4Fjvq8rQQvZGA0ZtixgBkkjK4F5vRZVPnTAmQ1n
         dqnHB2oZYTZpPf6w6YMggP5QFApT1RxKqVVJjhnPTqtTitEb2Dkj+VJLT0tFrdbe6YBU
         i9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb+yS6a18O5VfaxpCUEMmL8LlEDI5AuUqrKys+aojR8=;
        b=kSiHzg/YyJoNXr/OOkRp+WLtH7PehCiDlKskEp0WFyyJlhaTO1DYeHC+PIpS91/jLk
         rdMtChDJZPCqANXi4PNRJ5dEFaFNqT3mV4inxMyFrD1YsXJFGrqluY9IGe2omHvZRhRw
         Q5ltOrIkTFqbH9sQO9KXolTLSRibNtmK2n1vhJJJUyD60DEkosi0tOn1kP7LKmMmYuix
         kiljGMaoQCkBObzKQs0WxvSvXO+v81lRxO4JMKJOq7UxhDEuHmsCCnBvwM47tLkhS6X8
         Lw4ihwvrIVQ+9qknYhrBHv0ThV08+zi5c4a1fDAIdCHpXKdJAeTYKBpl1yaEmlLcsR6s
         pfcw==
X-Gm-Message-State: AOAM530OOzHqHYtBkp9lDOM5kuKdjIMrRGDVMPNIbVDQfn80/zrKENPT
        JnOpVPdoyL+eWwVAIBI6De+fLJs58e5fOkwN2mFhQA==
X-Google-Smtp-Source: ABdhPJxE0BGrPkRiVaX0zLa3SLSvGCLEp6Q6sZSHqqiRB0ZRHWuYJfq4qpc6Jw+Ng/1SIvKD1iBwk12TaR8aIHYJXYs=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr564045lfe.29.1611263581282;
 Thu, 21 Jan 2021 13:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20210118020848.11721-1-andre.przywara@arm.com> <20210118020848.11721-4-andre.przywara@arm.com>
In-Reply-To: <20210118020848.11721-4-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 22:12:50 +0100
Message-ID: <CACRpkdZKmDjaz9Pg9s3P_ve68tNhumHHcUL0coT+dAnoct+Fww@mail.gmail.com>
Subject: Re: [PATCH v3 03/21] dt-bindings: pinctrl: Add Allwinner H616
 compatible strings
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 3:09 AM Andre Przywara <andre.przywara@arm.com> wrote:

> A new SoC, a new compatible string.
> Also we were too miserly with just allowing seven interrupt banks.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
