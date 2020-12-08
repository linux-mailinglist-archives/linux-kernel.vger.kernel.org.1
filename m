Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184752D2E62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgLHPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:36:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729878AbgLHPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607441715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Eo0sHqe9BY+2nbzE/RtTw8rBsTU9VMe8ppwwiLSYbs=;
        b=RJmpE0mGAf6+ZMt4HZY/4LExrumk6Kudftsq04/rOJMJhYvFPHUqLzPES8T3ejUmfv5Unn
        ajDKhD9sacMkVP+IMpnm2JECD5yBkjXMMmJjaWjP8M3He5MqVVriuWbo6H4fBrrg5MZTP1
        mOV3enPSL11JANJWSjTFElmv6OBtIoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-liKTAhfkPOOUjIXzoLjPJw-1; Tue, 08 Dec 2020 10:35:12 -0500
X-MC-Unique: liKTAhfkPOOUjIXzoLjPJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94CB8104ED3D;
        Tue,  8 Dec 2020 15:34:44 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-227.rdu2.redhat.com [10.10.119.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91B4F1042AA9;
        Tue,  8 Dec 2020 15:34:27 +0000 (UTC)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
 <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
 <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <edfd0eb8-192e-60be-f0ca-2a72a26caa07@redhat.com>
Date:   Tue, 8 Dec 2020 10:34:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 4:12 AM, David Laight wrote:
> From: Waiman Long
>> Sent: 07 December 2020 19:02
> ...
>>> How much more difficult would it be to also add a timeout option?
>>> I looked at adding one to the mutex code - and fell into a big pile
>>> of replicated code.
>>>
>>> ISTM that one the initial locked exchange (and spin) fails a few
>>> extra instructions when heading for the sleep don't really matter
>>>
>> Actually, I had tried that before. See
>>
>> https://lore.kernel.org/lkml/20190911150537.19527-1-longman@redhat.com/
>>
>> That is for rwsem, but the same can be done for mutex. However, Peter
>> didn't seem to like the idea of a timeout parameter. Anyway, it is
>> certainly doable if there is a good use case for it.
> 'Unfortunately' my use-case if for an out-of-tree driver.
>
> The problem I was solving is a status call blocking because
> some other code is 'stuck' (probably an oops) with a mutex held.
>
> The code used to use down_timeout() (it was written for 2.4).
> When I changed to mutex_(to get optimistic spinning) I lost
> the ability to do the timeouts.

The primary reason for sending out that patchset was to work around some 
circular locking problem in existing code even though these circular 
locking scenarios are not likely to happen. Your case is certainly 
another potential circular locking problem as well.

Cheers,
Longman


