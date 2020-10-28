Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212E729D9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbgJ1WxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733228AbgJ1WxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:53:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:53:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e7so664917pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Xy/2zadYFsZw40LFEtdOiEBtCWDHEhIZKqPxiXGDgo=;
        b=bBaojgDCytTeCZe09Aniv5ZCo9/1FqsTT/3OVeHNHiQoo0VRsUJwEEF+dAKR8keSyL
         yRWbSBM9isY011JSCr6qCTcRwh2CYocjn/3k5iQI8Ss/5A/CGKTOriZdbyXDN2ys6BHT
         tIbkFOOYefNeoQ0CJz/hUYR7ERPfwa7Bx6B6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Xy/2zadYFsZw40LFEtdOiEBtCWDHEhIZKqPxiXGDgo=;
        b=kxb8wLbjsXKlYWQds7wAie7epWqlcR7QDVZKGk1LYTaC5zxleVHBwgZ3+XZtTGkjYf
         RgCN+FMqfx5rWVNPRI+5pygHWqRJhuu2gLdQLKHYogQB/Hh31aPNaLbP1nqt2nLWA/fv
         rEyhGJ2Me7+eC1I2LGk476kjmVqFIGBGRZHpoy2p9QQWT/o3qZSKHq6C5E/W8yo2o3s1
         CkMhrJjJcRQjrFwZsJhGmiV8DXLZXCCZEp8R1AvKEpYkVyfHp9IoB14VOx8lAXMNGOuW
         gFhf6Ws4Fcqa2TAlvPrK3tqX8864QaP5InVJ8jMbU9zSs7W/Rrknfsf5eK/WzYpKMrwy
         hdEQ==
X-Gm-Message-State: AOAM533sB/yXELr9aWjykxhaDtv03eHfHSKS7cafArNtLYJpw1sqnVnH
        FuUB2i0zOMBzETYeNasmaC2JQA==
X-Google-Smtp-Source: ABdhPJzNUPngBSBllGfVxFqpThpHmKtVDwZBWHpI1tUv5u0YsP97zuSXYttLoLqCl2FU2MQmSaZy8A==
X-Received: by 2002:a17:90b:90d:: with SMTP id bo13mr1086316pjb.111.1603925586677;
        Wed, 28 Oct 2020 15:53:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7sm465074pja.11.2020.10.28.15.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:53:05 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:53:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
Message-ID: <202010281548.CCA92731F@keescook>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
 <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook>
 <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:51:02AM +0100, Jann Horn wrote:
> The problem is the scenario where a process is interrupted while it's
> waiting for the supervisor to reply.
> 
> Consider the following scenario (with supervisor "S" and target "T"; S
> wants to wait for events on two file descriptors seccomp_fd and
> other_fd):
> 
> S: starts poll() to wait for events on seccomp_fd and other_fd
> T: performs a syscall that's filtered with RET_USER_NOTIF
> S: poll() returns and signals readiness of seccomp_fd
> T: receives signal SIGUSR1
> T: syscall aborts, enters signal handler
> T: signal handler blocks on unfiltered syscall (e.g. write())
> S: starts SECCOMP_IOCTL_NOTIF_RECV
> S: blocks because no syscalls are pending

Oooh, yes, ew. Thanks for the illustration.

Thinking about this from userspace's least-surprise view, I would expect
the "recv" to stay "queued", in the sense we'd see this:

S: starts poll() to wait for events on seccomp_fd and other_fd
T: performs a syscall that's filtered with RET_USER_NOTIF
S: poll() returns and signals readiness of seccomp_fd
T: receives signal SIGUSR1
T: syscall aborts, enters signal handler
T: signal handler blocks on unfiltered syscall (e.g. write())
S: starts SECCOMP_IOCTL_NOTIF_RECV
S: gets (stale) seccomp_notif from seccomp_fd
S: sends seccomp_notif_resp, receives ENOENT (or some better errno?)

This is not at all how things are designed internally right now, but
that behavior would work, yes?

-- 
Kees Cook
