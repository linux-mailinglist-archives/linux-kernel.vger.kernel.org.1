Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F008129130F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438447AbgJQQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438340AbgJQQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:19:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB51C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:19:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k21so7772270ioa.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9FAdmec8X3Z/zyS0441BsohTt/5lIOTFJXmL6v/ZaF4=;
        b=YgeZfRvQOBjnHabXTlhelcaZB3bXyJk25BY96Oo5tkpnlERJBpqZ0PaBZULn2SY+Td
         1J6CvbtPp/ITSdTUNnWRmdBOiG3VrvxGqyTk1ia4GkT5BC18vZfOuEFCwUFb6MphdedJ
         BLV9mXxe+dNH0+L+Kvj9bLFMU6Y0rc7Ch1l+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FAdmec8X3Z/zyS0441BsohTt/5lIOTFJXmL6v/ZaF4=;
        b=Cp3P4mI5vNAy1mfSHdnZs77z6Bdewt3n15pEA6Q6Bu0A28aK7W89chZCm/WkM+qev/
         sa5ocWkJB3qvUko2pmfGmKSilV5dM9PHXwq3inMtfmjketrwWy7J4XeSi7w/rP38Fla+
         JAttqKFLtyD+9RU5YeqeyG9QoyITBBIj7rOZGzlioqBp25w6EA+1EIUqkNsW0WLP23mg
         XkyYD6HQpkQfDRogCdsqbWwio0WZvyGwMxLZ8pWXcBAm7Tkox1egqlZs0Z+0eYPwztI7
         5cTJAfNSI8GBepeS3s/Mdu0qPmRwsHzED1nVN+mQn24r2r50eN+dcVNXZgrZ5OnAnD20
         YDUA==
X-Gm-Message-State: AOAM532gZOCZxoMiXJLhpKx3ILYFh/5uTnQZyZnEj0CibgSjskm/CDGD
        gLOx+Qwhh377bIWx3lIBfGW/NQ==
X-Google-Smtp-Source: ABdhPJyp7TOPDFfKJ9lvvnlYa5ls4M5vjfAQpH7GG1gHcALkFXtLTtcWhgNrEf0lLNYipiFSjWTa5w==
X-Received: by 2002:a02:6c07:: with SMTP id w7mr846626jab.46.1602951542632;
        Sat, 17 Oct 2020 09:19:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u3sm5631086ili.57.2020.10.17.09.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:19:02 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/16] 4.4.240-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016090435.423923738@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <68e8ec1a-51a1-4b69-e48f-8fa637ac8415@linuxfoundation.org>
Date:   Sat, 17 Oct 2020 10:19:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016090435.423923738@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.240 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.240-rc1.gz
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

