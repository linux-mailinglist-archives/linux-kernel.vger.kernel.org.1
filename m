Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77724F2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgHXHPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHXHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:15:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:15:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h15so813318wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v2AcXNM/RwmQxoIUWLpETnAZjFM9cKvvsGDBzZ8s8tU=;
        b=yNkmQig7Z6xT5X9MFS2ygbAucqr3neSCdyX7P6DQ2az6ewTQQeQgeB/e5pC4hppIRe
         WFQWE0H2wMj3xdaHXYypan0M4OV9qUTKJZhjhMkpa1+1mE7qcmUXn4vXYH3TFDjDqXGv
         wDo2vjkXC1QsqX8xgGbUMsbPwJ0k52Vna4knmD5Fun5Hb7IFWWWHlMSThenpvwv1QbL4
         7SUiymFvbNLzdeg3fq/wu4MaQf2YTpm0cyw2/XTxK3InWOTiPFNWPDnRnLTTyuNn46cb
         xYnDzAD5LT+/eekOZlcyJTp1+qqCZp4Rnyfc1d5g6Po06pXMOy4OZpksYcJEukkohEPa
         Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2AcXNM/RwmQxoIUWLpETnAZjFM9cKvvsGDBzZ8s8tU=;
        b=bjigQfK85ckpoH22kvBSnaauOoYgn0L22oChFnTpSj+oQGjah3nfw4vnsTyiQHDrSA
         MK3pcIidLm7H/Hxoe6mDi0EJd4wvALsKzDHaOZrBev0338fgv5hBJTOm/WTaZXKo5GQy
         elm6jxtKpM0I2c04SEGzQH47tlZuHUPMZwDK5Abu51qM18/ae6yrFMtECFmCiP8S1+0y
         ZNdO4pFFA3enjAl8729TMqu1ZGJt18pJEpOwo/ticg45oaBBUWdEHQAhEm4W2ykj8dcv
         qmknD1lhkYOFpM5UR5oJxm8sDQhDjGBLkoK5yiSkGX8JY1SIYPbPe25axwYLZYhNtEGI
         DnHQ==
X-Gm-Message-State: AOAM53353mfU7i/WLEF7nH9QZq8/RHmbz6ywB7n5R31NOVOsUAdx05PB
        MHppqAvnGwrX/8iDkOfJH8mADg==
X-Google-Smtp-Source: ABdhPJxd/szKSLNN6/XQR5TVLz2m2UUS4oEY9/vGslB5tLxWopsB1oAiE1Qk1WuEOYT2R/QxKR9KMQ==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr4213992wrr.323.1598253310616;
        Mon, 24 Aug 2020 00:15:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id l1sm23522540wrb.12.2020.08.24.00.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 00:15:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] thermal: qcom-spmi-temp-alarm: Don't suppress
 negative temp
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Veera Vegivada <vvegivad@codeaurora.org>
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <de23e464-3789-02a2-b16e-eb1cd4e015d5@linaro.org>
Date:   Mon, 24 Aug 2020 09:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2020 18:52, Guru Das Srinagesh wrote:
> From: Veera Vegivada <vvegivad@codeaurora.org>
> 
> Currently driver is suppressing the negative temperature
> readings from the vadc. Consumers of the thermal zones need
> to read the negative temperature too. Don't suppress the
> readings.
> 
> Fixes: c610afaa21d3c6e ("thermal: Add QPNP PMIC temperature alarm driver")
> Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
