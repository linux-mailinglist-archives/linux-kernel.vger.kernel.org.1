Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40CA2912E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438632AbgJQQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438193AbgJQQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:09:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727FC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:09:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d20so7721722iop.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iw36j7PQApmezQ/S4uUEB9jd/9DQJPJ3xQvX2zTf/Bo=;
        b=f2tBFsGTMQvRZpKmGeVATuZuFI542tMD/CLYfbMdMS07b/rCS+OZhunAwpwDzLK3ga
         bb1NOsSvv+yHNLIsIsm3H6M9J+LrCtVH7QGRSGikDvdh/Ill4DGohYRjbXbrFURZtuos
         kKeHInsBJkVHZq30bsH63i9qjGlvKzkcpAHNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iw36j7PQApmezQ/S4uUEB9jd/9DQJPJ3xQvX2zTf/Bo=;
        b=gwj/MPZg0ffO+ivIE9sQNlrqOA2sAC4uIUNbMy6ZDk3jSJOd2tEikoHk8DoOitDznf
         2Ceg4cpeBTzUFIASbCMSpsf0C/eJuBC0F1HNF41dsWBLnx96d/jykNoo4lpw6seOgy6z
         ld2K4tMnojLPa4E1CoefJr0bsLwhlsZ4nkqnbqC3+XshJA/+C28S3A+cY0cjHmCmS2Pd
         lHLFe6cpyX6uST6wmahkkQYE7yxAbiJsPkVYFlW7f4e8SDEfEAfSpKzxOfA19gUj/uD7
         zMwhaxbKMCQc/VdtCLI3qQaccuvX9ONuMMrPk871wTfic673TtHJVaEf6S3VE+V0r3wM
         WBhQ==
X-Gm-Message-State: AOAM53246oLNqTi/75Z16dmv6oM58v9Gwm6qQtBFbwuBNPmLt+4ul4ff
        cdGpNCD3Ph5y/9B6w1lbQjQ0Ng==
X-Google-Smtp-Source: ABdhPJxFKEAQA5dW2y2a76efduKh3d/5wgQxxndmtwbuZYB0ytbtsltl4VH67JDuPx2m4DA1kSelIw==
X-Received: by 2002:a05:6638:dcc:: with SMTP id m12mr6306246jaj.30.1602950961141;
        Sat, 17 Oct 2020 09:09:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a21sm4974498ioh.12.2020.10.17.09.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:09:20 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/21] 4.19.152-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016090437.301376476@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d2e8513b-e45e-ab91-9bd0-4efd5e69da49@linuxfoundation.org>
Date:   Sat, 17 Oct 2020 10:09:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016090437.301376476@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.152 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.152-rc1.gz
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
