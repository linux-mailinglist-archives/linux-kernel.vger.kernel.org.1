Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53205286D31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJHDfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgJHDfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:35:17 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4D920714;
        Thu,  8 Oct 2020 03:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602128116;
        bh=hTOR2ukGrSJtupTlDv5QdS0kaBG1Xzq+GHp7El4yX24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XoMa7RGjioCGVz4dP9L3B9vY650EO4+BaRQI9EqozeOJmjhQ2hu4AEkmGwEosah1y
         rFIbUfwTR1T1JtkZHJeojwhp4TSF+/YzoPBTcAeCNzcALFagZd46IV2zUc9ARo4ovp
         CxHyUhT5QCHxJ6MXAq3tQlyDUraaj1xZR7sS73B8=
Date:   Thu, 8 Oct 2020 12:35:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V2] kprobes: Correct a typo in function
 kprobes_module_callback
Message-Id: <20201008123512.b5c77ac2b4ab0643a7ab5b73@kernel.org>
In-Reply-To: <1602126837-32346-1-git-send-email-zhouzhouyi@gmail.com>
References: <1602126837-32346-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Oct 2020 03:13:57 +0000
Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:

> There is a tiny typo in comment of function kprobes_module_callback.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Thanks for reporting!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> ---
>  kernel/kprobes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index e995541..9d2042b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  			     within_module_core((unsigned long)p->addr, mod))) {
>  				/*
>  				 * The vaddr this probe is installed will soon
> -				 * be vfreed buy not synced to disk. Hence,
> +				 * be vfreed but not synced to disk. Hence,
>  				 * disarming the breakpoint isn't needed.
>  				 *
>  				 * Note, this will also move any optimized probes
> -- 
> 1.7.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
