Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69BD25A15D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 00:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIAWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgIAWVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:21:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809AC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:21:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so2586915otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9sdyF6sknnMonxVkT3RxfZbkTai4U5uWBnm7ioMmgSA=;
        b=aNH8dEmtAAvDI0rdMQyBL5J8aKdCZlWSyxLBDR4BDzoyQ/DVR9iXxa/slWiGN9E9MS
         oJY9g+n+6dhZbcANwB7zH/YHHeMwYNqkbNpo9VY5WyrkTrAyDAXctl4mfLxA0Ou6AYWr
         imuWZ36tWhci64u015VYfNNsQiW/mCC5Zwn3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sdyF6sknnMonxVkT3RxfZbkTai4U5uWBnm7ioMmgSA=;
        b=dYBZhj8MIu1IQUr7DZBXWsn7vIMzUnu6deLu5S/pe/ukvsdjffUCUGrQiWSwRVYxAO
         tukdZSvu1ByP6WZlmAvN2yObMFoDl0c8DKQpdWPxHN0NIai6itgkzADBX6a0FuwzLuF3
         coZeF6ZXcXxIa9eXtpg4W5clno8pBHohPw/ZPIIetxoyWExM7Dux7v1xxGh2xRArvaWT
         eXVcr4FsSB9QmgoUYVHwgKzpTzZlUU2acVnxOoHuDi2F7rPFr7VRspE0mOKk7s5mda7e
         MEmOr1SH7Ti1hsqwBi+RWEImLcm+J5HTR+6wSGLDkj+A4SNNfqq6ct7yEiBcnNy78owU
         7ndQ==
X-Gm-Message-State: AOAM531dzKzJfHUTgbU1XYvhK3EVFwqds0f+6/W/w7L73U5srPVcJdN1
        m7KdFeo57azckf5NQQ0MYT5SMA==
X-Google-Smtp-Source: ABdhPJyCkLs+KYIvJ3Q/pdfGbhcOB6ilSGR0J6hp3rM//k/J7gNGWQmcipkj02sGP7CNHRQlX4VVIw==
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr3058285oto.297.1598998892406;
        Tue, 01 Sep 2020 15:21:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w19sm416228otq.70.2020.09.01.15.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:21:31 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/214] 5.4.62-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4fe1bfa6-8d3a-15f9-5b22-701b9915a95f@linuxfoundation.org>
Date:   Tue, 1 Sep 2020 16:21:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 9:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.62 release.
> There are 214 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.62-rc1.gz
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
