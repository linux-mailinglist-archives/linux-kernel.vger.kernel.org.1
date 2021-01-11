Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E02F24B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404970AbhALAZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404177AbhAKXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:41:56 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7CC0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:41:16 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w124so466456oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DxYrBJpzsTdpCByMlubd+zVD3VF017W+hAmhZMV80Cc=;
        b=a0tSDinUzyGLUdtYVRMKC4u7GO14DYqrjuasJK/0xVI3QavqBnhBjgFbWKkcM63xcF
         BTxggTyb+ssXEWHFcJoS8IAFxOSYxn67ng5ZXiLdFB1QJ+bpTkJrBZnwJkNmBWjuSu91
         0fD54ruhsG/ynTkZ5ntl8COmatmZ4RXdttHbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DxYrBJpzsTdpCByMlubd+zVD3VF017W+hAmhZMV80Cc=;
        b=f1I71uVx8GKaVKYMtCUwRcLvdUs9N1ebwOhgNJXpmCcSXv7zt4vCpmF4evnLt/385r
         4vx0bRaaPMydOOjqx7/RJrc07MPl0cWkjrvzuONm2HXSnsfBgZ8xbFHk25TQN94ES58N
         RaWlXTe2ebwipzTZX3P3K9gA1c0PXNLi6xCjGhcnQYMOP5APMLJCX6lnX9JsAyjxHzDJ
         On4AD3F9mhwBb9ceKHvZahaIAJtJPnwZPxeuEsMjO3FG12InAo+B6RgqwkxMrXELROqJ
         G1MoPilvJoSrsimDnCc22rfuBmw6QwThfmgQH8ABO07LB4zbTa8WcMbnk/O5wPbM3Mtm
         jInA==
X-Gm-Message-State: AOAM533rdl8spjBRH+Hr6dHYKU1yj4Z27Bps+85BI3rUmFb60QMZrFmm
        HqvOuzUzbYcotaqdLB7YetHyNA==
X-Google-Smtp-Source: ABdhPJyRrXzc4mH6hqhnKZYXg0y1KFDAIPAvMPIRRSnaddNEqDgfNKpVTkQDWxUeC79c3a1NwhwXgg==
X-Received: by 2002:aca:474b:: with SMTP id u72mr759324oia.114.1610408475768;
        Mon, 11 Jan 2021 15:41:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 8sm294009oii.45.2021.01.11.15.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:41:15 -0800 (PST)
Subject: Re: [PATCH 4.4 00/38] 4.4.251-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210111130032.469630231@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9a2f41e9-6da8-fdd9-a0e0-d2c68900fe0e@linuxfoundation.org>
Date:   Mon, 11 Jan 2021 16:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111130032.469630231@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.251 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jan 2021 13:00:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.251-rc1.gz
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

