Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7891E3E22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgE0Jze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 05:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgE0Jzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:55:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD8F2088E;
        Wed, 27 May 2020 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590573333;
        bh=0vEyKxh0OHGJ9gF0R7NIKNktw24Wv6pQ4lvQk1y2efc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/rHUZhHlceJDTiD9oSe5JYsGHNHGVPib/TpRBweLOk3z0/bdBhib+7ZFEf32KPP3
         67oygptKA6VxdYQ64m5478zeA/FZbiMO8MJbtxCp4YIJQpx+N65PYL/IqAu4jzzltl
         LKaCXNTiKOv8JDw0w780+yxXVfFg7OsjwlyRyaEw=
Date:   Wed, 27 May 2020 10:55:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200527095528.GC11111@willie-the-truck>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 02:56:35AM -0400, Keno Fischer wrote:
> Just ran into this issue again, with what I think may be most compelling
> example yet why this is problematic:
> 
> The tracee incurred a signal, we PTRACE_SYSEMU'd to the rt_sigreturn,
> which the tracer tried to emulate by applying the state from the signal frame.
> However, the PTRACE_SYSEMU stop is a syscall-stop, so the tracer's write
> to x7 was ignored and x7 retained the value it had in the signal handler,
> which broke the tracee.

Yeah, that sounds like a good justification to add a way to stop this. Could
you send a patch, please?

Interestingly, I *thought* the current behaviour was needed by strace, but I
can't find anything there that seems to require it. Oh well, we're stuck
with it anyway.

Will
