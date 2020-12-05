Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577132CFAB0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgLEIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLEIvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:51:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACAC0613D1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 00:50:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d3so7280877wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 00:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vb2IIcNQksGUIdFeEKWYgp00zdQiE0I3U6A7kCetlbY=;
        b=dSETSxK2SblqS9KuUDc7tRh2HZdmVcle6az6RAYR19kIfP5cKf1naJNwfYJBb4f7MM
         yLRTyiqZurzAYQgkVehiIA/vnowysqamThBKuyIRr/PDFVOUPMcIuXJ23MmMCUycMtUy
         LR4CM8T27FtlSrN/t8KmU8++Nmr2gchi1sRRn3goCguk3Dq1FEVPhQROAogRzwCG8Kdc
         FxxfLfPUiGXP8MhzzAyLaCKEOjBNK1akYALyiPLV0FCukfIXV4GXcYTeBf4bg0JRAx2O
         wjGOQNdkDNVg61wzeGLUgKYSegUUhMr3UVZMevgCfcgUT2aatUTw8/jQzvZej7yCm6Mu
         /IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vb2IIcNQksGUIdFeEKWYgp00zdQiE0I3U6A7kCetlbY=;
        b=GIbcs4Pgm9T8f3eNGUCwn5ijq1aX5qfKAAlkBMUegvp19Dcq8W9d4KM9gyBM+5ftYG
         RP+HE76ejhOgSM51mu9NI0ih1/WwikAGNB3EEnn1WYrsScR6NWQw1NLue6iLx7/M7OqG
         nLrb5wLTsGSJwW3CALD2NLWp0xc6rbr90agSZvrKaFi2AWciCnuAvDyfJAfQaqRm/7Ha
         GKF7rHwWQsQSUbCMUU6IVO7890cZBl6mQ8gU/e3q14ganq/ltvb2T8TRz4YIl705YniB
         hyeDOsofnu22rrqKWtc6hQgVmWSRW6kaevKx8QmeYRLJhquitk/RfZp7jV/P07yBFTW5
         a0wg==
X-Gm-Message-State: AOAM531MfkrMuuJ/2EsMRufX8SHb3wp0WZAiWNhNx1D/b4+Uwle101bE
        a6Bc073azNcXs/cLELDA51yJz8GFEmAKrQ==
X-Google-Smtp-Source: ABdhPJwYuKnqPWVqFi6cOWH68bt5dnyiVK5tqGDCRzcUefVs82psQJ03PLdHW89lsczwwmDrbLwU+Q==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr8410375wmb.87.1607158231455;
        Sat, 05 Dec 2020 00:50:31 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8165:c1cc:d736:b53f? ([2a01:e34:ed2f:f020:8165:c1cc:d736:b53f])
        by smtp.googlemail.com with ESMTPSA id r2sm5203108wrn.83.2020.12.05.00.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 00:50:30 -0800 (PST)
Subject: Re: [PATCHv2] clocksource: dw_apb_timer_of: add error handling if no
 clock available
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, arnd@arndb.de
References: <20201204153643.129897-1-dinguyen@kernel.org>
 <b24fb09b-62ab-4459-8154-c9bccd3e48fc@linaro.org>
 <5cd3bdf7-e514-267c-2243-d6f98f1b328a@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <47497181-2776-5000-c514-7612e1a05f2c@linaro.org>
Date:   Sat, 5 Dec 2020 09:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5cd3bdf7-e514-267c-2243-d6f98f1b328a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2020 23:39, Dinh Nguyen wrote:
> 
> 
> On 12/4/20 2:00 PM, Daniel Lezcano wrote:
>> On 04/12/2020 16:36, Dinh Nguyen wrote:
>>> commit ("b0fc70ce1f02 arm64: berlin: Select DW_APB_TIMER_OF") added the
>>> support for the dw_apb_timer into the arm64 defconfig. However, for some
>>> platforms like the Intel Stratix10 and Agilex, the clock manager doesn't
>>> get loaded until after the timer driver get loaded. Thus, the driver
>>> hits
>>> the panic "No clock nor clock-frequency property for" because it cannot
>>> properly get the clock.
>>>
>>> This patch adds the error handling needed for the timer driver so that
>>> the kernel can continue booting instead of just hitting the panic.
>>>
>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>
>> Did you have time to test the different combinations ?
> 
> I did test both versions and did not see any difference between the two.
> On both versions, the kernel was able to continue to boot after trying
> to probe the timer driver.

Great, thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
