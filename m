Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010A27F5AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgI3XHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbgI3XG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:06:58 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17549C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:06:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q21so3531907ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u8kk68jq1HQ3VEfmqtlvvatNWaRvmOdWcvJpkeSRa5s=;
        b=VsW6xiYSmK1t2NVArskem6LSjWsvY2T0UvhVsyLThKXIOmko48cmupYThDRVbepg7S
         fJfqNoEXczTRpqMeA41zTl/xOEKTr5IM+h/1zy8OeQVWIwBUv15k+5MhaNsM/b9Ulkqz
         0pT/q6KbRrA9uAoTqQYbefJu9Kj5ElssFg0EVD6lQZiQuruNTGHrkdmCcqvivUIY7Que
         4zRK4/MaYykCt8olJxm2aTMTR9P3TQ3KiGO4+v1TWmZlF5YxcC1SE+3jCx4bdW3pqIAq
         izTthn6tdDi2gOjHaLYhnnZPh4UUT6sRTvmH+Wsobw2V4pnkvwcMeI0+7ntEt/JHjeQl
         a34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u8kk68jq1HQ3VEfmqtlvvatNWaRvmOdWcvJpkeSRa5s=;
        b=bNJszdkQB6+tZNysaRVgDijdPCiHMdl01nksPxSnXUHpKr8tkUW+zhguGhUmrmTrms
         cLJ8hW5gPN4B7ek3i1iObzzPedOB2Rkly62Y9mX+p4u9POHSix9GwJuEj8Oa2XKjnwn6
         z08eT7H+wTfHC33czMQ2AVvf/5fYBNApijxReh9kRhGg0gP5u6xyFxn78ZQrGuG/cRiC
         w7lKZv161allHeMDqggMkyWFh1kByeuT5af+1JZVBIg6XO59sbJFsZF5HUFgCb0feAB8
         NmeFOl2ORI0uCv9pfyyQpGUrvA3oSVjzRMu5MSuZ8qgxTijVPlmZ+FrYmiyRNqWC97W0
         wX/g==
X-Gm-Message-State: AOAM532Sub16WpcUrCE6WjTzKIoRUpqCvDWWCGTHdmTIOa1HKmAAzI9d
        hcPD/0fP6+jybgsraBurhddw1MMavQZx3i4r
X-Google-Smtp-Source: ABdhPJyKxZXSJZHwRvONe0FVQWKpUkGFgaqv3MBGaQg4v4c7Xy8x4Hdi96VUMfV/tn6TvIt+150cGg==
X-Received: by 2002:a05:6830:1d1:: with SMTP id r17mr3101583ota.311.1601507217496;
        Wed, 30 Sep 2020 16:06:57 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id h14sm783171otl.0.2020.09.30.16.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 16:06:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: ti-sn65dsi86: Replace
 #pwm-cells
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20200930223532.77755-1-bjorn.andersson@linaro.org>
 <20200930223532.77755-2-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <7ff13ed2-5fe4-01b5-d1d7-0916f0630196@kali.org>
Date:   Wed, 30 Sep 2020 18:06:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930223532.77755-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/30/20 5:35 PM, Bjorn Andersson wrote:
> While the signal on GPIO4 to drive the backlight controller indeed is
> pulse width modulated its purpose is specifically to control the
> brightness of a backlight.
>
> Drop the #pwm-cells and instead expose a new property to configure the
> granularity of the backlight PWM signal.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> index f8622bd0f61e..e380218b4646 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> @@ -66,9 +66,12 @@ properties:
>        1-based to match the datasheet.  See ../../gpio/gpio.txt for more
>        information.
>  
> -  '#pwm-cells':
> -    const: 1
> -    description: See ../../pwm/pwm.yaml for description of the cell formats.
> +  ti,backlight-scale:
> +    description:
> +      The granularity of brightness for the PWM signal provided on GPIO4, if
> +      this property is specified.
> +    minimum: 0
> +    maximum: 65535
>  
>    ports:
>      type: object


Tested-By: Steev Klimaszewski <steev@kali.org>

