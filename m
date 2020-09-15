Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAF26B4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgIOXbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgIOX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:29:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52BC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:29:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so5945580oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbOUuv1gUD+qXXkj5YWutXFkg4WLBN2ngc3Iyk5DDAs=;
        b=BlbJ7ncCQzp+upzh5WZtzcI/GRPLRHBv+YtzJu3J44nOv3QlIKEDkuiJRdsmYFJdvl
         q/6VZELF4b2ltbzpMVaXpLK+GzT4Nix7fuJdFpDQhZfQJLbPLdCMdOrZafZ2/ubqXN+9
         9rWlzx77n4KJQnwlbi8ZHAUqvr3EkmXGUccgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbOUuv1gUD+qXXkj5YWutXFkg4WLBN2ngc3Iyk5DDAs=;
        b=sBDbhIPT4zGLQdirMqWFkvCfL+BFDrt3Wj3GBafnqgO0nQPLxyveH839ONqNwDoL7U
         EvSeNu7EhkyXyYqhX5RpbEl0Cq+uLmzc0hGKVDAwJptI4+93oR+0+NjkUUu74O8CM5aX
         LJECPI/tliEktCTFziCUvpW7qbV5203s8pSKER93dD3l+kTVNVI2ysQH3603g0I+sSRM
         7ukX4upPAmRHFjFsKCpTPqezrTRE54qFK+2Vgjd2CCrMWiijz/xlSBbVIuoXf1fu2J5Z
         sJ7zaHxzf53ZHEmFASFRGtXf2Xp8RwmhFCarfNmUzLS3Z7yRl67UpWl/itixe5bTC18X
         v6jQ==
X-Gm-Message-State: AOAM531op5DoHLHZ3QkLHQVV1EMWXJmq/LLC/O+aXv20GrGORZgL+c+Q
        NUeslEZaGfpeKKFCjsUtpOxCJA==
X-Google-Smtp-Source: ABdhPJwxHv8Z8lb1erUw3ImFC9R2ImDiSNZK+V5IExxSAAwGZBukNJpnngQR2z+/IKUI/YDKWvLCTA==
X-Received: by 2002:aca:52ca:: with SMTP id g193mr1243613oib.126.1600212555958;
        Tue, 15 Sep 2020 16:29:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n37sm6816316ota.20.2020.09.15.16.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 16:29:15 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/130] 5.4.66-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200915164455.372746145@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <44c0fb9a-2510-c9e7-0bdf-52f1e19698e1@linuxfoundation.org>
Date:   Tue, 15 Sep 2020 17:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915164455.372746145@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/20 10:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.66 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Sep 2020 16:44:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.66-rc2.gz
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

