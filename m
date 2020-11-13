Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EAE2B25AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKMUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:40:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D4C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:40:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so11554075wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dT7SgKAaIzl1OqR+duy/glp1E5OJ8cb6vWwY2LeZAgg=;
        b=lBVaC0y9W/qZvGpOvHIn+QCPDMX3dmwPUr5N3JWY0HWOG1ORjIZ8PzL+jNBq6rLnB1
         rVrB1Bnbc57jC1LvnI2kDeXYBhn3tEByoU1CWjgSmb3//QZut1tDof6ZIJy8hzZ10vz5
         w8Vtz7XuDYL69Prmow3iNminANpUh3C0uXyGMOqoLSE2C46i00PReB2y3SMY7waSljEW
         TjoKygvZBiQ2TenvsGyhxhfdRrcKt3nCEFZ/dyYS9NjoMFLcc6rIhk+IT2MXFh6znxH2
         0wSxGghiSRM8278CKVbIKR0dOeDxxfiDa4uloeGvySqESe/hIpLrPf/ZlSjplCXDuhCD
         bwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dT7SgKAaIzl1OqR+duy/glp1E5OJ8cb6vWwY2LeZAgg=;
        b=V7zxaSMT6XVF7phxkS9tu743RkU6vo9QhscWQ7y74E08xEsKvydTpRe/wGZBYlJVbn
         ER/W0zguKRm6knMG6ub5DfbTZtXkRROhz9aPj8VpTrG7o9XfPDKnDcSibqB23PIP9Viq
         X7OTZFYLCcTF4mL7dahLTURoNLK2sE0oYpE/a9O+c5StLj9m9fO86n4rOXcbvpnVI1Rs
         0QRvugVZCEX1qFGVy65JOE0FOm1ialSAj1ma/8bEkg1vZriw7DYwTteNgX649h7QrvQQ
         yK6CXOihVxSmBBoqYG/XcbQuVT7QdSzR0aqrDGIiDKfj24wHCbS5r6i3XVa8/UWKmAUi
         3p1g==
X-Gm-Message-State: AOAM533kmCdNqp3lMH3iT7AOzqvgnKgWmiI0gzZUzx7Gj+Hd3tXH0wEm
        rVD7wth7XtQnoU8MPJiP4JSQppFVmB5Oxw==
X-Google-Smtp-Source: ABdhPJz/4uqiAXjzlR4PVqjyovXzFMCLzo6/8mTg5iaT5GzHUZnwrT690g1GmligzGSYHw+wCzb7/w==
X-Received: by 2002:a05:6000:1183:: with SMTP id g3mr5620316wrx.7.1605300032536;
        Fri, 13 Nov 2020 12:40:32 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y185sm11665472wmb.29.2020.11.13.12.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:40:31 -0800 (PST)
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <20201112184106.733-1-georgi.djakov@linaro.org>
 <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0e3179bc-61ad-19e4-9b19-956609e44e75@linaro.org>
Date:   Fri, 13 Nov 2020 22:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 21:14, Andrew Morton wrote:
> On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org> wrote:
> 
>> From: Liam Mark <lmark@codeaurora.org>
>>
>> Collect the time for each allocation recorded in page owner so that
>> allocation "surges" can be measured.
>>
>> Record the pid for each allocation recorded in page owner so that
>> the source of allocation "surges" can be better identified.
> 
> Please provide a description of why this is considered useful.  What
> has it been used for, what problems has it been used to solve?

Thanks for the quick feedback. I'll add more details in the commit message
when i post v2 next week.

> 
> Are there userspace tools which aid in the processing of this new
> information?

I'm not aware of any.

> 
> Can/should Documentation/vm/page_owner.rst be updated?

Yeah, probably i should update at least the size of the objects.

>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/migrate.h>
>>  #include <linux/stackdepot.h>
>>  #include <linux/seq_file.h>
>> +#include <linux/sched/clock.h>
>>  
>>  #include "internal.h"
>>  
>> @@ -25,6 +26,8 @@ struct page_owner {
>>  	gfp_t gfp_mask;
>>  	depot_stack_handle_t handle;
>>  	depot_stack_handle_t free_handle;
>> +	u64 ts_nsec;
>> +	int pid;
> 
> pid_t would be nicer?

Yes, indeed! Thank you!

BR,
Georgi
