Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA724139D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHJXMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHJXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:12:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68909C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:12:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v6so8651156ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SU7C5n0mjZgBQ0rPDuKYOoV0ucFHKRmKd1+rkblTeo8=;
        b=G4qB9y699W6Tzpa3363a9KER4rMzBEBY+csm7xk7oWiMyr3KKdnEmCyH01yCtjRcpK
         eJJepQSDtDcdUPCfyZ+Fx9Yw3xgTZnfsX+1m6GR9i/rxemYVGo2EtxgMkkAP4j0Q/DtP
         52R0G4RfPd7nuEYCIESOhV1rF2kpoOOLtlksY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SU7C5n0mjZgBQ0rPDuKYOoV0ucFHKRmKd1+rkblTeo8=;
        b=ClQSwhV+Ae2wRewVYKQqnC9sz8kUaz9RxoCsK6Cj0/7OOHo2UpMqbTp78NOJozv24p
         tJSY0gVjStNC3nCUYXg5Dxlq7uPufJsxEudC0gbKxpMRCbSBAiys+hcFhy7KOy6SLPio
         GuC5NtPc6qeoyvfi4WDJ1mYIHS1TDbD9rcYU7W1UZInL72sNiKp0xaUmQF0yUpQSvpRY
         dP/8ITdR5BwH17mZFLOvoOvNvmflzNkbZujnCZd3Mp/WjhJRDDtmA5sQsdq0/fQlmfR7
         /Omu1f3r4CB5opZsYoqf2nmmWeuu7Abkcgew8Wec7xwUwKM3q8R4qb5KRJJbUSQCtKFK
         OcwQ==
X-Gm-Message-State: AOAM532SQ9UYDWvMH4KqV9LbdQQx8chvq/nM7Rjo9RO9f18hqw6dy2V8
        ABnX7y4HeMgdPe1+HOZ14DheZQ==
X-Google-Smtp-Source: ABdhPJyIzznkB3XtO0QPID7PAzRM5l8q1dR2dWWHNIjl2NGwXaermQjcy/s51YfWoC2HyFbVKRmIjg==
X-Received: by 2002:a9d:7405:: with SMTP id n5mr2782246otk.286.1597101171176;
        Mon, 10 Aug 2020 16:12:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i10sm3945874oie.42.2020.08.10.16.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 16:12:50 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/48] 4.19.139-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200810151804.199494191@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <abdf0790-e2b7-c36c-ab0b-b01e4df817d3@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 17:12:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 9:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.139 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Aug 2020 15:17:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.139-rc1.gz
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
