Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D42BB932
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgKTWj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:39:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728470AbgKTWj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605911994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3El2hXRpQVR3PZtynZGSoJC07Ftno34H/6B207e9Sg=;
        b=IiEqQVWS4Vc3Z0sLBbT+0SqD+cMo2M7CMiZWhvVKAdNgWHaDCdr6uyLZvQW02AjcLyos1E
        U9wqncZh1z/dzb2pSJPzM9Zzup1ZkW0R56N/0NyihDirVm518TIrGnHsbYlmdl6tLgaPuq
        5qFlU5R+eHOxemovkWvNg0en9QO9Znw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-_OsoQEVgP2SmTPA7clkpMg-1; Fri, 20 Nov 2020 17:39:52 -0500
X-MC-Unique: _OsoQEVgP2SmTPA7clkpMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3DC318B613D;
        Fri, 20 Nov 2020 22:39:51 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19F025C1D5;
        Fri, 20 Nov 2020 22:39:51 +0000 (UTC)
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <20201120144408.GF3040@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <90e1bc43-fead-904f-3bed-a2fbadf9c1ac@redhat.com>
Date:   Fri, 20 Nov 2020 17:39:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201120144408.GF3040@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 9:44 AM, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 09:35:56PM -0800, Davidlohr Bueso wrote:
>> On Tue, 17 Nov 2020, Waiman Long wrote:
>>
>>> The column "CS Load" represents the number of pause instructions issued
>>> in the locking critical section. A CS load of 1 is extremely short and
>>> is not likey in real situations. A load of 20 (moderate) and 100 (long)
>>> are more realistic.
>>>
>>> It can be seen that the previous patches in this series have reduced
>>> performance in general except in highly contended cases with moderate
>>> or long critical sections that performance improves a bit. This change
>>> is mostly caused by the "Prevent potential lock starvation" patch that
>>> reduce reader optimistic spinning and hence reduce reader fragmentation.
>>>
>>> The patch that further limit reader optimistic spinning doesn't seem to
>>> have too much impact on overall performance as shown in the benchmark
>>> data.
>>>
>>> The patch that disables reader optimistic spinning shows reduced
>>> performance at lightly loaded cases, but comparable or slightly better
>>> performance on with heavier contention.
>> I'm not overly worried about the lightly loaded cases here as the users
>> (mostly thinking mmap_sem) most likely won't care for real workloads,
>> not, ie: will-it-scale type things.
>>
>> So at SUSE we also ran into this very same problem with reader optimistic
>> spinning and considering the fragmentation went with disabling it, much
>> like this patch - but without the reader optimistic lock stealing bits
>> you have. So far nothing has really shown to fall out in our performance
>> automation. And per your data a single reader spinner does not seem to be
>> worth the added complexity of keeping reader spinning vs ripping it out.
> I'm fine with ripping it... It was finnicky to begin with.
>
Good to know. I am going to sent out v2 with some update commit logs and 
some !CONFIG_RWSEM_SPIN_ON_OWNER fixes.

Cheers,
Longman

