Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E542FA863
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436800AbhARSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436787AbhARSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:10:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:09:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v184so10335617wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mKnu4Yy0ogp9EfG9YlOvCv8Tt32pBE+moBbd1rQQFc4=;
        b=OaplsSuJ7GorOCYPZNe5DPX8TAZXmYteYZDBa6YS62Kg+zrYO2Xn6ySD8vsEYmoGCG
         x6xhP8cTgAmg3FhgffFCFomalu4OKGqArtZfv62G5RQBZTZOnKREQ+6LWSJG0sXFQgCO
         H1kHXluj9pS0MhMmbuJJWkYEJZRZYJ/6eLrSoC5taeIbwAst80uKwYjaClHeBgB1/jyy
         uwpCIM+OjalWmJ0Fq5NN+y24A2wS5k4/dPxS87gI/ctvOZi4IK/YBtL81YRBwVxuApI2
         hINLgujbtPeGaIYdaLfU+94mHtxcIvyAQ4qd8PGiNYLH4ShCORAcp1QOzUCZSoDL4/CS
         BvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mKnu4Yy0ogp9EfG9YlOvCv8Tt32pBE+moBbd1rQQFc4=;
        b=jEu2D9FmgI5fHJaB+NZEg23RbM2lg/M+Ki5WL4paaqsOmIeTFagG0LrPeJ0h6qVC4M
         GgNLY1EojMIuYOov2ChYDe7OE83iVYeEQM1VfoVlYidt6KAiKjYdBX1OpxmZdLM1b86W
         T+3sEIVIwKuf+LvyIs/UApYZWeN7QrcTUkxPegTtwGhqU7INzRa2jV3VYN1QK9/97KDH
         sFlckvo3KNbRkUDfbbitjEypWwSO6HvI6GGPAM2FR8lcBzNatM6qCln2As2+6vOuVCXg
         yxRNwmEzZWxJ3P+Ulzcixedq7sPu64KBOcUI3W0HYU6Ii+4oy+EQ3ALDz9+k3GTkIKZ5
         hgSw==
X-Gm-Message-State: AOAM532CmYpVuEiAev0/qHR87zHdQmtHOjU3IT02NvEkdw63bLY1lVFV
        OVV9PpInyB4gnRIuKrzzmq3Ddln5sLi77w==
X-Google-Smtp-Source: ABdhPJxebkVqMVQKgrO//bNnPR+mMA9bYV2CDqUfJUPEOcp6nAmWPboAQKoI0lqKm0WkNs5ootvLFA==
X-Received: by 2002:a1c:b78b:: with SMTP id h133mr525052wmf.151.1610993363227;
        Mon, 18 Jan 2021 10:09:23 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id b10sm259767wmj.2.2021.01.18.10.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:09:22 -0800 (PST)
Subject: Re: [PATCH v2 3/7] clocksource: Drop unused efm32 timer code
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210115155130.185010-1-u.kleine-koenig@pengutronix.de>
 <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1fcd0b4d-583c-4602-69e0-31ca13b788fc@linaro.org>
Date:   Mon, 18 Jan 2021 19:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115155130.185010-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2021 16:51, Uwe Kleine-König wrote:
> Support for this machine was just removed, so drop the now unused timer
> code, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

I've applied this patch in the clocksource tree.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
