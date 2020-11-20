Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109B02BB126
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgKTREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728771AbgKTREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605891870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fDQVmfFKeAGKLRGbsrcZpScq4bc7Sw4oihjxYlBdLs=;
        b=eTlaPESwXU6G90UsLc4CyS5sb9sNrPPQYqTED7puhmDlvcKpUKis9j2eV9p72LI4zzBYBy
        chVDMhTEWMeSqBbY1rLEG5/hmS4vYqtab43YgqirrcA1VvZcuF+GgZDjU+IQ6rkqmTw/gw
        Ig+vpL2pPwOCOzMFIVuT5nRaNXRH0jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-q6tZPtKfNw-l-ZXQ9ou6cA-1; Fri, 20 Nov 2020 12:04:28 -0500
X-MC-Unique: q6tZPtKfNw-l-ZXQ9ou6cA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43985CE647;
        Fri, 20 Nov 2020 17:04:26 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-157.rdu2.redhat.com [10.10.118.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4201F0;
        Fri, 20 Nov 2020 17:04:24 +0000 (UTC)
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
To:     David Laight <David.Laight@ACULAB.COM>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
 <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <68d07068-ff31-26b5-f90d-7ea8b4ee2389@redhat.com>
Date:   Fri, 20 Nov 2020 12:04:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 8:11 AM, David Laight wrote:
> From: Waiman Long
>> Sent: 19 November 2020 18:40
> ...
>> My own testing also show not too much performance difference when
>> removing reader spinning except in the lightly loaded cases.
> I'm confused.
>
> I got massive performance improvements from changing a driver
> we have to use mutex instead of the old semaphores (the driver
> was written a long time ago).
>
> While these weren't 'rw' the same issue will apply.
>
> The problem was that the semaphore/mutex was typically only held over
> a few instructions (eg to add an item to a list).
> But with semaphore if you got contention the process always slept.
> OTOH mutex spin 'for a while' before sleeping so the code rarely slept.
>
> So I really expect that readers need to spin (for a while) if
> a rwsem (etc) is locked for writing.
>
> Clearly you really need a CBU (Crystal Ball Unit) to work out
> whether to spin or not.

That is the hard part. For short critical section and not many readers 
around, making the readers spin will likely improve performance. On the 
other hand, if the critical section is long with many readers, make 
readers sleep and then wake them all up at once can have better 
performance. There is no one-size-fit-all solution here.

Cheers,
Longman

