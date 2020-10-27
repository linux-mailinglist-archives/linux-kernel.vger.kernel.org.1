Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2119D29A8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896999AbgJ0KEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896981AbgJ0KEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:04:36 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C700F2225C;
        Tue, 27 Oct 2020 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603793076;
        bh=9oqzRDZNe+FfdXtk0S3LxKVoMZpBJw1CaS0aw8Ns96E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+9PUBR0MaYQIgZV2v2UQvZdY/l4W42pbJcmh3UytyQXuaZjA1zIbhbHw21jjfE+n
         KCCI5hK1v9Xh5pqwCBSqwaSxxgsPx4rQio5c8LpyZoGsdkeQQqniq/4z4vq87JpmRL
         Kf4oKAXoAmeAt430Ucr9Hy0qL+Oy5oVI9enLf5Nc=
Date:   Tue, 27 Oct 2020 12:04:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v2 2/6] RISC-V: Initialize SBI early
Message-ID: <20201027100427.GL1154158@kernel.org>
References: <20201026230254.911912-1-atish.patra@wdc.com>
 <20201026230254.911912-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026230254.911912-3-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:02:50PM -0700, Atish Patra wrote:
> Currently, SBI is initialized towards the end of arch setup. This prevents
> the set memory operations to be invoked earlier as it requires a full tlb
> flush.
> 
> Initialize SBI as early as possible.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/setup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index c424cc6dd833..7d6a04ae3929 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -89,6 +89,9 @@ void __init setup_arch(char **cmdline_p)
>  		pr_err("No DTB found in kernel mappings\n");
>  #endif
>  
> +#if IS_ENABLED(CONFIG_RISCV_SBI)

Maybe
	if (IS_ENABLED(CONFIG_RISCV_SBI))
		sbi_init()

> +	sbi_init();
> +#endif
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(1);
>  #endif
> @@ -97,10 +100,6 @@ void __init setup_arch(char **cmdline_p)
>  	kasan_init();
>  #endif
>  
> -#if IS_ENABLED(CONFIG_RISCV_SBI)
> -	sbi_init();
> -#endif
> -
>  #ifdef CONFIG_SMP
>  	setup_smp();
>  #endif
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
