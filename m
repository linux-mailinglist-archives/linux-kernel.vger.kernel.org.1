Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D83011A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbhAWAZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbhAWAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:24:49 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD70DC061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:24:03 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z22so14846165ioh.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iJV7GoX9NeC9Cf+uGRyB54/V6KkpqqSntpSBmaHYsEE=;
        b=ZXJNjzN/Di9kdGwcthHiDgZlA0lhjhc9faD5BzTjtjHcStIwmHt8S6CCe1iLcPmRUq
         S06yWhgpdYAZvpVsjNG2AVjErbWoB52d16c4hDFjyl7qWPanGxpri5SDFkjY+l9CxNGv
         D9f/PjSkgp7wYrLcqKRvLFA10shAo1Y/+lpnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJV7GoX9NeC9Cf+uGRyB54/V6KkpqqSntpSBmaHYsEE=;
        b=XFhOcB71k/DjcZYZTf7+XJsIPCEFwvyP5iRvVxEwUUn9j/fe5hslgim9r21YWdYIsU
         44PyR2O4YkHRiHO3F+Fu8dTl74gd0r6qnQHa+KW6g1p7tvcsPBWT+9jM6gnuturpXUd6
         8jLpl6v276AX6LSbdmluYMI26Pjw/Muzo0uaROanN6XoxDuS46nDhIJ4NqDVdwy96py8
         iXBkeDE/GTUnddaNTilZ3KUY9BfnK4SND5crHKKOqmUO0fKxyDcGzXShUIXbB7AetlrH
         T+hF6wR447RvLgU7JW4p51d2yaaPIoA9iEKfY8H3pLfwaHA3DyHTxyLIvPOI0Cvyc8P6
         QfIA==
X-Gm-Message-State: AOAM530vTc4IlWLQmtYgX91C3NjXIbyk0/dieg+2YAz/ZNnUN4kqpYR+
        CgX9A5NRkIlJAYx/YtrIe5R6FQ==
X-Google-Smtp-Source: ABdhPJyg8Lk3GiSWe4uw5lVnE56IFdtnAoxaVzebSRwP6oX9Cm5/GyR/a8qvyLjJyq5Vh5SEYzumFQ==
X-Received: by 2002:a05:6638:b12:: with SMTP id a18mr2254892jab.114.1611361443140;
        Fri, 22 Jan 2021 16:24:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j1sm4363380ilu.78.2021.01.22.16.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 16:24:02 -0800 (PST)
Subject: Re: [PATCH 5.10 00/43] 5.10.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210122135735.652681690@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5ce91f74-86d0-778c-d884-769cf4d7e3b2@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 17:24:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122135735.652681690@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 7:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.10 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.10-rc1.gz
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
