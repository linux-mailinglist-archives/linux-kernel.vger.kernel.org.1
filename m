Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CA2C7A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgK2Rsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 12:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgK2Rst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606672043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrWAJHUZ40Lonyn1Q/nX2kCT++1DHjrIAsCFRqELYdU=;
        b=Cg4+kG8oHvTNl5+X/rRzyjTaTMDx1SKM5lRQ+rgijw4t5Pal2x/8e4+o8olaqkLfu4yVtj
        xuUKeS2eUb6dtPUHKv1Ni428lPWuD0TNzUEKhgvLToJKy17Zh8y5beIokLc6eC0DEdlOBW
        Zg+RkDGfGz2ZIuDTbYZ6+zvhHWYFk+s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-LZ9tK50uNgK4KEOjMjQH3A-1; Sun, 29 Nov 2020 12:47:21 -0500
X-MC-Unique: LZ9tK50uNgK4KEOjMjQH3A-1
Received: by mail-qt1-f200.google.com with SMTP id v18so6717825qta.22
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 09:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SrWAJHUZ40Lonyn1Q/nX2kCT++1DHjrIAsCFRqELYdU=;
        b=E1hSgJURdGpQFCmNIER4R78wefH9Q8yF4PeGxcREXG4K3xjp9MlPaEmctYNi9uBk4H
         OKe2y6x0FPWlTSG38uDR+uZdvnWaVrvOXnyztbxFtjeQVPxiDhOZmvfxWmvyevAcuHdU
         lFtaLi4cDlGg9wxrBO7FKIL5vsu+EkoNV3vzkrw5slLtjyD9rfstQ9yDyWM2l9F6irE2
         Mkf46m8ynGIsTRkE6H+FUb++vK7geoK0tXd9CYu75um9Mtk6Tl2tC8MZtv2sgT/mkTVy
         +r5z7Vs7rw33JnAXh+0A9wEa9cupjcp8cFgmdjwAQALgdjRvb6w09Urw016e/U7SOfRe
         9MAA==
X-Gm-Message-State: AOAM532nyWa63JXjnCtwPIZbUIATfMCI43ZP1qCYpeXx2Q3ghP36usaf
        RoQY1N+1aYJjhFiwl1kJOKtqUrT1VvbrMpbjGQOz4zUOUok1G4yLOjDEWm0qUL4foJT1RR+jR/C
        t45EMKFek+Cdl7nenDNAIuwsAA0Yd7uOIv7BAQMLDeayQycBjrg+LfIw04UNmPvvIJEPCUbA=
X-Received: by 2002:a37:d8a:: with SMTP id 132mr18865361qkn.332.1606672040726;
        Sun, 29 Nov 2020 09:47:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn0xr4NyRhZFuipBRx/ScZBKeoKjxhE39f7KA13T6baPcGbruIJugXlMTwBH68yZ5MAhJD3A==
X-Received: by 2002:a37:d8a:: with SMTP id 132mr18865344qkn.332.1606672040491;
        Sun, 29 Nov 2020 09:47:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 14sm1559247qkk.128.2020.11.29.09.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 09:47:19 -0800 (PST)
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201127190707.2844580-1-trix@redhat.com>
 <20201127195323.GZ4327@casper.infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
Date:   Sun, 29 Nov 2020 09:47:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201127195323.GZ4327@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/20 11:53 AM, Matthew Wilcox wrote:
> On Fri, Nov 27, 2020 at 11:07:07AM -0800, trix@redhat.com wrote:
>> +++ b/fs/fcntl.c
>> @@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
>>  	(dst)->l_whence = (src)->l_whence;	\
>>  	(dst)->l_start = (src)->l_start;	\
>>  	(dst)->l_len = (src)->l_len;		\
>> -	(dst)->l_pid = (src)->l_pid;
>> +	(dst)->l_pid = (src)->l_pid
> This should be wrapped in a do { } while (0).
>
> Look, this warning is clearly great at finding smelly code, but the
> fixes being generated to shut up the warning are low quality.
>
Multiline macros not following the do {} while (0) pattern are likely a larger problem.

I'll take a look.

Thanks,

Tom

