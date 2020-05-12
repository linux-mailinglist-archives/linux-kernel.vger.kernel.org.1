Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C2B1CFB16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgELQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:41:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbgELQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589301697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HF+dv8UvvUiqcjhC1Sb2/924Jpbd+60T+DclXEjScNs=;
        b=cHsvCUMvxOwj3wbS3iP7KdZH+qn8imSc4w5puI7t2xBCLPqsLXEHGY/BHyA/gnBOunF4mQ
        fXzPtUjnIBYJ+d6MDpHIWG3Lka07vMJfRFnQ/frWziB/oa1Jc2GmNDJw1VFgcMlb1SxqIK
        fTcW9X4BPc3wbNv3t2Kkrs9Am58A3p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-p482huz2Pyqkvnq6eE6uDQ-1; Tue, 12 May 2020 12:41:35 -0400
X-MC-Unique: p482huz2Pyqkvnq6eE6uDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51729107ACF3;
        Tue, 12 May 2020 16:41:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D7A15D9E5;
        Tue, 12 May 2020 16:41:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 May 2020 18:41:33 +0200 (CEST)
Date:   Tue, 12 May 2020 18:41:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] kernel/sys: only rely on rcu for getpriority(2)
Message-ID: <20200512164130.GC28621@redhat.com>
References: <20200512000353.23653-1-dave@stgolabs.net>
 <20200512000353.23653-2-dave@stgolabs.net>
 <20200512150936.GA28621@redhat.com>
 <20200512160915.n3plwrwwrlpfqyrs@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512160915.n3plwrwwrlpfqyrs@linux-p48b>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12, Davidlohr Bueso wrote:
>
> On Tue, 12 May 2020, Oleg Nesterov wrote:
>
> >do_each_pid_task(PIDTYPE_PGID) can race with change_pid(PIDTYPE_PGID)
> >which moves the task from one hlist to another. Yes, it is safe in
> >that task_struct can't go away. But still this is not right because
> >do_each_pid_task() can scan the wrong (2nd) hlist.
>
> Hmm I didn't think about this case, I guess this is also busted in
> ioprio_get(2) then.

agreed...

> >
> >could you explain in details why do you think this PF_EXITING check
> >makes any sense?
>
> My logic was that if the task with the highest prio exited while we
> were iterating the list, it would not be necessarily seen with rcu
> and the syscall would return the highest prio of a task that exited;
> and checking against PF_EXITING was a way to ignore such scenarios
> as we were going to race with it anyway.

Sorry, still can't understand. The PF_EXITING flag is not protected by
tasklist_lock or rcu_lock.


OK, if nothing else. Suppose that a prgp has a single process P, this
proces has already exited but its parent didn't do wait().

Currently getpriority() returns task_nice(P). With the PF_EXITING check
it will return -ESRCH. Hmm?

Oleg.

