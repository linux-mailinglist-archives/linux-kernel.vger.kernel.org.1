Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B433722C678
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGXNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:30:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36601 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:30:48 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jyxmb-0006lR-9n; Fri, 24 Jul 2020 13:30:41 +0000
Date:   Fri, 24 Jul 2020 15:30:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
Message-ID: <20200724133039.hginkpnv7bkyz764@wittgenstein>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200705064055.GA28894@gmail.com>
 <20200714015743.GA843937@gmail.com>
 <20200722181506.GA4517@gaia>
 <20200723174140.GA3991167@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723174140.GA3991167@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:41:40AM -0700, Andrei Vagin wrote:
> On Wed, Jul 22, 2020 at 07:15:06PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 13, 2020 at 06:57:43PM -0700, Andrei Vagin wrote:
> > > On Sat, Jul 04, 2020 at 11:40:55PM -0700, Andrei Vagin wrote:
> > > > On Wed, Jun 24, 2020 at 01:33:15AM -0700, Andrei Vagin wrote:
> > > > > Allocate the time namespace page among VVAR pages and add the logic
> > > > > to handle faults on VVAR properly.
> > > > > 
> > > > > If a task belongs to a time namespace then the VVAR page which contains
> > > > > the system wide VDSO data is replaced with a namespace specific page
> > > > > which has the same layout as the VVAR page. That page has vdso_data->seq
> > > > > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > > > > VCLOCK_TIMENS to enforce the time namespace handling path.
> > > > > 
> > > > > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > > > > update of the VDSO data is in progress, is not really affecting regular
> > > > > tasks which are not part of a time namespace as the task is spin waiting
> > > > > for the update to finish and vdso_data->seq to become even again.
> > > > > 
> > > > > If a time namespace task hits that code path, it invokes the corresponding
> > > > > time getter function which retrieves the real VVAR page, reads host time
> > > > > and then adds the offset for the requested clock which is stored in the
> > > > > special VVAR page.
> > > > > 
> > > > 
> > > > > v2: Code cleanups suggested by Vincenzo.
> > > > > v3: add a comment in __arch_get_timens_vdso_data.
> > > > > v4: - fix an issue reported by the lkp robot.
> > > > >     - vvar has the same size with/without CONFIG_TIME_NAMESPACE, but the
> > > > >       timens page isn't allocated on !CONFIG_TIME_NAMESPACE. This
> > > > >       simplifies criu/vdso migration between different kernel configs.
> > > > > v5: - Code cleanups suggested by Mark Rutland.
> > > > >     - In vdso_join_timens, mmap_write_lock is downgraded to
> > > > >       mmap_read_lock. The VMA list isn't changed there, zap_page_range
> > > > >       doesn't require mmap_write_lock.
> > > > > 
> > > > > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > > > 
> > > > Hello Will and Catalin,
> > > > 
> > > > Have you had a chance to look at this patch set? I think it is ready to be
> > > > merged. Let me know if you have any questions.
> > > 
> > > *friendly ping*
> > > 
> > > If I am doing something wrong, let me know.
> > 
> > Not really, just haven't got around to looking into it. Mark Rutland
> > raised a concern (in private) about the safety of multithreaded apps
> > but I think you already replied that timens_install() checks for this
> > already [1].
> > 
> > Maybe a similar atomicity issue to the one raised by Mark but for
> > single-threaded processes: the thread is executing vdso code, gets
> > interrupted and a signal handler invokes setns(). Would resuming the
> > execution in the vdso code on sigreturn cause any issues?
> 
> It will not cause any issues in the kernel. In the userspace,
> clock_gettime() can return a clock value with an inconsistent offset, if
> a process switches between two non-root namespaces. And it can triggers
> SIGSEGV if it switches from a non-root to the root time namespace,
> because a time namespace isn't mapped in the root time namespace.
> 
> I don't think that we need to handle this case in the kernel. Users
> must understand what they are doing and have to write code so that avoid
> these sort of situations. In general, I would say that in most cases it
> is a bad idea to call setns from a signal handler.

I would argue that calling any function not in the list of
man 7 signal-safety
without checking the kernel implementation is "you get to keep the
pieces territory". There's a whole range of syscalls that are not safe
in signal handlers and we don't have any special precautions for them so
I'm not sure we'd need one for setns(). But maybe I'm missing the bigger
picture here.

Thanks!
Christian
