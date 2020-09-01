Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6190D2587B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 07:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIAF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 01:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIAF7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:59:32 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D9D2087D;
        Tue,  1 Sep 2020 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598939971;
        bh=BJfrClw+C5jaFYlYb2O3GY7/UQ3rsmmQs8RxMwdsSY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnLyZ5mDHRUIhha8dkmjwpA51hT6fthUo0yyY3VVOe1s7JbrSYsAlq8d6JAYO1DZN
         MZ++Rx2ECmGTFmGWOWCdO6SdR4ExDt62LEvpZTT9hx77PaIgfnwEnTUviPThaR8lwZ
         vX85aH1lrloWJDrbTGRVNz4jEyqkRQEM/0M5Ms7A=
Date:   Tue, 1 Sep 2020 08:59:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Reserve memblock for initrd
Message-ID: <20200901055924.GC432455@kernel.org>
References: <20200831212102.4014642-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831212102.4014642-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:21:01AM +0900, Stafford Horne wrote:
> Recently OpenRISC added support for external initrd images, but I found
> some instability when using larger buildroot initrd images. It turned
> out that I forgot to reserve the memblock space for the initrd image.
> 
> This patch fixes the instability issue by reserving memblock space.
> 
> Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/kernel/setup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index b18e775f8be3..2c8aa53cc7ba 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -80,6 +80,15 @@ static void __init setup_memory(void)
>  	 */
>  	memblock_reserve(__pa(_stext), _end - _stext);
>  
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Then reserve the initrd, if any */
> +	if (initrd_start && (initrd_end > initrd_start)) {
> +		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> +			ALIGN(initrd_end, PAGE_SIZE) -
> +			ALIGN_DOWN(initrd_start, PAGE_SIZE));
> +	}

The core mm takes care of reserving the entrire pages for the memory
reserved with memblock, so it is not necessary to do it here.

> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
>  	early_init_fdt_reserve_self();
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
