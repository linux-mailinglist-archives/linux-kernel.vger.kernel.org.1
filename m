Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3019E15F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgDCXQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 19:16:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727829AbgDCXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585955768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ow5jrQXb9as/47skj64mJ5864/J/UjNZWzuptpAdFI=;
        b=h3yp+8ypf7w3ojVRxrSykWYOq7ZXjxf8jMs6kQ2aeAFpOlIVI0RkYjQz+IM0P28ZeZr6C8
        1jdNzeWr/njSoHb8zWmU/cYS68uKz9fk5A7eyzdUAXuAtiO60Cc+y13rlU+UkWqEjKXsrT
        TgT3hpoSxyNdiGoJDAIV+/sJRcpLD+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-NvbznsXuNlq4LNHMrMkIUg-1; Fri, 03 Apr 2020 19:16:06 -0400
X-MC-Unique: NvbznsXuNlq4LNHMrMkIUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D3DB1084431;
        Fri,  3 Apr 2020 23:16:05 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-94.rdu2.redhat.com [10.10.118.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49B369A257;
        Fri,  3 Apr 2020 23:16:04 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
Date:   Fri, 3 Apr 2020 19:16:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 4:59 PM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 1:41 PM Waiman Long <longman@redhat.com> wrote:
>> Another alternative is to add new functions like down_read_unfair() that
>> perform unfair read locking for its callers. That will require less code
>> change, but the calling functions have to make the right choice.
> I'd prefer the static choice model - and I'd hide this in some
> "task_cred_read_lock()" function anyway rather than have the users do
> "mutex_lock_killable(&task->signal->cred_guard_mutex)" like they do
> now.
>
> How nasty would it be to add the "upgrade" op? I took a quick look,
> but that just made me go "Waiman would know" ;)
>
>              Linus
>
With static choice, you mean defined at init time. Right? In that case,
you don't really need a special encapsulation function.

With upgrade, if there is only one reader, it is pretty straight
forward. With more than one readers, it gets more complicated as we have
to wait for other readers to unlock. We can spin for a certain period of
time. After that, that reader can use the handoff mechanism by queuing
itself in front the wait queue before releasing the read lock and go to
sleep. That will make sure that it will get the lock once all the other
readers exits. For an unfair rwsem, the writer cannot assert the handoff
bit and so it shouldn't interfere with this upgrade process.

If there are multiple upgrade readers, only one can win the race. The
others have to release the read lock and queue themselves as writers.
Will that be acceptable?

Cheers,
Longman



Cheers,
Longman

