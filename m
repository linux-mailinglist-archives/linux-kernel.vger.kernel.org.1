Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9873E28DCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgJNJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgJNJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7FBC00214F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:39:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so1943601otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=InJlbJBQqXUR1oQj//MwzYufQPHMfh3uXTDyt2f2iPE=;
        b=QdLyM8Y9kzCzQMAnhirRhrBkGaHPWIuNuB7mMAZjtNIruKFLJv+gHCwX1m0hZQ6chb
         gdDA9tBvnR6/lKYCKKkfi9+hZ9ZyY8zHPSBJktNp4as9GoMP2XnzfGenRtU7Zf35gcAI
         HHEo0TVqviF3CsLG+idkZxMV04M+klp0mn718=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=InJlbJBQqXUR1oQj//MwzYufQPHMfh3uXTDyt2f2iPE=;
        b=DQJndcBNV84sHgsDMyd4DcIq8jqe3XmEK7KGt707B5G3BCrd17F1/dlyQ5EzkOClmD
         8/1BStdHng3ymASAxOkXH4ANBZcNxu7NXFFif5JgHJg68WNHXmm09LgUEXSSgQg/k824
         3sLklfDsyXUoQWQ3xQ5WdexGjOCXFGkSqlCWFz9uXZ3f3Bp3fiNMeTDsKzLfEaKd38DP
         vwCB2Re2wtt50Lkkh/kccgsKYPVyHNSDBORk6EyW0sd6sBNYaQUwNnTNLv+cpLxGP0LL
         6ARqrlM4zN6sN+ZTawYdnvyxUzW3iMQZWPqAXeB76T6Un498IfuLZwmq0W0NN1BYKcTi
         gGNA==
X-Gm-Message-State: AOAM533gccVMI/mUQ/UR3ZRXX8gMQ1Dv0YCmIUTPYZzU89cNpLqrDack
        P59QCvCEq/kgF7dwAvFUI1jqNA==
X-Google-Smtp-Source: ABdhPJwvNWhRi5/MWd++5EqpBUb6BJMpOOl4ZZs6SPSlaB2Wrs0JujJHlz5wQnyC7i7we2qIgpMq2g==
X-Received: by 2002:a05:6830:1303:: with SMTP id p3mr1835907otq.282.1602639596657;
        Tue, 13 Oct 2020 18:39:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l62sm660451oif.18.2020.10.13.18.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:39:56 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/54] 4.9.239-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201012132629.585664421@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db4da98b-793b-81d1-f246-4fc0c5d0f9c2@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 19:39:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012132629.585664421@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.239 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Oct 2020 13:26:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.239-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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


