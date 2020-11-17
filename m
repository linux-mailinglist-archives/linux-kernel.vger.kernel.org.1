Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1A2B7133
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgKQWEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:04:41 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7174C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:04:39 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id q1so90498ilt.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0t4Ozl0KNfcj3UrVhYYeBSmo/6VZ1jRdoln1c0F3A7Q=;
        b=cr1Btb/dqTd+JR71h0YurzG5Eeztlos3CPhNCQA+EeNPHE3V+KM5mgsbaeMS/HlDpR
         1EePV171tHIbHyalqC/NYMI0lXVHTV/TSCshxHPkbdm7CFO9S3cjPx22+vYLCEiKI/gA
         8u6RDmE2GSzTSruFGBpPSgOlGsK++1X0nYKA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0t4Ozl0KNfcj3UrVhYYeBSmo/6VZ1jRdoln1c0F3A7Q=;
        b=NVICUEM0Y6isqD6GMqoYXB4DIO1T9nKNpfhwDrGxjBf7SkAcFgekFrbesx2cVMdtEt
         hP0PY1jRyhlwjRcQP7Jlvpju8HzGhmqAxbFRBWwxnHC++RG1aSZRDk+qIUSDnmJgxA3e
         g+tz0K8UmXAY6ihhoaiu1e97H1MxeFGl7MAGXYBK9eWaBTdAT8oeZoicthMp+Zdn6RW6
         MCV78ixdoVBqzYbzYbGhTwMswU52QaEMaZ3R0WyZWaitlpevAUl/s7JTmbD+J1V9K/ab
         xJwXErYt6/J4syiPtkU9VkvSpCo9IV1GJ69m3apBkGdTq7EUK3JSDwKCgP9CQIoKTrs/
         eAkA==
X-Gm-Message-State: AOAM532OlKtdtD2OUP9mznT+d6+0NSwskU/7h3kCxD91JBWSPldEFVuE
        WRZ5/Ig1HOjHAd77YRSVa+8loA==
X-Google-Smtp-Source: ABdhPJx/kpU32uYjzPE4GGYwxBxnblMykmZjiWKAVvGVuVB14A0hNAlUlKb7LfQcuglFCMvOQZvueg==
X-Received: by 2002:a05:6e02:128b:: with SMTP id y11mr13766326ilq.75.1605650679168;
        Tue, 17 Nov 2020 14:04:39 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c80sm14895462ill.20.2020.11.17.14.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:04:38 -0800 (PST)
Subject: Re: [PATCH 5.4 000/151] 5.4.78-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201117122121.381905960@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <36a86d56-2cb6-2993-60e7-1c9a86149dc0@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 15:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201117122121.381905960@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 6:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.78 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.78-rc1.gz
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

