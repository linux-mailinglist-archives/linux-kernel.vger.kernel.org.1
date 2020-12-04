Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02FB2CF5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgLDUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgLDUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:50:06 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1BC094243
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:48:37 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so9458233lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx1hVnr91e0KzAJzuCg8cszSa+uY8heHW8ontUbVheA=;
        b=OCb5JSloiK/wo8ytjBT7XnulF6EBH5ud0a3HEmb4H+N92br+2uVpzsoJK6lHTSOyWs
         WwsB02uKPVWh8kWuRoMcpZdC2VqRkjeWUgIq+6Ju0QA4hflN6IrFRYYtrhbB5J8AUbft
         IuqnDpyDDGzg+CCb/ubYYdAnuZgMWPIens2kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx1hVnr91e0KzAJzuCg8cszSa+uY8heHW8ontUbVheA=;
        b=RhrlDuO81o1p9u9S+yN0jNXHm7mlOoT1TXZIbBpSe9NiCK8bHfJTLkaRSjtI/d19zm
         ui+gQN+AfP4pfNoG/tHUpO94Tm/ArowqRHb8z7QbbudLVmgtWidoIvqG4C+HSV5SPjUb
         wjKEd5YJE1XNsR3aqdlu8CGrc+w8FGTDDFXToUP6tdqHKnVzTiO7YwrgYMmYNcW2/xU1
         TuDciEnhrvvQNwZYbSh+51Kcgkh2ACZ1iX67H4G64DxkotRUWaD+Fi5Bvl+MLPhZk8Xw
         k0SxWM1svFfvD1/xH3vzwhBz5ETZevoEqnoqvgquWm+bbfIMyJD6K1CB2GTkPfRe52T3
         aTvg==
X-Gm-Message-State: AOAM530ZC+L4idtWPtSp528EpXoH2dfOIg/JRaORbZCy09Hr8gMSRFdV
        KgDFiiRH5uil9WL7yV4aEEMblKAxGDLjqw==
X-Google-Smtp-Source: ABdhPJwEDE98dHBn8lIJEtxp2PM7yLm/dSXUyiFWraAzMvF1UpYwHldzrNryFWVRLXW2DvYnkWtZsg==
X-Received: by 2002:a05:6512:3227:: with SMTP id f7mr4333019lfe.119.1607114915998;
        Fri, 04 Dec 2020 12:48:35 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j25sm2034647lfh.71.2020.12.04.12.48.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:48:35 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id a9so9505875lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:48:34 -0800 (PST)
X-Received: by 2002:a19:c301:: with SMTP id t1mr3589349lff.105.1607114914603;
 Fri, 04 Dec 2020 12:48:34 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org> <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org> <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
 <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Dec 2020 12:48:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
Message-ID: <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Fri, Dec 4, 2020 at 12:30 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>>
> >    perf_event_open  (exec_update_mutex -> ovl_i_mutex)

Side note: this one looks like it should be easy to fix.

Is there any real reason why exec_update_mutex is actually gotten that
early, and held for that long in the perf event code?

I _think_ we could move the ptrace check to be much later, to _just_ before that

         * This is the point on no return; we cannot fail hereafter.

point in the perf event install chain..

I don't think it needs to be moved down even that much, I think it
would be sufficient to move it down below the "perf_event_alloc()",
but I didn't check very much.

The fact that create_local_trace_uprobe() can end up going into a
lookup of an OVL filesystem path smells kind of odd to me to begin
with, but I didn't look at the whole thing.

PeterZ, is there something I'm missing?

          Linus
