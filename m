Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32BE2A10B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJ3WQe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 18:16:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48661 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgJ3WQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:16:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-61-f8gWZUeEPIy3ZCB6ot-DsQ-1; Fri, 30 Oct 2020 22:16:29 +0000
X-MC-Unique: f8gWZUeEPIy3ZCB6ot-DsQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Oct 2020 22:16:29 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Oct 2020 22:16:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Benjamin Segall' <bsegall@google.com>, Hui Su <sh_def@163.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: remove the spin_lock operations
Thread-Topic: [PATCH] sched/fair: remove the spin_lock operations
Thread-Index: AQHWru02j9v+7b8fw0CwtF3P4oRlh6mwtROg
Date:   Fri, 30 Oct 2020 22:16:29 +0000
Message-ID: <22f99ee1d9b245c2a356d4d555b54e6a@AcuMS.aculab.com>
References: <20201030144621.GA96974@rlk> <xm26mu0335zz.fsf@google.com>
In-Reply-To: <xm26mu0335zz.fsf@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Segall
> Sent: 30 October 2020 18:48
> 
> Hui Su <sh_def@163.com> writes:
> 
> > Since 'ab93a4bc955b ("sched/fair: Remove
> > distribute_running fromCFS bandwidth")',there is
> > nothing to protect between raw_spin_lock_irqsave/store()
> > in do_sched_cfs_slack_timer().
> >
> > So remove it.
> 
> Reviewed-by: Ben Segall <bsegall@google.com>
> 
> (I might nitpick the subject to be clear that it should be trivial
> because the lock area is empty, or call them dead or something, but it's
> not all that important)

I don't know about this case, but a lock+unlock can be used
to ensure that nothing else holds the lock when acquiring
the lock requires another lock be held.

So if the normal sequence is:
	lock(table)
	# lookup item
	lock(item)
	unlock(table)
	....
	unlock(item)

Then it can make sense to do:
	lock(table)
	lock(item)
	unlock(item)
	....
	unlock(table)

although that ought to deserve a comment.

	avid

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

