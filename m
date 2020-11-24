Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC52C1A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgKXAdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbgKXAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:33:21 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:33:19 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id x15so1995911ilq.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWpjM6rlLhjmnGtxI8kBhmMyiOX5TQhyzzoqqJ8J83I=;
        b=LKMewhuJyrSIODc191fQpag/yN0x/UKLykowviwepF5SglqGhUrsKPB5hx7X0fFHh6
         KV1Cw6RHa0BkJ6vRL3atM0LcStxtW2AoocTMbuKi58Yj5zvTgeARjBi1IUKFd8DKAH6A
         RaEfnCl/olg48oFdQuFqZmi8HA6pyJ7oC9Gu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWpjM6rlLhjmnGtxI8kBhmMyiOX5TQhyzzoqqJ8J83I=;
        b=UHvHK58GVUTJoxA/xcDOFE8rt63GcVxTn/D4LsLRAfcy3Sh5wuopyHDFg0mLigqmWJ
         6JroPP6w7lgdEt2fgdt1d3+1g0FRarWq/9fWxmMPTCmmGKanE7q+bmpOx7kQgHhKe07/
         lekUCRkhPx4BaB7GwGpyQniwEU2y4LJ+Pw6/SsGJJkYh8G/Y+zHmGaQMl8UINbx2Os5L
         ZGpGaBaN4mVJEhDhUpNSEsxanGeINx5gpEeJ0A2/eNlJd+C+dzRK5YSKMFMSdPF1RtFa
         LeUkst8Bydt16eDdBiWIM30gADh5mSJ3Udy/sIEqVSq2jBzMFpv81nSVa6aeiucfXsCq
         a06w==
X-Gm-Message-State: AOAM530dBD3ozTOmcSemLz5o6Y3YoKJLjcH2p90cYjEiDAfErFFo7zfe
        0dGlslUcd7YB8Ixh+anXDdDSUw==
X-Google-Smtp-Source: ABdhPJxJNH7BVih9T7IlB2tX9Cx1GoH1aTSUEB9YCka16Pr2/ZWx83wTs671HXbA3R5g0WxVHJWD6Q==
X-Received: by 2002:a05:6e02:eef:: with SMTP id j15mr2094080ilk.307.1606177998869;
        Mon, 23 Nov 2020 16:33:18 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b9sm8614265ila.51.2020.11.23.16.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 16:33:18 -0800 (PST)
Subject: Re: [PATCH 4.4 00/38] 4.4.246-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201123121804.306030358@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c6d5d9bf-93e6-401b-7455-8de10cbac616@linuxfoundation.org>
Date:   Mon, 23 Nov 2020 17:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201123121804.306030358@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 5:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.246 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Nov 2020 12:17:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.246-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
