Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267EB2F875D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhAOVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAOVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:16:20 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:15:39 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id v19so2553792ooj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FJvt87fhgEiBCFCQ/ZE0Ql8XUrXOJbKlo5Bx7IAY4Vk=;
        b=UhqAo4Tvta1Ul515oEwg78zsX4mjwggzj2IhwuLqrmaQwS+anbjuTsEs7k/dR2ZH5g
         /C5WcG2Zb97Q26ZYKSwJUzebM86sWs+T/dgRpFoyCOk33kxRQmHjos//20Dtaqm4iWrL
         vjbZG3zLCehdCCjPyUDQG1JoYH03Y7RlIV4Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FJvt87fhgEiBCFCQ/ZE0Ql8XUrXOJbKlo5Bx7IAY4Vk=;
        b=Fn4n31Fa+O4ajAtRu34y1ulwZqZQBzK8bApjlV0nTblvL5RwrbshUK9gt57OaDgy45
         Es9GuIEdi5Pxp5S0TrGPnzrCh6+mQO98ld4wpn8N+fb0jBlWB8C9ZWp9R8AwR7IYYrYe
         +y1v7uZsP01elLghfxEaKMqRX06tNphJme6jEI2MY03B0ufUtr0Vu69EbdwD0TdFjcCJ
         kWhJ4qFIFfh4lC/mvEk1O8m2oyJzvc+ttemSOEjrfXBXTB4GMxtbeHgFg+LPigQiykBa
         +O4H9e/vhimz+Gehz7DfC7DsfnxwxNeNob/yWPkSG+WFYYVdObdblY8IhOOcoapL3M77
         P1IQ==
X-Gm-Message-State: AOAM530oYJ7p/ueA4J+OL8ukyGCvHcyx+J7f457f9HC10y9bKhrO6dLw
        bT2T94LXzRFBIrBn0jUuUwa3mA==
X-Google-Smtp-Source: ABdhPJzp2H7VXn6ag9LxB3FOgxV0VL2f0oLddf6BC78/FbMdLTuuT29O/gtwg+Z5WepwSz1DL6qoDQ==
X-Received: by 2002:a4a:c503:: with SMTP id i3mr9764905ooq.6.1610745339338;
        Fri, 15 Jan 2021 13:15:39 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f18sm2047781otf.55.2021.01.15.13.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:15:38 -0800 (PST)
Subject: Re: [PATCH 4.4 00/18] 4.4.252-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210115121955.112329537@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0077f798-5d5b-8a67-dec4-a2fd13e58b92@linuxfoundation.org>
Date:   Fri, 15 Jan 2021 14:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115121955.112329537@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 5:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.252 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.252-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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

