Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36941D7766
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgERLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:37:20 -0400
Received: from foss.arm.com ([217.140.110.172]:38726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgERLhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:37:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73515106F;
        Mon, 18 May 2020 04:37:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F263F52E;
        Mon, 18 May 2020 04:37:15 -0700 (PDT)
Date:   Mon, 18 May 2020 12:37:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 1/6] arm64: scs: Store absolute SCS stack pointer value
 in thread_info
Message-ID: <20200518113710.GA1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-2-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:51PM +0100, Will Deacon wrote:
> Storing the SCS information in thread_info as a {base,offset} pair
> introduces an additional load instruction on the ret-to-user path,
> since the SCS stack pointer in x18 has to be converted back to an offset
> by subtracting the base.
> 
> Replace the offset with the absolute SCS stack pointer value instead
> and avoid the redundant load.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

One trivial nit below, but regardless this looks sound to me, and I
certainly prefer having the absolute address rather than an offset, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

> diff --git a/kernel/scs.c b/kernel/scs.c
> index 9389c28f0853..5ff8663e4a67 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -60,8 +60,7 @@ int scs_prepare(struct task_struct *tsk, int node)
>  	if (!s)
>  		return -ENOMEM;
>  
> -	task_scs(tsk) = s;
> -	task_scs_offset(tsk) = 0;
> +	task_scs(tsk) = task_scs_sp(tsk) = s;

I think this would be more legible as two statements:

|	task_sys(tsk) = s;
|	task_scs_sp(tsk) = s;

... as we usually save `foo = bar = baz` stuff for the start of a
function or within loop conditions.

Thanks,
Mark.

>  	scs_account(tsk, 1);
>  	return 0;
>  }
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
