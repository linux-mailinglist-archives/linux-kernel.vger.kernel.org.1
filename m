Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46CC2CFB4B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLEMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgLEK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:56:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD99C0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 02:56:01 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so9206257wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=taveVH9ruM4pGDLxyj9Mz8Y6qwlp51SkM+n4gyy1Uvo=;
        b=YJe6D1vY2cno1RcuykZjRCLNAOeQLzwyS0/TLJYPHbbZkXDu9fnmMr/8F0MKbe4B/y
         4IqUoj5KEkirA+5NqioYpa1P4XBHd6ayQxKCGewGiED4oWKcnzu8XZ8yL2GQyQ0Rly8c
         S+nGlMXe/Pt/2NHOslvBo7/GZ0Ca+aPdYm2VHCXClva4ruJZmUIOGE2nuyhd6RfCAGXK
         0BEvBkXrtXwkgXaTejaMjKC7YCclR8scmHmZnVZuAoheLdlpnKMx10LgeL6Bq5116P8g
         OVyh9bVXR6nQsSwuGTJDfidBJdMYiE3PXkrsMWPjGd7TKvKAtbLmukYDi3gLI9djU2rs
         HSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=taveVH9ruM4pGDLxyj9Mz8Y6qwlp51SkM+n4gyy1Uvo=;
        b=aUVbTa8SmZWk4zV1hPTcwiKWNQD/L3jZWzI5X3ZuU0THRprhnNp7dM+ORTO0BhLUNB
         wCVu93TX1+9Hbgy4id0dyS0tM1w+v04pgCQlpcf9FODgkZJSqBgX7ag0C3FesU3bjsmL
         RYCP+kvsfv0vGOcoD5RVeYMXnlmV8mM+fZ5goQiONffp8GHEhGLICYTy3GZ66Gi7c4lk
         qBnC20T4T2BEJs5mWvQJGnkkDMFsfXqp1rV8+A0MoXly6rtLy6koGR0lYs7bPPjwbRH4
         4ftFFm6heUIUI0HxtRsCRXqEKDFDeqZX64xxCUAxDKfE3Hw8QyncRsy+1hmTlCFDtSgW
         MVng==
X-Gm-Message-State: AOAM533Uim/PalKzNg4Mri5CbwtPOb4YkBugjyMjqRkSwUfThI5g6q6v
        NEKD9PSgfLGqFBPeIAg9vwZcPyScBiAr3g==
X-Google-Smtp-Source: ABdhPJwLuYZ95XCKn8SCQJ7+/Z/HWUX/5HK8D43WBN+zKykJcEYtEhrmT8rB+Y7I5/fM9XL1CwgjXA==
X-Received: by 2002:a1c:2288:: with SMTP id i130mr8885469wmi.78.1607165759561;
        Sat, 05 Dec 2020 02:55:59 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8165:c1cc:d736:b53f? ([2a01:e34:ed2f:f020:8165:c1cc:d736:b53f])
        by smtp.googlemail.com with ESMTPSA id b9sm1022674wmd.32.2020.12.05.02.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 02:55:58 -0800 (PST)
Subject: Re: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no
 clock available
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201204153643.129897-1-dinguyen@kernel.org>
 <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
 <5cd3bdf7-e514-267c-2243-d6f98f1b328a@kernel.org>
 <47497181-2776-5000-c514-7612e1a05f2c@linaro.org>
 <1caca7e5-1c2b-3333-53ea-73b980620b36@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <683b5765-1925-321a-20c7-74e24b04f22b@linaro.org>
Date:   Sat, 5 Dec 2020 11:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1caca7e5-1c2b-3333-53ea-73b980620b36@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2020 11:55, Dinh Nguyen wrote:
> Hi Daniel,
> 
> On 12/5/20 2:50 AM, Daniel Lezcano wrote:
>> On 04/12/2020 23:39, Dinh Nguyen wrote:
>>>
>>>
>>> On 12/4/20 2:00 PM, Daniel Lezcano wrote:
>>>> On 04/12/2020 16:36, Dinh Nguyen wrote:
>>>>> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added
>>>>> the
>>>>> support for the dw_apb_timer into the arm64 defconfig. However, for
>>>>> some
>>>>> platforms like the Intel Stratix10 and Agilex, the clock manager
>>>>> doesn't
>>>>> get loaded until after the timer driver get loaded. Thus, the driver
>>>>> hits
>>>>> the panic "No clock nor clock-frequency property for" because it
>>>>> cannot
>>>>> properly get the clock.
>>>>>
>>>>> This patch adds the error handling needed for the timer driver so that
>>>>> the kernel can continue booting instead of just hitting the panic.
>>>>>
>>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>>>
>>>> Did you have time to test the different combinations ?
>>>
>>> I did test both versions and did not see any difference between the two.
>>> On both versions, the kernel was able to continue to boot after trying
>>> to probe the timer driver.
>>
>> Great, thanks!
>>
> 
> I forgot to test this on ARM 32-bit system that actually uses one of
> these timers as a clocksource. The v2 patch would fail. The return of
> PTR_ERR(timer_clk) needs an IS_ERR(timer_clk) check.
> 
> I have sent a v3.
> 
> Sorry about that.

No problem, thanks for resending.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
