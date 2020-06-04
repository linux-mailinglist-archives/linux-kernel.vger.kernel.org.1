Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF871EDD67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgFDGo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFDGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:44:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30022C03E96E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:44:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f3so2827928pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lQVlXH+uj/MULxrEGj2byT6IBDKh5uPIe65HnVp2khs=;
        b=gzRnbTkcAnqvYEoVW9YseGY+0u1VoTMW/IO49nxbU4/b5h6mTCySH8tG+xs+BPJv/6
         KRDGlwtV9Ah7167fzuEQ8xp4anjyd5TQkJJ69SvgbXyirs97ICE1UiVX3L19uqWuQjAP
         3sot+5jrOtfXbLnpKCD/twibMkrA8D4z22h6fVm1qdzWoymfGSQkMemFvoN8iU3SWC3J
         10VJ1+++UoYEjyFX96NS4Co2pCuWJ/3yrjzugj9djTKFrXCDsNYr3XinRwGWguYuoCwg
         fyPAolJ41+4q6j+lvVYWBlvSj23VuYFXKER+6olegZJTTXe1Cl3lXoVoe6USONUNZocH
         Fz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lQVlXH+uj/MULxrEGj2byT6IBDKh5uPIe65HnVp2khs=;
        b=QNdxIHTPaxoKg28I7fdte/qkKcVOoGVn9IbRysBsyjSDp6iIWlRhAha6jjOStXnOaC
         cZ2XrmPgfY1IxRqS5cuJPsnziAwIRtkJgJ91Xh/QnEQZ/ISGFc6/uxx6RB9qgFWpDTIY
         c5Adm//OCoZj/xf57p8naBm9qDqX3uCQHu9LXaSe8ljYVW3soQaFzRiIPP7E4Cvojbx8
         kDee+fDaYxXb05dyaZpdWmeXooP6AtGBGQye8zMbJ1Aw6bb4qgUarL9t6Gop6YXc45Mk
         dDTzrxVaK4UweI4FVde82Snyg8iRDMx3cURApmWr+qessNGtC6R253x8HWnQV+Cs3kz7
         ddaw==
X-Gm-Message-State: AOAM532751CjdrjMNYZAa5SkG0JrDJS3QkQKd43olk0V2+ZGARWRYNTZ
        YNRA6eb2TwnxeIPCJEOsX2lmJQ==
X-Google-Smtp-Source: ABdhPJyTNTnMWGua4MqL8tx6aHu8UCUxEO5kUDj97h0sJ9J229Uu3bn79HTRPASqqjCM+e2BTW3S9Q==
X-Received: by 2002:a63:ad43:: with SMTP id y3mr2934343pgo.435.1591253067552;
        Wed, 03 Jun 2020 23:44:27 -0700 (PDT)
Received: from [10.15.1.238] ([45.135.186.21])
        by smtp.gmail.com with ESMTPSA id b140sm3461949pfb.119.2020.06.03.23.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 23:44:27 -0700 (PDT)
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
 <20200604033918.GA2286@gondor.apana.org.au>
 <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
 <20200604061811.GA28759@gondor.apana.org.au>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b23433f8-d95d-8142-c830-fb92e5ccd4a1@linaro.org>
Date:   Thu, 4 Jun 2020 14:44:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200604061811.GA28759@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/4 下午2:18, Herbert Xu wrote:
> On Thu, Jun 04, 2020 at 02:10:37PM +0800, Zhangfei Gao wrote:
>>> Should this even allow truncation? Perhaps it'd be better to fail
>>> in case of an overrun?
>> I think we do not need consider overrun, since it at most copy size-1 bytes
>> to dest.
>>  From the manual: strlcpy()
>>         This  function  is  similar  to  strncpy(), but it copies at most
>> size-1 bytes to dest, always adds a terminating null
>>         byte,
>> And simple tested with smaller SIZE of interface.name,  only SIZE-1 is
>> copied, so it is safe.
>> -#define UACCE_MAX_NAME_SIZE    64
>> +#define UACCE_MAX_NAME_SIZE    4
> That's not what I meant.  As it is if you do exceed the limit the
> name is silently truncated.  Wouldn't it be better to fail the
> allocation instead?
I think it is fine.
1. Currently the name size is 64, bigger enough.
Simply grep in driver name, 64 should be enough.
We can make it larger when there is a request.
2. it does not matter what the name is, since it is just an interface.
cat /sys/class/uacce/hisi_zip-0/flags
cat /sys/class/uacce/his-0/flags
should be both fine to app only they can be distinguished.
3. It maybe a hard restriction to fail just because of a long name.

What do you think.

Thanks
