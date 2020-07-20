Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46273227341
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGTXq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGTXq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:46:26 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A921C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:46:25 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p26so3558104oos.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2NsVeO10v0X3RsCVgHnm+hDBKwMRmXw0rSo2qqC9Jaw=;
        b=gCv2kvwfS2WgVMfacbJMRlXcROGn70Q+GI6gdlLyDgRLCbNrygXC7wZ4+rtNSTWg/E
         fxqoqWOToyQbUWFyOL7UWNeDpdpYoUxIIcwtf6eCNrqM8ZPgftesOf3UP7X9A2OPL0Fo
         wqswYjCMGAMszNbNb/lMvfhtpaoaO4AK2CsL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NsVeO10v0X3RsCVgHnm+hDBKwMRmXw0rSo2qqC9Jaw=;
        b=eS51NaEg34Zrtp80k80ox7zEGGP0UNwICKemthTqpVbNVfJr+tSZipXgRMehTyolcD
         XXqNLubmqp7KJZi7Ydl27SCmrtzB2tW0ymZ5hRsKR5caNl8nAC0yaDoMuT5lcITu6GHA
         3n3gFZp9NvLcTGeBEFyzbd/amghTxT71VAEgXBp3rM4J7TqOk/aqWCWF59DnN2N1br7g
         wLE9Q1FEoNDMvNu6hUFw+CE67ZxXITz4KV2800JxdCBDjtPTlfgOwJ53k1pgaDSnfAvv
         gXc83E5bwP9XwgM+rSSaRb2ctmhaJtAUlSpdamYEeMSxx9rtvYdnGuyfZwjtYA4QgDjm
         1LWw==
X-Gm-Message-State: AOAM531pNCtoqzTkhlZZv3uj65Ne/ZcQ0Lrl5PR7ttHSSX1fE1LRd20e
        PxkrfVgky0vLrDhqCkndnPLZ+w==
X-Google-Smtp-Source: ABdhPJxMwQs/tvVRSRay9ehskq3qKf0E6bvHsEVH0qkTxZD/3zYegQ8P8aBkAVRGr9UfzJjwECq/gw==
X-Received: by 2002:a4a:2cc5:: with SMTP id o188mr22115193ooo.30.1595288784384;
        Mon, 20 Jul 2020 16:46:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i9sm4748401oos.33.2020.07.20.16.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:46:23 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/125] 4.14.189-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04f76eba-7122-e173-f3ca-f9aa38048d6d@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:46:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.189 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
