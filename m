Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFA2F18B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbhAKOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729032AbhAKOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610376585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqZH7PucLcSk/Qb7NQ3SkFiM8vGpSQE/gSgpg3BnCno=;
        b=bKVmvBBdSdxCsmY6qXxejvTwptZL8BADEb3YunorOi+tYwQB2OdensADf2bO2EtJoxaS08
        n1xrj8cyuKjZEJbsXMo5dIHaefBu1hQcXT3V0c0joosCqL5ja6pF/OHmwhNLIbuu3h3geY
        SDWwsO6MuFfm6fCEQU88S6djU+mK9P8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-isGwgV9TPAyv3-OiSZMqTg-1; Mon, 11 Jan 2021 09:49:42 -0500
X-MC-Unique: isGwgV9TPAyv3-OiSZMqTg-1
Received: by mail-il1-f197.google.com with SMTP id u19so16238061ilk.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tqZH7PucLcSk/Qb7NQ3SkFiM8vGpSQE/gSgpg3BnCno=;
        b=W3SYsPPYzCjfwU+6Kg7pBOPe44H2XrpIuHSIxZZ5oeZalPY7jG+P3Llj18ErO7Ra1I
         Q+V1pJaQ+aKEUp99jMvTEB6Vo1IpqN7XfFrcjk5xvKLJAA3gp1n/NThJ5agQxSikxm9z
         xyt+M1UFv8+HHdCqELyJ7Us5bwlDjZUockvyDZ+ViP2IcnPaQDQZfbhiYcbiWIo58sWL
         whpXBkTiMHGfFTpSU8kgkN5j9V/gc/e1A6mqw5TpdZqn022t5sBvL6YzAROsHyTICS6C
         19yre7n2HNJYj8bzmvGIiWz0srgVduXnO0RHu1AJ+Os3sVlTMrm//K+qN9GWwPVAHgyX
         FDTg==
X-Gm-Message-State: AOAM5331CWMivkgssWGjJmjzcoATmPMxypLeqk50nhQlpjyxKN1IhjDq
        y3frTqZuiwC0I+quPqd1fv3FIOW85k2tE0ZgF15RXa3cwW1KX50CJAiSY+RMyh4CEJfnEUVCvMY
        XRMI6qTa3J/i8QE1rwvClEjmv
X-Received: by 2002:a05:6638:11d0:: with SMTP id g16mr124962jas.26.1610376581994;
        Mon, 11 Jan 2021 06:49:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqiLkOxqKR3V1LofC20YSuSPZdwsqhqikg+suk/YNSgNk9XaZggm9aNZDf1C1WBhhHxXz1Wg==
X-Received: by 2002:a05:6638:11d0:: with SMTP id g16mr124950jas.26.1610376581745;
        Mon, 11 Jan 2021 06:49:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a9sm11033641ion.53.2021.01.11.06.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:49:41 -0800 (PST)
Subject: Re: [PATCH] block/rnbd-clt: improve find_or_create_sess() return
 check
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, ndesaulniers@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210110215726.861269-1-trix@redhat.com>
 <20210111051431.GA4167786@ubuntu-m3-large-x86>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e63aa1a6-8be6-d3b7-dbad-19b1eec287a5@redhat.com>
Date:   Mon, 11 Jan 2021 06:49:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111051431.GA4167786@ubuntu-m3-large-x86>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/21 9:14 PM, Nathan Chancellor wrote:
> On Sun, Jan 10, 2021 at 01:57:26PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis reports this problem
>>
>> rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
>>   garbage value
>>         else if (!first)
>>                  ^~~~~~
> Ah, is it complaining that the 'if (IS_ERR(sess)) {' section in
> find_or_create_sess() does not initialize first even though that will be
> caught by the 'if (sess == ERR_PTR(-ENOMEM))' in
> find_and_get_or_create_sess() because alloc_sess() only returns an
> -ENOMEM error pointer?

Reviewing the code, failure looks like it returns only -ENOMEM.

So the check is correct but brittle.

>
>> This is triggered in the find_and_get_or_create_sess() call
>> because the variable first is not initialized and the
>> earlier check is specifically for
>>
>> 	if (sess == ERR_PTR(-ENOMEM))
>>
>> This is false positive.
>>
>> But the if-check can be reduced by initializing first to
>> false and then returning if the call to find_or_creat_sess()
>> does not set it to true.  When it remains false, either
>> sess will be valid or not.  The not case is caught by
>> find_and_get_or_create_sess()'s caller rnbd_clt_map_device()
>>
>> 	sess = find_and_get_or_create_sess(...);
>> 	if (IS_ERR(sess))
>> 		return ERR_CAST(sess);
>>
>> Since find_and_get_or_create_sess() initializes first to false
>> setting it in find_or_create_sess() is not needed.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Every maintainer has their preference for where and how stuff gets
> initialized but this makes sense to me. I am not sure the commit above
> find_or_create_sess() is needed but again, personal preference.

Mostly this removes two unneeded branches at the cost of initializing a variable.

Secondary, the static analysis complaint is resolved.

Tom

>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
>> ---
>>  drivers/block/rnbd/rnbd-clt.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
>> index 96e3f9fe8241..251f747cf10d 100644
>> --- a/drivers/block/rnbd/rnbd-clt.c
>> +++ b/drivers/block/rnbd/rnbd-clt.c
>> @@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>>  	return NULL;
>>  }
>>  
>> +/* caller is responsible for initializing 'first' to false */
>>  static struct
>>  rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>>  {
>> @@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>>  		}
>>  		list_add(&sess->list, &sess_list);
>>  		*first = true;
>> -	} else
>> -		*first = false;
>> +	}
>>  	mutex_unlock(&sess_lock);
>>  
>>  	return sess;
>> @@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
>>  	struct rnbd_clt_session *sess;
>>  	struct rtrs_attrs attrs;
>>  	int err;
>> -	bool first;
>> +	bool first = false;
>>  	struct rtrs_clt_ops rtrs_ops;
>>  
>>  	sess = find_or_create_sess(sessname, &first);
>> -	if (sess == ERR_PTR(-ENOMEM))
>> -		return ERR_PTR(-ENOMEM);
>> -	else if (!first)
>> +	if (!first)
>>  		return sess;
>>  
>>  	if (!path_cnt) {
>> -- 
>> 2.27.0
>>

