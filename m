Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCB2F874C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbhAOVOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhAOVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:14:07 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB8C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:13:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l200so10969465oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DS/wgirre7NaK0TzZMFF79cjJGDSA1mZl1Rm2cIIFm0=;
        b=Q3aZA16gTTV62EJQsAEB5xifS2dA3X0GFBQR0debjBrxqymblVxAkl01BanSJq316O
         z/ey47KF1DkpD7EuihxIeZPBTZbpJKh8ScixJUveKJlC90BH4O8y4iAi0sW3HM8BDE/e
         Z/eQcpta2KMR+fIbhqWO9VOMmAIRd1ah2vwjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DS/wgirre7NaK0TzZMFF79cjJGDSA1mZl1Rm2cIIFm0=;
        b=PMOdfRqlyq7dOD7pUp7AMwGDIaOw/4FWXJ7o+eMsSSFjCG8IdzctZB+FdeFf1JGvuY
         XKNC556BqXgEcmOUfo6lt70mGeb12jAKgTDyTutuCqAUv3jb5RUGv3F/U5HseujCgbfe
         TvF4LEusZUf8UEh+gpxSB8owLGQt6sGn+oZ9Sar9bKKV6uZl7yG9hGT9WNtQDz0UAl2F
         TSLq11Ab3YBarJH3EEE3tUZPcNFRqDqyWrj/8dV/NzeYY36p1LJF4GZlu6n/iNcsi6LO
         huv7bpUsvvgflnymDEpLVwLnSyY/ygb6dXtAVcpXd7EAh5nIlnDSNt2JObbV3pKClQgN
         VHtQ==
X-Gm-Message-State: AOAM531HHCmFImV3SowypWRxIqo75JrQJsNIeiiWhKgaSikXrVDwRIxb
        rIlixGdKQaYnIoFqE2sVn8L4jA==
X-Google-Smtp-Source: ABdhPJwIImM70d8xTaZFoBIAZAZAynUPj1dipPtwfWPbAbtMuM5wsmbNWRm+dszp8jh8esP+Dr8yFA==
X-Received: by 2002:aca:5b08:: with SMTP id p8mr7046257oib.23.1610745207041;
        Fri, 15 Jan 2021 13:13:27 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z9sm2052530otj.67.2021.01.15.13.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:13:26 -0800 (PST)
Subject: Re: [PATCH 5.10 000/103] 5.10.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210115122006.047132306@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <64c441ee-1010-7db0-fcce-3483b2da1bf8@linuxfoundation.org>
Date:   Fri, 15 Jan 2021 14:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115122006.047132306@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 5:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.8 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

