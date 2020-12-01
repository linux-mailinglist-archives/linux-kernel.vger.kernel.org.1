Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9A2C954B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgLACgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLACgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:36:45 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE6520809;
        Tue,  1 Dec 2020 02:36:04 +0000 (UTC)
Date:   Mon, 30 Nov 2020 21:36:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 02/14] ftrace: Fix DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 dependency
Message-ID: <20201130213602.3647f2b8@oasis.local.home>
In-Reply-To: <fc4b257ea8689a36f086d2389a9ed989496ca63a.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
        <fc4b257ea8689a36f086d2389a9ed989496ca63a.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 23:38:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> DYNAMIC_FTRACE_WITH_DIRECT_CALLS should depend on
> DYNAMIC_FTRACE_WITH_REGS since we need ftrace_regs_caller().
> 
> Fixes: 763e34e74bb7d5c ("ftrace: Add register_ftrace_direct()")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

I'm pulling this in for stable as well.

-- Steve

> ---
>  kernel/trace/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a4020c0b4508c9..e1bf5228fb692a 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -202,7 +202,7 @@ config DYNAMIC_FTRACE_WITH_REGS
>  
>  config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	def_bool y
> -	depends on DYNAMIC_FTRACE
> +	depends on DYNAMIC_FTRACE_WITH_REGS
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  
>  config FUNCTION_PROFILER

