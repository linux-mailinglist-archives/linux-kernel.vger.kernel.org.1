Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF882BB8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKTW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgKTW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:29:07 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE6C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:29:07 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o11so11534238ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ShaT5at/15Wk+l6TQvMcSJX2KPbHXeaX8eBWb/OiLA=;
        b=DAkI7GqfxYyBkSk1Yoj+3ra0CFQhecgHSjalcSq5ShUwPFNweEj6NhUVmKB1CI14Kv
         UpQUix6Wddj2iLg9efM63EJJ+8iwDLTSZ9elRHZoqw597LZRBsjwdxhrMdtEFisCS+It
         UGNC+KRCck/XkOUaMF8auUAEf+Q8BmqqR0Uco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ShaT5at/15Wk+l6TQvMcSJX2KPbHXeaX8eBWb/OiLA=;
        b=tDHHa/tRQPbG3uV2n4PUIUT1wSWxhlR/eGEW3jbWFqHVic745CpYkb8azbPcGSow9N
         E6AVII7UoFVRyrjitloe1fi2whgt9GQgaMsR6geUHAqqze+8fq/+88GNwTEGUijI1A9d
         JB1NCCEdMt0F9ZWK6AyBXa4OfPvuKs3uXjkIJT9aibZGw48ADlGcbuKasnZgHouY+z4e
         qcomGt/+gUSUi0qF+qG31l536E8bLoaEpRZpQXbx7Hgesc21bUm7wVRxmnSClmFuLQoD
         x/6PzmkYUw/yQVgfS1imp+R82IepSZYIPUtadt1Xij0Fb59NYs00ypSQR534MlNQ7z5l
         nlEQ==
X-Gm-Message-State: AOAM532RyfcC1GhY729+7vEsZHXHOB2gPTWJa0XxpQwPHL8xfKI8byMU
        N3PHPrFxUgvVCLOPpQwI3nKoSQ==
X-Google-Smtp-Source: ABdhPJzXQTpTP4PGIVMpnACGU85mHTbaATdYP96EszjuPp5+uJoSATZjXTiV+Gng2VWk+LWRgJEo+w==
X-Received: by 2002:a02:883:: with SMTP id 125mr20613873jac.30.1605911346655;
        Fri, 20 Nov 2020 14:29:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l6sm2808331ili.78.2020.11.20.14.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 14:29:06 -0800 (PST)
Subject: Re: [PATCH 4.19 00/14] 4.19.159-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20201120104539.806156260@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6388f273-440e-42f1-5eff-c58c51d09411@linuxfoundation.org>
Date:   Fri, 20 Nov 2020 15:29:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201120104539.806156260@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 4:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.159 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.159-rc1.gz
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
