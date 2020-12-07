Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFD2D0CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLGJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:15:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAvxPEKZaf6fFMzPaov349GhYP2S2lyW0J3rC9KuTzw=; b=p8P9peR3P/ByWb4PdlmrECAe0A
        ic/mYpm7h1EF189FYv7hFKAxf8W/PlhLuFigscheGnRDnWYOSxbMnlD8fY4r7J+BVt0Oi3rR61IU/
        PiECNtRlJfvowEn6NrsuTYpiWVAzYzZ6Jvkv0ShFZlSQjEnkAuKGMk91y4A0JnVla7mA4kOVfvAAh
        mUMVuB6D+HaFoHO+Ky4pQwb9H7D6bd+hZ2uwZlFzXUlkLyNKx99CJzFINegk8SmJwpPM5NuCzZQG6
        P63J35qh/g/787wzjwnS8+WFpjIROcyfHUG+7O0pPExHlgkFbZE2zFMOvtILMM0NtCWgfvqhI5p0h
        PyU8nYWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmCbn-000635-Sr; Mon, 07 Dec 2020 09:15:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25AD43006D0;
        Mon,  7 Dec 2020 10:15:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E52C200E0BA7; Mon,  7 Dec 2020 10:15:03 +0100 (CET)
Date:   Mon, 7 Dec 2020 10:15:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
Message-ID: <20201207091502.GG3040@hirez.programming.kicks-ass.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org>
 <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
 <20201204214836.3rncqw5kox42b4i2@linux-p48b.lan>
 <878sacyvpv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sacyvpv.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 12:05:32PM -0600, Eric W. Biederman wrote:
> I am trying to understand why the permission check is there.

It's about observability, is task A allowed to observe state of task B?

By installing a perf event on another task, we can very accurately tell
what it's doing, and isn't fundamentally different from attaching a
debugger (ie. ptrace).

Therefore we chose to use the same security checks. As is good custom,
one does security checks early.

Then Jann came and observed that race against execve mucking with privs,
and we got to hold that mutex across lots.

That patch I proposed earlier should solve that all.
