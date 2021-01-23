Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03BC3011B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAWA2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbhAWA0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:26:16 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB23C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:25:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u17so14951193iow.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeANXYEp47UQauSo3t6GV3epCeZjD6BhbfzidfhadEA=;
        b=K4ZbzvR3xbcWTvj2cCSDJQS3Yb6YzAluguDRzLd127qef34qShEee12E5eTz6eBVHP
         VoSYr+AgWA+wUfbMuXHf2wJk3amO+kP315E1zYtIeCoh3wl4i3HuHiVvCqhAIubLu9S1
         PKH9At+LWZVDS72+upuc5SuVBJyCBC8DueVeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeANXYEp47UQauSo3t6GV3epCeZjD6BhbfzidfhadEA=;
        b=hlauWxkt0haNHooRBZAV6wbF8wDVKv6n+dvD8AgI7Yy1to7hQ4zJ8rg8TwqUk5LdZJ
         q37BRz8QzQTg6LD49rBx8zDrYs4Vzjd1U+dh/2wgFKSusTTA8erM/vwEvU4W6acpGyK7
         Lubals1bu/fZTKZUM8JaGkQFzFBhZjW++PIJOVPgWBLC/zceo8BsXZa85XSAy9wUzpdV
         W7FAJ3lFqylph3Cnjwr9ZUpn9SBek7xOrQnGECg/2dnPevbQb6wPpQTdfwqJjwjD/+Yy
         iB0qDgkRdp47Bt7FhFHGGV5bATI9ffCCc8rwChJmy76ZUdtSKYP4d6FmB+2K0FtrBBrH
         DJMg==
X-Gm-Message-State: AOAM533Un6k3EMEFE+GICKlNF5cU5OownwxnT5CU9uOgIoWtUVJSJA0a
        Bfk81GLnIXhA1oIg375iFoY9Jw==
X-Google-Smtp-Source: ABdhPJwvuLTZ5hVgekmct4qR3pr4YJG7inX7BHhAYHWqDMVUUufpb01dnzSqrG9f4wdarA6gHYDvnw==
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr341125ilq.291.1611361535582;
        Fri, 22 Jan 2021 16:25:35 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k9sm6581454iob.13.2021.01.22.16.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 16:25:35 -0800 (PST)
Subject: Re: [PATCH 4.4 00/31] 4.4.253-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210122135731.873346566@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ce5725f3-0301-dc42-4ca6-1bc7af710625@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 17:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122135731.873346566@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 7:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.253 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.253-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
