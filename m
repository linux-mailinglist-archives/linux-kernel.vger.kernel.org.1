Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4261FECA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgFRHkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 03:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgFRHkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:40:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B689C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:40:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so4907366wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s/8DkSI65X40wSJ2wJgW7rhkfE2WrLXMAQ1mczpC6zc=;
        b=wHpyRT6g48UW/2VXK4Vlqpp8IdBVoxvfm7hbnHoGqXqCjcWMt6OjnjC0rOX3gwVWts
         CLtUGBGE6vad+ibfxaicPD/sIMOJD68RzNyGnf+1r0JdWkXwXI9ont46uDWDYJAwEceO
         wlqNwz4FlUo1BipYuyqxlumxcHgPp/x2UVL9Rei+ttRe410xPlxd42rDurT/o7l/PtWi
         78hcrsBrTwGr8bON5Uu9RG8gAJXxac8Nasy8ACpAXSOobGFMWW+EqW42O3T0ctfYgGuK
         bOsPXyue9KhNA9HLKghAG1/VXSbLRz0MOxZPd0AllO8Veeup7EVzoYbJ9pJAC4q+mbN5
         ubaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s/8DkSI65X40wSJ2wJgW7rhkfE2WrLXMAQ1mczpC6zc=;
        b=KLW5N4/2axx7cIK1Yzjm47QH8QTCYxNypNq9saDm8acGo91RbuXmSjh2FVe7Q1jTA+
         gdwSWgim9m9FJJy2RnUd40pZeVA89SBRJ83bwpcNNuDurINDOnEynja+eo+hnMQ0P1Le
         gC8x4kLRRejs01wEk0xDo5T7+vESNVbAvh1Ag5pFRQLYyGBpBR/Ox9IXmVoxqPlbKmrQ
         m7xhG2vFcn/43A1MoMlHVjz7kjzd7ja/eh1ZGkiuwS35yRwhYd2WN7JUQbX3Avv9Up9Q
         YmeAZELwU09QKCi0WGCMbNrJAlLAgkhQ6Juaku4dPGr5IH2xksWI1OLYvsuOP6gY8vdq
         j4OQ==
X-Gm-Message-State: AOAM532eQi+RKG+u4IZPPnxZ+T7mbjVTKVlD/FPNCFzrQymBFY3bRUka
        /BvSI2RhUePBIsXK1BVqBMbLvQ==
X-Google-Smtp-Source: ABdhPJxwjDquDAcT4g/jpcs1pS9o3jDdghMMVIQd0ngpDgfkG3HO7xafJGF9xrjnE6lQmQDojILE2g==
X-Received: by 2002:adf:f083:: with SMTP id n3mr446448wro.297.1592466001358;
        Thu, 18 Jun 2020 00:40:01 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id w13sm2368365wrr.67.2020.06.18.00.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 00:40:00 -0700 (PDT)
Date:   Thu, 18 Jun 2020 08:39:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Robert Jones <rjones@gateworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: gateworks-gsc: add 16bit
 pre-scaled voltage mode
Message-ID: <20200618073959.GX2608702@dell>
References: <1591714640-10332-1-git-send-email-tharvey@gateworks.com>
 <1591714640-10332-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591714640-10332-2-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020, Tim Harvey wrote:

> add a 16-bit pre-scaled voltage mode to adc and clarify that existing
> pre-scaled mode is 24bit.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Fixed the grammar in the subject and commit message.

Patch applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> index 487a844..ceec33f 100644
> --- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -79,11 +79,12 @@ properties:
>              description: |
>                conversion mode:
>                  0 - temperature, in C*10
> -                1 - pre-scaled voltage value
> +                1 - pre-scaled 24-bit voltage value
>                  2 - scaled voltage based on an optional resistor divider
>                      and optional offset
> +                3 - pre-scaled 16-bit voltage value
>              $ref: /schemas/types.yaml#/definitions/uint32
> -            enum: [0, 1, 2]
> +            enum: [0, 1, 2, 3]
>  
>            gw,voltage-divider-ohms:
>              description: Values of resistors for divider on raw ADC input

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
