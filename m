Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A691CA57C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEHH5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 03:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHH5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:57:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA39207DD;
        Fri,  8 May 2020 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588924641;
        bh=+CkCpSuKwhhUOdlSl/nBxTRsMI4V6pgCGiLirtJvjnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VHvg9PE1DV1GfVfbqhTNKfowsqct70VFs2BhegsCfzjdpPh275fCjWhmd0eC3360J
         nwlMzYwRSic09DyqMaxR5/g/mtF+8U0tI4681LrbzN0dFT8JbDyNHOT8Ovh8qg/DYl
         Mth0opGayuqRZCLUInzUJN681NKy2gou2k+1DWTA=
Date:   Fri, 8 May 2020 16:57:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Replace zero-length array with flexible-array
Message-Id: <20200508165717.ed47c8fd3a2863f8ef3ce329@kernel.org>
In-Reply-To: <20200507185733.GA14931@embeddedor>
References: <20200507185733.GA14931@embeddedor>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 13:57:33 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the complete explanation :-D
This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> ---
>  include/linux/kprobes.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 04bdaf01112c..4477205e3e92 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -161,7 +161,7 @@ struct kretprobe_instance {
>  	kprobe_opcode_t *ret_addr;
>  	struct task_struct *task;
>  	void *fp;
> -	char data[0];
> +	char data[];
>  };
>  
>  struct kretprobe_blackpoint {
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
