Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07F2DA46D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgLNXyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbgLNXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:54:02 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F6C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:53:22 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id 75so5498399ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3eJutbNKeShulJMJ6BHByIr5qoNsP+5XgU9y+aAUMPo=;
        b=I3ShiVPtYxdHY8ya3r1QHU7Hh4bqnVfTNWKSfhfu/e/UcrRHUSAdg3N1tDPJ/gO/u2
         ZM8z/9OcYT+v8u+GG0Qb5Rs1DPbXrIXwfnpEfW6u4ZVwR7pdfLnoOmCfm2dNUR+0Lomz
         O/qNOLwvKb77JU1fhoQCNqPsXtcdGzHgM/JhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3eJutbNKeShulJMJ6BHByIr5qoNsP+5XgU9y+aAUMPo=;
        b=Ll7VZ69VbizllCTwmYGy50Bg+M5pCuYK98m9SaPnXBAKuIgqSKrxv7GuOLTO6G3JBs
         lBMWPkJglcCbv2njjkShtkERZBKuPPbz41tUx6/JaPocfVzq62kIBotSYDEJjtzFL3u5
         C2xhiG1wXoreBe9CkYOpVx3kJ2uXVw65Mt5vueYuLDdxk42A6y8PmaxJ3bTGy8zwORDt
         upjeLdKY+sAuUwO06zijZTuVLV60Rt3T3pFbhbQtk1Iv3x2sFCLQ0sqMANxQIbgRJNrk
         /hbLEqbCWXM7xLwOVxR6sJyaeYcyCd7o8IuZgFaIf0/09FmW7n9i+hAJBokja5Kh+Hc7
         4IfA==
X-Gm-Message-State: AOAM532B4jn/fY4cfD0/SsnAS8URIKvfg4OMkwOVPFn2uOof3s+6A2R9
        S84ZRQxdOiYLrbGtQtCSKnjO6A==
X-Google-Smtp-Source: ABdhPJyR3a1QyV6byeRDm1xRWVRVRHEtpxprlB7qeCm5Wz9m5XJUFZBpVWLIOAT0XBUAfkIANhNyyQ==
X-Received: by 2002:a92:c26c:: with SMTP id h12mr32106916ild.165.1607990002063;
        Mon, 14 Dec 2020 15:53:22 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l13sm12209983ilf.79.2020.12.14.15.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 15:53:21 -0800 (PST)
Subject: Re: [PATCH 5.9 000/105] 5.9.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201214172555.280929671@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f70996b9-9c9d-6a6d-2468-b00443d83905@linuxfoundation.org>
Date:   Mon, 14 Dec 2020 16:53:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201214172555.280929671@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 10:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.15 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Dec 2020 17:25:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.9.y
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

