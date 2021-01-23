Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE48B3011A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbhAWA0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbhAWAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:25:56 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C532C061794
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:25:16 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id n2so14856913iom.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1JpAbXIdZnIGbZh5iu9Xgupsp22YQrUOwwDi1AFRBMo=;
        b=iRvJePrveryp6OEeUTkdXcFE2zDGucfqDRr5rm1Joi25LKZx9v8SJoveppL8VFPN9R
         SErJGSb1f1CRDJD+cMqT8Zq02Y2/990WEm7jhCsHJuc+gEJzsFj0uJzNaGRS6a/VZond
         YkO8vrdvJhbBovVJXZ8P7KZ9Lb2vKFJjU9JZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JpAbXIdZnIGbZh5iu9Xgupsp22YQrUOwwDi1AFRBMo=;
        b=Dyjc/w0S3LItzUrYaTDa1/fWRctlubFwDIdaVzxcNnAqsBTk4tQLVfdXMTmrXu+Zxr
         PK0OlGkHiT1yI/tNHd4Jh8I0x06v1JOrJJNwsf8TOsZYMi3veNe4jwqfxNSW2fb6VnOu
         NjAet/mJLLGA22IFo8Lqx52qDhRQFJMUAuxEnhNYsKUG3P5o/pdD84joqUAhlpD07aXV
         x6vJgj+6Ct+kL33MHLhZcK2eoC4WWzMPrO+OlAF7xY3PPZ/ccrbWJUuK1aGNKp7Tg+G3
         M4XoNyQcgQ4XqeNa5Mt7syRfu7/XladOqsU+vY3/T7fZ0zl9Y23bS7mXlJlSRZF23B9e
         qPSg==
X-Gm-Message-State: AOAM532Tc0Jcy0ONIgmxYNkPl+XRjNRcOdt3EBbeAv6A18AnQYiEoygY
        JOnQ1P5cnS59k3OyNPAapshW0w==
X-Google-Smtp-Source: ABdhPJyJ29lLZcxnIKk01q2/trt29BjLOz92Gp8MgyTiyTH7t9hHHkbwI2IF1tu2KFRxkZvst57OMw==
X-Received: by 2002:a6b:d102:: with SMTP id l2mr1464370iob.186.1611361515861;
        Fri, 22 Jan 2021 16:25:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x64sm7493616ilk.47.2021.01.22.16.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 16:25:15 -0800 (PST)
Subject: Re: [PATCH 4.9 00/35] 4.9.253-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210122135732.357969201@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a1fb0af6-854c-bf60-0aa0-086c77ee232e@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 17:25:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122135732.357969201@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 7:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.253 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.253-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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

