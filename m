Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D442B9702
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgKSPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727431AbgKSPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605801237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gZPwT9qAu8l8c4fl7FyhOMCUEM9BP/NqpqlxQ/g5IEE=;
        b=VVHvO1uwncgNcA0EjIcxKRROkGz6TtbjLYiplb6NwyPgDxhBtwcI0H6YwJc3RXLkPRXGFm
        OPAPEU9VUViZ8VJYWKWCAx4hLT/pvKICjVb3ZvF/x5r0v/ctnCgVNqf3dRcgEY5Nzp4GGm
        9WLAHnmIfKzay6y1gFQYGxv2uyKxnJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-vAy8Nkx6OEKH81-y-_LbFA-1; Thu, 19 Nov 2020 10:53:54 -0500
X-MC-Unique: vAy8Nkx6OEKH81-y-_LbFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C3C5801B15;
        Thu, 19 Nov 2020 15:53:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 784DF5D9D0;
        Thu, 19 Nov 2020 15:53:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org
cc:     dhowells@redhat.com, jlayton@redhat.com, willy@infradead.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Can you help diagnose a weird failed wake?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2220346.1605801222.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 19 Nov 2020 15:53:42 +0000
Message-ID: <2220347.1605801222@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Paul,

Jeff Layton is seeing a weird failed wake in the fscache rewrite.  Can you
have a look see if I've mucked up somewhere?  For reference, Jeff's branch=
 is
here:

	https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
	ceph-fscache-iter-experimental

The situation is that the fscache_cookie struct has a member called 'stage=
'
that indicates the state of a cookie representing a data file.  As a cache
object is set up, it goes through the LOOKING_UP stage (3) whilst the disk=
 is
being queried to the ACTIVE stage (5) when the backing file has been opene=
d -
at which point we can do I/O on it.  Each time the stage is changed, we ca=
ll
wake_up_var() to ping any waiters on the variable.  Waiters use
wait_var_event() and co. to wait on it.

We've added some tracepoints.  There's a function which begins an operatio=
n on
the cache.  It waits for the cache to get into the appropriate stage as pa=
rt
of that.  Around the bit doing the wait in we have:

	int __fscache_begin_operation(...)
	{
	...
	wait_and_validate:
		spin_unlock(&cookie->lock);
		cookie->trace =3D true;
		trace_fscache_stage_wait(cookie, stage, fscache_cookie_stage_wait_begin_=
op);
		timeo =3D wait_var_event_timeout(&cookie->stage, cookie_stage_changed(co=
okie, stage), 10*HZ);
		if (timeo <=3D 1) {
			pr_warn("%s: cookie stage change wait timed out: cookie->stage=3D%u sta=
ge=3D%u",
				__func__, READ_ONCE(cookie->stage), stage);
			fscache_print_cookie(cookie, 'O');
			trace_fscache_stage_wait(cookie, stage, fscache_cookie_stage_wait_fail)=
;
		} else {
			trace_fscache_stage_wait(cookie, stage, fscache_cookie_stage_waited);
		}
		cookie->trace =3D false;
		goto again;
	...
	}

and cookie_stage_changed() looks like:

	static bool cookie_stage_changed(struct fscache_cookie *cookie, enum fsca=
che_cookie_stage stage)
	{
		bool changed =3D (READ_ONCE(cookie->stage) !=3D stage);

		if (!changed)
			trace_fscache_stage_wait(cookie, stage, fscache_cookie_stage_waiting);

		return changed;
	}

At the point the wakeup happens, we have:

	void fscache_set_cookie_stage(struct fscache_cookie *cookie,             =
                           =

				      enum fscache_cookie_stage stage)                                =
      =

	{                                                                        =
                          =

		bool changed =3D false, trace;                                          =
                      =


		spin_lock(&cookie->lock);                                               =
                   =

		switch (cookie->stage) {                                                =
                    =

		case FSCACHE_COOKIE_STAGE_INDEX:                                        =
                    =

		case FSCACHE_COOKIE_STAGE_WITHDRAWING:                                  =
                    =

		case FSCACHE_COOKIE_STAGE_RELINQUISHING:                                =
                    =

			break;                                                                 =
             =

		default:                                                                =
                    =

			trace =3D cookie->trace;                                               =
               =

			if (trace)                                                             =
             =

				trace_fscache_stage_set(cookie, stage, fscache_cookie_stage_set_genera=
l);  =

			cookie->stage =3D stage;                                               =
               =

			changed =3D true;                                                      =
              =

			break;                                                                 =
             =

		}                                                                       =
                   =

		spin_unlock(&cookie->lock);                                             =
                   =

		if (changed) {                                                          =
                    =

			wake_up_var(&cookie->stage);                                           =
             =

			if (trace)                                                             =
             =

				trace_fscache_stage_set(cookie, stage, fscache_cookie_stage_woken);   =
     =

		}                                                                       =
                   =

	}                                                                        =
                          =


In dmesg, we see:

	[ 2977.269392] FS-Cache: __fscache_begin_operation: cookie stage change w=
ait timed out: cookie->stage=3D5 stage=3D3
	[ 2977.269398] FS-Cache: O-cookie c=3D000dd7d9 [p=3D000dce05 fl=3D0 nc=3D=
0 na=3D2]
	[ 2977.276673] FS-Cache: O-cookie d=3DCEPH.in
	[ 2977.277796] FS-Cache: O-cookie o=3D201635
	[ 2977.278552] FS-Cache: O-key=3D[16] '352b930000010000feffffffffffffff'

In the trace log, we see:

	 <...>-425461  [015] ....  2967.107716: fscache_stage_wait: c=3D000dd7d9 =
WAIT beginop now=3D3 arg=3D3
	kfsc/7-896     [005] ....  2967.107717: fscache_stage_set:  c=3D000dd7d9 =
SET general  now=3D3 arg=3D5
	 <...>-425461  [015] ....  2967.107718: fscache_stage_wait: c=3D000dd7d9 =
WAITING      now=3D3 arg=3D3
	 <...>-425461  [015] ....  2967.107718: fscache_stage_wait: c=3D000dd7d9 =
WAITING      now=3D5 arg=3D3
	kfsc/7-896     [005] ....  2967.107719: fscache_stage_set:  c=3D000dd7d9 =
WOKEN        now=3D5 arg=3D5
	 <...>-425461  [015] .N..  2977.452925: fscache_stage_wait: c=3D000dd7d9 =
WAIT failed  now=3D5 arg=3D3

So we can see the wait beginning, with the stage at LOOKING_UP (3).  Note =
that
we're actually waiting for stage!=3D3.

Next, on cpu 5, we're about to set the stage ("SET" line), and then we've
completed the wakeup 2uS later ("WOKEN" line).

Whilst the stage-change is happening, the wait condition check happens twi=
ce
in quick succession (two "WAITING" lines).  The first is presumably right =
at
the beginning of wait_var_event() and the second is inside the wait loop. =
 In
the first check, the stage is still 3, but in the second call of the condi=
tion
function, it reads it as 3 (still LOOKING_UP), and so meets the condition =
to
do the tracepoint - which then sees it as 5 (ACTIVE), but this doesn't aff=
ect
the result of the condition function.

[*] Note that in the traceline, cookie->stage as read inside the tracepoin=
t is
    the "now" number and the second is fed in by the caller.

wait_var_event()/wait_var_event_timeout() then goes to sleep - which it
shouldn't, because either the task state should've been cleared, or the
condition function should prevent it.

Any thoughts on how to debug this further?  Or if I've just done something
silly?

Also, do I need to use WRITE_ONCE() or smp_store_release() when setting
cookie->store, since I'm reading it outside of the spinlock, albeit throug=
h
READ_ONCE().

Thanks,
David

