Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4132CF6FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgLDWkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgLDWko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:40:44 -0500
Subject: Re: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no
 clock available
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607121604;
        bh=78eutLpRIYyU0w+LYeVPxyo5gblVQmXiOQPscu5QgCs=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=kN98AJbtu0FuHkCcO512uYbfjmO+BR62SeH5HoOS9g/3RVvEMnKrLiTwSZXlePSgP
         6815nLkPBQbjiPHfF2xJ7VSrmGX9QxF9e1YHZ0OelPKvMN6+ukkGET1Kc4dRYqcKHZ
         +MxTAv8EiOEkhxMHUaSS1gV8yx9xDw6/nXlULWgiAzuT4ytsSV6X2umjKkn5dWBLAD
         MSwagomHa/FOkhvKRdq0izSGRwITkhzYG1FJ5n42jTQFTYdhiFMLN0xOR5Z+4wzUcY
         DgoYxuKcMiCp6l/CgYtcSph9LXrs1dLlaeXQaHws1xBC1PHk3ncwAgIBJl4TXH3hj0
         VX8Abmj9jtFLA==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201204153643.129897-1-dinguyen@kernel.org>
 <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <5cd3bdf7-e514-267c-2243-d6f98f1b328a@kernel.org>
Date:   Fri, 4 Dec 2020 16:39:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/20 2:00 PM, Daniel Lezcano wrote:
> On 04/12/2020 16:36, Dinh Nguyen wrote:
>> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
>> support for the dw_apb_timer into the arm64 defconfig. However, for some
>> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
>> get loaded until after the timer driver get loaded. Thus, the driver hits
>> the panic "No clock nor clock-frequency property for" because it cannot
>> properly get the clock.
>>
>> This patch adds the error handling needed for the timer driver so that
>> the kernel can continue booting instead of just hitting the panic.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> Did you have time to test the different combinations ?

I did test both versions and did not see any difference between the two. 
On both versions, the kernel was able to continue to boot after trying 
to probe the timer driver.

Dinh
