Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8D2A2BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKBNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgKBNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604324577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNgI8i+pWr/ubDT2RgyT0/AFUjy2u7nNe8tclZPonss=;
        b=hbmDihyCFFy9wcwwSyoVXUAw5cURNTWyLZLF0pkNJN+JRaO01c2n+lhAiP5CpRMzJVXakz
        DL5TOM/yFdEAmJ6OLSbZN8Tg2yFdyw4KM+d2iJJrx4XcfhXsTspyPPJXJvdgYSwqZXOR/5
        O4E7Vdszfin13XDPohJ63hr1As33BhU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-AITHez6zPiixW0jo-cKFyA-1; Mon, 02 Nov 2020 08:42:55 -0500
X-MC-Unique: AITHez6zPiixW0jo-cKFyA-1
Received: by mail-oo1-f70.google.com with SMTP id d6so5775606ooi.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wNgI8i+pWr/ubDT2RgyT0/AFUjy2u7nNe8tclZPonss=;
        b=PgCFDhQde8NWIvsjP7aZyec6FVoWude/TRC4U6iD/T9Ba9p6sGwWjOA4zGrKaR/aDP
         H+VEVAoQsTfiOxl7wCTHzAxA4gq+eoH1Gk7bUU3ImyDbHZq9EAJt9FY4EiKE/AnUj4Rr
         so8wm0WH6tNsBuPumK3LRDAyMr4fkRkeeNymsohGTOAxQ78F+E5X4pTR7M1+60yQLsXH
         f3UAFGfPT5y+Mi8ru+DnDz5xF68wk92TKpkFqFrSskznpHsoIKDzz0iqxoLlny+mDEVF
         Oqx+FF7+cRYchnmKy0ATkw8SE6hSfEGFf3nQPwA1NOki/fbYLrS24eJIz+k1h5mveQQZ
         icFw==
X-Gm-Message-State: AOAM530RWwxL1xVS7yC4v8g33SRQYs0gqmElpv6bi6M7YqYBYyGMfuIm
        5ngWVMSAhK92L1trQLTIXgIzNS03ekkSDYQR7Q7NLKsqspelZ3MyAgCrSIq0JzFO6m8o6VkVftT
        KMR5YszmThUhuOgbJirLc+xYw
X-Received: by 2002:a9d:760c:: with SMTP id k12mr12470962otl.52.1604324575014;
        Mon, 02 Nov 2020 05:42:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ19i/H7DCLBkb1s9ygP+CrVESM+Pc7M9G106KD4uzV9wqtn7INLchqFiyTAEZvONPsYHxkw==
X-Received: by 2002:a9d:760c:: with SMTP id k12mr12470953otl.52.1604324574793;
        Mon, 02 Nov 2020 05:42:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k12sm2157256oiw.2.2020.11.02.05.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 05:42:54 -0800 (PST)
Subject: Re: [PATCH] memstick: mspro_block: remove unneeded semicolon
To:     kajoljain <kjain@linux.ibm.com>, maximlevitsky@gmail.com,
        oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201031134818.2135446-1-trix@redhat.com>
 <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <df2f3ead-8bf9-144d-8a8a-9d6356f8b389@redhat.com>
Date:   Mon, 2 Nov 2020 05:42:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8566b27c-2f71-16f8-1b9a-b1b79015f4d2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/20 10:51 PM, kajoljain wrote:
>
> On 10/31/20 7:18 PM, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A semicolon is not needed after a switch statement.
> Hi Tom,
>    I was checking this patch. Not sure if it will come under as fix patch. Since this is not fixing
> any logical issue do we still need to add fix tag?

My rule of thumb is a fix means the kernel needs to be recompiled.

This isn't a fix.

Tom

>
> Thanks,
> Kajol Jain
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/memstick/core/mspro_block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
>> index cd6b8d4f2335..afb892e7ffc6 100644
>> --- a/drivers/memstick/core/mspro_block.c
>> +++ b/drivers/memstick/core/mspro_block.c
>> @@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
>>  		return "attr_devinfo";
>>  	default:
>>  		return NULL;
>> -	};
>> +	}
>>  }
>>  
>>  typedef ssize_t (*sysfs_show_t)(struct device *dev,
>>

