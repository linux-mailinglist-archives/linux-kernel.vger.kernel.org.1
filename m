Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6995C2B38CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKOTnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:43:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:43:42 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605469420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqUSyAUeh+oln8IDe6CcbGx6+YPt/iQBXMlHnjAm338=;
        b=IX/yW47ggsZAWS+SrGrHdus69fz9Dz5jUK2A2gXzLIksJaLRZl0/nQ+BoXgGlOl7uGk1R+
        TDKGZJ7ZPDSWkxkZObEW3lg8cH5iYHv5xNUtU26tjah/CrYDn74tAxhHboensoD8y7MFAB
        BX8Aswue7CTArpkszzaw97PXESeExOIe3P90mrS6YaOhVVRLHnhDjnEu9YaPMR58RYyYB7
        o7xIYUZdC1rLUA1CRPqnnWDIZ+u7Q/emfRumAHHF8ctSnOrFf4Ln19K5z6SoKxFRZfMHHT
        7OCK0XZsz7t4Aql37bqT/h+niLFFlh1yFTsP1jrUovSaA7urXn6GnO0at7iH/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605469420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqUSyAUeh+oln8IDe6CcbGx6+YPt/iQBXMlHnjAm338=;
        b=Sv6jyJFgIxN4azQ59ZsPoJp0ih9bBrK7t8PL+yOCuL2FCzizrdAJiQnR7wpFkY+D/n2QF1
        qD7pZXFDSlVFDTDQ==
To:     Yunfeng Ye <yeyunfeng@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Reduce the critical region for jiffies_seq
In-Reply-To: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com>
References: <ac822c72-673e-73e1-9622-c5f12591b373@huawei.com>
Date:   Sun, 15 Nov 2020 20:43:39 +0100
Message-ID: <87h7pq8kyc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11 2020 at 17:11, Yunfeng Ye wrote:
> When nohz or nohz_full is configured, the concurrency calls of
> tick_do_update_jiffies64 increases,

Why?

> and the conflict between jiffies_lock and jiffies_seq increases,
> especially in multi-core scenarios.

This does not make sense. The sequence counter is updated when holding
the lock, so there is no conflict between the lock and the sequence
count.

> However, it is unnecessary to update the jiffies_seq lock multiple
> times in a tick period, so the critical region of the jiffies_seq
> can be reduced to reduce latency overheads.

This does not make sense either. Before taking the lock we have:

        delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
        if (delta < tick_period)
                return;

as a lockless quick check.

We also have mechanisms to avoid that a gazillion of CPUs call this. Why
are they not working or are some of the callsites missing them?

I'm not against reducing the seqcount write scope per se, but it needs a
proper and correct explanation.

> By the way, last_jiffies_update is protected by jiffies_lock, so
> reducing the jiffies_seq critical area is safe.

This is misleading. The write to last_jiffies_update is serialized by
the jiffies lock, but the write has also to be inside the sequence write
held section because tick_nohz_next_event() does:

	/* Read jiffies and the time when jiffies were updated last */
	do {
		seq = read_seqcount_begin(&jiffies_seq);
		basemono = last_jiffies_update;
		basejiff = jiffies;
	} while (read_seqcount_retry(&jiffies_seq, seq));

So there is no 'By the way'.

Thanks,

        tglx
