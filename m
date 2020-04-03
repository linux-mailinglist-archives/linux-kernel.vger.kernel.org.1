Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A945C19E168
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgDCXXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 19:23:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgDCXXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585956208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shK7qBjf2e10sdSywtDvuJVbDi+077h/FJ4bWP1/wIQ=;
        b=R5C5no3AjIi4bEk0+0xerl8GpMOTpgDii0OCWQhEuHGXVc99qTHHUFrDoaF8MQR5uLyegm
        YuAarBpc/d+/uYfo2jERQ0wpD4gU5YU8gT/VHUl/+UYsdpZO+oA8SF5M62bQkAlH+94a2g
        tASABuCfu9GkdN1iyoVRavplabpQBVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-VZgX9-JIN_KgLhI2gGovrQ-1; Fri, 03 Apr 2020 19:23:26 -0400
X-MC-Unique: VZgX9-JIN_KgLhI2gGovrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C82107ACC4;
        Fri,  3 Apr 2020 23:23:25 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-94.rdu2.redhat.com [10.10.118.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650E639B;
        Fri,  3 Apr 2020 23:23:24 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
From:   Waiman Long <longman@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
Organization: Red Hat
Message-ID: <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
Date:   Fri, 3 Apr 2020 19:23:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 7:16 PM, Waiman Long wrote:
> On 4/3/20 4:59 PM, Linus Torvalds wrote:
>> On Fri, Apr 3, 2020 at 1:41 PM Waiman Long <longman@redhat.com> wrote:
>>> Another alternative is to add new functions like down_read_unfair() that
>>> perform unfair read locking for its callers. That will require less code
>>> change, but the calling functions have to make the right choice.
>> I'd prefer the static choice model - and I'd hide this in some
>> "task_cred_read_lock()" function anyway rather than have the users do
>> "mutex_lock_killable(&task->signal->cred_guard_mutex)" like they do
>> now.
>>
>> How nasty would it be to add the "upgrade" op? I took a quick look,
>> but that just made me go "Waiman would know" ;)
>>
>>              Linus
>>
> With static choice, you mean defined at init time. Right? In that case,
> you don't really need a special encapsulation function.
>
> With upgrade, if there is only one reader, it is pretty straight
> forward. With more than one readers, it gets more complicated as we have
> to wait for other readers to unlock. We can spin for a certain period of
> time. After that, that reader can use the handoff mechanism by queuing
> itself in front the wait queue before releasing the read lock and go to
> sleep. That will make sure that it will get the lock once all the other
> readers exits. For an unfair rwsem, the writer cannot assert the handoff
> bit and so it shouldn't interfere with this upgrade process.
>
> If there are multiple upgrade readers, only one can win the race. The
> others have to release the read lock and queue themselves as writers.
> Will that be acceptable?

Alternatively, we could assert that only one reader can do the upgrade
and do a WARN_ON_ONCE() if multiple concurrent upgrade attempts is detected.

Regards,
Longman

