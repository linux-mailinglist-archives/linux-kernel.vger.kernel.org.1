Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0D2696F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgINUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:49:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45065 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgINUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:49:08 -0400
Received: by mail-io1-f68.google.com with SMTP id y74so1582511iof.12;
        Mon, 14 Sep 2020 13:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=324IWcSqtgH8IcpZs89vYu0Yda5zeL7Dvw7hvmrV6w8=;
        b=DayZ+sLgZm/VXggAguI4vdIe5vMXp1/EMWz0PFUDfm8orda+l39IRpo/4yciXV4bff
         WigdqtB6OEUUlNfUg8c7Z3jQ/wDk8lEmBJw721hS0RNsVyOuGWk33R/2nukMQ2ccThwQ
         OhB12QjhZ0fzzdThH/jsJ34oKQxtpEdStPMAVgaQ2wePqpnz5GNjoJDfdurWIu8dM0Pc
         H6Mh+kwz5BBrqqy3pycnS0+cohLzElWOSllekybaqYEqLkx4hX5vM01Em/56kc8arisU
         u3XqArQxSiZlR8s8SexLbcXEIv1jC5EHL446+6pyJlpkZKj7I20UDRHnGBg/Hwc8R4BB
         /bww==
X-Gm-Message-State: AOAM530vzkhM/BFApCGWIIuzLPjkXLf+ZjpjtTy6+fkbjpFz1S1c6fb1
        vsPZotVFm1NI/hoOwPcdPw==
X-Google-Smtp-Source: ABdhPJw3dG9R6uY1Hk2lyvK8UUg2e9cANhPTyhqEKEE1Z8Y1Yx9xPFKy234XgQJer9v3V+MrL73Qgw==
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr12756622iok.112.1600116547173;
        Mon, 14 Sep 2020 13:49:07 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k14sm6513960ioa.7.2020.09.14.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:49:06 -0700 (PDT)
Received: (nullmailer pid 220224 invoked by uid 1000);
        Mon, 14 Sep 2020 20:49:04 -0000
Date:   Mon, 14 Sep 2020 14:49:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: google,cros-ec: Add missing
 properties
Message-ID: <20200914204904.GA220139@bogus>
References: <20200903191407.12686-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903191407.12686-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 21:14:07 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (controller-data,
> wakeup-source) to partially fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos5250-snow.dt.yaml: embedded-controller@1e:
>     'keyboard-controller', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
>   arch/arm/boot/dts/exynos5800-peach-pi.dt.yaml: cros-ec@0:
>     'controller-data', 'i2c-tunnel', 'keyboard-controller' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add properties instead of using unevaluated
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied, thanks!
