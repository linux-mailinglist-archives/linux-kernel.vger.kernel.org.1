Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F208727F2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgI3Tua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Tua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:50:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:50:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so3021440oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x+S27V5N56hYy2EioGmGgncmnl6DyluScoxqYOs+KpM=;
        b=Z3OMIYtL+6cVrlxLkpzjkW4Nxc1IPA50PQoYbCWpkiQmc+RuOYjoF9Wy8X25IfukfM
         LE4UroWLjuERpHkAjM/Q8JI+2USVETBA3/fTdFDRDjJu5L+tN0+zIvcWPIUKKO7P35NM
         gYGAnYa/nNFT2P9xYR+Yc7h2nO34sXAgW9Dms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+S27V5N56hYy2EioGmGgncmnl6DyluScoxqYOs+KpM=;
        b=UBFaxpDaJuNtMmi05nwNBZ9rXV6p3YD+so0LGrMmUc482Phv55SlBM/Jt2IuL5LSM/
         cJ2DSLU+KxtPrrHSIMNEjJZyU3mm1FzNovxj6YZgwqUBUSkXvZTo4TPFoqhGwGKje+W1
         zd+CtjiTZ/COaoy47sfmdulY0RPn9PyJ1gnATmlTOoeZH1Rux8cpRIwi03vGVD5I8eFd
         GgPAu/RvUe1MqbG1AZEZHvHYskUaem5UFgSbgplBe7oJQ1PsDTIOwngSa2/iFsSWucOi
         qW7DKb0AakdLc2e9nfrJfYBr+vodo8Knbt8NN/nnwfNcNO1nPk2ZgvOFTmUwbkxasGDk
         vWeA==
X-Gm-Message-State: AOAM530kSEZVp9N3p0IrThnQbtUFzupWjAKy+aQGeaWPEFHoOyLppdff
        xU2ndw+EgH87JIYAiPNOnizBeA==
X-Google-Smtp-Source: ABdhPJyyjRGnvhc9CgKqsUHbranDgjFk1fhnmt9o1gAIfxkiKp2vkqeu/ttz2CThRHAKrlGIAeMNbw==
X-Received: by 2002:aca:1108:: with SMTP id 8mr2236914oir.74.1601495428037;
        Wed, 30 Sep 2020 12:50:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g26sm603689otn.77.2020.09.30.12.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 12:50:27 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/85] 4.4.238-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200929105928.198942536@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5adb0947-cc1b-88da-95b1-4e8fea0cd324@linuxfoundation.org>
Date:   Wed, 30 Sep 2020 13:50:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929105928.198942536@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 4:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.238 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Oct 2020 10:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.238-rc1.gz
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


