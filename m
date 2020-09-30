Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75A27EAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgI3O0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgI3O0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:26:23 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A80C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:26:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t12so1857397ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXCGZW/GuM/5IOGO9paoSAgp1GRJ9/f9ioRwrrondRk=;
        b=hVT5IYuQbm4+R/MaWscloTgYa6KLFIYIP+yvBJFftu9/VNQXLqsmsTkhLIxeffa9Gm
         hoIx1BmGvYx0O9XzM0rS3j43Q0gjQM+n6NgIfLYD0lW9VhuBhFrZRTw0cUNauzSyXHa4
         aYSpbhfzACd+dXcI96PmOt3EmmFwzYmFkutOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXCGZW/GuM/5IOGO9paoSAgp1GRJ9/f9ioRwrrondRk=;
        b=TZItwxWLgfavGPv5EL6oeOaq9u7iFL4oYPT1t3heJXGeBpcSB1CBK1Mgwgj5dkrU5g
         tKY047Z7KKN6UmfJPU8kKu3O4I/nW2kZNN7ypmWi1kM7TNSp/njAv3lxHKJRRs3Ldwqo
         KKkijGsCdKPkAi6V4Wyf1pknJ5uBYHqoduoZb2kNfi1nYEkjcV5jwZs5gFZKrCUBP4QW
         BQCDqSpykLFcTGtfXSVWhmKvz2FV1Wbdh+gbLF2wNMPjWYDuM2NGFnzn5AOshWxoLjRr
         fGcQxdJL3/Q2ybIBkAfpN3RZv3z9/xcAfyoAVHjnjnpe99JDzRPJ/CU1TMzZPU+GKl+P
         ZLMA==
X-Gm-Message-State: AOAM532tDYqji0P+pORy/jbYgezZfnWC8ArNZGU4AVCqvLaqVwdVFFCl
        LHzsmK9Lu3hvhS7iLrRgElxucw==
X-Google-Smtp-Source: ABdhPJwJq99LCiW4dbxu7/1wfjBE8vbMmdzUT70U+UHn12UbveeC1lTwiANg/xU/9r7IJZite6cnpA==
X-Received: by 2002:a92:9f56:: with SMTP id u83mr2237059ili.30.1601475982321;
        Wed, 30 Sep 2020 07:26:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm1058008ils.88.2020.09.30.07.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 07:26:21 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/99] 5.8.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200929105929.719230296@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e54e620-dbeb-0a39-b641-3fce97267b16@linuxfoundation.org>
Date:   Wed, 30 Sep 2020 08:26:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929105929.719230296@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 5:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.13 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Oct 2020 10:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.13-rc1.gz
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
