Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B032D18AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgLGSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLGSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:41:13 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1CC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 10:40:33 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id e7so5876555ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H76HhAjjk/sw3LKewH9py03QyMKOv9KHhwaii0HPTrs=;
        b=Xkt9685GdRJZwC9+pqiUbKST72aBqoo95eEsKQO/UFJ30ZDqSMqkHl0ViYidLRaBUs
         laGqWgs/kqwK917ScWTwjE402JUpeJWKvr7pMUhr4pZu1L8GvS+20ArPCyD1F0/4U1ii
         TPrAUBFeC6DLyoNqu9qs/BbHid+sankZqtjF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H76HhAjjk/sw3LKewH9py03QyMKOv9KHhwaii0HPTrs=;
        b=cloCs7WZT5vhVXhYayig7GfwmP8YFrRQlyCrIqrtcMVnncxF629DyXp+t02QyOUCiD
         zJM/ShxZJHgUbEksoAdD0stHcgseGBTKLxFZZ2jovJcrewQUwDubC3JpNh9vP1moxanT
         bIw2HTiF53M0d8eN8bz/ZQCCJeR3pjeRvW455w/wGmiEJ4la2tSHyE6UU7EWWISJ52Op
         I5E05THwPn2lGdo7YOrVjGS7qo0G/VKZG02NlVAYOyRRemfOmFHQeNhOc3Occ7GtQjkg
         zJvybPGKTksy3Z48Glu3Wv/9/m2IdlwLG9gFwDtvIbRYPxnaMn1lTqvXKqX+K6LT8b9C
         BYcw==
X-Gm-Message-State: AOAM532ehPLNdLMsGNLuucMmj//RiPYo/APBlJ/W+RmYAzer5EQHYvO1
        dU6yEGaDTIg0pA3/VEh6U4tgYNbloUA2ow==
X-Google-Smtp-Source: ABdhPJzposVWjc/7UjaePMNa+BQ+QKCzu32YyHfCATxdvWY5FadVJ4TuFAMsRC9c+YVOspgJy2EITQ==
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr9198685ljc.28.1607366430860;
        Mon, 07 Dec 2020 10:40:30 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s22sm2960612lfi.187.2020.12.07.10.40.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:40:28 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id j10so16102690lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:40:27 -0800 (PST)
X-Received: by 2002:a2e:a543:: with SMTP id e3mr9347909ljn.421.1607366427053;
 Mon, 07 Dec 2020 10:40:27 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org> <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org> <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com> <20201207090953.GF3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201207090953.GF3040@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Dec 2020 10:40:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
Message-ID: <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 1:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > PeterZ, is there something I'm missing?
>
> Like this?
>
>   https://lkml.kernel.org/r/20200828123720.GZ1362448@hirez.programming.kicks-ass.net

Yes, except I think you should remove the old ptrace_may_access() check.

Because otherwise we'll just end up having KCSAN complain about the
unlocked optimistic accesses or something like that.

So do the perfmon_capable() check early - it doesn't need the
exec_update_mutex - and then just do the ptrace_may_access() one late.

I don't see any point at all in checking privileges twice, and I do
see real downsides. Not just that KCSAN issue, but also lack of
coverage (ie the second check will then effectively never be tested,
which is bad too).

               Linus
