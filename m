Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D32912D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438108AbgJQQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438049AbgJQQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:05:22 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4502C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:05:21 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b8so7708235ioh.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kt88k7cgvlBTGEMPiFjZkBTAQFQ/LtHbDdw2jx7bcTI=;
        b=bB+KZwNf7yUKQOs75MKlzd5pBaFT6ECVE9c5bmJUUTxtsF+sLr0w8nxfvQKN0LmOJI
         bgLuxDj2viKWWOiKzFEA6w+Mz6PXWR4z9pW6eWPGykPY7251xht/A6aS+GAfnDs8o3Gc
         7JHPRa/NaSBEbygeHVX29TKEpevcGfcLRFUDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kt88k7cgvlBTGEMPiFjZkBTAQFQ/LtHbDdw2jx7bcTI=;
        b=Q1xO4vfE9H94WBhojlpeq4mm+BAB5x+fV/Lf6DB9xHkanBXLKJIjMgeH6234nB5T3E
         K4lRdZ0ZIoPIBK3B/Zd+qK/q3LroHuUXcPAnzeYA6edlWCjMWQk/CdIm7HKepEa0Co3+
         3lvaPV/8RVukln/3bHA/4YhL8Ui3RKuHW+G2KnLbuyhgi3MG9HIv1sXfrRxfEBDabJZ2
         HrtwtbWY6NCyK/wNatKUB32vBMupN1VI77HOOZNIFQGBcMhzusUfVMLN87L5MN9dwdqi
         CWshMQpVZobjFIGAkr+rsX6YYbq5RFmEGAZa88ohW2iuDZ+915BkaXWUFSPvF81M4kFi
         ox3Q==
X-Gm-Message-State: AOAM530Bud3xFyzEUbAfhBS22+ISK+lMu1OcPUFFDzHgmzbDLJdsi5WQ
        sPJvbtnHm/f0uUuMedCg/MvD/Q==
X-Google-Smtp-Source: ABdhPJwgkRbgbRYD1JqvUcamAQjJ6cM1pb/nUgK3i0OzUzygoZV4RY8mwQTq3iRRQwcdVUXOwsh64g==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr6114365ios.113.1602950721247;
        Sat, 17 Oct 2020 09:05:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm382538ila.42.2020.10.17.09.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:05:20 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/14] 5.8.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016090437.153175229@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2e0ac91f-a686-370b-0eb9-41c4621aaed4@linuxfoundation.org>
Date:   Sat, 17 Oct 2020 10:05:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016090437.153175229@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.16 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.16-rc1.gz
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
