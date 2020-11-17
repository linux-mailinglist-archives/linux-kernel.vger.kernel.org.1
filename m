Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B22B7130
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKQWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:04:06 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D33C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:04:04 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d17so339610ion.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuyG7enSLH3C+ylnXG8w+GbI5uwYKAX52vWcxedXXNw=;
        b=gTsO8g6IRE9TIWivpeuOir/sHEb6hYeljejWhQ3teem3n1kbgjnIvYRRUwwNOobOv9
         yuBpIKv1h9qWu1jR/ZcAPGBZbDWHaSSdRVHtwnfvwVvfY6Zwipoj0IVtUV3L9JAkkdbb
         zIAjDjyccm3J9X+sjFReu41Qg2Ltf1HvKmgzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuyG7enSLH3C+ylnXG8w+GbI5uwYKAX52vWcxedXXNw=;
        b=NtW3UkLDbaaXms7wjimPdtNdkAj6ySGtt9TecgY98dSstHMLqr2gTVDESp3/u5/pPy
         TErUnp/HiYzcGjA0A9Fl7J9w0B4lICb3CqR4lF+t07byA0SfoBff9xRldfilb0MzKqQ4
         2KfatjHrEKt6oxpPxJRBKbi9m4pe5ZTGixMb7xUBC8fO6SJkbCTpR4ZXlL60zZafbm/Z
         /S8gXqIVFT5C2X9m9wF7pWL4+1YQi9nsh1Mms1EB+JEWQZUbNPRNPCjwvpRG8LE95fiL
         Klrio1LzUkXRtKXBuz/wW4VykQ4HwEp13y3xu5oMqE5uz37+Xg7oZ8eFJyu6LvIqSTAP
         YhTQ==
X-Gm-Message-State: AOAM533ZfpzgUQLB1PDxMARTq99xRUDdIRu0pAfjRySYT2ARjXIsEaGP
        HX7mEzUxYz96FfV2bgac04GwnA==
X-Google-Smtp-Source: ABdhPJxQ62X3gAi9jbh6oOCZlHIC57zxknCpvMk1Hq+LKPgYCpgZvfpJV2SlwaX+gXn2kj/gEYC3hg==
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr5283838jaq.93.1605650644043;
        Tue, 17 Nov 2020 14:04:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w81sm14271467ilk.38.2020.11.17.14.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 14:04:02 -0800 (PST)
Subject: Re: [PATCH 5.9 000/255] 5.9.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201117122138.925150709@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <06bf0c38-a484-86c7-5a6b-5191c79c143b@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 15:04:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201117122138.925150709@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 6:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.9 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.9-rc1.gz
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
