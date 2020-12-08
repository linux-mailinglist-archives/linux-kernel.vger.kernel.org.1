Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F502D2FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgLHQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728602AbgLHQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607445269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kHgoGhv8HUb19jzaHIarDf6oRrYVWwvArf8AQ6kTY0=;
        b=aLOWVVYIQKdYswY/m8lvSWmgE+CIFK1RV2U6syu3VCBCKXnMbbjhxWVtwgHZBYclxhytoM
        zbntYi7dXkoMAyGcnuKQgBY7UClgRlUe1jNw871rvp8bkaG5dn4MavTF6QreK5wnAZJjsu
        QtIF/gf114qYFcMZk10hE1U4PFDrhzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-IWfkXfTSMnCWXoti1jJfAw-1; Tue, 08 Dec 2020 11:34:26 -0500
X-MC-Unique: IWfkXfTSMnCWXoti1jJfAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1695FD568E;
        Tue,  8 Dec 2020 16:33:40 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-227.rdu2.redhat.com [10.10.119.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10BA9794CB;
        Tue,  8 Dec 2020 16:33:38 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] locking/rwsem: Rework reader optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
 <20201208145743.GF2414@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <77f74f7f-f090-ef3f-11ec-62bc89bd9a83@redhat.com>
Date:   Tue, 8 Dec 2020 11:33:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208145743.GF2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 9:57 AM, Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 11:14:11PM -0500, Waiman Long wrote:
>> Waiman Long (5):
>>    locking/rwsem: Pass the current atomic count to
>>      rwsem_down_read_slowpath()
>>    locking/rwsem: Prevent potential lock starvation
>>    locking/rwsem: Enable reader optimistic lock stealing
>>    locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
>>    locking/rwsem: Remove reader optimistic spinning
> So I've munged the lot onto the other rwsem patches and skipped #4, I've
> not even boot tested them (will go do so shortly).
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
>
I have checked the four patches in your locking/core branch. They look 
good to me. Are you planning to push the branch to tip soon so that it 
can be ready for the next merge window?

Anyway, thanks for taking my patches.

Cheers,
Longman

