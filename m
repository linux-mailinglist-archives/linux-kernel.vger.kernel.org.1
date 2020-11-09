Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C22AC93C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgKIXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:22:14 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF92C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:22:14 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so11664959ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIDKK5avmAIYO1TU73iZKWcfPJP3vxUvkk4uRTGvp5k=;
        b=Nv33gF0JCvzJoMCYb+fppXhu0RxkvHPC38IK2QrimyjQwExqvQZgY/mPrvR1zffxCf
         78EkZpqZRuoV9wCOJYKWmOXRQ8KrFQCL4FvnI8IBKDSJZ4SXjGjfOAWvWpjhpKFlvDkf
         KGh/AMgwRWTZG6RNGb7f66F0xzDMQmgzsMeHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIDKK5avmAIYO1TU73iZKWcfPJP3vxUvkk4uRTGvp5k=;
        b=L+sx7OfSTTZxxE+xRQ7AhUWKr+Ko0WRsc2wq5AqhdZKVJE37csA1LWz2U4gNQXfqei
         Q9zQlQbiQ9hVF5aCi41uP80cDyRAuj/xZsUiwJR2AnLwJzlxnJe3Mq03eIQH6MD5i5w6
         lHiSVGFxW3+AON1qJoYM3VQ7MA65YdoCrgiN0iqOB5ycE4QqqMj2jsS6qpMI8DijA8vC
         vXnbr9WyCLVED28oReSxSF0WloBTkDbtf8tfkAB97T1dBtvSAT5oRKaazs3JGNN/YWDt
         K/7A/PQbrQE/ze+U52lUWK3Ait02mqjnOJLFbLHxjLIrLKjHmyLLmBDlUPy/qtr2Mu29
         i92A==
X-Gm-Message-State: AOAM533d/jrFm+c2j7QbAeC4SmpAjKQWEtkQPU0B7BeNpCDRQF6242Ec
        gvY0YJeIHjOrAuqMVO6aSoMdbg==
X-Google-Smtp-Source: ABdhPJyq+RaVSisC5PEiCAJEeY1T6z+2e2imJCEIuSOhw1BxTnzPtDsZRrE6rDTBBWz9baKjmkdAUQ==
X-Received: by 2002:a5d:8151:: with SMTP id f17mr8268605ioo.129.1604964134095;
        Mon, 09 Nov 2020 15:22:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i8sm8003592ilj.1.2020.11.09.15.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:22:13 -0800 (PST)
Subject: Re: [PATCH 5.4 00/85] 5.4.76-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201109125022.614792961@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae1eb0f7-003d-6c65-5f8e-890b955f6d12@linuxfoundation.org>
Date:   Mon, 9 Nov 2020 16:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201109125022.614792961@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 5:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.76 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Nov 2020 12:50:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.76-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
