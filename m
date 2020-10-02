Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F670281F5F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgJBXuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:50:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A1C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:50:11 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k6so3365935ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y34GUHs7y+dhv/PBEvBFpzMJQXZxzed838y/lOyLkeg=;
        b=OwYWHVGo0duTZnucRDmSw4KE0SR/5oK6MjUHXkaXaZfKd4ZipqfpuD49mVhiJKjZlv
         foof3M7EwOlISDCGFPniEcCoGb9R3GMBYpjtj1kdCbWhzCtglUC2Y3AhMXI56dvI4IB3
         12EP7mBPUzV7Y/Dkj7rbuTUXufEgWwpYYDz5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y34GUHs7y+dhv/PBEvBFpzMJQXZxzed838y/lOyLkeg=;
        b=Xjmu1h9zvk8F0lxt5ycH60g2zlIpa7ggS1y61Ajf53F8Jq6jZsGweZXETTzmKlS9C4
         P3Z3RJQfdS9wCSWDSAHvpNGal4/mLtXLvIPdEoh3TDCs8VXpQ1BgVHplEtEz3uvxT4lZ
         II7ANIgGDNIJMMIqZbojJAHPVXJ6bBxa26Pw9C8mhFPqLaUqfEUVkgRZYgy1H6Z6YmfW
         mKSzC7qWhwhwFvHGA4/EKX2mXpcgy9YQ++wpPgOg+XtdzFHU37SjsbWqUWg/G18IEPaJ
         ZTwlR4wRfgIPumFr/fJchLQj98V63pr7TqZkKusrr6GKRcApiQYpPOUcVwFXOjcCsTYh
         nGsQ==
X-Gm-Message-State: AOAM533EkX5i/5zz7Rc+PJjSESq7vQG5O1zXvIRLZ5ca3rbJjGK2tOdi
        A/tFag3dEHff4rAh2i8VRVRrBA==
X-Google-Smtp-Source: ABdhPJzSBEr+9V1AlHXCphfVeGtDS7AVdMlZMDMld9vw+ZO1HhBVd/1CspUbOw5A51Sn4k2ViZQJgQ==
X-Received: by 2002:a6b:7909:: with SMTP id i9mr3399241iop.98.1601682610398;
        Fri, 02 Oct 2020 16:50:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z13sm1571063ilm.53.2020.10.02.16.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:50:09 -0700 (PDT)
Subject: Re: drivers/block/rbd.c: atomic_inc_return_safe() &
 atomic_dec_return_safe()
To:     Jens Axboe <axboe@kernel.dk>, idryomov@gmail.com,
        dongsheng.yang@easystack.cn
Cc:     ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <ce2dbec5-00f8-831b-3138-cc4f3b8fdb51@linuxfoundation.org>
 <c2dd3223-bda1-be8c-fbc4-9c0eec63bc9d@kernel.dk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a3f6c88f-5b0f-0da0-c5ad-dd40ea36f4a5@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 17:50:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2dd3223-bda1-be8c-fbc4-9c0eec63bc9d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 5:44 PM, Jens Axboe wrote:
> On 10/2/20 4:34 PM, Shuah Khan wrote:
>> All,
>>
>> I came across these atomic_inc_return_safe() & atomic_dec_return_safe()
>> functions that hold the counters at safe values.
>>
>> atomic_inc_return_safe()
>>
>> If the counter is already 0 it will not be incremented.
>> If the counter is already at its maximum value returns
>> -EINVAL without updating it.
>>
>> atomic_dec_return_safe()
>>
>> Decrement the counter.  Return the resulting value, or -EINVAL
>>
>> These two routines are static and only used in rbd.c.
>>
>> Can these become part of atomic_t ops?
> 
> I think you just want to use refcount_t for this use case. They
> have safe guards for under/overflow.
> 

Makes sense. Guess these came before refcount_t.

I will track this for refcount_t conversion.

thanks,
-- Shuah
