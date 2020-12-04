Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6412CF6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgLDWOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:14:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:32990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgLDWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:14:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46B34AFEB;
        Fri,  4 Dec 2020 22:13:50 +0000 (UTC)
Date:   Fri, 4 Dec 2020 13:48:36 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
Message-ID: <20201204214836.3rncqw5kox42b4i2@linux-p48b.lan>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org>
 <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Linus Torvalds wrote:

>On Fri, Dec 4, 2020 at 12:30 PM Bernd Edlinger
><bernd.edlinger@hotmail.de> wrote:
>>>
>> >    perf_event_open  (exec_update_mutex -> ovl_i_mutex)
>
>Side note: this one looks like it should be easy to fix.
>
>Is there any real reason why exec_update_mutex is actually gotten that
>early, and held for that long in the perf event code?

afaict just to validate the whole operation early. Per 79c9ce57eb2 the
mutex will guard the check and the perf_install_in_context vs exec.

>
>I _think_ we could move the ptrace check to be much later, to _just_ before that
>
>         * This is the point on no return; we cannot fail hereafter.
>
>point in the perf event install chain..

Peter had the idea of doing the ptrace_may_access() check twice: first
lockless and early, then under exec_update_mutex when it mattered right
before perf_install_in_context():

https://lore.kernel.org/linux-fsdevel/20200828123720.GZ1362448@hirez.programming.kicks-ass.net/

>
>I don't think it needs to be moved down even that much, I think it
>would be sufficient to move it down below the "perf_event_alloc()",
>but I didn't check very much.

Yeah we could just keep a single ptrace_may_access() check just further
down until it won't deadlock.

Thanks,
Davidlohr
