Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D194249102
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHRWht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:37:47 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD45C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:37:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v21so17546913otj.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8JaudXSe47REaUhBRI37iwPCitU5RP8AxqGNR29qyYc=;
        b=fueNB182Ajr3jwXfkset+r8uY8pqzcomkZu0aa+JBLaEyLU/0P+jUshhm6DaKS6LFo
         vBU4mjE79artkabyqpPO2PvJRqyYsr7Xemog3FUpwcQB10Y/fCKquWHt4jZ7slULpJ5E
         2fGcbvJHufC06yUVbR8J1yI8pVb74qEGHt96Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JaudXSe47REaUhBRI37iwPCitU5RP8AxqGNR29qyYc=;
        b=NGJ93DPdE9aBIOVrlctU3udsvI1CXw+XCqz5GATnuf3wgNlX2iZbkIFLQDc+0RbJn2
         ypgn7jjuSVMUWLAQd7ESUrywzp+o+RG0CjVd7Po+u1UuHdGTY9oK4BVPNqb0+hNW82IE
         q68UTS6O1yws06mVhKJeD58aNH6KdVG11VIibsF41TxWSOYffkm/ufe+5yRkFhs71GyX
         x1DgjpxBIzoeWhl1JhkQ6SeJITVLuAEwsoNXyfvaP5e4yUpuhQTFx9n4vZ+XUxM9Puqn
         qsndd88lfpbBcWoJCWJZZ8TloEKW8N2EIkw7Wn8KkCZQ9024gzVTKSK4oo1+2cc7lLA0
         awjA==
X-Gm-Message-State: AOAM532eq74hvEZvz1jaHfXwfTx52bkDXCVJJAY3Td7evsupy5Q7Vqhq
        0PFH3HNnTzVFojBhq4Q6lVxeQw==
X-Google-Smtp-Source: ABdhPJxmFl5OHIe1QUDJ2v3wnAfEGs7SgjF678e5Dbzdv0cpUPo73Vl4JiIIIBRuy/E+uVCBdG7Zvw==
X-Received: by 2002:a05:6830:1286:: with SMTP id z6mr15841798otp.240.1597790266813;
        Tue, 18 Aug 2020 15:37:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s135sm4212896oih.35.2020.08.18.15.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:37:46 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/168] 4.19.140-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <48c42513-7f3e-79be-f892-d716175dcd52@linuxfoundation.org>
Date:   Tue, 18 Aug 2020 16:37:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.140 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.140-rc1.gz
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

