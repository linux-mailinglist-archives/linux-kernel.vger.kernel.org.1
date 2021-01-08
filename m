Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B727E2EEABB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbhAHBLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbhAHBK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:10:59 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47CC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:10:18 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p72so2035867oop.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vPWesmvMsLvw4dlOrsM9fYAvPKjuGIxzCK5/0PnH9wQ=;
        b=JcBQeCEgkxYXTEDlrDxiD09AKcBMOH+pyyCsorb1Zt71qwRfBPrxwWB8+DwPu4paJW
         Wfwscoxfe3XMfqJ3CfouVFYjT9zYYM0uXUUrgBOj4CAa8pdwu+RfB3bjIAHwn25XDWge
         LRCDLGPqpARsuf44qctIQl5AsF0B8c9Wy22e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPWesmvMsLvw4dlOrsM9fYAvPKjuGIxzCK5/0PnH9wQ=;
        b=QE2Yah/fkn9YECnLHZ9//MQzm+IACTLG691DTItizjY8QzrWQ5aasgrlaP3TCdas6M
         La8cm9RyYUUphqjLVeiTqGGIzUzxnPcXM7HmbzS6ieH+Tj/Pf1faanJSH9HDAq3tCo6U
         ehMUvc9EMnv4B19bxn0MiMjWINnN39QKYbi/wi1v8YnC05mgB5JQwSCQndMpPt/PXPbm
         xwshi0juecLqY7roq0X7qQxCQRyWrAmDNYOaDhTAnl7hyfzhcqVwOsm4xjaVKve3SbUE
         gzvluqV1Wqt8nqOh1lYwW6goTwJVj1yJTc8nHOxaORJWCNH0gWlw30gZdmvMOvcjf3WX
         7rfA==
X-Gm-Message-State: AOAM530dcMtBwBjrPlO6XkmC2NQnoCuXWwQkHwGCh2E+Lcjv60N7vvQX
        g4EMfLAHFXU1Wm1+84U++705qQ==
X-Google-Smtp-Source: ABdhPJzJFOHbq8Zj2ylRfmY50jk7u1WcOhlVQB/FjOFXBVHuE2RVoexccJl7CFWx7qqnV1w9b6SgPg==
X-Received: by 2002:a4a:3791:: with SMTP id r139mr2823943oor.87.1610068217556;
        Thu, 07 Jan 2021 17:10:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm1489699ool.16.2021.01.07.17.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 17:10:16 -0800 (PST)
Subject: Re: [PATCH 5.10 00/20] 5.10.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210107143052.392839477@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21133ac9-92b5-1954-da31-cb2d4afb5217@linuxfoundation.org>
Date:   Thu, 7 Jan 2021 18:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210107143052.392839477@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 7:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.6 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Jan 2021 14:30:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
