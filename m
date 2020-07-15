Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C020221114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGOPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGOPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:32:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94831C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:32:36 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h16so2315227ilj.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5j36s7iC5zp5BnB779s7+MCfhpn2EN7hNLz0r5dH+FA=;
        b=r51ZMZ/DE0WxoG59krMoig/9PaS0tfTZQHD+TvqbtLO1VBxZ9aeo4y5YWtJRp4zJRo
         vUqZXm2LLngXYhELgp5j9kD61YXkJhiqxqMEWOO/376d8UI8vonLIgP9dYxJWaoEd/mW
         Qtt0HRxHXQGRNQ2ppfPwColQHMv3zebgB827nmH0bKPq0N/dNkm1egJbZG5eIm/aUkWR
         7sxAouIYuZPqrXjSqm98qv5hCURTzr/2xpkXL3zjnfaFn9Z1YZGB8M0ewwuq+FQAiCSI
         3KIAbart0wn9Ekl8JVjJFjh3LU1DQJd8SLlJhtOvGb5/Q4ludj4LkFUyQ/blwlXJ0Q9q
         P0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5j36s7iC5zp5BnB779s7+MCfhpn2EN7hNLz0r5dH+FA=;
        b=jLsi1JyWorfh7NVc6P9y8XKf1usUocaiSw2hd8yWq/gG0GoVMpoH0Db4MmUGAzBw9O
         qc10zM/wRM59fHWacaUjRSzKKcAJ8DsRVS5SXWDqQg4B448OQJ+Xs8OK7zmH5SLAjlyS
         OxYKfNmFtvO/LPjqDFKcl3ppcOSsLsNRYYH7NSYFUU6NnfzEL5JJlzacoKV3revhnv6G
         UDb1s5R71J1vsi2T/2PrzFwPAqyynUw1ITd0+mTEXmPr2eepTjlC+yj4CvNCIbQLE8IF
         o58/SY4Zgk3O5hF2s89BHA70seUtKuqMr+IDBXqCQZx1KWn7kkC3Go/m1Ii4BDV5xSwd
         kH4Q==
X-Gm-Message-State: AOAM533Hlz31gSM5CS2HujY9U27oRlPFhu9v3KocWTQ2OPcuxWjQcEuB
        R6hOjI17nTM/EAipJqvWwkkQzw2JjF9Elg==
X-Google-Smtp-Source: ABdhPJzMy5tfw9Plsd3ic0px69p4rqwR4ycrMGtffRykSgnbPggNEenduhT9rlt/dfD+oFWBP2zgyA==
X-Received: by 2002:a05:6e02:de6:: with SMTP id m6mr61699ilj.296.1594827155581;
        Wed, 15 Jul 2020 08:32:35 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m5sm1234561ilg.18.2020.07.15.08.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:32:34 -0700 (PDT)
Subject: Re: [PATCH v2] blk-rq-qos: remove redundant finish_wait to
 rq_qos_wait.
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>
Cc:     Guo Xuenan <guoxuenan@huawei.com>, linux-block@vger.kernel.org,
        wangli74@huawei.com, fangwei1@huawei.com, ming.lei@redhat.com,
        josef@toxicpanda.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200628135625.3396636-1-guoxuenan@huawei.com>
 <20200714232123.GA49251@lca.pw> <20200715121942.33bb34d8@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73fa9772-9b02-fcfa-ea50-6779067ed70a@kernel.dk>
Date:   Wed, 15 Jul 2020 09:32:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715121942.33bb34d8@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 8:19 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 14 Jul 2020 19:21:24 -0400 Qian Cai <cai@lca.pw> wrote:
>>
>> On Sun, Jun 28, 2020 at 09:56:25AM -0400, Guo Xuenan wrote:
>>> It is no need do finish_wait twice after acquiring inflight.
>>>
>>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>>> ---
>>>  block/blk-rq-qos.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>> index 656460636ad3..18f3eab9f768 100644
>>> --- a/block/blk-rq-qos.c
>>> +++ b/block/blk-rq-qos.c
>>> @@ -273,8 +273,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>>>  		if (data.got_token)
>>>  			break;
>>>  		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
>>> -			finish_wait(&rqw->wait, &data.wq);
>>> -
>>>  			/*
>>>  			 * We raced with wbt_wake_function() getting a token,
>>>  			 * which means we now have two. Put our local token
>>> -- 
>>> 2.25.4  
>>
>> Reverting this commit fixed an issue that swapping workloads will stall for
>> days without being able to make any progress below.
> 
> I have reverted that commit from linux-next today.

Thanks, I'll revert it locally too.

-- 
Jens Axboe

