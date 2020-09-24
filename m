Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E27277782
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgIXRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgIXRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:10:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756D4238A1;
        Thu, 24 Sep 2020 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600967448;
        bh=gmJXib/WMHnc57gI6G8dSA/dxn41ZRyFW5IEJ+VpDnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KRA5bR3F3NVMGGCIypPfBLDauJPm1IsbjVA1d7kqa9fOov/CWol/X8NkWimyELVou
         vPktAA4i0EEjq+jIe9pdsITZCfZCwUAAnoHc6XGcXK+mG9E4uUDGXiJ7bTClTK65a0
         R13ZJxYvoaByRJlYKOGg9cSlZ3WuKTnJy6VuqDPM=
Date:   Fri, 25 Sep 2020 02:10:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] fault-injection: handle EI_ETYPE_TRUE
Message-Id: <20200925021045.d45f862caf4011767bbafba3@kernel.org>
In-Reply-To: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
References: <njB1czX0ZgWPR9h61euHIBb5bEyePw9D4D2m3i5lc9Cl96P8Q1308dTcmsEZW7Vtz3Ifz4do-rOtSfuFTyGoEDYokkK2aUqBePVptzZEWfU=@protonmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 16:48:56 +0000
Barnabás Pőcze <pobrn@protonmail.com> wrote:

> Commit af3b854492f351d1ff3b4744a83bf5ff7eed4920
> ("mm/page_alloc.c: allow error injection")
> introduced EI_ETYPE_TRUE, but did not extend
>  * lib/error-inject.c:error_type_string(), and
>  * kernel/fail_function.c:adjust_error_retval()
> to accommodate for this change.
> 
> Handle EI_ETYPE_TRUE in both functions appropriately by
>  * returning "TRUE" in error_type_string(),
>  * adjusting the return value to true (1) in adjust_error_retval().
> 
> Furthermore, simplify the logic of handling EI_ETYPE_NULL
> in adjust_error_retval().

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
> ---
>  kernel/fail_function.c | 6 +++---
>  lib/error-inject.c     | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 63b349168da7..4fdea01c0561 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -37,9 +37,7 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
>  {
>  	switch (get_injectable_error_type(addr)) {
>  	case EI_ETYPE_NULL:
> -		if (retv != 0)
> -			return 0;
> -		break;
> +		return 0;
>  	case EI_ETYPE_ERRNO:
>  		if (retv < (unsigned long)-MAX_ERRNO)
>  			return (unsigned long)-EINVAL;
> @@ -48,6 +46,8 @@ static unsigned long adjust_error_retval(unsigned long addr, unsigned long retv)
>  		if (retv != 0 && retv < (unsigned long)-MAX_ERRNO)
>  			return (unsigned long)-EINVAL;
>  		break;
> +	case EI_ETYPE_TRUE:
> +		return 1;
>  	}
> 
>  	return retv;
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index aa63751c916f..c73651b15b76 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -180,6 +180,8 @@ static const char *error_type_string(int etype)
>  		return "ERRNO";
>  	case EI_ETYPE_ERRNO_NULL:
>  		return "ERRNO_NULL";
> +	case EI_ETYPE_TRUE:
> +		return "TRUE";
>  	default:
>  		return "(unknown)";
>  	}
> --
> 2.28.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
