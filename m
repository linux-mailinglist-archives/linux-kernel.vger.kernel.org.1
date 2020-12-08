Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD43C2D29B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgLHLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:23:49 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:47075 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:23:49 -0500
Received: by mail-ej1-f67.google.com with SMTP id bo9so23988592ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 03:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vQIR8cILfXFY8rOgnw9V9vTbP76cwtxK2fEgl/bYiA=;
        b=o945JsLOiCQ1LCDPvDCiHcQmIeppXrVmBS95NsM1QzPr3wYYeKQb+UXQj9zVQeI/Yo
         BNwLQDP0ok/jUEXUB2kvZ27TkkGxL/BzOPJQaRZGtCo1gOsrrf4TtljX1sF8/JbZzfW+
         r3yQQpYscqh+ignl4hqv9j0OHFColtvf2mCDZWG7Bp+nFs6Wt0hsJnV/n6ZyPzTwP5WF
         2cJdFcUF1LvCxSwwwa3jcMMwre1WRTvUu2hyGvPzGvBL1K37TjXSY/KPeOhwG5wvG29I
         OxSGK1E7EvThZjcHDbjgrCQW7U7Pc/N2neDWDo6szV//HCvhP60qkr3SdtbZlb+tsFof
         T3rw==
X-Gm-Message-State: AOAM5318qlNiiTObYjidS1O04j6xcaBaqLYidVzn0xbsBeiZEidUqvYW
        sBx7bepJoxM9wHTNqlFPbTJVagnyh8iZNA==
X-Google-Smtp-Source: ABdhPJz1q4ahsSdr2WBU7qTuMJWyp18EfLFBlJ7kK5b8cVJwtgj05uA2lYGuY8aFxYd5y5a5yrHNDQ==
X-Received: by 2002:a17:907:444f:: with SMTP id on23mr23201089ejb.300.1607426586733;
        Tue, 08 Dec 2020 03:23:06 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id qn4sm4476420ejb.50.2020.12.08.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 03:23:05 -0800 (PST)
Subject: Re: [PATCH] tty: Remove dead termiox code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
 <20201208111312.GA27425@infradead.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <c1c9fc04-02eb-2260-195b-44c357f057c0@kernel.org>
Date:   Tue, 8 Dec 2020 12:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201208111312.GA27425@infradead.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 12. 20, 12:13, Christoph Hellwig wrote:
> On Fri, Dec 04, 2020 at 09:20:39AM +0100, Jiri Slaby wrote:
>>>>> Delete this dead code; but leave the definition of struct termiox in the
>>>>> UAPI headers intact.
>>>>
>>>> I am thinking -- can/should we mark the structure as deprecated so that
>>>> userspace stops using it eventually?
>>>
>>> If it doesn't do anything, how can userspace even use it today?  :)
>>
>> Well, right. I am in favor to remove it, BUT: what if someone tries that
>> ioctl and bails out if EINVAL is returned. I mean: if they define a local
>> var of that struct type and pass it to the ioctl, we would break the build
>> by removing the struct completely. Even if the code didn't do anything
>> useful, it still could be built. So is this very potential breakage OK?
> 
> Um, we do guarantee a stable ABI.  We have never guaranteed that all old
> crappy code will continue to compile, although we avoid gratious
> breakage.  And assuming there ever was code using termiox (which I'm not
> sure about to start with) it will surely have some form of feature
> check, and I think we are better off with that feature check not
> detecting the presence as that would be completely pointless.
> 
> Or in short: by keeping the uapi definition we do userspace software a
> disfavor.

OK, even better. I will remove it once I get to it (if noone beats me to 
it, of course).

thanks,
-- 
js
suse labs
