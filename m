Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7145A28F2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJOMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgJOMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602766176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCIQX4TO8AhD+oV+mB3K9at6ZGKnl/odKYoHfmps0Cw=;
        b=IlYs7FRmI2N0H1pUtatM1vly/05EFY375g9bxTkxpX2Fcqm8G3W2RtgUbcI7luUfCRu08T
        qKRDH/jWoxMXYsO9kdOhWT6Lpt31BTyaBUwuTjoXB5daKlsoS95WuHAnVdFQU9+rKOXhCY
        LXJgmyAzcMFvyW0GEZaLVLlTuZuJ5zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-JX-BSF-cNqmw5C493U-tYg-1; Thu, 15 Oct 2020 08:49:32 -0400
X-MC-Unique: JX-BSF-cNqmw5C493U-tYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487C188EF23;
        Thu, 15 Oct 2020 12:49:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id E7E535DA85;
        Thu, 15 Oct 2020 12:49:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 15 Oct 2020 14:49:29 +0200 (CEST)
Date:   Thu, 15 Oct 2020 14:49:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
Subject: Re: WARNING in get_signal
Message-ID: <20201015124926.GA24156@redhat.com>
References: <000000000000da06e405b0b20f1e@google.com>
 <87zh54bp0n.fsf@x220.int.ebiederm.org>
 <20201005134923.GA9995@redhat.com>
 <20201005163016.GB9995@redhat.com>
 <20201006170523.GC9995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006170523.GC9995@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06, Oleg Nesterov wrote:
>
> I still do not see a good fix. I am crying ;)

Sorry for delay... Finally I think I have a simple and clean fix.
We can leave ptrace_init_task() alone and fix task_join_group_stop().

I need to test it a bit and write the changelog, do you see any problem
in the patch below?

(TODO: SIGCONT should clear JOBCTL_STOP_SIGMASK, needs another patch)

Oleg.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -391,16 +391,17 @@ static bool task_participate_group_stop(struct task_struct *task)
 
 void task_join_group_stop(struct task_struct *task)
 {
+	struct signal_struct *sig = current->signal;
+	unsigned long mask = current->jobctl & JOBCTL_STOP_SIGMASK;
+
+	if (sig->group_stop_count) {
+		sig->group_stop_count++;
+		mask |= JOBCTL_STOP_CONSUME;
+	} else if (!(sig->flags & SIGNAL_STOP_STOPPED))
+		return;
+
 	/* Have the new thread join an on-going signal group stop */
-	unsigned long jobctl = current->jobctl;
-	if (jobctl & JOBCTL_STOP_PENDING) {
-		struct signal_struct *sig = current->signal;
-		unsigned long signr = jobctl & JOBCTL_STOP_SIGMASK;
-		unsigned long gstop = JOBCTL_STOP_PENDING | JOBCTL_STOP_CONSUME;
-		if (task_set_jobctl_pending(task, signr | gstop)) {
-			sig->group_stop_count++;
-		}
-	}
+	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
 /*

