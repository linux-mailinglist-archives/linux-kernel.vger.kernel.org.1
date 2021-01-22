Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81D30075A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhAVPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:30:39 -0500
Received: from foss.arm.com ([217.140.110.172]:53324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbhAVPaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:30:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D8D11D4;
        Fri, 22 Jan 2021 07:29:24 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E033F66E;
        Fri, 22 Jan 2021 07:29:23 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:29:21 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kprobes: Fix Uexpected kernel BRK exception at EL1
Message-ID: <20210122152921.gnevsymmd4mckkee@e107158-lin>
References: <20210122110909.3324607-1-qais.yousef@arm.com>
 <20210122223601.4b3b7e01c6ec583c0439f1c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122223601.4b3b7e01c6ec583c0439f1c9@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22/21 22:36, Masami Hiramatsu wrote:
> > Further analysis showed that kcb->kprobe_status is set to
> > KPROBE_REENTER when the error occurs. By teaching
> > kprobe_breakpoint_ss_handler() to handle this status I can no  longer
> > reproduce the problem.
> 
> Very good catch! Yes, this missed the reentered kprobe case.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> > 
> > Fixes: ba090f9cafd5 ("arm64: kprobes: Remove redundant kprobe_step_ctx")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> > 
> > Another change in behavior I noticed is that before ba090f9cafd5 ("arm64:
> > kprobes: Remove redundant kprobe_step_ctx") if 'cur' was NULL we wouldn't
> > return DBG_HOOK_ERROR, but after the change we do.
> 
> It should not happen, since the KPROBES_BRK_SS_IMM must be used only for
> kprobes's second break which must happen on the trampoline instruction
> buffer, which must set current kprobes before execution.

I see. Thanks for the explanation!

Cheers

--
Qais Yousef
