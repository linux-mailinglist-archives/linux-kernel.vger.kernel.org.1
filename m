Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8762675FA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIKWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgIKWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:36:24 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:36:23 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so9640027otr.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jd3rc9wLqDkcjq6CRTFLi+h7vU1J4+2KL8NUdpSrlYo=;
        b=VVENOdypOQsLj973e7V3to+GykLNCsq1u30d8D0PFP0RQZAY9/nRpNroxTXJLl+qeX
         nRtGvc1oNAgCYcAkPPNldpzv0PLp7Rm6jovxWiqDv94ZaVRTx7GRIgS8tHJCKrfrDdQ7
         d/e7HmguGroUdZTs5N1vaQB4/UFhpTk/okS+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jd3rc9wLqDkcjq6CRTFLi+h7vU1J4+2KL8NUdpSrlYo=;
        b=hFcgvYYLNQtSepfia37DVmXVjp9sxs+nf7N1F/ynPhFyh9bi11CV3mgghDpZT5LbUQ
         4JzAk4QEC6I6n9GSqcByPDNaPCODwt5kjGLCvF0LRLhCVI51YNMA7gEjwLcxBUd4QTN1
         bgKOG7vAkAD8dYXORG9bmViDfPHx6syjzP3k5BBHn4/5IQbO/oXMuZZO0Bj621sgJBgt
         t9hVPCYBinatHQYFLzlHrh82imejVdaAmIbfKOXnKC9GhTzOg0kpQwqXfJQe4ewSkQa5
         cI9TBVQUR2Wz38Hh5vwB4tWCtNLE7W1FcYJW9wz9zoQLVEgOZLGoqYNljB+134e+IE+g
         zHNA==
X-Gm-Message-State: AOAM533Rls/sEmzpArbhWAAxfRbxvN+SBndWDEpdjj18ZN7K/aoczy9c
        7VFffg6vy8SLsCQP4C3O9f/69Q==
X-Google-Smtp-Source: ABdhPJycr4snTCmYhvfSD9Xd69cU/mxtUSOwbqaeV7tVy0U3iXmah8naR9mOIEkTUsxt70Q1G/WM/Q==
X-Received: by 2002:a9d:57c3:: with SMTP id q3mr2398582oti.146.1599863782677;
        Fri, 11 Sep 2020 15:36:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h14sm571773otr.21.2020.09.11.15.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:36:22 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/62] 4.4.236-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200911122502.395450276@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b1cd6ab3-e7e3-5796-199b-4cbb6c78a158@linuxfoundation.org>
Date:   Fri, 11 Sep 2020 16:36:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911122502.395450276@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 6:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.236 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 13 Sep 2020 12:24:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.236-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
