Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25328DD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgJNJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgJNJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB386C0076FB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:29:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u19so3095843ion.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vkn53wIH96OoNwnk8pDVt8nYl9FQdlL2nesW/SzmZeY=;
        b=JERaY0M090r5CpiYVGdY44ZiZZU2nbwYpT+GVAO21q//R/XNCujqD1iI05tn6dwL0a
         plfip9qggsJhPP3AyQt7dtmYpCL/xl1wfQ52boEW/KNvMjUSsBrtdMKixz+lSznTq2A4
         rEMGmWGlTd1mBQCfojXfA72sCJjkPf/M1n5tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vkn53wIH96OoNwnk8pDVt8nYl9FQdlL2nesW/SzmZeY=;
        b=C4hMtW0UgQpQsDlEFH5wqCgC2fCE8wlH3Qw09j8ow67QMnWpR6zJGYOAIhACXCGkB+
         b1T7+fhKtqriPzbWDhE2yWjvZ8Er6uCqTD/QocmKWjxFpNV1rVBOKofZy/IMmOoHoZXi
         6akf4yLssa1iah6u0M1ExM8sNj7LZ/YLFmeTsR3f+HZSnAeqx7H1tdbp+JaFqEH8/lRi
         pGnBXIxtJvE2vcxkNyEQpo8tsHVT1+RU/9mtby2L054lEzn0NueOd2GrvDYvNnIdz1Ny
         p2q1dN0L3s6dVr7gz8BZoUJNdHPFHvtF6DUf38WnRWjElbdDQNiZJqQ6EwKCBIGv6qgc
         womQ==
X-Gm-Message-State: AOAM5310Ih/V1TNPYnmEmBCuu0+uZrRq6sGkDaTXq0O3XigZ5iSj/8U6
        QWR5NyPavunqIFPoDlKnrnpyFQ==
X-Google-Smtp-Source: ABdhPJzb5hjmtNQOXDfw2txoX4BIqeT//jWJHwRI63cZzTk8L0gicDNJDpFlQtR26f5syPh87ZcQVg==
X-Received: by 2002:a6b:4e0a:: with SMTP id c10mr1116606iob.120.1602638940083;
        Tue, 13 Oct 2020 18:29:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a11sm1393329ilk.81.2020.10.13.18.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:28:59 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/70] 4.14.201-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201012132630.201442517@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a7bdc000-d7e1-1bb9-3ae2-0f63460f064d@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 19:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012132630.201442517@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.201 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Oct 2020 13:26:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.201-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
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

