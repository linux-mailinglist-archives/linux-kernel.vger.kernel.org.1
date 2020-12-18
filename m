Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE42DE3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgLROMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgLROMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608300650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gu9xz6qa9Z3nFfsgaYSBwn9dCVbNjrSOJI1gB2zjnDs=;
        b=Mv+hCsIWNwY+r9JsEaSnwAZrfOU07nwOPjoB1wzVqcuJ8uNm2ETM81C2n1mduhoR/x1GTl
        cYKiOGW/oI3J+6/RmokfKcgRBygbBQxZwyB4oLGquSYFaEChgnBhKXjMivcGRMlhxDeuRq
        mNRxN4snyUEwl9hJ6M7aHEF35AWkuUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-MIDmJ1fJN4-R7Bwuz2c3aw-1; Fri, 18 Dec 2020 09:10:48 -0500
X-MC-Unique: MIDmJ1fJN4-R7Bwuz2c3aw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94249801ADF;
        Fri, 18 Dec 2020 14:10:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4FAB917577;
        Fri, 18 Dec 2020 14:10:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 18 Dec 2020 15:10:46 +0100 (CET)
Date:   Fri, 18 Dec 2020 15:10:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its
 pid unexpectedly
Message-ID: <20201218141032.GA20989@redhat.com>
References: <20201217142931.GA8865@redhat.com>
 <875z50roia.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z50roia.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Suppose we have 2 threads, the group-leader L and a sub-theread T,
> > both parked in ptrace_stop(). Debugger tries to resume both threads
> > and does
> >
> > 	ptrace(PTRACE_CONT, T);
> > 	ptrace(PTRACE_CONT, L);
> >
> > If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
> > resume the old leader L, it resumes the post-exec thread T which was
> > actually now stopped in PTHREAD_EVENT_EXEC. In this case the
> > PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
> > tracee changed its pid.
>
> The change seems sensible.  I don't expect this is common but it looks
> painful to deal with if it happens.

Yes, this is not a bug, but gdb can't handle this case without some help
from the kernel.

> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks!



> I am wondering if this should be expanded to all ptrace types for
> consistency.  Or maybe we should set a flag to make this happen for
> all ptrace events.

But for what? ptrace is the very old API, I don't think we want to
suddenly enforce the rule that every reported event must be wait()'ed.
Plus this needs some complications to support WNOWAIT.

I would like to kill JOBCTL_TRAPPING_BIT which ensures that the tracer
does NOT need wait() after PTRACE_ATTACH(stopped-task) (see
wait_on_bit() in ptrace_attach()). I think this makes no sense but
who knows, perhaps even this change can break something.

> It just seems really odd to only worry about missing this event.

Agreed,

> I admit this a threaded PTRACE_EVENT_EXEC is the only event we are
> likely to miss but still.

Yes, this is the only event debugger can miss even if it uses wait()
correctly.

> Do you by any chance have any debugger/strace test cases?
>
> I would think that would be the way to test to see if this breaks
> anything.  I think I remember strace having a good test suite.

Heh. You can never know what other people do with ptrace ;)
For example, see

    fab840fc2d54 ptrace: PTRACE_DETACH should do flush_ptrace_hw_breakpoint(child)
    35114fcbe0b9 Revert "ptrace: PTRACE_DETACH should do flush_ptrace_hw_breakpoint(child)"

Oleg.

