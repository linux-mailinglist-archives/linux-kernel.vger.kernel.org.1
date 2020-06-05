Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FD1F02C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgFEWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:13:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB42C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:13:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o7so8832987oti.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4KUZ4vRpKIe3qa77IAxpCMFQKithPWzH7hezTb7q7nk=;
        b=ZdOrQY7G3ajRdNewu9pCCMymN5/xTvu8X1N/jdjsU4beSpSLUHtWP70EnMyM7sbQLk
         VrpISQ0cIQoNcVXSSJGDMidlz5Fo9h4+wDqc8d6mFZMzrrnhbQY011QMNb/CTQsHQYsj
         KKkAp6bY/Dm3TZV/zpUv82C/5k3lpYGPD85og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KUZ4vRpKIe3qa77IAxpCMFQKithPWzH7hezTb7q7nk=;
        b=ijymUfV4sjyinPTnHq/n1yl++RmCcQGPT40EMxdlGRV1XMaxokf8TW6T8x6wwV56FM
         74j4Z8db7EBhy0MEx2DfbUWENcg+oDRQzSzLMXWjmABQhBY/8QN5i/z9amjQMaLYw8/9
         x9cJN+oSsYDxMJKOL1Y2+eHUraHggtUI77uCmHoflXaUXYOYBI/1xaz9/hwAjEbiz3bJ
         JWU1x7VlOYlukkq9VyoZlsjdb4k7gVVlcEi338iNwTdJngFOIOI0ddHtaFKsx9sAcBMN
         ofNE2JxAM1//IOggQCn+woRSDeA2HQgHD5kq3VJJjymz3vrid/P+QLB0R8W/xRPZyqzC
         RtOQ==
X-Gm-Message-State: AOAM531tKsqhC0aqv1xga0GMY8KBGSVRY+1h++VrhMg+3Ub2grRM+v6D
        Q4HCVWltgpHGG97ZjmXrX5YXDA==
X-Google-Smtp-Source: ABdhPJwLYIQM+XujncUEcDbtC5NuhnZCRaliaqneZj6TT8D5NezIxrWSFGtEXfep3uy+OGZV7MV0TQ==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr8677745oti.97.1591395193352;
        Fri, 05 Jun 2020 15:13:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q186sm948995oib.12.2020.06.05.15.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:13:12 -0700 (PDT)
Subject: Re: [PATCH 5.6 00/43] 5.6.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200605140152.493743366@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <54d45ae5-0354-a401-af46-d80f01cf450f@linuxfoundation.org>
Date:   Fri, 5 Jun 2020 16:13:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 8:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.17 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

