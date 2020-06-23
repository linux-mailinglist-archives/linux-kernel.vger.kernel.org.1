Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B7204CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgFWImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:42:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41706 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbgFWImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:42:32 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jneVh-0003DY-GX; Tue, 23 Jun 2020 08:42:29 +0000
Date:   Tue, 23 Jun 2020 10:42:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 02/17] sparc64: enable HAVE_COPY_THREAD_TLS
Message-ID: <20200623084228.jpufvn5mn3lhjc36@wittgenstein>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-3-christian.brauner@ubuntu.com>
 <20200622.203516.1857672250009821997.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622.203516.1857672250009821997.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:35:16PM -0700, David Miller wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Tue, 23 Jun 2020 01:43:11 +0200
> 
> > diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> > index db42b4fb3708..192f3a28a2b7 100644
> > --- a/arch/sparc/kernel/syscalls.S
> > +++ b/arch/sparc/kernel/syscalls.S
> > @@ -86,19 +86,22 @@ sys32_rt_sigreturn:
> >  	 * during system calls...
> >  	 */
> >  	.align	32
> > -sys_vfork: /* Under Linux, vfork and fork are just special cases of clone. */
> > -	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
> > -	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
> > -	ba,pt	%xcc, sys_clone
> > +sys_vfork:
> > +	flushw
> > +	ba,pt	%xcc, sparc_vfork
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Please indent branch delay slot instructions with one extra space, as
> was done in the code you are changing.
> 
> > +	ba,pt	%xcc, sparc_fork
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Likewise.
> 
> > +	ba,pt	%xcc, sparc_clone
> > +	add	%sp, PTREGS_OFF, %o0
> 
> Likewise.

Fixed, thanks for taking a look again! This somehow slipped past me when
applying. 

Christian
