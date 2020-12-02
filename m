Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84F2CC2FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgLBREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLBREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:04:51 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:04:05 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i9so2671932ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/gCmD1vLwNCXEDqlI0OcLeN5pNVy9SzgUhF1pWh3bdU=;
        b=PiGi8RJjquqiTY5nES9qiB0hKoqnguPpcTeBncHHuosCqxkWhGpokHKZPLoDmedMcW
         7LP8xcSoeUL2LLPFKpmwGggLINeSdtRdMJv0y+HL5BPB2YH/ACzzfmZTu2MbwQlQlQNN
         UaxlDR3lztff7B83xms9zmew//vACft13ZpZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/gCmD1vLwNCXEDqlI0OcLeN5pNVy9SzgUhF1pWh3bdU=;
        b=OriCKftZdV4iGNx7gO48su+5hmwWn6w14Py4xvr+UikswWJeiG5hUT+FPdxp2nhPig
         Aru5BfepmxvUzn7cBLyYNS5StBdWcqaPXIKVC8qrdiXsiMWn3y169AeZqHHd47pq1ZnG
         2AqP02gPT5s0YZu1/MV6i+sSAFJoO61PcICyZ+08a/YI3AS89idQWrJXRE61xU2nanJJ
         LA+v+ug4TtlbbzUyb8SW2EISmfRF7L9v52hkoYeFJhEkgk4vqvRZPcGYYeXwtpmUQqU/
         049JjBqLL0fVESBJm1Dzl7/gI06esMvjMZDrzNLnyMSrZespoqv5WXam/sg80jdE7R0f
         7rGg==
X-Gm-Message-State: AOAM532shVqEhEb8IWpMRLTsyzP8jeTNP9f/YUrcrflO+arxipPXV4cy
        08oIvmURlPCw/4AS0Jknc/BiqSQ4KvNZ2A==
X-Google-Smtp-Source: ABdhPJzESqvAMIx/C9E9R3FcfAsizeab/IJ3/5xx5tKvFZ95tEUFtQ+K70r7T3PBKQT040dJTGEEMQ==
X-Received: by 2002:a02:c804:: with SMTP id p4mr3046628jao.110.1606928644478;
        Wed, 02 Dec 2020 09:04:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b15sm1124253iow.5.2020.12.02.09.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 09:04:03 -0800 (PST)
Subject: Re: [PATCH 4.9 00/42] 4.9.247-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201201084642.194933793@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e25a4aa1-ad22-b77d-62ec-ad380b07ca4b@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 10:04:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201084642.194933793@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 1:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.247 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.247-rc1.gz
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
