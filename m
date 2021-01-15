Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E602F874E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAOVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAOVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:14:38 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C99C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:13:57 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d8so9925846otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2yS+/mPCIhMqui9syG37qyuAui4P2Wj3yJ3qSWKhmpg=;
        b=Ss2edRKTV6ENACuZ0SzgIE91XETZDvgmQ7apPjcJVdFRl6mqHdTU1yFWmsWP7Bcfk6
         PzXJoBAIPXjGPEzb4FcmZ0XLsXJxofOPEySLTwxrMYg2EBQtszJnFv362gdgWeocXMMz
         uyAEj/CbWSKqGCPLrLNGTwid5wPKCYDUd+FhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2yS+/mPCIhMqui9syG37qyuAui4P2Wj3yJ3qSWKhmpg=;
        b=oobfQHcoHuNZUvEDSMe7wf9m5HOhaLoPqAYJ2uycmmRkM9fHOKhIfG+V495FBydygV
         Z3vCn0L0ZEmJcdPPJc0nonMxg0Z+ipzpuNzGnfeWKOEahKpFQnA2k974EX+evo18BuaQ
         CuTx2Tu8ESa23k8vxCmLIvbuNI+hJ5IYEwyS8DIZrim5hGkEUzqLGmfzouhmvtv0cNNR
         wiarbdw6VubioayC2SpW3RYTWcBU8CfOMgjU2s2qWlfoDuBSr5GnC5WkYcYHgbddTzJd
         zZVwaw1HvmC58sdUHDk0ifI/hBE+abrLPTBQY9m4Nje0rv9XWxWFW+eJpR6a7XMJ4kFg
         A0Xw==
X-Gm-Message-State: AOAM530EAHZrvvhUU0Aq9YH1eNY/plwvJdfKQZ4E6cTuJf6ZigAw+0Lz
        jEAJ9a0V022cNzYgCOSsWyrJ4g==
X-Google-Smtp-Source: ABdhPJxWmt1jJRJOvhUe7JK/UEFonxtjfSwIaYLZL7NjB7SCwG9r2IkSrIKs/As9RLeAflnpHzLrDg==
X-Received: by 2002:a05:6830:19da:: with SMTP id p26mr9481121otp.80.1610745237254;
        Fri, 15 Jan 2021 13:13:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c14sm2042681otp.19.2021.01.15.13.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:13:56 -0800 (PST)
Subject: Re: [PATCH 5.4 00/62] 5.4.90-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210115121958.391610178@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3b993bdb-965a-5474-151f-cad765f8de3d@linuxfoundation.org>
Date:   Fri, 15 Jan 2021 14:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115121958.391610178@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 5:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.90 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.90-rc1.gz
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
