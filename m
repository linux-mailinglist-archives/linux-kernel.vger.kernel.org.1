Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAE2B0AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgKLQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKLQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:59:05 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA429C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:59:04 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so5903679ilp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GaO4q7T8iJjRlcnl93QU8Zwl4O2C359DE1W1JVxhVXg=;
        b=b6ZpgqQnIUqlYhaFnT3Ou7QD+FXOKHPByYy3RWrr8gsAroJlielBkL6YYndoXMh3g9
         rsjP4Q/9ungxcBW4afCFKkZ3DEqZc2DfXzcE6yNqYA/dlPR4s5WscDWRFqtt7kW0K/4I
         9kFdYw8H985FGwCp0eLFZs0/YexMY4qyt6qHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GaO4q7T8iJjRlcnl93QU8Zwl4O2C359DE1W1JVxhVXg=;
        b=GEtmv0IIahye9FpRCdqPKzTcIdU043ORdLXAnz/KKLeiC/GXZC2afntkV4XnC96dJr
         2yB/RfnPJtRfCdOQt2eROHQ7mjyFmjD/mHiRbBO290m9BpMqteWqehtS1NTlirdOT/S9
         C0tWZ2WGKtlXJkckCBovM1LiH9ijzIATJfp9tGhMru1e7nGYQu2q6qqOF7lVkgATjFIq
         2gaO7vF3RxbbDeHu+AXF+3CGMpIO4SMClAeH18Kh4szAfX6DeO0hD1rzWO/WjTvEEay9
         djwKe0GjXNPioVwUuFvvE9alMoJY21z9L/nusQ6iS7CAsXh1Ak0sc2v90zhYSNop+5FI
         +/TA==
X-Gm-Message-State: AOAM533pE3Dkm2t2m2b8tD53xTa/I914ANSx0oPgNs4LSbBGNmObJpAS
        I6qVfX44nX8QT7as7LuHcQ2kfg==
X-Google-Smtp-Source: ABdhPJwN6Vf5B+ZH0aq7fuoCQ9TKbzlvtMLLvd38lE9BKuuu/XpeqkLpsg3KNdrzb27u9aqnoM3T+Q==
X-Received: by 2002:a05:6e02:931:: with SMTP id o17mr328192ilt.273.1605200344286;
        Thu, 12 Nov 2020 08:59:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j10sm2983083iop.34.2020.11.12.08.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 08:59:03 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>, corbet@lwn.net,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <X6r7BIG8JTUOLcY0@kroah.com> <X6r7Vl45bgGQiAD2@kroah.com>
 <202011101614.E7D880689@keescook>
 <3075a4fd-8615-1459-2b20-b7d9d2be34ff@linuxfoundation.org>
 <20201112123621.GY17076@casper.infradead.org>
 <acad8c18-a0a6-f52c-429a-02e614bee05c@linuxfoundation.org>
 <X61mwRe6tFrSrgQa@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c20dc33b-3163-b7cf-fdd0-12c30e07ecc0@linuxfoundation.org>
Date:   Thu, 12 Nov 2020 09:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <X61mwRe6tFrSrgQa@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 9:45 AM, Greg KH wrote:
> On Thu, Nov 12, 2020 at 09:17:27AM -0700, Shuah Khan wrote:
>> On 11/12/20 5:36 AM, Matthew Wilcox wrote:
>>> On Wed, Nov 11, 2020 at 12:23:03PM -0700, Shuah Khan wrote:
>>>>> Agreed: this is a clear wrapping sequence counter. It's only abuse would
>>>>> be using it in a place where wrapping actually is _not_ safe. (bikeshed:
>>>>> can we call it wrap_u32 and wrap_u64?)
>>>>
>>>> Still like seqnum_ops.
>>>>
>>>> There is seqcount_t in seqlock.h which is a totally different feature.
>>>
>>> Yes, and that's why this new thing, whatever it is called should not
>>> have the word "sequence" in it.  People will get it confused.
>>
>> Any suggestions for name. I am bad with coming up with names. How does
>> Statcnt API and struct statcnt along the lines of your name suggestions
>> in your previous email?
> 
> What does "stat" mean here?
> 

Stat doesn't really reflect what we are trying to do here and sequence
does. I am just looking to address confusion if any and make a call.

> And I don't understand the hesitation about "sequence" in a name, as
> that's exactly what this is.  seqlock is different, yes.
>  > How about "seqnum_t"?  That's what we call the sequence number that we
> export to uevents, a "SEQNUM".
> 

Good point.
This is what we have currently in patch v1 and let's just go with it.

thanks,
-- Shuah





