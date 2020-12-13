Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE2D9043
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgLMToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 14:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728530AbgLMToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 14:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607888575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PybtF7w1Lh4LKher9Pdy6RACSnKlX1ExGTMf/b4q00=;
        b=R7EnDWL5mRudewuKPWOQNW3J43IsOjyg/8msd8ayYhHfKPmrxWDIJBc9saZMu4tFt8ydyD
        Wl/Z399YB7FtslOQKn4AkNyE+L6cABSQs495iQapI2LFPgVdAkMiuZOn7QomHdv7Flns44
        kb30uoHwDSQ2n2q0wh2iPmWzJY8UyD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-YhqXPidyOvmi-F4vVw-m6Q-1; Sun, 13 Dec 2020 14:42:53 -0500
X-MC-Unique: YhqXPidyOvmi-F4vVw-m6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D4C1180A094;
        Sun, 13 Dec 2020 19:42:52 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-248.rdu2.redhat.com [10.10.112.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B193A62461;
        Sun, 13 Dec 2020 19:42:51 +0000 (UTC)
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201213180843.16938-1-longman@redhat.com>
 <20201213183936.GA20007@pc636>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ae1f12c5-b57f-7b40-81d5-0fdf7927c437@redhat.com>
Date:   Sun, 13 Dec 2020 14:42:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201213183936.GA20007@pc636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/20 1:39 PM, Uladzislau Rezki wrote:
> On Sun, Dec 13, 2020 at 01:08:43PM -0500, Waiman Long wrote:
>> When multiple locks are acquired, they should be released in reverse
>> order. For s_start() and s_stop() in mm/vmalloc.c, that is not the
>> case.
>>
>>    s_start: mutex_lock(&vmap_purge_lock); spin_lock(&vmap_area_lock);
>>    s_stop : mutex_unlock(&vmap_purge_lock); spin_unlock(&vmap_area_lock);
>>
>> This unlock sequence, though allowed, is not optimal. If a waiter is
>> present, mutex_unlock() will need to go through the slowpath of waking
>> up the waiter with preemption disabled. Fix that by releasing the
>> spinlock first before the mutex.
>>
>> Fixes: e36176be1c39 ("mm/vmalloc: rework vmap_area_lock")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/vmalloc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 6ae491a8b210..75913f685c71 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3448,11 +3448,11 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
>>   }
>>   
>>   static void s_stop(struct seq_file *m, void *p)
>> -	__releases(&vmap_purge_lock)
>>   	__releases(&vmap_area_lock)
>> +	__releases(&vmap_purge_lock)
>>   {
>> -	mutex_unlock(&vmap_purge_lock);
>>   	spin_unlock(&vmap_area_lock);
>> +	mutex_unlock(&vmap_purge_lock);
>>   }
>>   
>>   static void show_numa_info(struct seq_file *m, struct vm_struct *v)
> BTW, if navigation over both list is an issue, for example when there
> are multiple heavy readers of /proc/vmallocinfo, i think, it make sense
> to implement RCU safe lists iteration and get rid of both locks.

Making it lockless is certainly better, but doing lockless the right way 
is tricky. I will probably keep it as it unless there is a significant 
advantage of doing so.

Cheers,
Longman

>
> As for the patch: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
> Thanks!
>
> --
> Vlad Rezki
>

