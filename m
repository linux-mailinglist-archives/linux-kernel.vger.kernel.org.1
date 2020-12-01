Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6112CAA50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgLAR4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbgLAR4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:56:13 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A236121D7A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606845332;
        bh=nfFVXnlt+xBRFLL3jaXHr+XPZGpCy4Qs9g6aljBGBSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QnPDY4Ubml131S8p2XcCSbFOMDg9+3yXPSlQtuNcn40LtV5y8N94HHD/ZE4CQbDXQ
         eYJ1QMotRPVis9ohh2esKVMzXhA/vK9ebCPqo4Jr+h5zCI3ZANTsBfajuMiLOuLRDq
         ij32B6CnVhJBIGOtMDf3C5kywPQRL/R+N8vp2mI8=
Received: by mail-wm1-f47.google.com with SMTP id v14so5173285wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:55:32 -0800 (PST)
X-Gm-Message-State: AOAM531vZmrZlI/LlP8TgaCXtK99I3ujxR3+6m5cAEYRVJIfhAhGVn7Q
        t71Kvbv1z2C4JTCjSumaAoY6iDN2cvjpAPq6ls5AtQ==
X-Google-Smtp-Source: ABdhPJylJtC8I6zYOGwJPqwSmhBgARswm14IQ36zCf1lcJjocjtytK9Jybzpw0E//dk40dQ2fE+PqByp2b/XIlutzrs=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr3874637wmj.21.1606845331057;
 Tue, 01 Dec 2020 09:55:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606758530.git.luto@kernel.org> <c67b85690f9cb42d1e92db30e19c78e872bdd0e4.1606758530.git.luto@kernel.org>
 <20201201100604.GT2414@hirez.programming.kicks-ass.net> <1317667456.69303.1606833070872.JavaMail.zimbra@efficios.com>
In-Reply-To: <1317667456.69303.1606833070872.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 09:55:17 -0800
X-Gmail-Original-Message-ID: <CALCETrXgKMamvjDZAjvZ36_N2BWRqniJRrtYz=89drMXc6A3LQ@mail.gmail.com>
Message-ID: <CALCETrXgKMamvjDZAjvZ36_N2BWRqniJRrtYz=89drMXc6A3LQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] membarrier: Add an actual barrier before rseq_preempt()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:31 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Dec 1, 2020, at 5:06 AM, Peter Zijlstra peterz@infradead.org wrote:
>
> > On Mon, Nov 30, 2020 at 09:50:34AM -0800, Andy Lutomirski wrote:
> >> It seems to be that most RSEQ membarrier users will expect any
> >> stores done before the membarrier() syscall to be visible to the
> >> target task(s).  While this is extremely likely to be true in
> >> practice, nothing actually guarantees it by a strict reading of the
> >> x86 manuals.  Rather than providing this guarantee by accident and
> >> potentially causing a problem down the road, just add an explicit
> >> barrier.
> >
> > A very long time ago; when Jens introduced smp_call_function(), we had
> > this discussion. At the time Linus said that receiving an interrupt had
> > better be ordering, and if it is not, then it's up to the architecture
> > to handle that before it gets into the common code.
> >
> >  https://lkml.kernel.org/r/alpine.LFD.2.00.0902180744520.21686@localhost.localdomain
> >
> > Maybe we want to revisit this now, but there might be a fair amount of
> > code relying on all this by now.
> >
> > Documenting it better might help.
>
> Considering that we already have this in membarrier ipi_mb :
>
> static void ipi_mb(void *info)
> {
>         smp_mb();       /* IPIs should be serializing but paranoid. */
> }
>
> I think it makes sense to add this same smp_mb() in the ipi_rseq if the expected
> behavior is to order memory accesses as well, and have the same level of paranoia as
> the ipi_mb.

That was my reasoning.
