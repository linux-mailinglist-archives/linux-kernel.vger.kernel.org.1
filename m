Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C2262492
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgIIBlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 21:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIIBlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:41:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B96FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 18:41:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c10so913005otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sqOKYa3rPgv74NvlQXPKtS0S3SVyRZjrRrzvNsZDXDk=;
        b=D/IzFXdY/7/ef9AzJ9pbClPznIDhkUsQTQT2QTRkqJStYus4nfuLBMF0Egg1X79tei
         gTWZdReBrrZb82aGW7gqVo2WzalsM90mOu2rA7Xeg2kNLU1o9pVWtBKmHXQJCo4+qF+s
         SGpL7Wd1MQ7jIwbfIPQMok433NOYtpgze98bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqOKYa3rPgv74NvlQXPKtS0S3SVyRZjrRrzvNsZDXDk=;
        b=Y+s1khNXH61IG6shkV9/rIzI/Ne9gfTra/rmfeeWpuaZEE+B71r0uYsQgDsX4msNhA
         7COKQ7oS6byMQqp410e9IMfGR+XL2xoEa8dYtJJG+lCUWlxEghyEx7JT3RanW1oQNI2i
         xC1kmI0LIiBNpBbkUmtp3LsvAyUN4lr54vRHasOjwX0Gv2zKdjrm97UBXslMbTt/+E8D
         yYiVAEgc5EzqzlsAZNi7eHV6M8mJrTGP8ULa3K+m3GEH5YPlkGwJ4PyYOjkH4i6ORvP1
         +20OhZH/1OJ3vRGt6azqHPCcza2z00LATwVhRSK3lW5M8wGhC/aV/yND2QXWrM3PevJR
         MJYA==
X-Gm-Message-State: AOAM532Ob4Mh2J8o33RjRtEjXPGM0KmkLQJjU1GFARD9dAcLOzPU5YZj
        HuiXf1VxswGfMGYzJyy0QBRWGA==
X-Google-Smtp-Source: ABdhPJzj48AscdGnW6Ski+7bHdeTc9icPEAFOEU01Tu9ByzLTAEl07LLKw8ybqWDgPtXway1TptGuQ==
X-Received: by 2002:a05:6830:10c4:: with SMTP id z4mr1287390oto.263.1599615708968;
        Tue, 08 Sep 2020 18:41:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c25sm166132oot.42.2020.09.08.18.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 18:41:48 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/129] 5.4.64-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1d00471a-3b02-ec9d-39ef-778048e8eaa4@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 19:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.64 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
