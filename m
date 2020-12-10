Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB362D69AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394029AbgLJVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394023AbgLJVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:23:54 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE4C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:13 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so6770764ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CYZd6jdoPPyIzqEniMfNIDK6f2ux98X4MNJ25wEjL2k=;
        b=F4Sa/Llc5C0BPYjByDx0UfNlMRCv0iSri81JqmWfiJJX28oOul1egS+O6Vd5Lq5V+q
         suyvtRO7xXPGSJ25AjMAjYOKhovWmw+mvqyI4RAEyDL7ArIT9LwF5k/R9mJRc3gZMDLi
         nJp3hTCXE37lvhSVm0TRzQpja2g0yZTB082FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CYZd6jdoPPyIzqEniMfNIDK6f2ux98X4MNJ25wEjL2k=;
        b=rquQLUG9mYXnTR1q6UBU4JLWc8AkRVVNCiKd9gvLyQf30gtdZk0dS6pw3aktwCycGH
         uGss9S5nzlyu3hNQrmZNdv5A4feijeHSvLYwxJO/3JeAIkUtBcpK5J9xy/oiMzdOrL6p
         wLVqJzeFKkPA1OWs3rRTsBSFHaU8Gsu1jUuEMMWmPv4m3dMYEEHafKIdQ5pDyo/qsMVm
         6eexvwLNT9iGeL9RZYNiPx+V+ZWAm647PGsMrAcX8/O2sycHzh+k6Gw/OI7cUiC2Iakh
         qSXrEbtPb7HmuTndf84GXoIGxKNQL7qBJfaDspmDC1rx2aAt9Wdlw9VPVWxasE7q9u3a
         7+gg==
X-Gm-Message-State: AOAM530L/BE0jokyZuJHPaAj+hZZRqUAjXI5K+zkQpicFiJlunwzLxyc
        VntQ8VL9YBcQu4f60Cv3P+3tBg==
X-Google-Smtp-Source: ABdhPJx/hItjT7sjMoQbPSVjjKzdIAOLLhEAbRyTMvW7oNs5MytvZc6vVliujvIWZyMfJoASjxCxEw==
X-Received: by 2002:a92:4019:: with SMTP id n25mr10872145ila.25.1607635393092;
        Thu, 10 Dec 2020 13:23:13 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v13sm4178797ili.16.2020.12.10.13.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:23:12 -0800 (PST)
Subject: Re: [PATCH 4.19 00/39] 4.19.163-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201210142602.272595094@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <28bf5a79-30c1-29b8-e188-59ed0020d800@linuxfoundation.org>
Date:   Thu, 10 Dec 2020 14:23:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210142602.272595094@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 7:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.163 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.163-rc1.gz
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
