Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E507295A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502895AbgJVIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502520AbgJVIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:31:50 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EFBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:31:49 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 73EEAE8080C;
        Thu, 22 Oct 2020 10:31:47 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id BDB36160834; Thu, 22 Oct 2020 10:31:46 +0200 (CEST)
Date:   Thu, 22 Oct 2020 10:31:46 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022083146.GA324761@gardel-login>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <20201022080548.GP3819@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022080548.GP3819@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 22.10.20 09:05, Szabolcs Nagy (szabolcs.nagy@arm.com) wrote:

> > > Various changes have been suggested, replacing the mprotect with mmap calls
> > > having PROT_BTI set on the original mapping, re-mmapping the segments,
> > > implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
> > > and various modification to seccomp to allow particular mprotect cases to
> > > bypass the filters. In each case there seems to be an undesirable attribute
> > > to the solution.
> > >
> > > So, whats the best solution?
> >
> > Did you see Topi's comments on the systemd issue?
> >
> > https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
> >
> > I think I agree with this: it's a bit weird to alter the bits after
> > the fact. Can't glibc set up everything right from the begining? That
> > would keep both concepts working.
>
> that's hard to do and does not work for the main exe currently
> (which is mmaped by the kernel).
>
> (it's hard to do because to know that the elf module requires
> bti the PT_GNU_PROPERTY notes have to be accessed that are
> often in the executable load segment, so either you mmap that
> or have to read that, but the latter has a lot more failure
> modes, so if i have to get the mmap flags right i'd do a mmap
> and then re-mmap if the flags were not right)

Only other option I then see is to neuter one of the two
mechanisms. We could certainly turn off MDWE on arm in systemd, if
people want that. Or make it a build-time choice, so that distros make
the choice: build everything with BTI xor suppport MDWE.

(Might make sense for glibc to gracefully fallback to non-BTI mode if
the mprotect() fails though, to make sure BTI-built binaries work
everywhere.)

I figure your interest in ARM system security is bigger than mine. I
am totally fine to turn off MDWE on ARM if that's what the Linux ARM
folks want. I ave no horse in the race. Just let me know.

[An acceptable compromise might be to allow
mprotect(PROT_EXEC|PROT_BTI) if MDWE is on, but prohibit
mprotect(PROT_EXEC) without PROT_BTI. Then at least you get one of the
two protections, but not both. I mean, MDWE is not perfect anyway on
non-x86-64 already: on 32bit i386 MDWE protection is not complete, due
to ipc() syscall multiplexing being unmatchable with seccomp. I
personally am happy as long as it works fully on x86-64]

Lennart

--
Lennart Poettering, Berlin
