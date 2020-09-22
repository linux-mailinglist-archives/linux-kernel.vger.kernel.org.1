Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06256273ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIVG1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgIVG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:27:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:27:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so955427pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7TowK30MHMS9nYC+XkxH0dF6ELzDDi6Bf6QUmYP+8w=;
        b=nXvxuujivv1bAyJqzQYaVbtnDdcZ2irAAEdRTOIY2jtIBp5rm64u133GrkGEuc7jD7
         K+TP8bM/5xjR8RuWftjfR0Z8NvbfGyQ+bimR4AoeOLZTzDwYALPWa52wVAJAw4W1ljdo
         0kga3lwJjG92awyhM8grqOjaWxRS6U8ekcMWjN4Vvs1CayxKR8eiN8Qo+Zda9R6ZYn0N
         dZXOeaHTDXn8MsbUmr4vwwPvSK+PB3CSgd3QcN8stgL65hsx57pCQ5ul3Gqq7TDwvPkg
         2hkQ3yfbVM0XazBz0nb4DVBm4ry2gv80neHm6gxiV7w66Ja03/qzjgGHMi9qLQ5Sfsb6
         ThLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7TowK30MHMS9nYC+XkxH0dF6ELzDDi6Bf6QUmYP+8w=;
        b=RugUgL4ltreMff7uja/4FO3IX9Tf5Udb8TdhBwKExrlawHuK7h2N3Mcxj3o4qUYByN
         sVeW1QmcVObrGJYY/Fh0QmjCOf8vslb89r74dP+lKdz2LD1VtO0JJ1JMbn55kFGTFveu
         WuQ5wJneHe488Xdqnw7Ir+2J51/lHDuHWrysT2K9gvr9G0NP28DnSCM0g71q1Eqv7yKx
         Yv4DCcfqT6bFP9HJZEV5tTjKSiz2R3iDSgzUa5mA5bPOk7rKFMjidTFnJMqdFgK+4Gq/
         p23McXi9mPQS4REBLmxWYX2J/1yzWORqVZO1AY0BQQL3sNYpff5hbtIktaRZUjDD5Lnn
         6LDA==
X-Gm-Message-State: AOAM531T6hXnzNqGs5za46oe0ifepLl65JD+thg48qaQGeEvMgmvxXul
        6hYKuMYhG4ZtwfMROi7aRwtt
X-Google-Smtp-Source: ABdhPJw4WxAkECoLs+iqqM1A7c3B+8G+NkxPQbYPhcfo8G5yvV9GmpfkDn4Hemv7h4URaPC53Bzpdw==
X-Received: by 2002:a17:90a:72c7:: with SMTP id l7mr2605184pjk.19.1600756032255;
        Mon, 21 Sep 2020 23:27:12 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f207sm14587112pfa.54.2020.09.21.23.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:27:11 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:57:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/4] dt-bindings: arm: actions: Document Caninos
 Loucos Labrador
Message-ID: <20200922062701.GC29035@Mani-XPS-13-9360>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922024302.205062-3-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:43:00PM -0300, Matheus Castello wrote:
> Update the documentation to add the Caninos Loucos Labrador. Labrador
> project consists of the computer on module Core v2 based on the Actions
> Semi S500, computer on module Core v3 based on the Actions Semi S700
> and the Labrador base boards.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for v5.10!

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/arm/actions.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> index ace3fdaa8396..1cc66803ce2a 100644
> --- a/Documentation/devicetree/bindings/arm/actions.yaml
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -19,6 +19,11 @@ properties:
>                - allo,sparky # Allo.com Sparky
>                - cubietech,cubieboard6 # Cubietech CubieBoard6
>            - const: actions,s500
> +      - items:
> +          - enum:
> +              - caninos,labrador-base-m # Labrador Base Board M v1
> +          - const: caninos,labrador-v2  # Labrador Core v2
> +          - const: actions,s500
>        - items:
>            - enum:
>                - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
> @@ -26,6 +31,11 @@ properties:
>            - const: actions,s500
> 
>        # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - caninos,labrador-base-m2 # Labrador Base Board M v2
> +          - const: caninos,labrador-v3   # Labrador Core v3
> +          - const: actions,s700
>        - items:
>            - enum:
>                - cubietech,cubieboard7 # Cubietech CubieBoard7
> --
> 2.28.0
> 
