Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB262CC302
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgLBRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgLBRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:05:09 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB0C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:04:29 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so2644131iov.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fsT73oNtve64KA9d1Aov7halYc6/XDAuFfl8oVg8pA=;
        b=VQJi2BowNXTARCOghH9V+PLMYjKMMr40NF69JdT0MkvzxlyhDmcl3EjF2OyqtOkXZk
         YhQMaXIlK3JvnySdnSuso6OMEwPsqOlV/ITmDjPoU5H03SfRGi7rsZflpg14466aII9N
         POKpr7qEsZPKYXije/pIoacrIPWhwne5U0rKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4fsT73oNtve64KA9d1Aov7halYc6/XDAuFfl8oVg8pA=;
        b=Xggj0m5eSCKaHh8uvZOuvlPbzZX1sQWCRJB+q8C19KgsPVfvrdqyI7oQEn2kK6jm0G
         kY0R5vRnLvaqsOGYTLVGrAlttj8ohwcrIuRNpiMi6NPx7a/nNPVTV4cTJBCQiRc12hKj
         pD+TnvfE2TERDpnNiBfowjohM7ryoAW9Ek6SWPuV3w1WIN5cbTQN3X4KMHIUKKSvIipL
         5ck+j1GAs0S0UldjHLNYHrDmUYtyJ6r6wA9aBziqBH58rNtevMjoWyvyr0kop2werg0B
         I9FiprnQdLKwFWOeiJc8wEO3fWaUotAoLQVTLK8JzCVvtMC6WyQ851x7r0RhlQmPkKAk
         b9mA==
X-Gm-Message-State: AOAM5316/7L2o4SXevE9AnLa5ZUxjAUz3jnL86GbjgMOpVWWvo/u1n72
        E9+fPU/PSJ78KeejpveODkPvqA==
X-Google-Smtp-Source: ABdhPJzaDdQ/XO/zB+U7tGQJbGl1qefkz+25Wg/MqVEHHLiap7GxGq8n4VQiQl7/lSREIrvfd2s+fg==
X-Received: by 2002:a02:a1ca:: with SMTP id o10mr2958653jah.19.1606928669080;
        Wed, 02 Dec 2020 09:04:29 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b15sm1124604iow.5.2020.12.02.09.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:04:28 -0800 (PST)
Subject: Re: [PATCH 4.4 00/24] 4.4.247-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201201084637.754785180@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4c8a09ed-467e-a9d2-f791-135488e48b43@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 10:04:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201084637.754785180@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 1:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.247 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.247-rc1.gz
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

