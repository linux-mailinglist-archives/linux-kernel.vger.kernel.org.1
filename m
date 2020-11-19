Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18602B9AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgKSShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728814AbgKSShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605811041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNuPfYb6QpUO0dpq/+CinmBMNnGjxsjuYOWF3kUqYn4=;
        b=jUKwVxERPJ6V3NYa6/JJxGEXY1mtvDgOgAc9GAnk8jj/HeVO7ZEGCIPZwHIWy8adM8mEiK
        t4ow6Hohk/n4DZSAw3JbLnize8UPqrh72XrTppbzDMWbHp3CnqFdt9i+qZsawUXF5QeK3W
        Aj01CYEncNOuussYr0j5VDzKJlzHkMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-bOQ27-woPTKUT69XVp6DNw-1; Thu, 19 Nov 2020 13:37:17 -0500
X-MC-Unique: bOQ27-woPTKUT69XVp6DNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AAE8143F3;
        Thu, 19 Nov 2020 18:37:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-63.rdu2.redhat.com [10.10.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D9235D9C2;
        Thu, 19 Nov 2020 18:37:15 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/rwsem: Wake up all waiting readers if
 RWSEM_WAKE_READ_OWNED
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-5-longman@redhat.com>
 <20201118045345.hpw2fjmd247xpnwl@linux-p48b.lan>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a148b930-ae25-29a6-4f02-6c6c582ca2cd@redhat.com>
Date:   Thu, 19 Nov 2020 13:37:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118045345.hpw2fjmd247xpnwl@linux-p48b.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 11:53 PM, Davidlohr Bueso wrote:
> On Tue, 17 Nov 2020, Waiman Long wrote:
>
>> The rwsem wakeup logic has been modified by commit d3681e269fff
>> ("locking/rwsem: Wake up almost all readers in wait queue") to wake up
>> all readers in the wait queue if the first waiter is a reader. In the
>> case of RWSEM_WAKE_READ_OWNED, not all readers can be woken up if the
>> first waiter happens to be a writer. Complete the logic by waking up
>> all readers even for this case.
>
> While rwsems are certainly not fifo, I'm concerned this would give too
> much priority to the readers by having the reader owned lock just skip
> over the first waiter. And I'd say most users are more concerned about
> the writer side. Basically this would affect the phase-fair properties. 

The idea of phase-fair is that when a reader acquires the lock, all the 
current readers are allowed to join. Other readers that come after that 
will not be allowed to join the read phase until the next round. In that 
sense, waking up all readers in the wait queue doesn't violate this 
fact. Patch 2 will guarantee  the later constraint though it has the 
exception that if the reader count reach 0, it will allow reader to 
proceed. I am relying on the handoff mechanism to make sure that there 
will be no lock starvation.

Cheers,
Longman


