Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3B2D3124
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgLHRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729558AbgLHRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607448654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOXvqHHkd4dZLF36ak7r6rs3Qqq6NivRt1M6tkCD6J4=;
        b=FoGCEga07mKTXbXDRbw1DI3REP+6pE+eGEDCGOQGKdA4kxd5SgwI/0v/NJleievMEaTtpV
        VvefQ3ZlP+jpS8SuHGjbLlEkPO1QLAObqQwL+fAeM6Fv2mic8lIPlREICPjUsheyYGOcNa
        eod9qlD0Dow1+YSeGckx3bO01M1kB/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-LrVjmYh3MNWpiRZ3G3pCyA-1; Tue, 08 Dec 2020 12:30:52 -0500
X-MC-Unique: LrVjmYh3MNWpiRZ3G3pCyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A76F1084D7E;
        Tue,  8 Dec 2020 17:30:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-227.rdu2.redhat.com [10.10.119.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2D05D9DD;
        Tue,  8 Dec 2020 17:30:26 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] locking/rwsem: Rework reader optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
 <20201208145743.GF2414@hirez.programming.kicks-ass.net>
 <77f74f7f-f090-ef3f-11ec-62bc89bd9a83@redhat.com>
 <20201208170233.GG2414@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c99590ae-f560-e96c-0518-8f1296f33278@redhat.com>
Date:   Tue, 8 Dec 2020 12:30:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208170233.GG2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 12:02 PM, Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 11:33:38AM -0500, Waiman Long wrote:
>> On 12/8/20 9:57 AM, Peter Zijlstra wrote:
>>> On Fri, Nov 20, 2020 at 11:14:11PM -0500, Waiman Long wrote:
>>>> Waiman Long (5):
>>>>     locking/rwsem: Pass the current atomic count to
>>>>       rwsem_down_read_slowpath()
>>>>     locking/rwsem: Prevent potential lock starvation
>>>>     locking/rwsem: Enable reader optimistic lock stealing
>>>>     locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
>>>>     locking/rwsem: Remove reader optimistic spinning
>>> So I've munged the lot onto the other rwsem patches and skipped #4, I've
>>> not even boot tested them (will go do so shortly).
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
>>>
>> I have checked the four patches in your locking/core branch. They look good
>> to me. Are you planning to push the branch to tip soon so that it can be
>> ready for the next merge window?
> Yeah, provided the robots don't hate on it more than already reported.
>
Good to know:-)

Cheers,
Longman

