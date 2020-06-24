Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003C207F04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbgFXV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgFXV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:58:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19343C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:58:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n6so3452543otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h+nPaOF7g1qY8EOAE2i6vUjX5UoCottzvvovb2/RSXU=;
        b=ZZQnbXuyQKc0MQoausN18nmR8BjECWh1WF7+nC4nUcnCzFaIDISaNlFcskElS/j8p2
         Q3dj1L9xll9zyWN1yhydKD/lOSa0tmOXTdytpOeKrnv7f+qE0Hay+jP6ZzvOud7dN0LF
         FNBDKhlpf9/CW5ofqlXwhhSYrZILyzUX8xb9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+nPaOF7g1qY8EOAE2i6vUjX5UoCottzvvovb2/RSXU=;
        b=GOsd5pXtpuN0G3LJDoLZ3Gt/Srjaw5oN8ihtkqQMn9jQ+qHZMIz5XmhAGIv01QHODb
         ZJRtrZQR92HoL7/kCVlDLWUnsC+2uMolEsLjm60/lWfxDlFMbq3x5n0D+bTmw9x3xoks
         ezZCzLfL3P4ZsdFevEyomsHkbJ21II55dRmz4wdNpHPZU5I9OYroEOzIv+3JG3f5Z1dU
         tZcitYGJFPHk++ngpkiDo7FmQNjCUhVpZ3Ak4ECzc75RkkCv01hfNDwrpf1YB1LjfL4o
         TinBSutQZYH2tJsPwa3gozuI4NuUnC1LBNMFME7n9a2DNUq+fy8086yLS8y9qTicrT4R
         b5ew==
X-Gm-Message-State: AOAM5322Ye2dfi7u7C5AuRW8sBM1oWNpG7GhcCNhId6YnzqmeaVK+n57
        zmY+k6r+HEZ3UmoMhUNtsJZbQQ==
X-Google-Smtp-Source: ABdhPJzTPoZWg8CM7iAvZgzyIFkWBJXOWd2M3L+8xmyNFYd4cOYQN0plC/CfOQWEPu5FuiY15fGHhg==
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr23928828otn.359.1593035913500;
        Wed, 24 Jun 2020 14:58:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z20sm97672oti.49.2020.06.24.14.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 14:58:32 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/314] 5.4.49-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <61d837be-c4d1-f0b8-7f15-6b40601d9aba@linuxfoundation.org>
Date:   Wed, 24 Jun 2020 15:58:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 1:53 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.49 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.49-rc1.gz
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

