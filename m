Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D128F4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbgJOOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387589AbgJOOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602772456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJjIXiJnVqHKp5XONa8t2m4dwK//7P5N/0nBKHq4J+E=;
        b=cTa7zc6u9mcgi/ct/ENz0G7WTdXY1/1FVF+Ck2i1lmcsKOHFzu/nlv0g52SKZWsbiRaF90
        Ib8UBTxz6baa7iDcEiNXOxev9gOQren4CTzaeRJsmHUoLMfBwm6oVrAn9k1MoFk5NjCvC2
        lBV+D7eseqfk28kSL7/MAW6C7G2CHqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-qU_iVLrJPhuSWzNZPJjCHA-1; Thu, 15 Oct 2020 10:34:14 -0400
X-MC-Unique: qU_iVLrJPhuSWzNZPJjCHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7E41018F77;
        Thu, 15 Oct 2020 14:34:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64D93610F3;
        Thu, 15 Oct 2020 14:34:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 15 Oct 2020 16:34:12 +0200 (CEST)
Date:   Thu, 15 Oct 2020 16:34:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 4/5] x86: wire up TIF_NOTIFY_SIGNAL
Message-ID: <20201015143409.GC24156@redhat.com>
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-5-axboe@kernel.dk>
 <87o8l3a8af.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8l3a8af.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15, Thomas Gleixner wrote:
>
> On Thu, Oct 15 2020 at 07:17, Jens Axboe wrote:
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -808,7 +808,10 @@ void arch_do_signal(struct pt_regs *regs, unsigned long ti_work)
> >  {
> >  	struct ksignal ksig;
> >  
> > -	if (get_signal(&ksig)) {
> > +	if (ti_work & _TIF_NOTIFY_SIGNAL)
> > +		tracehook_notify_signal();
> > +
> > +	if ((ti_work & _TIF_SIGPENDING) && get_signal(&ksig)) {
> >  		/* Whee! Actually deliver the signal.  */
> >  		handle_signal(&ksig, regs);
> >  		return;
> 
> Instead of adding this to every architectures signal magic, we can
> handle TIF_NOTIFY_SIGNAL in the core code:
> 
> static void handle_singal_work(ti_work, regs)
> {
> 	if (ti_work & _TIF_NOTIFY_SIGNAL)
>         	tracehook_notify_signal();
> 
>         arch_do_signal(ti_work, regs);
> }
> 
>       loop {
>       		if (ti_work & (SIGPENDING | NOTIFY_SIGNAL))
>                 	handle_signal_work(ti_work, regs);
>       }

To me this looks like unnecessary complication. We need to change
every architecture anyway, how can this helper help?

Oleg.

