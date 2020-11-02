Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62852A2C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgKBNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:55:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgKBNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytGUxyQFsDqgxxojPp7/D2Ty0Jj+0Gic6ECasG0S6AE=;
        b=CTWQ7w6Gp5S8O668kqlmHI2JFC1dosM5ag9xu8oKIKbaA3UgAGRk3kFVxqwcWxCif5+WTN
        mdpPW4TFBtCO7qO712wi2xV7V806+x9LG5irrNNRPQYtqhebSlqQGaMDqNWz9oxFWYhQB7
        aJ/VyBnBX00rsJ9D5o9lscBI4l1L/iU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Rx3XlnKYNSmaoHZqPJ3vbg-1; Mon, 02 Nov 2020 08:53:52 -0500
X-MC-Unique: Rx3XlnKYNSmaoHZqPJ3vbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A3A0CE65C;
        Mon,  2 Nov 2020 13:53:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-236.rdu2.redhat.com [10.10.114.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 353AC747C6;
        Mon,  2 Nov 2020 13:53:43 +0000 (UTC)
Date:   Mon, 2 Nov 2020 08:53:41 -0500
From:   Phil Auld <pauld@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Benjamin Segall' <bsegall@google.com>, Hui Su <sh_def@163.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: remove the spin_lock operations
Message-ID: <20201102135341.GA154641@lorien.usersys.redhat.com>
References: <20201030144621.GA96974@rlk>
 <xm26mu0335zz.fsf@google.com>
 <22f99ee1d9b245c2a356d4d555b54e6a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f99ee1d9b245c2a356d4d555b54e6a@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:16:29PM +0000 David Laight wrote:
> From: Benjamin Segall
> > Sent: 30 October 2020 18:48
> > 
> > Hui Su <sh_def@163.com> writes:
> > 
> > > Since 'ab93a4bc955b ("sched/fair: Remove
> > > distribute_running fromCFS bandwidth")',there is
> > > nothing to protect between raw_spin_lock_irqsave/store()
> > > in do_sched_cfs_slack_timer().
> > >
> > > So remove it.
> > 
> > Reviewed-by: Ben Segall <bsegall@google.com>
> > 
> > (I might nitpick the subject to be clear that it should be trivial
> > because the lock area is empty, or call them dead or something, but it's
> > not all that important)
> 
> I don't know about this case, but a lock+unlock can be used
> to ensure that nothing else holds the lock when acquiring
> the lock requires another lock be held.
> 
> So if the normal sequence is:
> 	lock(table)
> 	# lookup item
> 	lock(item)
> 	unlock(table)
> 	....
> 	unlock(item)
> 
> Then it can make sense to do:
> 	lock(table)
> 	lock(item)
> 	unlock(item)
> 	....
> 	unlock(table)
> 
> although that ought to deserve a comment.
>

Nah, this one used to be like this :

        raw_spin_lock_irqsave(&cfs_b->lock, flags);
        lsub_positive(&cfs_b->runtime, runtime);
        cfs_b->distribute_running = 0;
        raw_spin_unlock_irqrestore(&cfs_b->lock, flags);

It's just a leftover. I agree that if it was there for some other
purpose that it would really need a comment. In this case, it's an
artifact of patch-based development I think.


Cheers,
Phil


> 	avid
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 

