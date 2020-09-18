Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDF2700C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:18:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgIRPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600442316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ETZHh7FXeQbyxpDjZYV13SKWV6kJy3ncbq86WYzI9Q=;
        b=eFpw96ZbjXDuJsMPL1zbb02WbvhCVdZ4wv+/FLDIEJj8fjnf2daUto2k6SiFQ1ZzWbWWuN
        h6msWZwjdfGALjDb2j0vIBOt0AxOJTQwe1+AUgB1dHeHaIoJx7abCjRDTXeapZOvdhH+pJ
        Nna7HAEggSawbacvqmcgEm8pXRC+mn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-VgCgk5PWNmKv1s7PrTgqKA-1; Fri, 18 Sep 2020 11:18:34 -0400
X-MC-Unique: VgCgk5PWNmKv1s7PrTgqKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5ED64098;
        Fri, 18 Sep 2020 15:18:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-232.rdu2.redhat.com [10.10.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 428925C225;
        Fri, 18 Sep 2020 15:18:32 +0000 (UTC)
Subject: Re: [PATCH v2] sched, mm: Optimize current_gfp_context()
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
References: <20200618212936.9776-1-longman@redhat.com>
 <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
 <a5b29e4d-cc9e-a422-e7b4-e68e0dee37c7@windriver.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c8f3c589-c4c4-f132-8759-24a44cfa73f4@redhat.com>
Date:   Fri, 18 Sep 2020 11:18:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a5b29e4d-cc9e-a422-e7b4-e68e0dee37c7@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 2:44 AM, Xu, Yanfei wrote:
> Hi Waiman,
>
> On 8/12/20 6:29 AM, Andrew Morton wrote:
>> On Thu, 18 Jun 2020 17:29:36 -0400 Waiman Long <longman@redhat.com> 
>> wrote:
>>
>>> The current_gfp_context() converts a number of PF_MEMALLOC_* 
>>> per-process
>>> flags into the corresponding GFP_* flags for memory allocation. In
>>> that function, current->flags is accessed 3 times. That may lead to
>>> duplicated access of the same memory location.
>>>
> I have a puzzle about this comment, what's the meaning about "That may
> lead to duplicated access of the same memory location". After using
> variable 'pflags', will it not duplicated access the same memory
> location?
> Looking forward to your reply :)

That condition usually won't happen on a non-debug kernel. However, if 
certain debugging capability is turned on, access to current will be 
compiled into a bunch of checks and memory accesses. So if current is 
used multiple times, the same set of codes will be duplicated the same 
number of times slowing down the operation and increasing code size. By 
accessing current once, we avoid this overhead in a debug kernel.

Cheers,
Longman

