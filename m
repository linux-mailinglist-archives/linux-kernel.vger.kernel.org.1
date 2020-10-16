Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3F29037A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395489AbgJPKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395480AbgJPKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:48:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E7C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:48:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a7so2263299lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZlBunlcShoHfhB1fmbzAp/Jc2DcXlgRRI6F6yPhywro=;
        b=ORJjCKJ++XhGaD7eZCMNQolkXf2O1gu7eQtFAIlgE0eYXbmVTd6hN5wWN0zblDiRrM
         WQVneb2ymz1sCWfeOarU3TfU0KQEsn0rSz2fmsl/OFFgiq2+/Dgr/Nur0GboXDWZyixk
         rmVVZ4Aj4UZFxwwQot9QX69NeUJtIquHjV7HRmP2tp5TlWuRklvzCoQRyDQuIURI+AUv
         xsGiZJxm7wYQE5k1P7VfHHOITO5sGMXd/8Z4rUYTCkIbGvFvAFv6gpRMFW/Dkklt7LsC
         83/Vpyo8cYYfY1xNUivMkytjpieL9rHGJuTpJMM10v7Tgq8Unqc4letrgd8JS0QqNC30
         Ql1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZlBunlcShoHfhB1fmbzAp/Jc2DcXlgRRI6F6yPhywro=;
        b=P4PtaRKJRPL1Rc1Kga7Dcp7B/lS8GT6ZaoKXv3u+MDRgeVZEw0L7xvB2Z6rWTfBuoD
         TnXILwaFxQo7G8yvjlDY9AovX7JwVqyjxfLAHgppfkR4lAYEh0Z5xh36kVVckwkSqzWo
         lUiwWXyG0JcmeirbMIk7RiflbhIxuYbELqDv0iayQkNWA+r9+wn/MA0ECC38YJCSFA7O
         O6hDBQJ9xy26f7SNi2EcsNeqmr5oKO+eNvlMOSIxTIexFdgKAZFLJ6GSdlSTx1aFr/dj
         TcxoZth18IuF8sZ4NiPtktvmuuv0M9Lx5iWIPz/4HuRITOTvYbyeQoxJzi3rZMUA7EGd
         y2mg==
X-Gm-Message-State: AOAM530tmSwM3Z1b0v9IWEuCQixaRYgaGDSZ9hVBukGBSAUSD5y4uzL1
        wiL7+4aC6AtoXzVZhORon6R5nA==
X-Google-Smtp-Source: ABdhPJwYmqHAF50z96iUiLYikZRk6e1MI+eV5J4/QlAStNhj1AhyNRJET4r7BvlaxAUWZy8OtKmB1A==
X-Received: by 2002:a19:848e:: with SMTP id g136mr987714lfd.466.1602845293305;
        Fri, 16 Oct 2020 03:48:13 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id k21sm761042ljb.43.2020.10.16.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 03:48:12 -0700 (PDT)
Date:   Fri, 16 Oct 2020 12:48:12 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: media: renesas,vin: Add V3U support
Message-ID: <20201016104812.nxdqjznjj6fxidmu@oden.dyn.berto.se>
References: <20201016111158.17521-1-jacopo+renesas@jmondi.org>
 <20201016111158.17521-6-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016111158.17521-6-jacopo+renesas@jmondi.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your work.

On 2020-10-16 13:11:57 +0200, Jacopo Mondi wrote:
> Add compatible string definition for R-Car V3U.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> 
> This and the following patch are still under discussion as the
> proper support for the V3U VIN might require the implementation
> of a different driver.
> 
> I'm fine deferring it to when we'll have a more clear plan for V3U support.

I think it's best we defer it until we have a plan for how we are going 
to support it on the driver side.

> 
> v2:
> - Increase maxium value for the 'renesas,id' property to support
>   the V3U's 31 VIN instances
> 
> ---
>  Documentation/devicetree/bindings/media/renesas,vin.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,vin.yaml b/Documentation/devicetree/bindings/media/renesas,vin.yaml
> index ad2fe660364b..f7ac1fd3df25 100644
> --- a/Documentation/devicetree/bindings/media/renesas,vin.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,vin.yaml
> @@ -51,6 +51,7 @@ properties:
>                - renesas,vin-r8a77980 # R-Car V3H
>                - renesas,vin-r8a77990 # R-Car E3
>                - renesas,vin-r8a77995 # R-Car D3
> +              - renesas,vin-r8a779a0 # R-Car V3U
> 
>    reg:
>      maxItems: 1
> @@ -120,7 +121,7 @@ properties:
>      description: VIN channel number
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> -    maximum: 15
> +    maximum: 31
> 
>    ports:
>      type: object
> --
> 2.28.0
> 

-- 
Regards,
Niklas Söderlund
