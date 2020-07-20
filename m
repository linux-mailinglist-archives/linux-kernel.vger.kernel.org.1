Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449DA225A03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGTI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:27:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgGTI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595233627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4z7nR04vRuVBvqoFTXOBrRy4wubg3LXnzAisW2rHG8=;
        b=aGfxJuM3H9G6LWu/gDCs6wpNflRlT16UIrfLz8Ft5Vb5encZsEe5GNuc2dPLhcsyLCLd4A
        TzGfH+bmuTNOj5sEdFaf2cmXTq6SFGCsVTsGt6/NbBtvDFV3NLws+3QN6NzBJqj6Fu1dgp
        jPIl0eaVzVRNFR6SqJLU/5Qsb5qy3h8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251--lMo-fx-NMyyAy6e2oW7CA-1; Mon, 20 Jul 2020 04:27:03 -0400
X-MC-Unique: -lMo-fx-NMyyAy6e2oW7CA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A94EC800597;
        Mon, 20 Jul 2020 08:27:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D90773058;
        Mon, 20 Jul 2020 08:26:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jul 2020 10:27:01 +0200 (CEST)
Date:   Mon, 20 Jul 2020 10:26:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <20200720082657.GC6612@redhat.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720064326.GA6612@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
->siglock held. That is why ptrace_freeze_traced() assumes it can safely
do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).

Can this change race with

		if (signal_pending_state(prev->state, prev)) {
			prev->state = TASK_RUNNING;
		}

in __schedule() ? Hopefully not, signal-state is protected by siglock too.

So I think this logic was correct even if it doesn't look nice. But "doesn't
look nice" is true for the whole ptrace code ;)

On 07/20, Oleg Nesterov wrote:
>
> On 07/20, Jiri Slaby wrote:
> >
> > You tackled it, we cherry-picked dbfb089d360 to our kernels. Ccing more
> > people.
>
> Thanks... so with this patch __schedule() does
>
> 	prev_state = prev->state;
>
> 	...
>
> 	if (!preempt && prev_state && prev_state == prev->state) {
> 		if (signal_pending_state(prev_state, prev)) {
> 			prev->state = TASK_RUNNING;
> 		} else {
>
> and ptrace_freeze_traced() can change ->state in between. This means
> that this task can return from __schedule() with ->state != RUNNING,
> this can explain BUG_ON(task_is_stopped_or_traced) in do_notify_parent()
> you reported.
>
> Oleg.

