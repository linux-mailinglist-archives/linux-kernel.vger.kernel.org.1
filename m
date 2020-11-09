Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23752AC94A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgKIXZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:25:02 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD40C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:25:01 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id p7so11681805ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoQ5KGgmbgZvd6Lg6rdG+UVjgedIWh0S/9SXU8UMl50=;
        b=gSeEHKc55IXfBebzLuau/kNVHKJA/J0S+ZU72MI0EdmnvytAV82RFuvRzZRMZNZhmJ
         lOviKunOHzUb1r5kb4zgpIOPS/PG4nUh26uetT+6tH22GC2yG/69FKNmwyeqvqgwFcdx
         fL2jqEOJz8gBZsOSXfDHIQU3isGL4Azm3MTxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoQ5KGgmbgZvd6Lg6rdG+UVjgedIWh0S/9SXU8UMl50=;
        b=HTxHDy4ywbRp9t7yVUVhWjuofTTYsicVcGuZ+GpJwtBPXEMSB5i4FrU9S9kqmBj1oF
         laNAZQg0O+O4uFVQbGfJEC/Qx48pbR3AjnJ4QwD9sLvXd9TGY54CDCaAonxXZ4DeSaeW
         ep1KRPy+Dj4sz+hu/Dm185eKKzSNVO6OTKBNOXOKm39lWruxJbH5AXs73knvCuBbTAqB
         OZpIJ8Rg8z1g1HS+PgXqxY/vcPWbJQjKl2hnoDi6JqJRWaFonPrC1of+lrtlDcDh+RMR
         Zg/dDQaZ2d9KaH7bKTdNzfuGXHvhpO87OQDVd+KxIXY6I1hKHEbvXj+GegxwyhyqlfDh
         7iVA==
X-Gm-Message-State: AOAM530My9KSzFMKwY36rr+ScB/pZflw/BRN1yFB8AX4h68mQxhtL02n
        rkj30r8P5T2Z0bLFp9YZ8IUzVA==
X-Google-Smtp-Source: ABdhPJysaW4n58mlhaxQXi9oUptqRPRJB8biyVeXPDzAcU1wNgFJBqOWJ3QdqlQmCjGqM871qQTzow==
X-Received: by 2002:a5d:8344:: with SMTP id q4mr11628698ior.182.1604964300770;
        Mon, 09 Nov 2020 15:25:00 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u8sm7506355ilm.36.2020.11.09.15.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:25:00 -0800 (PST)
Subject: Re: [PATCH 4.14 00/48] 4.14.205-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201109125016.734107741@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <184c64c5-0c82-fb45-7eab-705218f52c73@linuxfoundation.org>
Date:   Mon, 9 Nov 2020 16:24:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201109125016.734107741@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 5:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.205 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Nov 2020 12:50:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.205-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


Compiled and hangs during initramfs load on my new AMD Ryzen 7 4700G
test system. This is the baseline for this release. I have to look
into what is going on. This shouldn't stop from releasing this rc.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
