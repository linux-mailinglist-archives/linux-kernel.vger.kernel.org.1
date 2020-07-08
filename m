Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83615218AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgGHPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:04:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:04:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so19552845otf.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qAxRhOVTsHpW8y+9qH3bw+T9CM43zkyDmvr5lDcILZg=;
        b=Q0PaE52LKHUSyakI1IMAGkOYy77ckAvd47pas+mtZs0+gJYxQm8Bme/8rp6wvaKYhg
         /Ie4EanJit7+tCWnWHHXTX6q+28io2zNYlrzPFHDLPFRvMCc+M7KU68CtxE7Xv0F+C7D
         cIacLbLGu71ef+aPHkOao4RLriE6cmdr93PHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qAxRhOVTsHpW8y+9qH3bw+T9CM43zkyDmvr5lDcILZg=;
        b=Py9b/4PnQMKKr8QJEapYcF7lzz6YQlQWJaf/ldt2GTxjpcP+GQvx6UmEUsDaHF8HQL
         iQIO9FI5DaUs67Ff9+Ve5XDKUM8oMXR8dD99gdsW1krVDyGhK4fA9pog47qRfPBVg61z
         eoNdyTCZVGJ7Wp3QAnYNNH7IQCjx3sTld/vkcl7Gw6dQ2sNOlC1NFwP3RJZUowe9tUsl
         w3Rtz5VQpliVyoTG1b5GWloobpDgggKfVA8E3GzWfWqe922LB1ZaNWNXVAliLGJkTqf4
         ulv7+AplDenTT6Zb4FdUDn3HUTcLYwrNrUjtS7OMZHWx0E0SlxL+t6gR8SAZiyCIaNj/
         fFQA==
X-Gm-Message-State: AOAM533dinmHV0TY7Zh7h77ZMdofq2jn1ERol/ATxH/u8cuI3sg3QNUe
        bpIipPqN4c/3z4Q5EtPRrxlunA==
X-Google-Smtp-Source: ABdhPJx5BOOY4zlhbKbICdwG2WXtcJnsE3cai+2+f8I5p5GtkBQnSYmo49sufjqBR0L6PyWQJVAV6Q==
X-Received: by 2002:a9d:2f0a:: with SMTP id h10mr16227167otb.314.1594220690094;
        Wed, 08 Jul 2020 08:04:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y7sm20360oov.26.2020.07.08.08.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:04:49 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/36] 4.19.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200707145749.130272978@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43dbed05-5481-1ca7-6f1b-2354e166d474@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:04:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.132 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
