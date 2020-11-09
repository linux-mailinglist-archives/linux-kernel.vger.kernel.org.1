Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988C02AC954
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgKIX1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKIX1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:27:11 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:27:11 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so11693939iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LlpW6Fiei2Dm+qwuiEkQgtBJw6Od/EH5n+8gsYoXSkw=;
        b=M3n50JuXXLHBtME2dtOB1ylWVr6gySlW3TlsVRtn1mn6cK0PF/K4PSarZEQfQa2BDZ
         4rmW5holrMfXqhCGMG0yxH7n/Ov34aHA8wsgdalFP/k+rV/jx7VmCjAgWoz9G+GUzRYz
         dNW0305uvuOqbzHTFEsaIWz8qZUNzP8Q0pCGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LlpW6Fiei2Dm+qwuiEkQgtBJw6Od/EH5n+8gsYoXSkw=;
        b=gq3IKMCllaF7+SNGI8QNOUgcr3ngH4lDkb7eITB22WtUUbVse4cEfvaMTz5oTgHwFG
         No6giVygYayPH8FJGxlOPQbx6DXiKLEfYetL2c4wpcznAHh/CPZfn/ldUMKWUezSzguv
         FS0ohaGL/Iz2bo7xfBzkRV8Q9550rQjoQq2cX1G/VEbvrMHPNWDR77mjHpQmRUmPSXRx
         /iZFZJr0VeGFE1+W3txOTd+PGr+YmFHDf2Xs/nlPqDZuaklKr5B4vk/5bjVPGyGiWkjg
         SLgQN9mBU/p5pHLpKux3qEk8tYfRNsiLuLNxoA4bqAQ6XOQfWEcuyHB7LKorqT9EJ3YF
         598g==
X-Gm-Message-State: AOAM531/rCDKTh/Y1hpS2Qhvhh75oUWWbI9onrDu7ofOq9DKmYf9C6ok
        ZDRza/CB5ZloGOUJmoPyffUQWw==
X-Google-Smtp-Source: ABdhPJxYlHK5ro87qkLlIdc+eZEV4yIidcQ1JMNt5ScQRzpYmHDt30CtcFhEN5PAbF65q6AJqvJCUQ==
X-Received: by 2002:a02:d85:: with SMTP id 127mr12885805jax.13.1604964430797;
        Mon, 09 Nov 2020 15:27:10 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z11sm6424132iop.22.2020.11.09.15.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:27:10 -0800 (PST)
Subject: Re: [PATCH 4.4 00/86] 4.4.242-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201109125020.852643676@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4ecf7792-3479-cade-287e-1eb1853730c8@linuxfoundation.org>
Date:   Mon, 9 Nov 2020 16:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201109125020.852643676@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 5:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.242 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Nov 2020 12:50:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.242-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my new AMD Ryzen 7 4700G test system. No major
errors/warns to report. This is the baseline for this release.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
