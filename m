Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED7296BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461083AbgJWJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460856AbgJWJE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:04:57 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB9524182;
        Fri, 23 Oct 2020 09:04:54 +0000 (UTC)
Date:   Fri, 23 Oct 2020 10:04:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201023090451.GB25736@gaia>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com>
 <20201022083823.GA324825@gardel-login>
 <20201022093104.GB1229@gaia>
 <20201023061316.GR3819@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023061316.GR3819@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 07:13:17AM +0100, Szabolcs Nagy wrote:
> The 10/22/2020 10:31, Catalin Marinas wrote:
> > IIUC, the problem is with the main executable which is mapped by the
> > kernel without PROT_BTI. The dynamic loader wants to set PROT_BTI but
> > does not have the original file descriptor to be able to remap. Its only
> > choice is mprotect() and this fails because of the MDWX policy.
> > 
> > Not sure whether the kernel has the right information but could it map
> > the main executable with PROT_BTI if the corresponding PT_GNU_PROPERTY
> > is found? The current ABI states it only sets PROT_BTI for the
> > interpreter who'd be responsible for setting the PROT_BTI on the main
> > executable. I can't tell whether it would break anything but it's worth
> > a try:
> 
> i think it would work, but now i can't easily
> tell from the libc if i have to do the mprotect
> on the main exe or not.
> 
> i guess i can just always mprotect and ignore
> the failure?

I replied to Keys before reading your email. So yeah, still issue
mprotect() but ignore the failure.

-- 
Catalin
