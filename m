Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538292D2BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgLHNPc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Dec 2020 08:15:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37177 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbgLHNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:15:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-222-wvjfaZhvN7umMCpXgS5LxA-1; Tue, 08 Dec 2020 13:13:51 +0000
X-MC-Unique: wvjfaZhvN7umMCpXgS5LxA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Dec 2020 13:13:50 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Dec 2020 13:13:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     'Waiman Long' <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Christopher Yeoh" <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Sargun Dhillon" <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: RE: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Topic: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Index: AQHWzK7TgKb+NsLWq0OuVEyoMuW4SKnr2Z6AgAAkBICAAOuiYIAAOaIAgAAJfcA=
Date:   Tue, 8 Dec 2020 13:13:50 +0000
Message-ID: <53fb660a657848a29ba80040ec99c777@AcuMS.aculab.com>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
 <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
 <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
 <20201208123204.GW2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201208123204.GW2414@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 08 December 2020 12:32
> 
> On Tue, Dec 08, 2020 at 09:12:36AM +0000, David Laight wrote:
> > From: Waiman Long
> > > Sent: 07 December 2020 19:02
> > ...
> > > > How much more difficult would it be to also add a timeout option?
> > > > I looked at adding one to the mutex code - and fell into a big pile
> > > > of replicated code.
> > > >
> > > > ISTM that one the initial locked exchange (and spin) fails a few
> > > > extra instructions when heading for the sleep don't really matter
> > > >
> > > Actually, I had tried that before. See
> > >
> > > https://lore.kernel.org/lkml/20190911150537.19527-1-longman@redhat.com/
> > >
> > > That is for rwsem, but the same can be done for mutex. However, Peter
> > > didn't seem to like the idea of a timeout parameter. Anyway, it is
> > > certainly doable if there is a good use case for it.
> >
> > 'Unfortunately' my use-case if for an out-of-tree driver.
> >
> > The problem I was solving is a status call blocking because
> > some other code is 'stuck' (probably an oops) with a mutex held.
> 
> Working around oopses is not a sane use-case. If you oops, you get to
> keep all the pieces.

It's not so much 'working around' as trying to get debug info out
to fix the bug.
It gets annoying when another process lock up.
ISTR there is something global of that nature after a panic.

I have written a version that reported an error if the process
holding the mutex is dead (wasn't race safe against process exit).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

