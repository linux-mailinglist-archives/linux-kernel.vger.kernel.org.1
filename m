Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAC2675CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIKWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgIKWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:20:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF56C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:20:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u25so9646008otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JlSOuUP84PheRPChzmseazUp+fXQJKe9ypAXFppY72s=;
        b=IUodJOctpkhuq7ptHwiSKLo1rYUSVMIOuR2MEITfL8B2KUQ/fYLWGVsospw0WQnY1D
         2295foSiOHZnGI0/VMVEaUVScw2MPXCcM+mmiA+wn6+OXyxYpNbaMff5I2Lf9bgKueor
         L/LQe3LdzU3X9SuT8w0wNo5ttvLCxRPviHejQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JlSOuUP84PheRPChzmseazUp+fXQJKe9ypAXFppY72s=;
        b=hhQwpCgZM9RL6yL5fmHh6xtJwa0ORnx1Rw4j/OC+behxjkC7y4NcoMswYXa4RDsnrl
         LH7FKQiPsf8Ao4S9vrxUwwPcZEEgBxPY4kEOpEq8mgyQFjRfMtCoUlXz/DqSLwgFwepB
         viLGzzAuiOD46TiiMtxuQgEBNeQTKC+GBjoF4s6FDJIXxjX9mQMawtgH8up/AjK/xEl9
         1mvWr+4KpMcM9ZGt9WiZA6pVP62wkdcCrHPBnCN/I9YDTKtEo0nIk5mDtzZivX9CmTC7
         /dn86p3hbey/eIOeJixb+QqjP49JHRwGAx0/2PyR+kKi8vTJHq+ZAiQ6Ls2g+pdYtj2y
         lFVA==
X-Gm-Message-State: AOAM530UKumdfqgKQiEbHrxt5Tiz0LVkc3xa2unfxf6g0Wru2rV2QmwF
        uBCzXygC1uYDhgdjXorC+cW8Hw==
X-Google-Smtp-Source: ABdhPJzL4BAMCBFoVMiKiE+2s6hu4suwUbwsAFCZOjz956p2atJDZtvAonycYzS8hCb+VKciPypqvg==
X-Received: by 2002:a9d:a65:: with SMTP id 92mr2601480otg.282.1599862853828;
        Fri, 11 Sep 2020 15:20:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 81sm582963otf.18.2020.09.11.15.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:20:53 -0700 (PDT)
Subject: Re: [PATCH 5.4 0/8] 5.4.65-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200911125420.580564179@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3ea817bf-fe93-6c4f-bcc8-23a06e08c6f0@linuxfoundation.org>
Date:   Fri, 11 Sep 2020 16:20:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911125420.580564179@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 6:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.65 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 13 Sep 2020 12:54:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.65-rc1.gz
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
