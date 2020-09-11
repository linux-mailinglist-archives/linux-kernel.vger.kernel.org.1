Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F422675E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgIKWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgIKWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:30:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75242C061795
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:30:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so9668302otw.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xrWJgJpkeSVBnkFKBQmIbISrKpWemR5O/kX349f073E=;
        b=WaASEkKOeSUFpn7FWyITzqzPT7s+N8hD4v5MKgz+PJzMNF8LFwruPNaprP2SxYpvaU
         2djQwCA3A8o0nfTtIaJU3JgbuwyPce2M13ClflPsW7M6wkWz3VG7PVCB6GdHIxhdFyt0
         BU4qauWGgo0szJGUle7PLBynd5bSFOO4VJPJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrWJgJpkeSVBnkFKBQmIbISrKpWemR5O/kX349f073E=;
        b=JWbH4+USxq0d7G5HIu5gvb0lO7XZG5/HrQ8We/sohTcGmrZDEvFek5mDqC9X3JlUFy
         bw86sfvh/kmwLdGZj6vGFfgQfAqwTSVhhu7EHAMWcA2BQkAtOnutCNnu9yqhyuut5Wpu
         dqjz7/9LCAvRtolFbghxemyvVQFQ11u/fhSmXUlH7rR30eczOY3DzDiHOPVhuTmS1Mvn
         4kjO4tg0HJVBBMMFs/o1qBbe6NemFlFVbOtd1y76y3WbOUCE4lIGq7MSYdlyiFhuqJ9F
         Jpqw7jVZEqKAl8YP167MwTlpZ8Qw1D4eGIHuPjtd+tzf5qbOCmXSk5Bl1bZrSxLH2Dou
         tUSg==
X-Gm-Message-State: AOAM53092G1vCcsPKnk6gJ1EnLGPuQQTwyWhVHQ+VoCS+vBJmRxnpL7r
        5N66W5nCGv+Tipkgwvi0eFgQxw==
X-Google-Smtp-Source: ABdhPJzCfnKGXv3005Ye0JD211p3GaVKcYRC4n+dgIfLX3hy/Qd+0MvyVvJiT1sJJwJX26IelBVx5w==
X-Received: by 2002:a9d:688:: with SMTP id 8mr2458266otx.122.1599863448552;
        Fri, 11 Sep 2020 15:30:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c15sm526127oiy.13.2020.09.11.15.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:30:48 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/12] 4.14.198-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200911122458.413137406@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a1deea4e-8d7a-3748-48d8-e4d2c9dd0582@linuxfoundation.org>
Date:   Fri, 11 Sep 2020 16:30:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911122458.413137406@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 6:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.198 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 13 Sep 2020 12:24:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
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
