Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70B0284346
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJFATC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgJFATA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:19:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066FC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:18:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so10694068oih.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iCNS2Mt7RYa/vQIW1MgM7dt2+SlfEcRtrJHzkHPD78E=;
        b=BEb24k9fKVTYev/Kp8u/prxqYADD3/O4fgpmhFwNY/aexp+3mte7L2rXaWxWytw+9E
         fD4tn6u761/Zqjmog+h1LAP/eG9HkDGdcgvatftwyXgKhWPxqpHbP/46YhzDMMzQuxy8
         FU5QltJ7M4F5FWpp6wTtPxlJDSaG5c0Npfm40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iCNS2Mt7RYa/vQIW1MgM7dt2+SlfEcRtrJHzkHPD78E=;
        b=Wx2ZWNTxGlEt0UNbRQu+zKVVDk3HCm/f96/x7XRsbzvCmn4M4fpwP30ZXwGoyhz/lj
         37eW5IfZETk3fgBkCcn1cYHvbVHnVpeZyXQJAjzIGlYMB2K+FOI+gqE9AKPa51VB2oqF
         7BwQxo/43zlJ+6z28hhQf61yMeHW1Rv0iNbCkb9InIOcEoxU1IKy+gVvR/30X5+9YpVI
         Di5Pkj6/g8bWMV/3JosizltmMJMOoeyAk42raNVfxx4OXNv9i2F1qXXgtkJATEteRMEY
         qP4oqpfKlEjhazOK5BSHIoyMLieK60zmYI84L8dKL5N0iyixvdhUPFmcuIOhGrF3afKH
         GFEw==
X-Gm-Message-State: AOAM533jlbicJoQRKQEsBpoLT60GhSgPz5QkwtZQ9va75xA9ltfvfE4B
        W0LEvGks8dlNCEyKM56lrnsHYw==
X-Google-Smtp-Source: ABdhPJwMZCFpEf4HT4YvHBdN+JfpItjBRX6d5IetZVjAU46i/+HFWKHv8Mdve7RDGkgHhQR2sU9nCQ==
X-Received: by 2002:aca:c546:: with SMTP id v67mr1211518oif.24.1601943537954;
        Mon, 05 Oct 2020 17:18:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u2sm402757oig.48.2020.10.05.17.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:18:57 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/85] 5.8.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201005142114.732094228@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <796191d0-b72a-296d-1fa9-ea9384597024@linuxfoundation.org>
Date:   Mon, 5 Oct 2020 18:18:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005142114.732094228@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 9:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.14 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Oct 2020 14:20:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
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
