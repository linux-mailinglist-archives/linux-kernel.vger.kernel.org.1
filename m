Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0029D284351
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJFAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJFAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:24:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51767C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:24:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so10580701otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EV2rkt5B0yfq/E+WINti7RyCLI+0e5yMrP1wAryhb24=;
        b=fXjzMG8ncFmqYnnWUewyNv2yD193AfJ3+o4dydHQNmZ4EWrVbbEvkaUghJ9DcP8mgU
         8uPet+VeJsQ4fU/FlFgVAk/t5hAm1cTW9KkixH1K3qiJSkYmmf8dsF6W3T8eDPGbvuIV
         tO1F2WfxmsyXSnA9/yX/akdVVwzFF0V3+/vMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EV2rkt5B0yfq/E+WINti7RyCLI+0e5yMrP1wAryhb24=;
        b=eTdliy/t0SiNcqlTLs+X/v4oTDFDqWe12FovVMAncCggN2jIYnBnUnvW1f6lZkD7hl
         kvetq+A2F9sO7B9ku/q/sfSe3R3UFNWr5hoxbNjeiuHYL15Su0047cq/U/RhyQj64KQL
         b9K9Wp+np5cu/ThyeYvhnXbOZDdbCAmsNejMsv847aLOeNA5BV3p/xRNYTgkVL5miMTp
         AOz8Fykpq5ANaqs+40xc5mc62vVMFe5fuGWjv28vaKlTeHI1Qb5c305pdRBihyS4CF/d
         YfHgd99M9BK28aVY2fBMbFTVpTtnVHgXKj7M8I1MBiN2NWefFCy0zIwlsG8Mkz12f8gJ
         U8gQ==
X-Gm-Message-State: AOAM533Zfrr8vDXC6bweZtz1PWRK5zCLEykYagmr04cJDD+DVNpRgr0J
        3ce+Vtri1eGbclW83gvTjqzn+g==
X-Google-Smtp-Source: ABdhPJzN3K35hpZKEa6+3PPEeN1zwhaXcYDeDKWaooLzctJWvAk4MNyO2eV35AuxREMM3BuSOPxyFg==
X-Received: by 2002:a05:6830:1f2b:: with SMTP id e11mr1321976oth.296.1601943840759;
        Mon, 05 Oct 2020 17:24:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o16sm438513oic.27.2020.10.05.17.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:24:00 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/38] 4.19.150-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201005142108.650363140@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a1380ce6-bdbf-18f3-37ac-25bb9414d8bd@linuxfoundation.org>
Date:   Mon, 5 Oct 2020 18:23:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005142108.650363140@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 9:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.150 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Oct 2020 14:20:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

