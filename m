Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB402D69B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404693AbgLJVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394036AbgLJVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:24:39 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C508C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:59 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n4so7177319iow.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eh7W541r8QY5zvpqKf9LxNMZH8ioprodhGtACUkSbqc=;
        b=HKj54ty6NU8+Ji8QrdlHe1BB0LTuEA9230eyHGxfHQSXaFaWyOxy0SwHNm8rjlx3f2
         jv3QUBRklJiHsrBAzIoKK3DASE0CMSReJuBf/wOlVPjaKA2abdZx/mFYMjlEDepLC+Tu
         JwCj+C2TDKFZmB9qmRiF5h6etu2nlKVXki1fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eh7W541r8QY5zvpqKf9LxNMZH8ioprodhGtACUkSbqc=;
        b=WHLFCbT9DaVyLh7yvlZfZrjH1kur0aJLnz3wuDGzhuqXe8kiUF37Nrp0TvLBjIgr3C
         JPu9ogYncitMLeIXeFLwyHqvDl4JnfJBYbPk4DXKHwBhJptp3qrYaQWrdGbun1pQBTf8
         1I53LdBgxyFSQ33uMtmzdpcK5ivm2SBHH7KL7d38VR3mP5pJJJQF0nxsJ/W0Cmrn40BD
         wtmOyodGNzeFrU9hNFrkvnGCeYHfdC53tSS4TlvwjqD6OaiToRu4kIAYqO/sHjfrvGge
         rt3z5OFvPDsKU4bfK/vgZSBsptO/vYPgQDjDeBl8ZNmiBRkxO5POgE1AdWNhCpPstZXB
         /51g==
X-Gm-Message-State: AOAM530veGaKOW8+nUPbN363vAUyiAGNurO+CAWlwC6Q6mMEwwa0w8l/
        eIc25FQCfWqYs7F8SdP5KmjnUw==
X-Google-Smtp-Source: ABdhPJwUkcYnwoBbAklb0ZDJ3TC3Gx0pk4mnlr0fbSCBi731eT7FPc/r6IGlBUDVkM16CvoiT4UJKg==
X-Received: by 2002:a5e:9706:: with SMTP id w6mr10517966ioj.132.1607635438770;
        Thu, 10 Dec 2020 13:23:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o11sm3084526ioa.37.2020.12.10.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:23:58 -0800 (PST)
Subject: Re: [PATCH 4.9 00/45] 4.9.248-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201210142602.361598591@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d70720bd-1e85-e279-af00-a570c78c6507@linuxfoundation.org>
Date:   Thu, 10 Dec 2020 14:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201210142602.361598591@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 7:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.248 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.248-rc1.gz
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

