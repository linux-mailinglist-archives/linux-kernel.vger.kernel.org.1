Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5691F2158F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgGFN7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 09:59:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728940AbgGFN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594043988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK4/PcR5dFxByvykusuy2iYWwJ1NONwxquwieynQjzM=;
        b=gvdVXroXw2gbtQsn2IFxiZySah/vltpBloWj/eUT6+0cawFL2ExMk2g8h9j7Zk0D0FRfQB
        9MrauSENU0XUGZ2bgY3EoDvJftK9O+SV+QhlyHDcty8HF59yU3msGNHD2Z7/diaiuBNbk2
        EpawBQzVMSBcLxwJ7T7aM8mLE77UXGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-JNc9btf_MXefKsQBKiCktw-1; Mon, 06 Jul 2020 09:59:44 -0400
X-MC-Unique: JNc9btf_MXefKsQBKiCktw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6F2107ACF3;
        Mon,  6 Jul 2020 13:59:42 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-118.ams2.redhat.com [10.36.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D35471665;
        Mon,  6 Jul 2020 13:59:36 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
        <20200629190036.26982-3-mathieu.desnoyers@efficios.com>
Date:   Mon, 06 Jul 2020 15:59:35 +0200
In-Reply-To: <20200629190036.26982-3-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 29 Jun 2020 15:00:35 -0400")
Message-ID: <877dvg4ud4.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> When available, use the cpu_id field from __rseq_abi on Linux to
> implement sched_getcpu().  Fall-back on the vgetcpu vDSO if
> unavailable.

I've pushed this to glibc master, but unfortunately it looks like this
exposes a kernel bug related to affinity mask changes.

After building and testing glibc, this

  for x in {1..2000} ; do posix/tst-affinity-static  & done

produces some =E2=80=9Cerror:=E2=80=9D lines for me:

error: Unexpected CPU 2, expected 0
error: Unexpected CPU 2, expected 0
error: Unexpected CPU 2, expected 0
error: Unexpected CPU 2, expected 0
error: Unexpected CPU 138, expected 0
error: Unexpected CPU 138, expected 0
error: Unexpected CPU 138, expected 0
error: Unexpected CPU 138, expected 0

=E2=80=9Cexpected 0=E2=80=9D is a result of how the test has been written, =
it bails out
on the first failure, which happens with CPU ID 0.

Smaller systems can use a smaller count than 2000 to reproduce this.  It
also happens sporadically when running the glibc test suite itself
(which is why it took further testing to reveal this issue).

I can reproduce this with the Debian 4.19.118-2+deb10u1 kernel, the
Fedora 5.6.19-300.fc32 kernel, and the Red Hat Enterprise Linux kernel
4.18.0-193.el8 (all x86_64).

As to the cause, I'd guess that the exit path in the sched_setaffinity
system call fails to update the rseq area, so that userspace can observe
the outdated CPU ID there.

Thanks,
Florian

