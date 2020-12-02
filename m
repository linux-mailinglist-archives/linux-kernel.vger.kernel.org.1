Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18622CC2E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgLBQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgLBQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:58:32 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:57:52 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id h3so2271522oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QovL1bJkK1rlg64i1ghsOHozVubUlg8mH7qNmCrH2Uk=;
        b=SoJBH2yxWJNAtuqKxTr9iuf8dwQRF7V2QuiHXdkdGejI8GTQsq/UOzV6q7/yGN/o4H
         Aj4S5PmbIp/3ELw6tv3F5LYNxBYzZ9ec1gO0FnPaPMKhxJh3FGVMQNuU+ht3cfw9hySD
         RiVKMaC9sltqbJQ3z7OWyg8LWBgZ7yOA3E3XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QovL1bJkK1rlg64i1ghsOHozVubUlg8mH7qNmCrH2Uk=;
        b=ixGrhTORNGdDnVDtkN3uUtZMe5ZJIXw7qJjo9c08qfqdhl3D2u8sTMKQgKmKSKbP41
         yEhOeDBzD4yZu7ht+O7ufLBJYszUEI9FeGko/piDyHGBufLMxtB5QGQscSAN6RmjJyOk
         zYnKs51ErnTMvvPWgS5PwqXYHsk6rallAxup3r1a9V2rCoMiBrIX2hT8BmhkUK//VulJ
         bcn9PD5gTpREX2Lf7+Ytb0xzerM3CtoCAGNfMyvBDrwOoc38UarUDCkVyyjR9SaWjz0b
         paUkbEYZh0Vs1FUyI3bWjCXpjBtpjTdEwNc9F2e8hyAshdrPYxmh3Gvzj0/H5KkKS943
         VF1Q==
X-Gm-Message-State: AOAM533eopopzUG+olIpD0349g4qqTzlkNbQeD4quiNaeEIPdIvTepyz
        wUx/2/cne9C5G/cuYgRDp9W3yw==
X-Google-Smtp-Source: ABdhPJxSKCHVYszxGMpnT8ZXXECWpyntuswGolme4i6AmKBfcBVoZVUbqogIbyR+FzkdA4ZeUppZJg==
X-Received: by 2002:aca:d787:: with SMTP id o129mr2334101oig.61.1606928271527;
        Wed, 02 Dec 2020 08:57:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v12sm462290ooi.46.2020.12.02.08.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:57:50 -0800 (PST)
Subject: Re: [PATCH 5.4 00/98] 5.4.81-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201201084652.827177826@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <96f5f939-1d96-10a1-4af2-84e9baae010e@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 09:57:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201084652.827177826@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 1:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.81 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.81-rc1.gz
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
