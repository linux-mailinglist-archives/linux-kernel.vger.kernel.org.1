Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454241F5B22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgFJS2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFJS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:28:34 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B3C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:28:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u23so2479573otq.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zyv1EVC5aQ7p40tg97oP6U8UUyPJu7Y8g2caqHmmDMU=;
        b=JmthF9888oAGJCcqQME0wV2BsV7zzmVSwLn3tbKObFtqJM6cwBJU76dSXH6zyfSFuV
         8udvfTCNLy3oTQr4YqEl6PpsfDV4HsiyNWq+T1y+zqqsLwx8hhehv5GYoqhKhFFZADAb
         Mt4iF97vmgS4f4h2Xy2iJx+riY2ezAvSgqs5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zyv1EVC5aQ7p40tg97oP6U8UUyPJu7Y8g2caqHmmDMU=;
        b=Ubw0OOWGhaZDp2L2BlhGf7a/Huj41FgpnIFRLT7uK77E79uCzdpelc8iwyIybO6WET
         o1svM8oCMtB/A+TgUzG5jxaGwTP4Sp339oWB7115WKHrA4h3tA9oAXIu+8zYkYqfs6ZW
         KyIHohFFe3vzTonK/A6yqxYjSQN2yBU7nnY5ytT6KmUjR1W0+TzBaeF+aj5p/V+AKNG1
         hZZz36WE+VSZgJR6rDgog6XayiPe80WD+YD7n4uCYWkc30z4wOFZwvq3JpG4woHuSrsq
         wQsx8N75Bo0LdBtwEwPUMFV6Ksre3tuX6KvDSn3BjZRNlEhl2Jkrt9lMf1SoQ++K4g9E
         1hDQ==
X-Gm-Message-State: AOAM530QdzLvZJcLGjlO5c7WKPl6/cZLZD+xaTOSgZv3+pqib0MQzoqt
        pCS7y7IVofiPhMTWCibvYmKxDg==
X-Google-Smtp-Source: ABdhPJyoPbqBrHmCEpSP2rYJC3OybCisfNTjpANhnhJoNrKpjjhZ2j4130VgDowrT04pkISFdnN7qA==
X-Received: by 2002:a9d:7b46:: with SMTP id f6mr3843182oto.286.1591813711180;
        Wed, 10 Jun 2020 11:28:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g51sm162045otg.17.2020.06.10.11.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:28:30 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/25] 4.19.128-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200609185946.866927360@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c600bf6-f032-ae5b-76ff-907efacabf8f@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 12:28:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609185946.866927360@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.128 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 18:59:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.128-rc2.gz
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

