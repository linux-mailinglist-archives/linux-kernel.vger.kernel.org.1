Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696212F24A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404909AbhALAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbhAKXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:39:40 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F3C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:38:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id n42so553281ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHBgbj3gLpwyRaMVsJwk4fOyMI+yKmjgcQJMhAdaJsQ=;
        b=YeTkffq9l5+SjA/Nb1aU8dxBnv2X/CAALYPtdgj6PQ7Ug62FaXlK6/IVsz5S6Cas9v
         NLipPycrKNX/uEDGYPJe7eZ4U/EfeDV0KZgT/jG/SCMUD9h6DKvPwDzEOwbG5naqLpIa
         Vk064jPvw2UY5wUbJuSdOnZsPygSh88lxxFTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHBgbj3gLpwyRaMVsJwk4fOyMI+yKmjgcQJMhAdaJsQ=;
        b=kFHpglAqY+wjlMlyX46Nw+lRyncnpI+17953SkVYZilBSQMthzi6rmK8OltjCr789m
         tEslqNkq2q0Enbt1Mtx6rDt1pwyFszOcq/YVTZiCTzrw30Ru54VGSNklMbRAptb+KaqP
         gXxGE1FF/DsXjLxrfWxtS5SPweLuabdRHf2a2QSBAhwOC/OfKpuBePlu3qyLUpwF46zk
         myaErYichHNAKfB5VO+0je3Tnv8/tLNaYEVxLxYQHHt/Xi3YDme+MSSxk7s68FWXk9gv
         knoGf4BkIhXHR/hCyxBKNNKFz3kBz6EJ6lD+4dIKi+SnLUgNHvcMfp68aT5qXjnpemQS
         K7uw==
X-Gm-Message-State: AOAM532Nw3VSbOXdHhoSHimijyWyGfNa4A8Q/XNDL22FRNoRZkch12ic
        EFN+ccPBYkEBIXVMrOLEDYEaBg==
X-Google-Smtp-Source: ABdhPJxRUsr70YauoanTxIWAYczuDhZuhtEtPEm/HdXZ1mTPwf6iNXGDoNCJMwxRJnHdlbnFDOMNqA==
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr993555otl.326.1610408338959;
        Mon, 11 Jan 2021 15:38:58 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m7sm226355ool.29.2021.01.11.15.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 15:38:58 -0800 (PST)
Subject: Re: [PATCH 5.4 00/92] 5.4.89-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210111130039.165470698@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9272d776-9107-8607-1dd6-e638beefb428@linuxfoundation.org>
Date:   Mon, 11 Jan 2021 16:38:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111130039.165470698@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.89 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Jan 2021 13:00:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.89-rc1.gz
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
