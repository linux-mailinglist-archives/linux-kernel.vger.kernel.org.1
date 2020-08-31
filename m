Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5384325746B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHaHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:38:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:38:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i4so1540894ota.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHM0ipYAykCZfvaDQgKFrlp9NlpH0uWgznR6MJusTIY=;
        b=K4J/wl8RwA8G4iOVI5H+sqPuPfNmjFyJUSyLDXKi88W2aNfG8i2EnXNcF9a/O+1JqE
         oJga6x547Bf69S9pVkVCrL6Nxn1nrfx636oFRGnmX4dTN3VwciI/mszCJSuyyB3pU2Vg
         pND7lxjbmupG3Q0Rd6f8/r03NkR8gzBQmXsoBoeAB8UvuFCodEPKVl+qi8TjgXqDyd7c
         hiEGHWRE3FU/JwyCbrVcjuwMLXlNSEVZ7Fk7NmuCpxAeDeCRWyE8Vy+zPLCAmciHy1eA
         AauPbg3oFXajAIzgHfQRrYnhyO4Ix+qZqjm+g1p7DE+MXdn6XizcoGHnVByq2CXbJq40
         d86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHM0ipYAykCZfvaDQgKFrlp9NlpH0uWgznR6MJusTIY=;
        b=EJjUYeRuB+VYouc3ji93NjbVf7vimQpQNc3D0MrnLtTjPGBKF/uxqRKGTgCL/sTCTo
         9AYi22uJRW80YHK3mfsdv0gTFYKnf8dIo0cg3HyClGzHz8ew4+LyaIttdoQKJh4/DRS+
         Apuw0o1uWPpY+DZKZNchP5inFXBCPP7olisiU61TS4D/1lClXdTAHX+7agCNkRoh5GcZ
         r+PbBbU+HhtYzKPcCZWo95Osuaa3lwuEDRZzXK2owJSpJ0FQ2JXNJ+YagpNI5xl6DkHn
         /mvORO68L6ErWHVxIAmnPmcBFChQNB5vfRMdazQGTbmhH7FJqSUfoM1rnANF40m8XcJx
         mKsQ==
X-Gm-Message-State: AOAM531mTz4Z04youGPQ8F6JpfOPy7mkqODx6sX1+X9CyMwAsAS58fBc
        Ti2Drg4R1U5OqIp5OqMFuKcsNMXknJcqmbxamIruRrCZEfI=
X-Google-Smtp-Source: ABdhPJyG0ujdLY5xhcGDrW8ZMF5AXIW9LAHFYrBlHQAEwzxTnXnKYhduM0AYUpDQGb8QygdQC7IwtcXEsifHqVkSrTQ=
X-Received: by 2002:a9d:3da1:: with SMTP id l30mr236693otc.233.1598859519309;
 Mon, 31 Aug 2020 00:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <159881061564.27993.11909051048930389391.tglx@nanos>
 <159881061804.27993.16119786735164087221.tglx@nanos> <CAHk-=wi6ufj=O-PDu=HVYw0QXpK52GPWKJfBaU4Djr0h6OFpKg@mail.gmail.com>
 <20200831072427.GM1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200831072427.GM1362448@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 31 Aug 2020 09:38:28 +0200
Message-ID: <CANpmjNP5xPUqkBfR2xu8KvDJeo6Vc2HM46HnBfhgA+asV0dm+A@mail.gmail.com>
Subject: Re: [GIT pull] sched/urgent for v5.9-rc2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 09:24, <peterz@infradead.org> wrote:
>
> On Sun, Aug 30, 2020 at 11:54:19AM -0700, Linus Torvalds wrote:
> > On Sun, Aug 30, 2020 at 11:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > >  - Make is_idle_task() __always_inline to prevent the compiler from putting
> > >    it out of line into the wrong section because it's used inside noinstr
> > >    sections.
> >
> > What completely broken compiler uninlined that single-instruction function?
> >
> > I've obviously pulled this, but it sounds like there should be a
> > compiler bug-report for this insane behavior.
> >
> > Or is Marco building the kernel without optimizations or something
> > like that? That has not been a supported model, for various good
> > reasons..
>
> I think that was Clang with KCSAN on, KCSAN obviously makes this
> function a little bigger with the instrumentation for the load(s). But
> yes...

I wasn't quite sure myself if it was Clang or GCC, so I re-tested with
the linked config (which says GCC), and it reproduces on both.
