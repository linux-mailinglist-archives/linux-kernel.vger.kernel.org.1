Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C732CC2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgLBQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgLBQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:58:20 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47EC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:57:12 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id t142so511645oot.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKhZCXxnh9Gr8c+y0PLwVDYCIRPAiDoBN92awWJ4Pgk=;
        b=MQ/qXwYFdc7FPet0cFzu8iQTEovVyZNX9T9uZFpSw6YhdI7OQQEAlwuuOjEX4qlJRI
         hAhvGdGEvQgzfW4ZfWWjAQtYwh4oh1XPQeq9zyUVwzpw/L81Qie+W0yu835ArhjPMkG+
         RSkVsTkWtsuXP1bUqeh5blHrwCwtbyByXnM9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKhZCXxnh9Gr8c+y0PLwVDYCIRPAiDoBN92awWJ4Pgk=;
        b=YFLke8wxdHnpOO2GiZsJIJ7zFENqHqUCMQCOdM0sJSeF6uib/AFav/3u/YFUoFZ2cT
         w5fH60mei2ivb6Si4tW/mw1YUvLMXg1MxCiIcfjTTMaOXCsDQwFqApsULiJXoDOi4hAe
         Ohlal777iWkJ2tvwkM3v1teI5UOPWhU1qDy585gKSwAaQdM2k8ttd8IL0Q1izX8MzTxp
         hR4Y7tmhPKjaGxaQE1kJLSvhs3LCMUcmcfwWEcEdmRTLtG/je994qNU4BGzWX1DQHycC
         oAkFN7e+Sf/b+vEcUsbk/sGJFXrJHYl5ire2iOSnTu3HoExSAu2V0eNE2zsPupo6NCSR
         AfIA==
X-Gm-Message-State: AOAM532zfFKgDsh9Vc8mAZiOK9Q6tB6DwUPYUYjmyyeSTt0Fo8OEhJjc
        qU88pzH7xGO8rJMnR4dclwuVFA==
X-Google-Smtp-Source: ABdhPJz5+BS97kEJVi1ml86jmoZoKYcSDfBwXBfGqmS6yM/YPrT2BXkcGFp/hRUDPdI86mTpssAF1Q==
X-Received: by 2002:a4a:d21a:: with SMTP id c26mr2392045oos.68.1606928232091;
        Wed, 02 Dec 2020 08:57:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a4sm479616oot.6.2020.12.02.08.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:57:11 -0800 (PST)
Subject: Re: [PATCH 5.9 000/152] 5.9.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201201084711.707195422@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <53ca0c70-8cb2-68ea-25df-07a26318e4e3@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 09:57:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201084711.707195422@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 1:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.12 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.9.y
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
