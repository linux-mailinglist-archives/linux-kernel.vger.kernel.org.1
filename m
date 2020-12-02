Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405842CC2EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgLBRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgLBRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:01:28 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:00:48 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id 81so928939ioc.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zi/zixdoKqZ5PZb1aIHLR28SpFiihzwMb6piblktrQw=;
        b=HIau1xgRR1/X5EcyJP5u8dGtaXPfOgFwqw0m0FKLX4W1UGsK2tlb/Aavhl8TdXn0B/
         HJ/+hirCkiEg6nQZSRQQ6MApupeTK/QoO9cHIpCkU3+KpIyL8SBpB3i9+6zQhtKaXe9v
         gMq/j+7MNDmFegK0ond7LWovpkeipLRJt4IN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zi/zixdoKqZ5PZb1aIHLR28SpFiihzwMb6piblktrQw=;
        b=Uidq1HOaYbzl1zEqlkao9oXlle6N0VGznzxySHn6qOy6t+Bwga+rQsi9C13Sfmw07j
         aW7KVGWrXs3jj492VpNW+x2Ge6qL1ou5WtD364BOczHleod5UGMv8k1tFP5xh8L4egwf
         xT4ScMQ5ijNMklKbo2uXdZm5xrtlBYTqn9mbCZTCnFbDQimEk/nVbf91W6rYyL908hH7
         xCC/ZOiQEkUi6ZyTYV7OA+u3a7SNZnZ4ZRap/UWebNmAlLmeNqV7czUWWqgdhf7wQQg9
         zeFrtS6GaxzOmyOMH+Scsc/Lin3P0j8WnRpBvJzkLlSWdr8s6Cy3DMxoAGNb8W8CT12h
         6Ysg==
X-Gm-Message-State: AOAM531j9UBXP+COXwFFiYaFmIlJ7fOPYKAGBJs0bnbpMy3tGv6nX6uj
        0QuOYo2/NCGM7euz1HBZOpCeQg==
X-Google-Smtp-Source: ABdhPJydLO8fJWbuOihHhhBgHzR4sKjLhh2HKkGrb7dlrYZgoa2Nb0AKTJD29Cj/LAQIgx/s1nQs9Q==
X-Received: by 2002:a6b:2b97:: with SMTP id r145mr2755619ior.6.1606928448086;
        Wed, 02 Dec 2020 09:00:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s17sm1337822ilj.25.2020.12.02.09.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:00:47 -0800 (PST)
Subject: Re: [PATCH 4.19 00/57] 4.19.161-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201201084647.751612010@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <83f1147b-c4bd-1595-b13f-c08f28bcec03@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 10:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201084647.751612010@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 1:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.161 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.161-rc1.gz
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

