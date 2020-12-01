Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9282C954C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLAChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLAChN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:37:13 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A87120857;
        Tue,  1 Dec 2020 02:36:32 +0000 (UTC)
Date:   Mon, 30 Nov 2020 21:36:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 03/14] ftrace: Fix cleanup in error path of
 register_ftrace_direct()
Message-ID: <20201130213629.185216e8@oasis.local.home>
In-Reply-To: <5a10d77b845633fbd13f1c3c71e7f9777bbbe601.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
        <5a10d77b845633fbd13f1c3c71e7f9777bbbe601.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 23:38:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We need to remove hash entry if register_ftrace_function() fails.
> Consolidate the cleanup to be done after register_ftrace_function() at
> the end.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/trace/ftrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9c1bba8cc51b03..3844a4a1346a9c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5136,8 +5136,6 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
>  	__add_hash_entry(direct_functions, entry);
>  
>  	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
> -	if (ret)
> -		remove_hash_entry(direct_functions, entry);
>  
>  	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
>  		ret = register_ftrace_function(&direct_ops);
> @@ -5146,6 +5144,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
>  	}
>  
>  	if (ret) {
> +		remove_hash_entry(direct_functions, entry);
>  		kfree(entry);
>  		if (!direct->count) {
>  			list_del_rcu(&direct->next);

