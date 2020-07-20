Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09722732E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGTXjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 19:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:39:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C5C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:39:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so13663534otw.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cnekmFwCsUzYYdLK7CNLwz76v2dry0QPkNCxNctK1Vg=;
        b=e+TTMp1hcB/1o7Sv5gDNchQ5fnopFX0DY6DRi/8+tmfhii609qlzj3rTkVO8isJ3Au
         Ht/1K0C+Kb3Yilk+a8cPKpP7ScgibAdPCXYj6x7oZwMkfwg5gfUpRD2aU7aGgPeO0d/t
         smnXUIr+JbqgypyJaO+MFqOIEVVLQq2ykceH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cnekmFwCsUzYYdLK7CNLwz76v2dry0QPkNCxNctK1Vg=;
        b=N0qKNM+k2G3ipEj+g69QeG9kIcIVqnemX0+lt0JvTXXo9thw168kEqPv99WxDZaDSD
         JuV1unvG8k2Lm3l3ooAfuXR50675idCnkM/d+9qqvk7mOVdaweFzDRUa3uwcs7fjCBWV
         y973p3as8/YPtA+u7fohuQnifhw1F5fpii2PI7CV3tYnYnVKDL3V+SKbs0pkn5Csx+1r
         2MwUa2d6l3nwDCU89DK1vBuy+HDaXmYk0s6EYgSa9gfqpUsJOYxk8pDc/aO2YpZuIK2l
         raNfvwYVprUbrgNX/2XYfvcEhH7z8kMHabZeIbR6jlbj9/AXXud2DHPZfE9+sa1PFT+k
         nXWA==
X-Gm-Message-State: AOAM531yjRmtrQkBLsf7WElUjayE83vqn6sAN64pSDZo6Nn2RJj1MPBq
        D87v94H0CtV0zEm+ATPyMvmujw==
X-Google-Smtp-Source: ABdhPJzewSzuiETEFOa28ZWze6xw40kMSf8WvGljKnnJVivwaQ5UQJuoPyaNmqns0720pTu0rVPCHw==
X-Received: by 2002:a9d:664a:: with SMTP id q10mr22436862otm.66.1595288380754;
        Mon, 20 Jul 2020 16:39:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 80sm268144otj.67.2020.07.20.16.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:39:40 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/215] 5.4.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <28abf795-4eb6-049f-0d32-59078926c983@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:39:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:34 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.53 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
