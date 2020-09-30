Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A127EAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgI3O3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgI3O3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:29:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:29:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 26so1890427ois.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ib+3ZHrdesZmXYxrPbDbE/2iDrAtnoX6K17Jk6W2gR4=;
        b=OqpWlJe43VD4pvOkBz/nAFCDBWzOHPEO3ZlVtUiqmShV601UDxYDhIpPw3pw66n8lS
         dLlRH25XbeF32f+eKAa7Zdq3G78/+axqTw8ub24FtA7wyPAIO0MdJGP6ivli/SDQz+E1
         jBUI8uSY9bdGMdQmpfgyA6he00aee1ZdAgHxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ib+3ZHrdesZmXYxrPbDbE/2iDrAtnoX6K17Jk6W2gR4=;
        b=jxFTppSM3dY2iQaeZUPfON1gJv5njxEgqC/9Pi68Z0QWn/pElv5jfxZULr2WcZn/Wy
         vcrzJMOPiFoGhXuC7/SrRbDfL6LG69FUfgOUKIw3IBi0m58cT+7AfwM4ZPH7qRISaaeb
         rHUrER3PCiJuqfBBSyWWefW9Vj2wKZj00jjeEKJ/r/00blpXHPxkW3/7xDsG+9DNyD6N
         CXfw6qpRSlY95wiZf+z56/KE5NNAf1mo4x9/d32tCQQaUeLzojk+L8KVAMpK6lQPcLua
         ZhNBArlJA8MiudFByD11sCO1GUvFnPAubX9Wd9R2H1We28JEF+0bvWlfDxiaDjC+VsJW
         x4iQ==
X-Gm-Message-State: AOAM5307n5VNlI0M5bzqU1Znc8ahdi3N1RIakTpVB6li2/Je6wX4kUrO
        DrklJ2tlw9pz4TYvh92S1XCd7g==
X-Google-Smtp-Source: ABdhPJwQMjrbKDLM6b0o8Z+OgHEt15cr7ko80ZI6CY4XLDynDyoiFmLR+HBvHxmYXNdTUalj8kVwug==
X-Received: by 2002:aca:1716:: with SMTP id j22mr1611984oii.44.1601476163755;
        Wed, 30 Sep 2020 07:29:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l12sm341521oib.32.2020.09.30.07.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 07:29:23 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/388] 5.4.69-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200929110010.467764689@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff9f91da-b4be-551b-e467-768b4b5d2db4@linuxfoundation.org>
Date:   Wed, 30 Sep 2020 08:29:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929110010.467764689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 4:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.69 release.
> There are 388 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Oct 2020 10:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.69-rc1.gz
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


