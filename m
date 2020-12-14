Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92C2DA351
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408353AbgLNWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438675AbgLNWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:21:45 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:21:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r9so18518943ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HF/WBwS/ZBNGWY2y0QipZP28Qi8JaINnoQSzLWyEN44=;
        b=Xx+6yk+Kqx70rK0zJ45aBlLi27a9912m1D2gs5ceH1rgsXeqNLrx11ITCSh+G0bdoi
         3n49UyA1Yi8YikYlzrEnADdYJbZY+5SJLNpgsk1FxJdo/U5TKB/6W3Cc5u/JU0FmPaAs
         OSHlMm+Iz945gpF+ZR6RFdktAMMliqG7ABP/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HF/WBwS/ZBNGWY2y0QipZP28Qi8JaINnoQSzLWyEN44=;
        b=o/PrMMF6Ri/F/Wj2uINTn1hYZEc8BH22jL4L/yXKtEQqCEMBDBcsVHgrmEthaB2glW
         kNXYWgL2Bulws88GmVwQyqm4fqsjt/uPWL/9qnXs1NPVnp/9wyIQ18UUjdjzkLFjXctz
         5VHbjTcqp3iBqUQ03/OTGhY38nF22pAgtwqYY0ifFDhKoQXqRrgWxor7z5lT+UB7gV0r
         O+6fPEWgmDLpWpEHfGqGvRx9T+AYwm0pdnEZ2Prl2u7p4I7rQ4tOO39zlr5XgUfjgIcD
         78bP1UrNp9rW1P5ZCnyW5zoGp52p2dRe3vUXnvO6SqdIzCDdSrpqI9kHB58SaxHjegYl
         NJog==
X-Gm-Message-State: AOAM532JAhNGLR/k1XA7Jsaxb0Cspam2oMkiGrCULQEDM+NnngfUUWVz
        4rT02bq3fCEqbm7+3I32j3nVJw==
X-Google-Smtp-Source: ABdhPJwVKtFAChZtYZivT1rexBYN9JQmkzjB1rb86rYrAmsaAEbl1bzAVHCFICxhbPwLZ1LvQW4iWw==
X-Received: by 2002:a05:6638:2:: with SMTP id z2mr35531327jao.2.1607984464494;
        Mon, 14 Dec 2020 14:21:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g6sm11979942ilc.85.2020.12.14.14.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:21:03 -0800 (PST)
Subject: Re: [PATCH 5.4 00/36] 5.4.84-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201214172543.302523401@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <425de779-55db-760e-314d-326e57d59035@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 15:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214172543.302523401@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 10:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.84 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Dec 2020 17:25:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

