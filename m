Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201822FF02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 03:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG1BkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgG1BkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:40:12 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A38C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:40:11 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a9so3509706oof.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQppRAauYrBLvA7m04CGM9vhP3Ev72erH3kiJsmnuss=;
        b=bsz1FOx8N7HHVnQ3ujkWHMirW3LyUGgAIooaRcPKrMeeQdZwX/xargv9RM7DmXlffc
         KHtDoQ+zmnLCdrUw9do4jJr6N00xOXAMiuS66y0a9Obt3dVSMMz2Fz8VzKRgNrZ4e37w
         NF5zTPdly/U1KH4GD4agruJscEFBu4x7NpeFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQppRAauYrBLvA7m04CGM9vhP3Ev72erH3kiJsmnuss=;
        b=pKqqeK8jT8wWQdIP9or7QRPnup5cYT95RcfR7kLC0yHXp9DcleSsadfI2a0fjPuoAQ
         Th0x6xujJloTQwrI6MwViyCcE7Ty4f3rYDeC9J3bmS6MtP2phNHod4HoNwnJhZPRST5I
         54j2m6rJxCcR/pjoyCFdw0H8V26kg6DsX1NA3SGlUgQOvXfKK7QfFRENiuGtbzVizeeZ
         WbspaVTige6kg4UI9mBGmtwXaJvILJnFBsnIZKF1fRulhHP6nbPNclQyIF1ARvAtBYtV
         jyPpE3mYiq7SH3NA3Qeg738FpfJbYpL5BqjTZNZd6/eQL/edLbKW0Cfj2+Jw7am1+1vF
         Nqvw==
X-Gm-Message-State: AOAM531djg8u/GHRVs/dGTVlH//jxx8DEOaVxih3VdGRVaQi1Ipp0jAd
        PIXQ8ENYhUWCmg4/RuEaMKYfCA==
X-Google-Smtp-Source: ABdhPJwbi5PABQNxjk56EQPLCOqNesaQY9pvlbIi0GZKt2XVc58UO0YX9PNgPk59rAgFi8vbd5QQWA==
X-Received: by 2002:a4a:3504:: with SMTP id l4mr19839731ooa.90.1595900411295;
        Mon, 27 Jul 2020 18:40:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 7sm2116869otb.66.2020.07.27.18.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 18:40:10 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/64] 4.14.190-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f2bac9a5-8a0c-5d2b-b36b-9de086a67611@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 19:40:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 8:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.190 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.190-rc1.gz
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

