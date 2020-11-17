Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD22B7135
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgKQWFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgKQWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:05:18 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:05:18 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id h6so82480ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fAX4l1NEggT+f69oA2rkR848Cab+Z/pkOArOa5r33IE=;
        b=Fr2aXM43hN8fm+LrHigYlkA5GAlz2nh5b5NcmQw9NvxtyD7zWtH47n59cwD+yDKnNI
         baNAnolOKpOMFI7s09SyPJJFPKo88xbLj0c0ASPMGM+PdPt1O+rxfSBITioylg9xORoy
         8OmEA3BGdEeNEY15tPkwo7wLftlI/bPH2R1NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fAX4l1NEggT+f69oA2rkR848Cab+Z/pkOArOa5r33IE=;
        b=Fx+ygj8cm1lazHjMk6uoNXMryrE3jZQoU0Tpk+N1PGOQ1SmD5Up0Qhd25y8ZGQPlE2
         5n0jjexa2nmD/Io8P3txbhLwJVZa0yYoHMwV6WCH37xvsfzYuTSerM5nxa3kpk3D6fRG
         kIbO/L55JcFbdhSFSdBK6c3+Ztz17d8/QuPwcsrFyqYOSCIvAkaEdDClQ+l5vKcd0hNY
         bojQRFdJx6PeeFYUpEsbrPoVQRYYf/iaOGlEQtM/xt23VOi0U9S+ntZnleXIbdkAXzxh
         9/kXZI2jvgCWvKZslrH3QkaFho+9dA5KXP2VWs/j2AktlffA+CPX26hrGCQy43TDRCEY
         5yRw==
X-Gm-Message-State: AOAM530g3jQzo5+U8sB5ZOBRxqB6cadz8rkeYTCBNxeVW5iJKebUn3Qt
        vEcZ2D/oWJ584n6I10FmzZg4KQ==
X-Google-Smtp-Source: ABdhPJwgJ1SImbP0MYEpRKs3VHhCUhmN6jhWP9QQ67U8SSfqI1OWC8gp6Th1rcTeMfMeDzgZwGXOCQ==
X-Received: by 2002:a92:6f02:: with SMTP id k2mr14502350ilc.81.1605650717650;
        Tue, 17 Nov 2020 14:05:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u1sm14603868ili.55.2020.11.17.14.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:05:16 -0800 (PST)
Subject: Re: [PATCH 4.19 000/101] 4.19.158-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201117122113.128215851@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d85a5168-6f4d-352f-c272-b7d5435969b8@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 15:05:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201117122113.128215851@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 6:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.158 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
