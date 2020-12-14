Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0632D9A92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLNPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408120AbgLNPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607958337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsRXHORkSBohlUPPStBUsx3EB0JydpdD1grl8BL2x68=;
        b=bpVlwe0TlvuRbketiN+LZpQMwpTFM4N+BDwWfBOqD7h2N4tq2TEOqOk2fzi/uYpT4cGQfq
        5JhBuf8YFro0iTXrenPI565c9qh4bNZnM4g6H+oY5BcRCpz5J92QLKYMwG1Rjuxi3DmKhl
        +wX9DAla73VUs0X/1rpWv8UZg+1q3o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-f8o2K-UnO_2B8JW3ohNe-w-1; Mon, 14 Dec 2020 10:05:34 -0500
X-MC-Unique: f8o2K-UnO_2B8JW3ohNe-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB2CB800D53;
        Mon, 14 Dec 2020 15:05:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-252.rdu2.redhat.com [10.10.116.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC5E10023BF;
        Mon, 14 Dec 2020 15:05:29 +0000 (UTC)
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201213180843.16938-1-longman@redhat.com>
 <4510fe4a-a4e1-32e6-4263-5aa66aaa7895@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <290d5967-9929-b0df-a3db-755c102f6599@redhat.com>
Date:   Mon, 14 Dec 2020 10:05:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4510fe4a-a4e1-32e6-4263-5aa66aaa7895@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 4:39 AM, David Hildenbrand wrote:
> On 13.12.20 19:08, Waiman Long wrote:
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
> I'm not sure if this classifies as "Fixes". As you correctly state "is
> not optimal". But yeah, releasing a spinlock after releasing a mutex
> looks weird already.
>
Yes, it may not be technically a real bug fix. However, the order just 
doesn't look right. That is why I sent out a patch to address that.

Cheers,
Longman

