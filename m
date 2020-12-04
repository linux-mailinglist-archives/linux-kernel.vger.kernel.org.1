Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449C42CF55C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgLDUMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgLDUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:11:59 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C021C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:11:19 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so9372183lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQpn0o892pEbZLHFd+9gLpvB3MBMiU/L0nR9Ji5w5Ws=;
        b=EIFCJEvQUYJnBphqSUS2irvQEUigMurEkzX40ERNG5CNdR9rcGCkWuwqRaK1dES97D
         3lg+hjnOypTh+xGzaIcHQnM2LINwLeuxZ+zvYpW2GPOcwVGEq6Sp5DleHqcutwEEDY3M
         66uvPwJsErHJ6BO5lKDWbDNY3QeHtwpfioKGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQpn0o892pEbZLHFd+9gLpvB3MBMiU/L0nR9Ji5w5Ws=;
        b=meALmhHCHLN1TH6Q1z0ro16WM/x0eWEFFRJiaM94Xe1L8gSVVcb1Iy2L5yGakQb2x1
         bRrjcTDQZJpjgrWTBGVprS16cBorOxPzSML6xD4+HKztE8OS4nAfaWcd50MHiYxlUp3L
         7aWta9DPZwlroAEg1v2aEaog/wBXmtT+4yjM+5GrgVA+On7RqLCpcbHFxi734qO8cws/
         uDoFHXeNuoICdp+kWJ5dGDZTN8iLCLfQ2HnUNHfxMCH42Roy/p8vUlC8vMrx0dn1Rwt6
         APNXv3WYJzQ9yIZKvC/O/ZA5nlTy16IzxERnrEPPVXJj9Im4L9KJVk/NxQCy7og2DF4x
         9MCQ==
X-Gm-Message-State: AOAM533O1Ab8qI8ae7ItKCLC1ub+2FlZfR6M9hszIk6uZALuRNOHLFmD
        Lj9C+L1GTWvcLDEjyENrRoXXcWgCPQumtg==
X-Google-Smtp-Source: ABdhPJwUWhHJ5MpEX6ebt9gEA2mf7Mit13l/gBOuNCgM3sYzOgywRYvhU4POOUM0c7HOI1SbrfyLvw==
X-Received: by 2002:a19:c0c:: with SMTP id 12mr3985757lfm.315.1607112677287;
        Fri, 04 Dec 2020 12:11:17 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w11sm2010545lfl.33.2020.12.04.12.11.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:11:15 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id q8so7927251ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:11:14 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr4078394ljj.312.1607112674455;
 Fri, 04 Dec 2020 12:11:14 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org> <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com> <875z5h4b7a.fsf@x220.int.ebiederm.org>
In-Reply-To: <875z5h4b7a.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Dec 2020 12:10:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
Message-ID: <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 11:35 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> From a deadlock perspective the change is strictly better than what we
> have today.  The readers will no longer block on each other.

No, agreed, it's better regardless.

> For the specific case that syzbot reported it is readers who were
> blocking on each other so that specific case if fixed.

So the thing is, a reader can still block another reader if a writer
comes in between them. Which is why I was thinking that the same
deadlock could happen if somebody does an execve at just the right
point.

> On the write side of exec_update_lock we have:
>
> cred_guard_mutex -> exec_update_lock
>
> Which means that to get an ABBA deadlock cred_guard_mutex would need to
> be involved

No, see above: you can get a deadlock with

 - first reader gets exec_update_lock

 - writer on exec_update_lock blocks on first reader (this is exec)

 - second reader of exec_update_lock now blocks on the writer.

So if that second reader holds something that the first one wants to
get (or is the same thread as the first one), you have a deadlock: the
first reader will never make any progress, will never release the
lock, and the writer will never get it, and the second reader will
forever wait for the writer that is ahead of it in the queue.

cred_guard_mutex is immaterial, it's not involved in the deadlock.
Yes, the writer holds it, but it's not relevant for anything else.

And that deadlock looks very much like what syzcaller detected, in
exactly that scenario:

  Chain exists of:
    &sig->exec_update_mutex --> sb_writers#4 --> &p->lock

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&p->lock);
                                 lock(sb_writers#4);
                                 lock(&p->lock);
    lock(&sig->exec_update_mutex);

   *** DEADLOCK ***

No?  The only thing that is missing is that writer that causes the
exec_update_mutex readers to block each other - exactly like they did
when it was a mutex.

But I may be missing something entirely obvious that keeps this from happening.

         Linus
