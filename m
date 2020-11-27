Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BC2C6AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgK0Rmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731703AbgK0Rmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606498952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snNIyQg7RWkkPFd12tdtmWJtlwMAtdJfQ5GsHCYEsu4=;
        b=esAngmR0ndg9cGLpqPCBb8aoWWETk5R/ZO148lHb7T1OeGSgNiE3BDjTRcJjTlEld6nPFx
        Yb2YGInoec9CJEhfTetqAGkG8goFoOq66DlqFk2GtbZm8st8tseUlcVDEHxpuN/6zaURRD
        VoxHMDx+069YDEz6g/VyEFfaGVA2HVM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-B30H6Q-3P5W8nG_c7vK7Cw-1; Fri, 27 Nov 2020 12:42:29 -0500
X-MC-Unique: B30H6Q-3P5W8nG_c7vK7Cw-1
Received: by mail-qt1-f200.google.com with SMTP id z8so3611164qti.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=snNIyQg7RWkkPFd12tdtmWJtlwMAtdJfQ5GsHCYEsu4=;
        b=czNpgsND6/Zrd/K25RW+rcGSXko4f+5xkLVPzdmpbiJv/PYE/92S+je3gGvIuaUKLX
         yKpKPUWCvB68rQvOLHeTn2lXpjkT9omipLq+mw4I6DERjagjXULQfdhpI5yh39BsmeNn
         CMP+jmQcln875M8+5dciwvyS0Ckbgr9rnWeAcUivW+4KoFiCC9ZkvPz0K64uCwLhw7kY
         yKVpSIVUdO92XnVvW/JJCE0J/Vh/J3lHho/PAztLGICx9OLXFVqWFSKKDMk6TOnykVli
         knI+VUBbN2uLdHCgRdDzqbKgQMtKoSBvL3k5KOtAjzrbrb2Q8WcZJ1cwyLMLK2c7V3uZ
         zhTw==
X-Gm-Message-State: AOAM5324YOsjUIw6MYA6pDCKw4jzhiP4Ti2z9IAeKy4+FQ5JJ/wlo3FD
        lx87iDim3ESAZlRT8OlA0jHPL2aJCuBWeTbuKiRz9JcgNPJM+i9hYFSmp4stjkIZpngJi5LNqdY
        y5Rt2x3BgnHVPn357tofKZMVwJFHkw1P7ItjRScNW56eF4QVhymKBiUG0xQiUQeGmnA4t1gs=
X-Received: by 2002:ad4:4baa:: with SMTP id i10mr9350921qvw.40.1606498948890;
        Fri, 27 Nov 2020 09:42:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfXoG3FjVgAv1MvJYWD8IHo6mmrKYiOQMcKWTiYMzkk1fGajinFUhCNtZh3LzuLciAuD7FWw==
X-Received: by 2002:ad4:4baa:: with SMTP id i10mr9350902qvw.40.1606498948670;
        Fri, 27 Nov 2020 09:42:28 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t133sm6216932qke.82.2020.11.27.09.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 09:42:28 -0800 (PST)
Subject: Re: [PATCH] misc: altera-stapl: remove trailing semicolon in macro
 definition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20201127165421.2692469-1-trix@redhat.com>
 <X8ExfFYVcwsbBa81@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <12cd047b-9826-d200-1c70-faea0a753755@redhat.com>
Date:   Fri, 27 Nov 2020 09:42:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <X8ExfFYVcwsbBa81@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/20 9:03 AM, Greg KH wrote:
> On Fri, Nov 27, 2020 at 08:54:21AM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The macro use will already have a semicolon.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/misc/altera-stapl/altera-jtag.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/altera-stapl/altera-jtag.c b/drivers/misc/altera-stapl/altera-jtag.c
>> index 27e8e0c9e8cf..0238600107b0 100644
>> --- a/drivers/misc/altera-stapl/altera-jtag.c
>> +++ b/drivers/misc/altera-stapl/altera-jtag.c
>> @@ -17,9 +17,9 @@
>>  #include "altera-jtag.h"
>>  
>>  #define	alt_jtag_io(a, b, c)\
>> -		astate->config->jtag_io(astate->config->dev, a, b, c);
>> +		astate->config->jtag_io(astate->config->dev, a, b, c)
>>  
>> -#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL);
>> +#define	alt_malloc(a)	kzalloc(a, GFP_KERNEL)
> Ick, really?  That macro should be removed entirely.  Can you redo this
> as a 2 patch series, the first for the alt_jtag_io() change, and the
> other to remove all users of alt_malloc()?

yes.

It may be a bit, I would like to see if there are other similar wrappers.

Tom

>
> thanks,
>
> greg k-h
>

