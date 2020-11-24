Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9DB2C2977
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbgKXOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:25:52 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEEC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:50 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id u24so11144163vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0bYsVH3nX2+OrWeKV+IhWPNW7SxLL8wfGpVZs1WpC4=;
        b=EDgjj2+oAPA7Acji64+FmuVACR9K66q27TqlRkf8LTM2/hnbs4KTFVRq8v55KrYBdq
         vwI7SxLUYPVLhi2EjzKvEWfEO4V2ZpxHHYEpW4rVQeG2PXS3X/NDzXY0CZEVhSd1S0g5
         vpaeda9BQx3NJDhrFDGTuYRAu4BRmXHa1uSxzWBYyf3b0NErGFMiDgtSwy+SRNRrAJiK
         7El+PAryir76UjhHOYvMCell+95Nvgjz5c9sTd0qjSwsYIU17yTc7h/Pd3SxRRP3OZu/
         yhq5GTbzx8DkvOuotF9AIYMFo9rRH55YxSKW791CF7radC//clZc02ZJ41uvRV5n+5HL
         peTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0bYsVH3nX2+OrWeKV+IhWPNW7SxLL8wfGpVZs1WpC4=;
        b=QCFEvGHlw7BHRLWWLRbuNUEH8ZOTwYUhcjHEvONb7CikMg0IjkNRDrIjiBQL9BS031
         0swCPd0Rit+W3loyTsZSczz5xBUdjjFoI6vfcwHpFOF463bCYXvKfF6Y1tv80CUcf/+W
         RL8sS4wj5FNharH5KqH0/hMEL6X6XFmw+q+nkGZSdySsGONA/VowLPo/3UpoiBA5nPJw
         fVUxsmkTcELp2Lq+Jb8npABdAjfwljyx+hs0rSR3CtWuBsqEU9jTUO3p+TWtyJTD0n4e
         ThTPs1pW65NvYBEuvB5PYNeforra0yabYlbotGJP6RiZEKwZ3I4YLiiIAf27ilAKid1B
         qagQ==
X-Gm-Message-State: AOAM5323go41H8kBzLlN1XJpTdYfxjn90wc7Dus9rZqd956zYdTJmyc1
        0P+WiKz776/mspBGpsmOfQCrBhu1gZ1o/RNiB2KY3Q==
X-Google-Smtp-Source: ABdhPJzhZfHuOq5aKuFvvR01RfE3+t1reY1YiLArpVadOD1pJBErw+3edBrUDyCXjNqiRSg8zYmRuFcAc/c4n2DajhE=
X-Received: by 2002:a67:ce8e:: with SMTP id c14mr3917991vse.42.1606227949488;
 Tue, 24 Nov 2020 06:25:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com> <713f57f4a66fff9a50a8d93643a7987d6560becb.1605823502.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <713f57f4a66fff9a50a8d93643a7987d6560becb.1605823502.git.cristian.ciocaltea@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:12 +0100
Message-ID: <CAPDyKFrFp52NhNPtbOmoCRVVTMACcmAFNomJJM1whm8dCAP2hQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] dt-bindings: mmc: owl: Add compatible string for
 Actions Semi S500 SoC
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 00:56, Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Add a new compatible string corresponding to the MMC controller found
> in the S500 variant of the Actions Semi Owl SoCs family.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> index b6ab527087d5..b0d81ebe0f6e 100644
> --- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -17,7 +17,9 @@ properties:
>      oneOf:
>        - const: actions,owl-mmc
>        - items:
> -          - const: actions,s700-mmc
> +          - enum:
> +              - actions,s500-mmc
> +              - actions,s700-mmc
>            - const: actions,owl-mmc
>
>    reg:
> --
> 2.29.2
>
