Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED82CFB16
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 12:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgLELCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 06:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgLEKzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:55:43 -0500
Subject: Re: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no
 clock available
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607165702;
        bh=/B6Ul/TD0pyA/kagpFHQO4cwl5phYr6g0Xftl3a8dJY=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=QMqT5EtYeizyPOZF3woeqSuqpbUvdszeQONJF3NOZ5xhHblJj8GtHpjgAtSjsHSDO
         DqXzQjMY0MP6wAaOIykXkLl4TEuawlyR4rEJFeSb2TiCh8fevuxzn75yaVrV1KfWjU
         hqkzMIywVD9GwRh+8TgfsBMT7MeJa3ry8Ypz3hfzWpibvxZKGjLTKIa6d0uLZ6eFEK
         Tua1esjAdbziguQXrBaXW0Ao2GQdjX9j47vWj4nnCwCL7wJVq0QQ1XoRfzeyktaTKP
         XzPefyBZsQ14EMZEWzJDz1ivS1Nf8MG028TlETUEvZKP6f9whbeo2W5VsKl0sYWBrf
         /zpp9hhMZF87g==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201204153643.129897-1-dinguyen@kernel.org>
 <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
 <5cd3bdf7-e514-267c-2243-d6f98f1b328a@kernel.org>
 <47497181-2776-5000-c514-7612e1a05f2c@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <1caca7e5-1c2b-3333-53ea-73b980620b36@kernel.org>
Date:   Sat, 5 Dec 2020 04:55:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <47497181-2776-5000-c514-7612e1a05f2c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/5/20 2:50 AM, Daniel Lezcano wrote:
> On 04/12/2020 23:39, Dinh Nguyen wrote:
>>
>>
>> On 12/4/20 2:00 PM, Daniel Lezcano wrote:
>>> On 04/12/2020 16:36, Dinh Nguyen wrote:
>>>> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
>>>> support for the dw_apb_timer into the arm64 defconfig. However, for some
>>>> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
>>>> get loaded until after the timer driver get loaded. Thus, the driver
>>>> hits
>>>> the panic "No clock nor clock-frequency property for" because it cannot
>>>> properly get the clock.
>>>>
>>>> This patch adds the error handling needed for the timer driver so that
>>>> the kernel can continue booting instead of just hitting the panic.
>>>>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>>
>>> Did you have time to test the different combinations ?
>>
>> I did test both versions and did not see any difference between the two.
>> On both versions, the kernel was able to continue to boot after trying
>> to probe the timer driver.
> 
> Great, thanks!
> 

I forgot to test this on ARM 32-bit system that actually uses one of 
these timers as a clocksource. The v2 patch would fail. The return of 
PTR_ERR(timer_clk) needs an IS_ERR(timer_clk) check.

I have sent a v3.

Sorry about that.

Dinh
