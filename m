Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA02BB8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgKTW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgKTW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:28:30 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2CEC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:28:30 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m9so11532865iox.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7iGa0qebswj4sujNd2QbQVjudQRKcskLDPM729iaJpA=;
        b=U/DAnXPrf7ZF+Dva80EZUZUDybVTawVhawOlKJfWpD9W3dcckUur5AymxqNauhbotf
         RUAIpTPywJOoIFEgnM8n+sHBELgyW2C4nrK+rD/6ppQXVQ8Cff4fI7BHoW9l3ZEWAqrh
         8MXU8kmTfkHg+8q/GS679m2NqP8ng43uVN7S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iGa0qebswj4sujNd2QbQVjudQRKcskLDPM729iaJpA=;
        b=meQK6dzTtNafFAVPNA/CBCBEVAxMlrrcFnjfI516/eowKGq6KNX3SZTWZKDHKAhrUp
         wdPfFVXKHniQ4sZhEnZkvRy/Z9ImjKOxDtup/xrjic2IUUBx2thphutjRILzC6JxNWYW
         1qlbPfi+3PAUwdpbcURiJRlHx54BZ58JqsflNXfsZ8/xHH3hKWbAwWf22jmhac4CDqGd
         d/FrsakMzT2uF1HqiNUx624jzO7tgZigtUNlq0Nqfgd2KmpMsbQRx/sx/IwN8A404nxs
         gtu16d/j0fTzJUyUKXa+GmLakTqMijlWGRX5q/0bPZw2WLqWrZlgAC9WtZtjm7rXivoo
         2xZw==
X-Gm-Message-State: AOAM532EOzdXL26zoBgs87qvC2WtPjT2EJmO5Z9c4kFiuzwOF8QzW1pn
        1m2IDPC6q7TDBmcCaWZSVzmJyw==
X-Google-Smtp-Source: ABdhPJwdaN0zSI6egpKTw8v6qoxa2/m9fefn8pNWWNWDM+igQcEPWg8KtDbHlYPh7gp90i56De3f1A==
X-Received: by 2002:a05:6638:3f1:: with SMTP id s17mr20364305jaq.102.1605911309666;
        Fri, 20 Nov 2020 14:28:29 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d5sm2149315ios.25.2020.11.20.14.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:28:29 -0800 (PST)
Subject: Re: [PATCH 5.4 00/17] 5.4.79-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201120104541.058449969@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <348c0e19-82a4-4ebb-8269-11409fdc2f54@linuxfoundation.org>
Date:   Fri, 20 Nov 2020 15:28:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201120104541.058449969@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 4:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.79 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.79-rc1.gz
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
