Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607C829C8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830088AbgJ0Tcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:32:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45423 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830073AbgJ0Tcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:32:32 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so1837435iol.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AExj9aOFhvxmtnajnatMYd8PMsHr28fh7IU5OgxP5fI=;
        b=WKcFIjM4yDsM8HcgPRK6SfFmYTvlsPOOcw9l3Y208vFzAi3biP0o3QF/C8MNYLgMNH
         bololnv6m1a/BcowjA950XehWDu71bLNBGRawzX9z6nY7gbT7zPgQB1N80Jfi5igtkmD
         qAkK147c9WD9aa4F24jxPBmUJyA6x3+wVXZiIVwgpbQDsWDGd9ig4AtC5V04BoQOfytc
         nieOAap8pG9OVyN91bZfJTuyzcTT32IuJqurQfOL+FBUemkW/54Hb+SBaq56RtzGDYGw
         XyNGNfjY1aticQY8hhnpPFfYmShb+ydHHrhAGXscGI5/H79fnbygsJvKqWWQqwb/Wh7S
         7GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AExj9aOFhvxmtnajnatMYd8PMsHr28fh7IU5OgxP5fI=;
        b=NRKge9f0U4nY7C7WD/cTV4VPx7pnepliPfBibkXJtIu3A7mV5QPOKZHKuPsvm9xWbk
         R7ucwRLypOh6LTusLvaeGEIeQP08yfLHiCs0X/oIbwrSohsFO1/a4UPpVzs5TGTl0PDx
         nPlu/v5L7cwsyusBx+ZNRa1riS/9yiuRWuiJeOs/56BzQwOMjzpnrc4TElJ5Id/098tv
         snKHkgXasfp/MBBnTPc+iNK/wVS1ChpcgEDf7PME1Fr0tRN288jI88swC7d/5IOlCSKI
         8k9tnMR5FlojMYTtGLwKvyJbYHBCtUqela3hc9/kDDZtjgzWQMNI7qm7qwOwhJPVjWLv
         1DJg==
X-Gm-Message-State: AOAM530XnppKdPWdmTD+EJbyW7HEq01iFn73DP9lJcvE9IgPy2GBlGt/
        P2W2wWgBZUCKKyw5NP1rDPubkkbRV5UhUg==
X-Google-Smtp-Source: ABdhPJyq25TWfxXRwXbLcD0qjrtgJWM63aitgjfuwT1vPwjHt4i5opOp9StiSchHd1R66eYr8ZutqA==
X-Received: by 2002:a02:b61a:: with SMTP id h26mr2778449jam.129.1603827151543;
        Tue, 27 Oct 2020 12:32:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r14sm1355546ilh.10.2020.10.27.12.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:32:31 -0700 (PDT)
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
 <20201027191920.GA262123@centos.familie-tometzki.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43252884-dcf2-fe13-23ce-765f97e86579@kernel.dk>
Date:   Tue, 27 Oct 2020 13:32:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027191920.GA262123@centos.familie-tometzki.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 1:19 PM, damian wrote:
> On Mo, 26. Okt 18:03, Jens Axboe wrote:
>> The removal of compat_process_vm_{readv,writev} didn't change
>> process_vm_rw(), which always assumes it's not doing a compat syscall.
>> Instead of passing in 'false' unconditionally for 'compat', make it
>> conditional on in_compat_syscall().
>>
>> Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
>> Reported-by: Kyle Huey <me@kylehuey.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
>> index fd12da80b6f2..05676722d9cd 100644
>> --- a/mm/process_vm_access.c
>> +++ b/mm/process_vm_access.c
>> @@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
>>  		return rc;
>>  	if (!iov_iter_count(&iter))
>>  		goto free_iov_l;
>> -	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
>> +	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
>> +				in_compat_syscall());
>>  	if (IS_ERR(iov_r)) {
>>  		rc = PTR_ERR(iov_r);
>>  		goto free_iov_l;
>>
>> -- 
>> Jens Axboe
>>
> Hello Jens,
> 
> i got the following error when i try to build. 
> 
> m/process_vm_access.c: In Funktion »process_vm_rw«:
> mm/process_vm_access.c:277:5: Fehler: Implizite Deklaration der Funktion »in_compat_syscall«; meinten Sie »in_ia32_syscall«? [-Werror=implicit-function-declaration]
>   277 |     in_compat_syscall());
>       |     ^~~~~~~~~~~~~~~~~
>       |     in_ia32_syscall

Yeah, sorry about that. Geert sent out a fix:

https://lore.kernel.org/lkml/20201027182246.651908-1-geert+renesas@glider.be/

-- 
Jens Axboe

