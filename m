Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AED2C1A19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgKXAcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgKXAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:32:10 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:32:10 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id r17so5742103ilo.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9QNZdMH/PA/pHLZjUKOEtHevUVMx4kRepNcO/cQUXhQ=;
        b=dC7wwsHNtSDev28owu/2qGWi0qbPfBTq/MOGpMRMcG2AKSME+jwKn+xsopuiDLsHu8
         NGQVouczYF4EVujpdBvlFMGwBgDxOoD9KxH2msv8W3KNV+taIrY1ADU6VVlVYbe+/0UA
         LL2+toKC1BphKy0rgxfKOBbNC5lZsmD83HFUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9QNZdMH/PA/pHLZjUKOEtHevUVMx4kRepNcO/cQUXhQ=;
        b=WjTNif1ldVCYtAKB5UOzEGbEpQmDVfbDm2skHufVtAozB16Jk6sRhCgZd6+N0lcpn+
         sw7uMTQs4MCZY+Vm5WYpURFLHuTVPXLQVCtgvtwiayCB2NAvMOt9XAdJfuCG7HWRiSb8
         gs20o17w4a0rfIcbUl6DRKM0u2bSELHV6wCPtRDCoK3W7S9hiBfwsyS5QbnJm2mgWp1b
         vjvZ9X3187L1Bo7X4ms339+tzyRpIhq0ZXGLmG/XDFr8byn8v+VRo5cet4lhfc80wryB
         ZHcOHBB9Hu6mOMU98qPG75n3v2kRpu21GQFyjjK1x5IP3goWVvrBEuMv05ZL4v0r1hvQ
         dL1A==
X-Gm-Message-State: AOAM531VqD5Q5SFeVf1MldjBAn+aSWIK3jjQbiJqEue6ddufotZ8P3c5
        Xz4Ggyb+gyFjMHsl8xJzBqjgcQ==
X-Google-Smtp-Source: ABdhPJxTHJJtMKoBLyeYEsr0bepf7XZ7HOvjtnBC8nCDkhdrb4Wu8TrQUJNOCnWiepzKs2ToSBOaGQ==
X-Received: by 2002:a92:d04:: with SMTP id 4mr2132128iln.210.1606177929916;
        Mon, 23 Nov 2020 16:32:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t11sm8351052ils.37.2020.11.23.16.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 16:32:09 -0800 (PST)
Subject: Re: [PATCH 4.19 00/91] 4.19.160-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201123121809.285416732@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b0f29578-e9e4-a08e-7c0e-20d16ffae8da@linuxfoundation.org>
Date:   Mon, 23 Nov 2020 17:32:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201123121809.285416732@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 5:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.160 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Nov 2020 12:17:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.160-rc1.gz
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
