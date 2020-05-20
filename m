Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD061DBBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETRly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:41:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DF020709;
        Wed, 20 May 2020 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589996514;
        bh=vwO5w+JtVONHfb0euQ8pgchCgtobqFMlado05i6hxzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNyKyCDzEBiEp9U/hzypTeDYnsOS2t6Wh55G/pV23Pg0+rv8ymIZsfBsT6iYxVLMg
         YuSOHyJ2aM5+x5TC5MbYPPx1BZ5uQyaiujC8mclcVJCNusddgnmCGP3hPPKFvmeQ8l
         N/D88s10AuUVD503Mi/ctOIw0KF+NZINj+0+OFCo=
Date:   Wed, 20 May 2020 18:41:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200520174149.GB27629@willie-the-truck>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keno,

On Tue, May 19, 2020 at 04:37:34AM -0400, Keno Fischer wrote:
> > Yes, we inherited this from ARM and I think strace relies on it. In
> > hindsight, it is a little odd, although x7 is a parameter register in the
> > PCS and so it won't be live on entry to a system call.
> 
> I'm not familiar with the PCS acronym, but I assume you mean the
> calling convention? You have more faith in userspace than I do ;). For
> example, cursory googling brought up this arm64 syscall definition in musl:
> 
> https://github.com/bminor/musl/blob/593caa456309714402ca4cb77c3770f4c24da9da/arch/aarch64/syscall_arch.h

Hmm, does that actually result in the SVC instruction getting inlined? I
think that's quite dangerous, since we document that we can trash the SVE
register state on a system call, for example. I'm also surprised that
the register variables are honoured by compilers if that inlining can occur.

> The constraints on those asm blocks allow the compiler to assume that
> x7 is preserved across the syscall. If a ptracer accidentally modified it
> (which is easy to do in the situations that I mentioned), it could
> absolutely cause incorrect execution of the userspace program.
> 
> > Although the examples you've
> > listed above are interesting, I don't see why x7 is important in any of
> > them (and we only support up to 6 system call arguments).
> 
> It's not so much that x7 is important, it's that lying to the ptracer is
> problematic, because it might remember that lie and act on it later.
> I did run into exactly this problem, where my ptracer accidentally
> changed the value of x7 and caused incorrect execution in the tracee
> (now that incorrect execution happened to be an assertion, because
> my application is paranoid about these kinds of issues, but it was
> incorrect nevertheless)
> 
> If it would be helpful, I can code up the syscall entry -> signal trap example
> ptracer to have a concrete example.

I guess I'm more interested in situations where the compiler thinks x7 is
live, yet we clobber it.

Will
