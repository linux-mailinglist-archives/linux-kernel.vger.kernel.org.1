Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E042F0D18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbhAKHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:07:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40489 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:07:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DDl9d1xKXz9vBnG;
        Mon, 11 Jan 2021 08:06:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id prXPXq5z2Ylb; Mon, 11 Jan 2021 08:06:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DDl9c3cZSz9vBnB;
        Mon, 11 Jan 2021 08:06:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D0D38B78A;
        Mon, 11 Jan 2021 08:06:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HC1KZHsRdfsP; Mon, 11 Jan 2021 08:06:17 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA1D08B75B;
        Mon, 11 Jan 2021 08:06:16 +0100 (CET)
Subject: Re: [PATCH v2] powerpc: fix alignment bug whithin the init sections
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, keescook@chromium.org,
        dja@axtens.net, npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        maskray@google.com, ariel.marcovitch@gmail.com, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210102201156.10805-1-ariel.marcovitch@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dacc0535-217d-1a35-fcfe-7ff730e32735@csgroup.eu>
Date:   Mon, 11 Jan 2021 08:06:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210102201156.10805-1-ariel.marcovitch@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/01/2021 à 21:11, Ariel Marcovitch a écrit :
> This is a bug that causes early crashes in builds with a
> .exit.text section smaller than a page and a .init.text section that
> ends in the beginning of a physical page (this is kinda random, which
> might explain why this wasn't really encountered before).
> 
> The init sections are ordered like this:
> 	.init.text
> 	.exit.text
> 	.init.data
> 
> Currently, these sections aren't page aligned.
> 
> Because the init code might become read-only at runtime and because the
> .init.text section can potentially reside on the same physical page as
> .init.data, the beginning of .init.data might be mapped read-only along
> with .init.text.
> 
> Then when the kernel tries to modify a variable in .init.data (like
> kthreadd_done, used in kernel_init()) the kernel panics.
> 
> To avoid this, make _einittext page aligned and also align .exit.text
> to make sure .init.data is always seperated from the text segments.
> 
> Fixes: 060ef9d89d18 ("powerpc32: PAGE_EXEC required for inittext")
> Signed-off-by: Ariel Marcovitch <ariel.marcovitch@gmail.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/kernel/vmlinux.lds.S | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 6db90cdf11da..b6c765d8e7ee 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -187,6 +187,11 @@ SECTIONS
>   	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
>   		_sinittext = .;
>   		INIT_TEXT
> +
> +		/* .init.text might be RO so we must
> +		* ensure this section ends in a page boundary.
> +		*/
> +		. = ALIGN(PAGE_SIZE);
>   		_einittext = .;
>   #ifdef CONFIG_PPC64
>   		*(.tramp.ftrace.init);
> @@ -200,6 +205,8 @@ SECTIONS
>   		EXIT_TEXT
>   	}
>   
> +	. = ALIGN(PAGE_SIZE);
> +
>   	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
>   		INIT_DATA
>   	}
> 
> base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> 
