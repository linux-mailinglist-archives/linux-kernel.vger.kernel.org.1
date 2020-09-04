Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44525E261
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIDUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIDUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:07:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E3C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:07:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e14so7450917ile.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Jg9VU73gZ+7YHgdtpsBvolMRud2ea97/XzW1kHoQ78=;
        b=PB+WB4sz8fYgYJMqBSzJbVeHpt5v77NIMVtsh4XbQARfKhY9t0ZaCueiNQz0/7CMR1
         hm0a99JGfI9ytjZRLutJBw/b2CPPRvNkJrl62eU1EiX5dvmUkMtUfoz3q8V7b6sp9FB9
         UtSm3ADy+f4knG3zf+JoT7g85QyI6f7MF1evI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Jg9VU73gZ+7YHgdtpsBvolMRud2ea97/XzW1kHoQ78=;
        b=geUHLZWtyhuEUuGWgbWFygzb4ZiWgkqBLCtbAQhargXisSqoaIJnWTcvHcU1CaLhoN
         aKOcaEgEhOvDJqFSKb/yyzxhSnoyIAVOHNmCCMo+cnx1O3kpAeVKAbxYUJ4JEw1p8OJO
         rgqPa6pQQpMwRdF65pH+dlF/2W6Kfn6sOsK15/mn9RYBdU87gWw8gf9VknG2bfrtJHAV
         YsO5MBwcSkHcL0kj6HxG3DHI2DY9NQK4uUryZ+G/XzWSz0NAO5Wh1YMIYHwm4k7llli5
         HLcDnmJ3VpquECmP251YgkTimAOLBp42WeCzn82RJMXwOsCfFVfee92IoZpx9wWU4SQF
         lH3Q==
X-Gm-Message-State: AOAM531/cBbK5PosmB+e0WfO8WuSmOMrt+wkr+u39zBPGcV0NrjQNRqx
        ML1ehy8kJpRWmJTpX+qNZfyJQw==
X-Google-Smtp-Source: ABdhPJx2z9SZSRZAaYo6HLa5BLLirn0uRTUuecWU949nQ+tKxHKypa4/EcuE2B+91TTm77OGO2nRPA==
X-Received: by 2002:a92:aa54:: with SMTP id j81mr9402231ili.291.1599250059312;
        Fri, 04 Sep 2020 13:07:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r11sm3648169ilt.76.2020.09.04.13.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:07:38 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/16] 5.4.63-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200904120257.203708503@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <319c61f6-98d6-fc2f-171c-b771bb528d10@linuxfoundation.org>
Date:   Fri, 4 Sep 2020 14:07:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904120257.203708503@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 7:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.63 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2020 12:02:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
