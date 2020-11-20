Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D102BB931
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgKTWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgKTWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:39:44 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4924C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:39:44 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y22so10244337oti.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEb2uBInLCs8IsOkwmnYRce3Wq6xcB4B+D0gKBebh3s=;
        b=h4pWoCg3U9Kl89tXl7GLuHaBLzfyq/mc9J6vMUskj5qYU9vvPN66+lNvcXxbbPGeXS
         GvmlgLxEYMzlnhIlCVxKKin2sdFGoBOim5JdtwCrTkBBJDjlBFjQNeyv/zq1hn1qVY6z
         unlhZSbNHcpHLnKjcZsFDIxXnj/V+/Kh+yfPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEb2uBInLCs8IsOkwmnYRce3Wq6xcB4B+D0gKBebh3s=;
        b=Dyc8YrI9TbU6uMtsZsxR8HwHRby6BaFSU6y9UMH8y729P5fkCDUwyzAMG0FQZikDkq
         dQJXvnRXLlGFfPdoTKY7+fhGFKcOJdSXbinrriGAcN556oZxRCfnNs+UD8cZEF3M6mOx
         StRNrbXbRzc8/0bqkIapTBw4Tpmfbfktgp2/1c0+BzOC5s1DBetr/NzRpnm8844k9blz
         Hu41yy6cINZRx4Lk3+H36LRja9qR8NjfZpdoKk4ZWRPqQk633DWlM1+L8Gfe40kLTFzH
         OBGcIv+KuiW+NlZsPhcmQMRz4TGgKjX35q+oauT5OpuGbS81smLTcZeSNoTHRMUkG4aI
         Uogw==
X-Gm-Message-State: AOAM5305zfluI7yYRhExL9Zii/Lsz8CRVCxuhliQ+Ik+LWKCccmm7CJ0
        WV2EyrLPbYmI51PPhh0rVOX6Mw==
X-Google-Smtp-Source: ABdhPJyBisCkWa2BWCHze9LlSOmV2DyuKPPJMp1IPSqMsbK2UaWiD2nBMK7QxbkWM5ZPQj6gs5QsPg==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr14315206otp.226.1605911984095;
        Fri, 20 Nov 2020 14:39:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o6sm2245556oon.7.2020.11.20.14.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:39:43 -0800 (PST)
Subject: Re: [PATCH 4.9 00/16] 4.9.245-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201120104539.706905067@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <87002b8e-59cb-7f83-600d-e00d981b4880@linuxfoundation.org>
Date:   Fri, 20 Nov 2020 15:39:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201120104539.706905067@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 4:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
