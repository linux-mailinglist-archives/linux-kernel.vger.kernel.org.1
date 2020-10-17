Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635D291305
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438707AbgJQQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438389AbgJQQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:15:02 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F8C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:15:02 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id n2so176500ooo.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HbhgCYWej0NK3YomTLnitrbOqlsaZby/60JQVXI3Lf8=;
        b=MCHbJrfvYFL48AyanPvdFGlEByg05Jxtf417HKoqUOK/erncOVHC9XzFMlbHxVFgXU
         t8xZpqpzRlW1XE5fXZEkToXWdRto+1HZdZDn1SfAZuUNTx8EFX+/VLEwwYDB/TzZEmf+
         43918MYcKYcYD/P7HEZAWOPMsPIQioK9XyAro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbhgCYWej0NK3YomTLnitrbOqlsaZby/60JQVXI3Lf8=;
        b=kuicAopREqeUdhCoWc4oIjlh2SOBucMdgw/saodm1FwhYnqhAg5SFg/5e1BL+1+CxV
         aNVcOcHmUujbjHQ9yDva5EoD+ATkXhtUonstNccLlspPlh+r//n2EysOEjWfnGsgLC05
         mZo5kXDsqtGVG6Sj8OvVFCusbe8I2RPW17AyNqvrNDJUPphWgcxbq8HMfwodhOdsv8yO
         AdnNMvWewnnDuYFyLge2bJKImm3p0brvzspmUgorMxktKZAEkrjjEUEBYwgN2saAza+o
         d28NN7mpJ971sZkZEJjBmCV0GNA1xIW6n96JkHOsZSpgPRIel5+H1uuVIILFeqNDScLQ
         MKAQ==
X-Gm-Message-State: AOAM530AfzvaZ0RYaFFBFbcriZnXwy2pf+pS0VPmfOi+zX7YgutmPp3Q
        8IvvdC/BKbqlsXj6Uw1ZT10wcXF4scNK+w==
X-Google-Smtp-Source: ABdhPJxcDDfwA7hPsdD1qC2A6OKa0/Uz6V6D4rsZ+DD7rKF57QEUmLf3wCjWi1Csde3uVTXspdiwew==
X-Received: by 2002:a4a:d622:: with SMTP id n2mr6704860oon.23.1602951301615;
        Sat, 17 Oct 2020 09:15:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x13sm2096686oot.24.2020.10.17.09.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:15:01 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/16] 4.9.240-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016090437.205626543@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db38aaf2-918a-ad38-dcb4-2e40b1d7dbc8@linuxfoundation.org>
Date:   Sat, 17 Oct 2020 10:14:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016090437.205626543@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.240 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.240-rc1.gz
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
