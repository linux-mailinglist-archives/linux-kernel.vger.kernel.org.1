Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6752912D5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437997AbgJQQCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437930AbgJQQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:02:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C16C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:02:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k21so7731868ioa.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUYBiAeroGPA82hdZshpuKIq8SLH8y0kZs282Lhl0nQ=;
        b=R4vYDIO3IW8855NRERc+rYo+8UrAfXnysQc5WIIjOkK8ebQIB1hxaQJK3gri6YVZyv
         Hy7Htp7THVf2keRypFjppxi1+CqEyKQbVuQpl0L+wOKTu1ccjcky+ktni3ZxmkubLzGt
         EHdGJbF4hXS0f0H98k8TaM2hEOOef32/POrA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUYBiAeroGPA82hdZshpuKIq8SLH8y0kZs282Lhl0nQ=;
        b=qjzkTmp3ECDGsCnKHQdEY6nCG8QwwIJ5ncKvA0saMOYVBm4ESGOZY79c1fSrWelEGg
         fxINRfETKyEIGZstp2tRa+pdi8W63qI0WdTRB8jwTmuYNSX2qM/JDYedJE9/W+vOYgeC
         mwORS642cFgPeDseayzxJnJzJl/p8qhRmXmWH/mUeOHTT8jyb0fYQO/t02lb38Bf8nfF
         hWR6TroCrlffO40YnRsnpHfvnlqYTFLze2fWh7/4+HSkrp1o59fR7Owp7TtuUAUgvWBe
         tuZkbAqzZqsQ1taBps1HpuQ/s8o4GuqvrDAIevAHoiorW3peaCG/qQQaxPNQ+vdNli7L
         wBbw==
X-Gm-Message-State: AOAM530Yxn4lIbo8ECcIXMVd2IeZKWMHgWVGcrmAbZ9tqRw6aSZNS4DV
        SKT4hnzf5nBpwIwADbV4SGUmCmebbn34Ug==
X-Google-Smtp-Source: ABdhPJzVb4+t5XxmaHGA1264i6pR5D1gCEIzQsXIbxqwWrZwgXtMXT1kZCVWrBqcolEN/v5YtRNP/A==
X-Received: by 2002:a05:6602:442:: with SMTP id e2mr5974326iov.71.1602950572329;
        Sat, 17 Oct 2020 09:02:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i82sm5591769ill.84.2020.10.17.09.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:02:51 -0700 (PDT)
Subject: Re: [PATCH 5.9 00/15] 5.9.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016090437.170032996@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f0a580a-40d7-96bc-b51f-df4217759eb3@linuxfoundation.org>
Date:   Sat, 17 Oct 2020 10:02:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016090437.170032996@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.9.y
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
