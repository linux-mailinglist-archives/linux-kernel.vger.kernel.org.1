Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52A2F24AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404958AbhALAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404167AbhAKXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:41:20 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84549C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:40:39 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id k7so182152ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1wwg5CvCf7+UEe8B5Bp1chsw68hTnOjBG43X7pn23M=;
        b=ikIYTVERJPZSUok48ou3dw1bmkwNmpv773xO01ynbyHeE7OqPzjzpRJkhyAVGQkINK
         QqXwYM6HZRCtq+Tir4GS380MD7xe7woJcQq3fAzUIPZKaf/ntA0rKCg71OSqdwFSK4kF
         kxsKfkBymNRJ0mJ6FAb4GrEZv5UIM0ijppOIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1wwg5CvCf7+UEe8B5Bp1chsw68hTnOjBG43X7pn23M=;
        b=VALEKmFKR0HDwa9IRuIDfG/tW8FOgANWJC1OD/PbqIulUsIO5xPajGYF1aY+MdEuqI
         9vZopayQ0QewA7lUtIJvzgvBJ1g8BldjIt99UucBvl1jL5Bky8O6JB51n2iINUHwg3S7
         zclD/j0QQHcxDjbgL3X3A/rSGZe2sKLEV8Fg7d0b5p5zwk6wR1WMI2UYmwDDnpFKj5VN
         ILla0xBoKcYJO9YwOpRSTCNeDwW+QqyNxikRf8MgQcSRzCLil9mLu0Vn7/jfRP3eU+mU
         BFYg1ne7zHKVV19RlekzgokGwaWwOfRpIrZ8oe+gMxTPVu/R7GZayt8zWY60zaj8pH5X
         O2EA==
X-Gm-Message-State: AOAM533ir8vSp4vR3jCe6xu1Os3whmHuTX6SbtLO9eW9rUam++dlg6cZ
        4zYAzU5LovfiE8YIdqDPHVYToQ==
X-Google-Smtp-Source: ABdhPJyOcuOLlV3PwTS9fVcnA3sfs1kObBUVwLXJz+H+i+N/c/S8wY9NuZA/VZh3kQCInxfoK9immg==
X-Received: by 2002:a05:6820:441:: with SMTP id p1mr1075219oou.21.1610408438999;
        Mon, 11 Jan 2021 15:40:38 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r25sm283261otp.23.2021.01.11.15.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:40:38 -0800 (PST)
Subject: Re: [PATCH 4.9 00/45] 4.9.251-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210111130033.676306636@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <635dc346-908b-963d-a690-712525ddd157@linuxfoundation.org>
Date:   Mon, 11 Jan 2021 16:40:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111130033.676306636@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.251 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jan 2021 13:00:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.251-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
