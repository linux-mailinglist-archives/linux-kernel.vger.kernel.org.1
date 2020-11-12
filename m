Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77E2B105D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgKLV1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbgKLV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:52 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B14C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:27:52 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so6660688ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pe7knPPM6RlQRiyKkqHKowghuuy1LIXCQskVBXm8l/4=;
        b=a4nIvoFdd07r8vUOoQfGfMWVPK1O+s3ylwqh1FSBwKi2gBJxL5iI84Bw5zkNhxJo8E
         T4Jrb7aWCnL5uxBa9duWfo71MKj5BAxPTy5Q8BQ+32pTQ6T1TenQNbH+Fh9FjL5m60PJ
         wC2dzl66KcrD9IwOc3RwQZnssW2HnC1AhmnSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pe7knPPM6RlQRiyKkqHKowghuuy1LIXCQskVBXm8l/4=;
        b=BBTDeVMsnO/BPc9+aj8FxvrVvLfjUjCUEwb5drmkTy2qWEw7/yZ+mzIEnuf+PJuK26
         MeeUht6x7gmus25i+g7Kd+dY2pciRxrujYjB28th1iSCGBm5vjTLcoAbCbTKUXD1OAGa
         CXWuWpJOGqZ2FKLUaIJBA/+l+lExbnlY/5e3A/efloV4rX0COpCQp4jcvfEPikuiaN8q
         oquD1bC9peYfAZHXFNub5DGdqWubL0p9rLP2NQR/zM1hDgt3hqqQZb+dnZOr7vrQElQj
         3KR0Kb1IX7dVpZriRAxSlX4WVkQzKGhv/5KqjUgi9PxGVf06g9E4fOdVc5A4mxsjEi2D
         g7ew==
X-Gm-Message-State: AOAM5315j7Vl79eueqm2T5OGlyUhJh88KnzQ/BkQylTWTXpU13S7g3lL
        sUnRXBd3+l02SZETVwbd3yO/fQ==
X-Google-Smtp-Source: ABdhPJwrPDF8nlrvD3hxuIrtrSQDWQIdi9vBTbEo2An0oCHD8zWfGIs/vBLQ26UesmiscVzXPhKAPw==
X-Received: by 2002:a92:ba8c:: with SMTP id t12mr1184674ill.243.1605216471357;
        Thu, 12 Nov 2020 13:27:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm3525098ila.42.2020.11.12.13.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 13:27:50 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <X6r7BIG8JTUOLcY0@kroah.com> <X6r7Vl45bgGQiAD2@kroah.com>
 <202011101614.E7D880689@keescook>
 <3075a4fd-8615-1459-2b20-b7d9d2be34ff@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f2b3ae49-bc41-0061-e811-1a7e41040366@linuxfoundation.org>
Date:   Thu, 12 Nov 2020 14:27:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <3075a4fd-8615-1459-2b20-b7d9d2be34ff@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 12:23 PM, Shuah Khan wrote:
> On 11/10/20 5:18 PM, Kees Cook wrote:
>> On Tue, Nov 10, 2020 at 09:43:02PM +0100, Greg KH wrote:
>>> On Tue, Nov 10, 2020 at 09:41:40PM +0100, Greg KH wrote:
>>>> On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
>>>>> +Decrement interface
>>>>> +-------------------
>>>>> +
>>>>> +Decrements sequence number and doesn't return the new value. ::
>>>>> +
>>>>> +        seqnum32_dec() --> atomic_dec()
>>>>> +        seqnum64_dec() --> atomic64_dec()
>>>>
>>>> Why would you need to decrement a sequence number?  Shouldn't they just
>>>> always go up?
>>>>
>>>> I see you use them in your patch 12/13, but I don't think that 
>>>> really is
>>>> a sequence number there, but rather just some other odd value :)
>>
>> To that end, they should likely be internally cast to u32 and u64 (and
>> why is seqnum64 ifdef on CONFIG_64BIT?).
>>
> 

atomic64_t depends on CONFIG_64BIT

include/linux/types.h

#ifdef CONFIG_64BIT
typedef struct {
         s64 counter;
} atomic64_t;
#endif

thanks,
-- Shuah

