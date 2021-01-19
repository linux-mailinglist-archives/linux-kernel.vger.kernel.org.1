Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81E2FBD07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbhASQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390426AbhASQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611075189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HK4nAJ3T6oXK1ONWdl9zHivMWs2pVZ45ipCqU6He5eg=;
        b=M/JULRFDF1gEPbSOAowUUqk5UHOclfRbFIsi9SRKyv/8YCclQ0T+1JDzFIJvheHkQnvr3J
        Bi97rm+vTw5GtvRg6aVIarDeL5jwMPr9cjYMl/usS4JcrwDkGXt7FeShRvZX1xO7Io6u1h
        SIlj42HfuhIh2J1VeKfuspqpAstS1rI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-cQg_A79oOi-uhudHURkm9A-1; Tue, 19 Jan 2021 11:53:07 -0500
X-MC-Unique: cQg_A79oOi-uhudHURkm9A-1
Received: by mail-lj1-f198.google.com with SMTP id r22so5306314ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HK4nAJ3T6oXK1ONWdl9zHivMWs2pVZ45ipCqU6He5eg=;
        b=E2Xo3bdZXBaGGEzdlSYYpt1BDEbtOJdJqepsgjvyXyUFdPh6wHwhklipr9B7ZwJbfp
         llLHgksKVcOZsbVo50BiWIMd6OsezCzvq8LYLuaupvZ6gNYzYH0Rml3BPoptpBjIOA5r
         LO67KGadM+yhxItDcR4dqLAQ94HQISb38ISws7jmFnNPO5B98GiCz7ADBaIY6X89GXq1
         Ffb2mirtTltrwn6iyboIsHatpdWMDVSHX73r3K5+jX/DEpmp0v0YJoMK6mShqXbaGi/O
         6Uq4szIx+MMmqz3VXJVr2IvOY9e2u3bmk/49066SJ3Ffgk8O0LI8fzdyfySh87vjbtAc
         CqDA==
X-Gm-Message-State: AOAM530cWTB07MRlx+1fT/ALem90S8XZoOPrSqXG4ksabREz3EnJQpJ8
        4w+7pxPyB8j0u6l5RzA3i1OtSHPJJZBBuXOwU5wcJmN6ed/Y9456GPvtDAvBiyxfhmgdxrkuEyp
        MWFy3PWvHy3ITqVv2gvHpDJKIzpkVmX9an95b25o9
X-Received: by 2002:a19:58a:: with SMTP id 132mr2288990lff.355.1611075186344;
        Tue, 19 Jan 2021 08:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI3Q9N/A/K+bU3g9xUudRjbeGxYzhCCeDbwHeLDGBbfnqurDrSLN/JZZ3wEwt/vd6EIC8VtwC1NVoTsV0EYc4=
X-Received: by 2002:a19:58a:: with SMTP id 132mr2288974lff.355.1611075186136;
 Tue, 19 Jan 2021 08:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20201203171431.256675-1-aklimov@redhat.com> <20201207083827.GD3040@hirez.programming.kicks-ass.net>
 <87k0tritvq.fsf@oracle.com> <87im7yc2bu.fsf@oracle.com>
In-Reply-To: <87im7yc2bu.fsf@oracle.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Tue, 19 Jan 2021 16:52:55 +0000
Message-ID: <CAFBcO+_PoXhbq+p-2z=acCpboJtOewXkp-9-3=csafoAYuNFQw@mail.gmail.com>
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu online
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        qais.yousef@arm.com, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:54 AM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > Peter Zijlstra <peterz@infradead.org> writes:
> >>> The nature of this bug is also described here (with different consequences):
> >>> https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
> >>
> >> Yeah, pesky deadlocks.. someone was going to try again.
> >
> > I dug up the synchronous patch
> >
> >     https://lore.kernel.org/lkml/1579878449-10164-1-git-send-email-prsood@codeaurora.org/
> >
> > but surprisingly wasn't able to reproduce the lockdep splat from
> >
> >     https://lore.kernel.org/lkml/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/
> >
> > even though I could hit it a few weeks ago.
>
> oh okay, you need to mount a legacy cpuset hierarchy.
>
> So as the above splat shows, making cpuset_hotplug_workfn() synchronous
> means cpu_hotplug_lock (and "cpuhp_state-down") can be acquired before
> cgroup_mutex.
>
> But there are at least four cgroup paths that take the locks in the
> opposite order.  They're all the same, they take cgroup_mutex and then
> cpu_hotplug_lock later on to modify one or more static keys.
>
> cpu_hotplug_lock should probably be ahead of cgroup_mutex because the
> latter is taken in a hotplug callback, and we should keep the static
> branches in cgroup, so the only way out I can think of is moving
> cpu_hotplug_lock to just before cgroup_mutex is taken and switching to
> _cpuslocked flavors of the static key calls.
>
> lockdep quiets down with that change everywhere, but it puts another big
> lock around a lot of cgroup paths.  Seems less heavyhanded to go with
> this RFC.  What do you all think?

Daniel, thank you for taking a look. I don't mind reviewing+testing
another approach that you described.

> Absent further discussion, Alexey, do you plan to post another version?

I plan to update this patch and re-send in the next couple of days. It
looks like it might be a series of two patches. Sorry for delays.

Best regards,
Alexey

