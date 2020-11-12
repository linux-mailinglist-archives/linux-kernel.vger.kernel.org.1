Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C592B0437
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgKLLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgKLLpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:45:05 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D2C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:45:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so4984956wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W4rTVHjbd+mpguywWNkSROq0hOpiSxqsmTDa7iGbWzE=;
        b=DNCauhmrLLDTzPZ+mQbVBE0eqe/PQovUWayd6SBm7RrhfibTuoWKWG0EWv3oHEhUwE
         FVgr/6Rrg3Y+NcpsqF5u0zlvXOlJ0VnIB6hCciiAebVa1zVaG9TenreCe0QjoQ3R0xRc
         IyACffreqtASl9MdO4+nLmgZbhDvXWrSZkkpOn8PHOU/uT6PUZEUJYQjr9WC/xzoku4z
         FxTjaOEnhNR08GW0xyrZY+uyTfDDOazCtoMMjR7a37auwVi9r6K1ySWeaOVQXQp/BRd3
         IzraqvYlBkxo+tGSBgxGDaAGnqm2Lfc/D6IIwxasUBraNQqG/YYxpJuXXwDB9ONdvMl2
         9/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W4rTVHjbd+mpguywWNkSROq0hOpiSxqsmTDa7iGbWzE=;
        b=Z5qgenoYlqqqq250cwWMkHmz+38psGOJAIuYIrhPaJTuBMIlwzwJkr/xrCDTfwKz1Y
         3gYBHwKlfG78QNB8YAwIfFCFDO3J9n5mPDA/25BuTJik/ec+W0/RK/28Xq6mOO+iha0b
         /k7l8RRrqZbJF98sCE4e5Y0Q/EnIJM5R26cMBzCPIZCx4xUlIzikISbyw781AGXGZxI5
         WyolfB6Q0XFHaM/4ze+tudBNMAZkL8qfEiGJ8yvfTKLGyKnwkI/ZbZy+4XaviY80PhcV
         0wjfXVxW3CYtPnPwg9ripWAePP1AuPKzIR8wv4yb8OQX+d7jNjdI02pHRyhWbVuIVSGD
         GmvA==
X-Gm-Message-State: AOAM532hinqhtZjA9mnW66E2UyFPsQ8ydcEcts/XbWiiBVxXKJugLcDP
        d5s+gm7unEDDuM64L/d2xyD4DVpTrmT/Jg==
X-Google-Smtp-Source: ABdhPJx6GWoJgz5qXJzSTiQQAr2TDZDRCT0AUD+HPdj5y/7wWse8oZFJ5ZN/sD6m25n3mlGvcJg0Ig==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr8822414wml.57.1605181503138;
        Thu, 12 Nov 2020 03:45:03 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id o184sm6215357wmo.37.2020.11.12.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:45:02 -0800 (PST)
Subject: Re: [PATCH v5 0/2] dt-bindings: timer: renesas: tmu: Document
 r8a774e1 and
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201110162014.3290109-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a70ced89-3e47-9211-e914-84e3fbae0583@linaro.org>
Date:   Thu, 12 Nov 2020 12:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110162014.3290109-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 17:20, Geert Uytterhoeven wrote:
> 	Hi Daniel, Thomas,
> 
> This patch series picks up missing Device Tree binding updates for the
> Renesas Timer Unit (TMU), and converts the bindings to json-schema.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (1):
>   dt-bindings: timer: renesas: tmu: Convert to json-schema
> 
> Marian-Cristian Rotariu (1):
>   dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
> 
>  .../devicetree/bindings/timer/renesas,tmu.txt | 49 ---------
>  .../bindings/timer/renesas,tmu.yaml           | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.yaml

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
