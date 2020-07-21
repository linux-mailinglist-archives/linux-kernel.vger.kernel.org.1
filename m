Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4122769D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGUDWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 23:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgGUDWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:22:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F4C0619D9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:22:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so11287728pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijZcvY+9HThogPQGU1zhNOmg7ddSlcdPOxTGsylYukU=;
        b=jYPX3N/CYwrP8xdNoZm6Jr5f6CFeNAOzox2cznLatSc6OzyK71rLS2Q01WaRr9xjWw
         EwjoYXhjMJGl88p2OYXPm0Y8GrymObK4q3Gr6KyQpSpctoA/7Pz+kGPUQRqh7DMbKbm1
         xRCj9BQnbsXzzoeJ7amj+1JJGbQXy9NWlFc+IZ1N8aPvU7v0jcG/yvTmBLvVaoYMn+Vs
         OTZa5qdb9I06AvZg1of6xQzxglhtCqYrU6lupDFQh7DRm5dr17cb0rv0RNJgjw8OOexG
         MTU2rlNhDi+qC/Si0jn6sbgB75I26/HWknjIVwFgUnc2OBePW4wx3JVfQgpg4O2EvPOo
         o8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijZcvY+9HThogPQGU1zhNOmg7ddSlcdPOxTGsylYukU=;
        b=ASxrBhAFDqJRRLDr8cyKtbMQDXaGXG6LhS8ZRAxvFZFYkT30lyqlJxh3hKEzrZs6mq
         56OX1fwhGFUb8Msbh5vjkvp156pjt464RF0lCWQpCNbQtPDu8zFlTKbbQT3zEv5MSh3s
         d9HX196Gdo1SEUeUHGGWdc3o8cs/yO604iCTQ45CNoR2d0qGuy6kPdWCxKPJpz13HlZB
         93ReibBO/LwVUJEXhEBkbYPpmFs3cvKUet40P/oe0AFa9HeDnf1Ktu/IbADHlHcPnSBe
         93bvzkLxAFJOMoJZzzY4/Yh2AEiRTEs5o42D6pPX6agbev6VVBJMuMHNr1KuEHg6rC+T
         7NLg==
X-Gm-Message-State: AOAM533CRgGchH9tXQRtCUdbJx07SEV3JdemMwCBDDqR+38PazXmawvJ
        b4prh6ELl9RM1pfTfwZ5gnaKRw==
X-Google-Smtp-Source: ABdhPJx61jmy8+lIZewjXQ+YePZ0gDxMGB+c3iKHDGI3JWW31i4NNS2itBhvkd+VWS/UiHU4wWEQKw==
X-Received: by 2002:a65:408b:: with SMTP id t11mr20670837pgp.407.1595301721432;
        Mon, 20 Jul 2020 20:22:01 -0700 (PDT)
Received: from localhost ([223.179.133.67])
        by smtp.gmail.com with ESMTPSA id t1sm16787715pgq.66.2020.07.20.20.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 20:22:00 -0700 (PDT)
Date:   Tue, 21 Jul 2020 08:51:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, daniel.lezcano@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Talel Shenhar <talel@amazon.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: thermal: Get rid of thermal.txt and
 replace references
Message-ID: <20200721032149.prgxcmwjxonml4u6@vireshk-mac-ubuntu>
References: <e9aacd33071a00568b67e110fa3bcc4d86d3e1e4.1595245166.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9aacd33071a00568b67e110fa3bcc4d86d3e1e4.1595245166.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 17:23, Amit Kucheria wrote:
> Now that we have yaml bindings for the thermal subsystem, get rid of the
> old bindings (thermal.txt).
> 
> Replace all references to thermal.txt in the Documentation with a link
> to the appropriate YAML bindings using the following search and replace
> pattern:
>  - If the reference is specific to the thermal-sensor-cells property,
>  replace with a pointer to thermal-sensor.yaml
>  - If the reference is to the cooling-cells property, replace with a
>  pointer to thermal-cooling-devices.yaml
>  - If the reference is generic thermal bindings, replace with a
>  reference to thermal*.yaml.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> Changes since v1:
>  - Rebase onto v.5.8-rc6 to make it apply again
>  - Fix cpufreq/nvidia,tegra20-cpufreq.txt
>  - Fix bindings/arm/freescale/fsl,scu.txt
> 
> 
>  .../bindings/cpufreq/cpufreq-dt.txt           |   3 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt     |   4 +-
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        |   2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
