Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23FD26248C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 03:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIIBjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 21:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIBjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:39:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E7C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 18:39:10 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so199413ilp.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RpI+kabku/kBmSZfv/GwdaKk4pSuDpGxO7Kupq3z6O8=;
        b=arcf6JgNlRxSY2u7fy4r8Y6NVhsqKd4/RGK3xxff8HJzKDbZWU3GXFzqlucbma9GOo
         CSQKNu+dqFwqN6C85jF3EdwwtFMfPzUedf913mSbLSJFV+kD1mwsIVZrQXC+2K5vhs2v
         K62zgiCwTzDc/Z1UcffOY4k127lDHU9W/c/fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpI+kabku/kBmSZfv/GwdaKk4pSuDpGxO7Kupq3z6O8=;
        b=F4TiU/M/Onhi8c8BekjNo93P3wnpslHEo8LEcwKipkVtvMo88+5IjR2soZdZhyQBTq
         4X3K7ZZJhvEL5+4JTMFMSvYRjuO5xaCL2ECTRmlgwMSgCcSJLxBBt1aJUyQAyvUmTElv
         A3SPljOocBrOHNy1b0RuOYjrRF6HdGanPsk7b8GDVuRju0Bk40zph8ShqksY8CB0KiTm
         GvKlzW9nkjsxUJ+Fn2I/hIHNYb3YCL9SMoBJ4LHVCx3MMqOOLbLfDyTTHnwBuYD3Ate0
         i8+OwjnncC5NgwQmfa6gXb3iC1o0/LwAodkZ9ghXUA/z6FzHtnX5q+hIACNkuYGDA5Qr
         yhZQ==
X-Gm-Message-State: AOAM533eslKkkx6pA/J9ioo+WZDOMq4zWqIlYFiPYTCKUwrBLbPnC1fx
        NPvwbu3KxCQ/g+2hYbF5IcQW5A==
X-Google-Smtp-Source: ABdhPJwS1SKCO/lf8DCNDa6C6ZzqeAjFSJVrxKcif+3Vd7ZAzt8kl+t41vCqkfaLO5lrMTkRNxe0bg==
X-Received: by 2002:a92:b503:: with SMTP id f3mr1613342ile.23.1599615549761;
        Tue, 08 Sep 2020 18:39:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i73sm493181ild.61.2020.09.08.18.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 18:39:09 -0700 (PDT)
Subject: Re: [PATCH 5.8 000/186] 5.8.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a2949ad4-fa8f-1944-7835-4cb5e4c4134e@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 19:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.8 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
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

