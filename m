Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C21CF89E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgELPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:09:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727844AbgELPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589296186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3mzHOjyJBVl0+9NmeI1isPR/7RdebGvNkEnyKCfdAo=;
        b=UUKlOSrje9UV8aekJ4OtX22lBoG3WdhAsQlxMSGtHzsmUG5uP2VG+eROewIe8tE/Lb86tW
        qlpPa5NKlTr8hNj+I0nIB2N+CESYYi+C2tj6qg7touldH+bm1l8u2HJkPE/QmnxNKqDgw9
        Px2/op+TQD9juKt3MuS4pnO7eaT18q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-CPQ8ZxIfM4OqdKjiM42LYw-1; Tue, 12 May 2020 11:09:42 -0400
X-MC-Unique: CPQ8ZxIfM4OqdKjiM42LYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6CB8100CCC0;
        Tue, 12 May 2020 15:09:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id EAC6F5D9DD;
        Tue, 12 May 2020 15:09:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 May 2020 17:09:40 +0200 (CEST)
Date:   Tue, 12 May 2020 17:09:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] kernel/sys: only rely on rcu for getpriority(2)
Message-ID: <20200512150936.GA28621@redhat.com>
References: <20200512000353.23653-1-dave@stgolabs.net>
 <20200512000353.23653-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512000353.23653-2-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Davidlohr Bueso wrote:
>
> Currently the tasklist_lock is shared mainly in order to observe
> the list atomically for the PRIO_PGRP and PRIO_USER cases, as
> the actual lookups are already rcu-safe,

not really...

do_each_pid_task(PIDTYPE_PGID) can race with change_pid(PIDTYPE_PGID)
which moves the task from one hlist to another. Yes, it is safe in
that task_struct can't go away. But still this is not right because
do_each_pid_task() can scan the wrong (2nd) hlist.

> (ii) exit (deletion), this window is small but if a task is
> deleted with the highest nice and it is not observed this would
> cause a change in return semantics. To further reduce the window
> we ignore any tasks that are PF_EXITING in the 'old' version of
> the list.

can't understand...

could you explain in details why do you think this PF_EXITING check
makes any sense?

Oleg.

