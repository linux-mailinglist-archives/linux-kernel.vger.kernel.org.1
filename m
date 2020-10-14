Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D833E28DDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgJNJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgJNJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A1C008647
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:21:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p16so3333599ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZAQeGgpeqN79999lxdxGr8+/QYmcQXgu9OaQTkWNF5k=;
        b=bQy+C2w7IW95f5PX6o0ydd2dtTnxZO3KvVJcfpadd9LaTY4WT+mEW7/SptgJl/U2t2
         ODnHRK9RDeuEaziItvvlOPyAwIpgT5eaKiHhw6N8otgXHJHfHvwRpN15+Sn5dCptlXST
         2oSRYNvFAhGaFrcJinK2wlC4vyNuS7RuNYkYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZAQeGgpeqN79999lxdxGr8+/QYmcQXgu9OaQTkWNF5k=;
        b=fbnk0b9nYDVMHnV4QtukBhThmRZHIMdmIb2f5GvO19lHTlzGePd1tFbehpQn5Ggva/
         6BWEAK6O5CxID0W4HxqAnXwlcie4bR+ziHtC1g6trOSWSVKLaUyMsLCRgMmgjcY0HwjO
         DMiR4AqOvKhFSa2FFs5654Rx7w+WGVuNsGsyBEG+QTzrpekKBoMhnra0atWRGOZaCnPr
         WJHMWZG/Y6JJqbBlKo38uZ3TLw7T7fEc2rP2XeV/5hzKa3e6R8lIq0WJbeHyp+T5PgEP
         x+fwGh8T9GjK9JqNe2jhJ+xhdUhLJTo9aaqm5tLy4Of+u4Gu/y87Z4We59k/5uNYFlCx
         zrLQ==
X-Gm-Message-State: AOAM532YMRKn8ne76LF6udtw5VQjVd8QHzUdUs9M8y1oATVN7zvJCvof
        OP4J7YNw1aHEQQRVjVwi4+vnqw==
X-Google-Smtp-Source: ABdhPJzhjIZdpZB0ZizzMuxxQ1oxWpKlyuq15zeGBM6WMJvcvmBqcwtT9ZsyU029OMMj+MmzhY/Mfw==
X-Received: by 2002:a92:d211:: with SMTP id y17mr1844782ily.215.1602638511881;
        Tue, 13 Oct 2020 18:21:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b14sm1786955ilg.63.2020.10.13.18.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:21:51 -0700 (PDT)
Subject: Re: [PATCH 5.8 000/124] 5.8.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201012133146.834528783@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <75488e9d-392a-0a15-cfb2-5ba00e04f9f5@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 19:21:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012133146.834528783@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.15 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Oct 2020 13:31:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
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


