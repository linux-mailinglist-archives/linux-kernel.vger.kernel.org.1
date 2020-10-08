Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D322875EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgJHOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbgJHOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVz2+YqIfMMMSBBhsKspP0YjHIaZImbC/yPLLJ1TgAk=;
        b=SEn4Szbbeid9xBUitCL4j4IQ++Z9Uzd85tcRyuVDTKPneb0G03xUX4Ig7y4k2xqUeri8/a
        //ZOEgat3XM+KRWfueNAckAIaCEsqj8H6Fi8N/W09UG7I0DXyb0VDMVcR5mq3CwYEow4TT
        h1jnUDhtYqSrB0ejGmvFQA4zeA8JEps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-IZ_9PBY9PfOOFYlCHVoLXw-1; Thu, 08 Oct 2020 10:21:40 -0400
X-MC-Unique: IZ_9PBY9PfOOFYlCHVoLXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6996519080A0;
        Thu,  8 Oct 2020 14:21:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id C932176647;
        Thu,  8 Oct 2020 14:21:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Oct 2020 16:21:38 +0200 (CEST)
Date:   Thu, 8 Oct 2020 16:21:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH 3/6] kernel: split syscall restart from signal handling
Message-ID: <20201008142135.GH9995@redhat.com>
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201005150438.6628-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150438.6628-4-axboe@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05, Jens Axboe wrote:
>
> Move the restart syscall logic into a separate generic entry helper,
> and handle that part separately from signal checking and delivery.
>
> This is in preparation for being able to do syscall restarting
> independently from handling signals.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  arch/x86/kernel/signal.c     | 32 ++++++++++++++++++--------------
>  include/linux/entry-common.h | 14 ++++++++++++--
>  kernel/entry/common.c        | 11 ++++++++---
>  3 files changed, 38 insertions(+), 19 deletions(-)

Can't we avoid this patch and the and simplify the change in
exit_to_user_mode_loop() from the next patch? Can't the much more simple
patch below work?

Then later we can even change arch_do_signal() to accept the additional
argument, ti_work, so that it can use ti_work & TIF_NOTIFY_SIGNAL/SIGPENDING
instead of test_thread_flag/task_sigpending.

Oleg.

--- x/arch/x86/kernel/signal.c
+++ x/arch/x86/kernel/signal.c
@@ -808,7 +808,10 @@ void arch_do_signal(struct pt_regs *regs
 {
 	struct ksignal ksig;
 
-	if (get_signal(&ksig)) {
+	if (test_thread_flag(TIF_NOTIFY_SIGNAL))
+		tracehook_notify_signal();
+
+	if (task_sigpending(current) && get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
 		return;
--- x/kernel/entry/common.c
+++ x/kernel/entry/common.c
@@ -155,7 +155,7 @@ static unsigned long exit_to_user_mode_l
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		if (ti_work & _TIF_SIGPENDING)
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)
 			arch_do_signal(regs);
 
 		if (ti_work & _TIF_NOTIFY_RESUME) {

