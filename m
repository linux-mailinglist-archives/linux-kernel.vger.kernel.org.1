Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21582B9AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgKSSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbgKSSkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605811212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgy/V0UxwiGYR9z/XPHQctCh3F8LfVyhlf5Ot3bhOUg=;
        b=NuJeSDq2if5SWYNMBJnmtRy5goZxKsYFAhR5YLTsx/Zcd8GWLI6ZCpJ7CK6wJZyNQXPZ3G
        g8oBZkF2ytvOxJzhwGZ5iUlutcaOCSVAAgnG2509YvIAmKC96YWa7OBzdYrjERMjS8wq+N
        1kPOeexjlV3eVgVeJBMRZOQx3b5tiVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-i49NzqxAM5SHG_1MjCuMKw-1; Thu, 19 Nov 2020 13:40:09 -0500
X-MC-Unique: i49NzqxAM5SHG_1MjCuMKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D9CF911EC;
        Thu, 19 Nov 2020 18:40:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-63.rdu2.redhat.com [10.10.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B48A5C1D5;
        Thu, 19 Nov 2020 18:40:07 +0000 (UTC)
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
Date:   Thu, 19 Nov 2020 13:40:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 12:35 AM, Davidlohr Bueso wrote:
> On Tue, 17 Nov 2020, Waiman Long wrote:
>
>> The column "CS Load" represents the number of pause instructions issued
>> in the locking critical section. A CS load of 1 is extremely short and
>> is not likey in real situations. A load of 20 (moderate) and 100 (long)
>> are more realistic.
>>
>> It can be seen that the previous patches in this series have reduced
>> performance in general except in highly contended cases with moderate
>> or long critical sections that performance improves a bit. This change
>> is mostly caused by the "Prevent potential lock starvation" patch that
>> reduce reader optimistic spinning and hence reduce reader fragmentation.
>>
>> The patch that further limit reader optimistic spinning doesn't seem to
>> have too much impact on overall performance as shown in the benchmark
>> data.
>>
>> The patch that disables reader optimistic spinning shows reduced
>> performance at lightly loaded cases, but comparable or slightly better
>> performance on with heavier contention.
>
> I'm not overly worried about the lightly loaded cases here as the users
> (mostly thinking mmap_sem) most likely won't care for real workloads,
> not, ie: will-it-scale type things.
I am not that worry about the lightly loaded cases either. I just state 
the fact that some workloads may see a slightly reduced performance 
because of that.
>
> So at SUSE we also ran into this very same problem with reader optimistic
> spinning and considering the fragmentation went with disabling it, much
> like this patch - but without the reader optimistic lock stealing bits
> you have. So far nothing has really shown to fall out in our performance
> automation. And per your data a single reader spinner does not seem to be
> worth the added complexity of keeping reader spinning vs ripping it out. 

My own testing also show not too much performance difference when 
removing reader spinning except in the lightly loaded cases.

Cheers,
Longman

