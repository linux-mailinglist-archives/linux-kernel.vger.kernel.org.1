Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2192C8E50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgK3TpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3TpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:45:01 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD29C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:44:15 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so19800733ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=03JMD4RuPYo2VJb6bAXktJHFZqT1yVfytR2jptyT/EA=;
        b=e0kz8S6OUqevvE2bK0NlyDBFDx5jpi7V+mSO6Uh8N4AW3Ennxjkrh/bUj1wGBa7Lkv
         vrsyR2ei7/leHTKwsK6eft74lJ6QLL2uUrtFrKzzDdjZgP/jAmqmm3lErmYqYdVL9mMA
         61tv8UFhfkXncMH+z+KYB0rXUVUreZ4098CUanQCeh91bMuoDIcUNWZTVEdIROsVkxPx
         C2EWrggTsn0H4UYe9QkQn6h8PqtPbOZSMKWf+NpUMSqlk32BEuCQeYLFRlBQb7EgxpvO
         OETRqxuBZrG55uBQNnkYf2De95FkANtGoy2/QiWePHhM8ePOro4FmJA9hVI+j1j/8ks/
         NhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=03JMD4RuPYo2VJb6bAXktJHFZqT1yVfytR2jptyT/EA=;
        b=Or+GljWFaSxrpJUWC4gkdE9hLl+7UIp8EBdMtuB/dR7SObCLcHFwVVz1sHQbWkki+1
         ZkuvCRtYYexZZbQOZDdvN3mL6+9AvDe1wVA6miKUNkIyRTKMNmVjQuIz1ao2YQtuAsEm
         hWZ7ZXjGhTOfZsDKWSD89eg4Ps9zfMxhEvnq43WkHcNfEie7jYDh5NHriK1O0DK2lOF5
         1N06slltt7ZgHy1Vw8UtQI4PploBtjPawU4GKWoRvnkaBrNL6P8c5/bKuHjZ8aSKqjYS
         g6ujZW5/Flen7Vt+nkG5Lz3IpMdkMBmYQZ4onDh6VjQrbg+WXQrnE3Xa/n7y/I5o3eZ7
         8H9w==
X-Gm-Message-State: AOAM533e1EcPxRiivfmDan4MeACmEKPOjFreyyWKaOwT+BYU3NhqI4hG
        1jYrOzXLgsZzpP8vSrfRPXk=
X-Google-Smtp-Source: ABdhPJxlMBou355QHbBVRs3//xbs2rtOffltQRJpXRdfCZwDpF11CoP93xV5S01pjyyC5kZ20BDVmw==
X-Received: by 2002:a2e:9cd3:: with SMTP id g19mr10564527ljj.188.1606765453562;
        Mon, 30 Nov 2020 11:44:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id f20sm239205lfk.230.2020.11.30.11.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 11:44:12 -0800 (PST)
Subject: Re: [PATCH] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1606446515-36069-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201127200215.dc96a839cdd816361e7093e6@linux-foundation.org>
 <9ddb17cd-cf5f-15b1-6a7d-986ee44fd5df@linux.alibaba.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67aacbba-7049-bee8-0ad4-ab4db588c841@gmail.com>
Date:   Mon, 30 Nov 2020 22:44:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <9ddb17cd-cf5f-15b1-6a7d-986ee44fd5df@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.11.2020 07:43, Alex Shi пишет:
> 
> 
> 在 2020/11/28 下午12:02, Andrew Morton 写道:
>> On Fri, 27 Nov 2020 11:08:35 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>> Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
>>> so we could get out early in the situation to avoid useless checking.
>>>
>>> Also warning if both parameter are NULL.
>>
>> Why do you think a warning is needed here?
> 
> Uh, Consider there are no problem for long time, it could be saved.
> 
>>
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -613,14 +613,13 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>>>  	struct mem_cgroup_per_node *mz;
>>>  	struct lruvec *lruvec;
>>>  
>>> -	if (mem_cgroup_disabled()) {
>>> +	VM_WARN_ON_ONCE(!memcg && !pgdat);
>>> +
>>> +	if (mem_cgroup_disabled() || !memcg) {
>>>  		lruvec = &pgdat->__lruvec;
>>>  		goto out;
>>>  	}
>>>  
>>> -	if (!memcg)
>>> -		memcg = root_mem_cgroup;
>>> -
>>
>> This change isn't obviously equivalent, is it?
> 
> If !memcg, the root_mem_cgroup will still lead the lruvec to a pgdat
> same as parameter.
> 
>>
>>>  	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>>>  	lruvec = &mz->lruvec;
>>>  out:
>>
>> And the resulting code is awkward:
>>
>> 	if (mem_cgroup_disabled() || !memcg) {
>> 		lruvec = &pgdat->__lruvec;
>> 		goto out;
>> 	}
>>
>> 	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>> 	lruvec = &mz->lruvec;
>> out:
>>
>>
>> could be
>>
>> 	if (mem_cgroup_disabled() || !memcg) {
>> 		lruvec = &pgdat->__lruvec;
>> 	} else {
>> 		mem_cgroup_per_node mz;
>>
>> 		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>> 		lruvec = &mz->lruvec;
>> 	}
>>
> 
> Right. remove 'goto' is better for understander.
> 
> So, is the following patch ok?
> 
> From 225f29e03b40a7cbaeb4e3bb76f8efbcd7d648a2 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Wed, 25 Nov 2020 14:06:33 +0800
> Subject: [PATCH v2] mm/memcg: bail out early when !memcg in mem_cgroup_lruvec
> 
> Sometime, we use NULL memcg in mem_cgroup_lruvec(memcg, pgdat)
> so we could get out early in the situation to avoid useless checking.
> 
> Polished as Andrew Morton's suggestion.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/memcontrol.h | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3e6a1df3bdb9..4ff2ffe2b73d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -610,20 +610,17 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  					       struct pglist_data *pgdat)
>  {
> -	struct mem_cgroup_per_node *mz;
>  	struct lruvec *lruvec;
>  
> -	if (mem_cgroup_disabled()) {
> +	if (mem_cgroup_disabled() || !memcg) {
>  		lruvec = &pgdat->__lruvec;
> -		goto out;
> -	}
> +	} else {
> +		struct mem_cgroup_per_node *mz;
>  
> -	if (!memcg)
> -		memcg = root_mem_cgroup;
> +		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> +		lruvec = &mz->lruvec;
> +	}
>  
> -	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> -	lruvec = &mz->lruvec;
> -out:
>  	/*
>  	 * Since a node can be onlined after the mem_cgroup was created,
>  	 * we have to be prepared to initialize lruvec->pgdat here;
> 

Hi,

This patch causes a hard lock on one of my ARM32 devices using today's
linux-next, please fix.
