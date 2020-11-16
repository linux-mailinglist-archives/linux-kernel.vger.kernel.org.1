Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B212B3FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKPJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgKPJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:31:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C74C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:31:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so22931555wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABaEAifreU6ill0fVccYX03AsnzCT9hxJKGOUgbxzeI=;
        b=O0HVs2oJrzXTuE+InncgRAz8NbTDSF93Z6fGiS1sdH40DH8UVT4PEO0VMjPyn8TyLL
         UBvaNYAHYCeLgNKMHyeRodwvoWfOd55GQy4CI6C8eqC1hlT2oGWO0+OrDzhUpf2niu0b
         YRAIFFlMURyfAEHxQCBuquvF/chjrafyXF5y1XwueRqRLnvF/Fm7vIMirZnX2DJPL0fH
         o9uRE4f9h1EGB+2kf1u+06YHktolk9icXdArkTlzdkf8AaLRJ92godCc/3eoBvfpuvPv
         AFwaI3jAGpnp0PsPxKmykJHmRrfMlrk1k9YT+4vheJUbn1pPd9oTcX10/mkEmc9sUt6q
         2PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABaEAifreU6ill0fVccYX03AsnzCT9hxJKGOUgbxzeI=;
        b=nivdY3qAvxIQXNezmQ0HSjBfomj+/8lQe3g/D/iu+ChYQz1HWHHLBmObFrreJaJO2Y
         XqLJQ5vP0R2S4ZooHLzq6kQzjHLgOH/j7Y2n4+x45oviSGF0ehczyE8TEZjNkKfVECf/
         SkSONSnVyzsGqvrxossfxDnPHLb/nAq8nuvlHxJP2GeiCvwn994bgUq0ltVgpMrdsoek
         ZxYep2h64cVsuqb+iXAT/SD7uaVr8E4la27mPVw6SilXCmRee8fpJBm6RBP8SDMinbks
         8SRCT/1txwLCDnLxte3iqF9kAu0w5xYEbVjIjarlmj+D2C6V5pbX5nvPdHE6Wnc7LzpM
         Hy2g==
X-Gm-Message-State: AOAM5322xNsQt6yLPy1ubmYbhD7kcB/B7hO49ye2W6iqBbwT302fTbzS
        QoOdKdc0XTzIb46iREIjAProZxkg4E1xqg==
X-Google-Smtp-Source: ABdhPJzwtiIYgFBNDHFnCilZC4CXmtssbJmayAX7j9tzX01VWZGCfdMNSZPcGwl2jImRa7SkJ+w0xA==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr14822474wmi.142.1605519089444;
        Mon, 16 Nov 2020 01:31:29 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:eda6:9373:9374:7214? ([2a01:e34:ed2f:f020:eda6:9373:9374:7214])
        by smtp.googlemail.com with ESMTPSA id n15sm22013041wrq.48.2020.11.16.01.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 01:31:28 -0800 (PST)
Subject: Re: [PATCH] thermal: amlogic: Add hwmon support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        glaroque@baylibre.com, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-kernel@vger.kernel.org
References: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <229d2ac2-cad7-ecea-71ec-ea2f9ff5e4c9@linaro.org>
Date:   Mon, 16 Nov 2020 10:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115190658.631578-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2020 20:06, Martin Blumenstingl wrote:
> Many monitoring tools read the CPU temperature using the hwmon
> interface. Expose the thermal sensors on Amlogic boards as hwmon
> devices.
> 
> Without this lm_sensors' "sensors" tool does not find any temperature
> sensors. Now it prints:
>   cpu_thermal-virtual-0
>   Adapter: Virtual device
>   temp1:        +44.7 C  (crit = +110.0 C)
> 
>   ddr_thermal-virtual-0
>   Adapter: Virtual device
>   temp1:        +45.9 C  (crit = +110.0 C)
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
