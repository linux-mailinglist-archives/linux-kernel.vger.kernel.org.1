Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCA28DCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgJNJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbgJNJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:08 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F4C008596
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:27:52 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so3109430ior.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yu4fpjGA/oNpI5MWBMijCWxJVEX2ijhPY+B6Nfm/zME=;
        b=Rg8q/mDVRPBpU1kkF6A3oKBiifNlO2HpNY/hcnO/SV5aIuSLxhOSq9NHjvneZgm4BA
         onKhkqiz2Kd+18P1J0dmGZQwICP5bKryPvaprzoArfJmHC1xx9oHaasWuFD3gQ5X7JBx
         vzUEsQuYfNG6TcI94dQpVpqzRWzM3VaBk/T64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yu4fpjGA/oNpI5MWBMijCWxJVEX2ijhPY+B6Nfm/zME=;
        b=XIQjT8UUH+3Sw9EaGs/4ecg9Q1iOf0a31f5ReA63aa0qCy+itETljVhPWIXF9ICDTZ
         LkYsTkoZLr/3HI6lVOLSx3TRYDwo5OBGzHj7P/RPj3mF6gtSFuat/+Q5Ze2GZAaBod7v
         Shjqp7J/WdfE4WITInhuXjwGXWwwrGNajfMR6fZrLtZY7WYziG59W5N/MfOIp1yI7hDp
         8285l+EySaTIItcrnOHbEZkFj01PtGCcQ0RFpDN6GKtRN/xN5P6W/Sj9cYHv9Ta+TneW
         ouQK90V5ky+5unoGXzFYkGbQi+vKBA0VtxfO+EXd3xukjdg3iwNJXJcgaxG4gZy81IHS
         quAw==
X-Gm-Message-State: AOAM530iHzjWfiRoRKPnc84i65384x/OyPJEHrRLtfMR3L6DTzMzlT9p
        TVbRtQ8JOVQP5UZ0ny6K3kGXqw==
X-Google-Smtp-Source: ABdhPJxDNiwNBnUnvAWi1jVfc/G8wn5dbP5eC5gvCkbeviUO7wpHoQREGnsF3FSzalWTlxqJmeS4ig==
X-Received: by 2002:a02:b709:: with SMTP id g9mr1272804jam.90.1602638872122;
        Tue, 13 Oct 2020 18:27:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c63sm1839006ill.24.2020.10.13.18.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:27:51 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/49] 4.19.151-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201012132629.469542486@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4e13d25-791b-2f61-00ef-12824e6948a5@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 19:27:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012132629.469542486@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.151 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Oct 2020 13:26:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
