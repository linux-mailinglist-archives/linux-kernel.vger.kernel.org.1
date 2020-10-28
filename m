Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7629DF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgJ2BCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgJ1WND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:13:03 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3106C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:13:02 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 67so489512ybt.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kBQEJAcsNoDypblzItIVRGC5xJLK4RkxOtKNMPRA5Z8=;
        b=M4LUqheCRVN4aDlx34+QxY/4pY3jpcrJREx0gbY0u9MfglfuhcSTufiKC6drQol5GY
         RjFX3yP1cSgS+W3lGG4ggcRHlYoTEIuUgNow6adQ6cHP6YMEjWoGOP8Lj/sV/7uB5fxy
         hViG/0s2Oer/cQ5vkGhBNAv6FTV3qzFqPFWbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBQEJAcsNoDypblzItIVRGC5xJLK4RkxOtKNMPRA5Z8=;
        b=gbdYYZGnhkVAex/NgVxIS7Y5iJ6J5Rm/3wOh/heGPiHGzIJzBzTYzLv9yaQY+Hk1Ih
         KjsgcJ0VL5Zz9/7nO7aQTnnc4qgNfKuwSSYOOMYEra7GEsjl6Tk4nFfw6Gz5ndYYkGTy
         6jiHLYSHZ2D/Buu2QnM0tjvdjgLtNITvkJgeOn5gGEqWaE8kgtFu77ky1uHM1nDaMqwf
         YALX6TnlpyORmWM2jfCxfryVNb1iZ5U63NyJYa5LPQ4G6zJOF1V5a4NwxewEz3jnfKko
         CXnkLKuY+VGiYsJwBdZMnpANZUVWkDieu40AaMZGMwlQi+fox10Fu4tFdY9t103V1kob
         /g1w==
X-Gm-Message-State: AOAM533vwcHVl561qt5PskT164PIu2yHab2qjgdkyenujabuOpqx2szo
        n6Q4AN7ACA/JdZ3FFdZ2RJCVrfrrSmNZzg==
X-Google-Smtp-Source: ABdhPJxjTy3T36nWQmk8c0DFM/H14BocDfoMWVqNtagjPo1S/SOliv1XFcYQLMM5E1xEglS9gQWtRQ==
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr5615792ots.371.1603897570814;
        Wed, 28 Oct 2020 08:06:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 19sm2498132oin.54.2020.10.28.08.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:06:10 -0700 (PDT)
Subject: Re: [PATCH] selftests: intel_pstate: ftime() is deprecated
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
 <d315994a-3398-be41-1b26-e78f8359aa5c@linuxfoundation.org>
 <d4adb97b3325ac93295d5e42dc07e8381fb9efab.camel@nokia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <459bc6a0-8046-e223-f88e-10e643a36dd7@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 09:06:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d4adb97b3325ac93295d5e42dc07e8381fb9efab.camel@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 1:36 AM, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> On Tue, 2020-10-27 at 14:08 -0600, Shuah Khan wrote:
>>
>>> @@ -73,8 +80,8 @@ int main(int argc, char **argv) {
>>>    	aperf = new_aperf-old_aperf;
>>>    	mperf = new_mperf-old_mperf;
>>>    
>>> -	start = before.time*1000 + before.millitm;
>>> -	finish = after.time*1000 + after.millitm;
>>> +	start = before.tv_sec*1000 + before.tv_nsec/1000000L;
>>> +	finish = after.tv_sec*1000 + after.tv_nsec/1000000L;
>>
>> Why not use timespec dNSEC_PER_MSEC define from  include/vdso/time64.h?
> 
> Hi,
> 
> If the define was available in the UAPI headers, then certainly would make
> sense to use it. But I would not mess with the kernel internal headers here.

Suggested the wrong file while looking up the define. I was thinking
linux/time64.h

However it isn't part of headers_install, so can't use that one.

Considering the number of places NSEC_PER_MSEC is hard coded
and defined in headers e.g: tools/include/linux/time64.h, probably
should be included in timespec block in time.h

Not something to worry about for this patch. Please add a NSEC_PER_MSEC
define for now in this file.

thanks,
-- Shuah






