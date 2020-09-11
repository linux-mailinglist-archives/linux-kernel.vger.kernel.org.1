Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45E2675C9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgIKWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgIKWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:19:52 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC53C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:19:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so10954062oic.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IOZDiyDMObx9Xhgxme1I+r4Kwu1SwKebZnPCcSmrzxw=;
        b=iURCft50+iYexKK+LfGCcHlL9yhUsBZ75rgROgphX5PUHNi1LmvqX2c3T3FR/8pEmr
         8gzaMYSPQdQ9LbZd7f5R6gL3XkZdIuwzYw5sHzDqzAXPqhZVuGEUKMTiuknc0AtCqIZe
         33Ul7H1vlhXEWfOr0NZHoKmBZE43Fww34WCUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IOZDiyDMObx9Xhgxme1I+r4Kwu1SwKebZnPCcSmrzxw=;
        b=q8+Z45plmveXp675vXelNL9+mzFiinY16z7SL4NVSy3hOIdzFFDJ9utcXy/0sIKljC
         DqM18+Naf2bDKdi6Xzpd5gSHG3Fy5ZCLzgyv2YWlkvfsKENfNOLzTPx2QeEEJWczAGat
         BhCT4AfE+IpCGAEWpkLMBn4cm0aVXfRwp6Kmm7viGZ+AfBV2xjlLwGx8xU+JUzD4NCU1
         g4PypApK8F5yIwSAHHXst1v9oG4Do+oMFwMbJOWpEBsrNCWbuJtT8oXvPj4NtI4gTqT+
         wXiAKGu3eSPThPlpeZ4jxBg6Pk+iURz1g5CE9/fZJBjRUXlYPjaDTIyQBToIscgreEaU
         s7iA==
X-Gm-Message-State: AOAM533AF2BryiiBqX7zwrZJe7pvuU20tyJaGsvGNZKnh0THLbvwOwnl
        WUrdhKB5c9cv5ODJLTJrXme1QQ==
X-Google-Smtp-Source: ABdhPJzBw+2poW/b9QFx89W/rlCZY7M5cJJK3MP96E50WUpuXyUQri0ANvhYYOHBwJZ4zDmszbpvvg==
X-Received: by 2002:aca:1108:: with SMTP id 8mr2570617oir.26.1599862790917;
        Fri, 11 Sep 2020 15:19:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v12sm569950otn.6.2020.09.11.15.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:19:50 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/16] 5.8.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200911122459.585735377@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e96f6dab-ff0d-eea3-86f4-95e4cd81bc69@linuxfoundation.org>
Date:   Fri, 11 Sep 2020 16:19:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911122459.585735377@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 6:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.9 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 13 Sep 2020 12:24:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.9-rc1.gz
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

