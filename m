Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF41FCD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 08:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:33:53 -0400
Received: from [192.168.0.106] (220-244-111-178.tpgi.com.au [220.244.111.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E6B2078D;
        Wed, 17 Jun 2020 12:33:51 +0000 (UTC)
Subject: Re: [PATCH 1/2] m68k: nommu: register start of the memory with
 memblock
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200617065341.32160-1-rppt@kernel.org>
 <20200617065341.32160-2-rppt@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <45cb9ecf-44c2-d307-4342-e66851ef67a7@linux-m68k.org>
Date:   Wed, 17 Jun 2020 22:33:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617065341.32160-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 17/6/20 4:53 pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The m68k nommu setup code didn't register the beginning of the physical
> memory with memblock because it was anyway occupied by the kernel. However,
> commit fa3354e4ea39 ("mm: free_area_init: use maximal zone PFNs rather than
> zone sizes") changed zones initialization to use memblock.memory to detect
> the zone extents and this caused inconsistency between zone PFNs and the
> actual PFNs:
> 
> BUG: Bad page state in process swapper  pfn:20165
> page:41fe0ca0 refcount:0 mapcount:1 mapping:00000000 index:0x0 flags: 0x0()
> raw: 00000000 00000100 00000122 00000000 00000000 00000000 00000000 00000000
> page dumped because: nonzero mapcount
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc1-00001-g3a38f8a60c65-dirty #1
> Stack from 404c9ebc:
>          404c9ebc 4029ab28 4029ab28 40088470 41fe0ca0 40299e21 40299df1 404ba2a4
>          00020165 00000000 41fd2c10 402c7ba0 41fd2c04 40088504 41fe0ca0 40299e21
>          00000000 40088a12 41fe0ca0 41fe0ca4 0000020a 00000000 00000001 402ca000
>          00000000 41fe0ca0 41fd2c10 41fd2c10 00000000 00000000 402b2388 00000001
>          400a0934 40091056 404c9f44 404c9f44 40088db4 402c7ba0 00000001 41fd2c04
>          41fe0ca0 41fd2000 41fe0ca0 40089e02 4026ecf4 40089e4e 41fe0ca0 ffffffff
> Call Trace:
>          [<40088470>] 0x40088470
>   [<40088504>] 0x40088504
>   [<40088a12>] 0x40088a12
>   [<402ca000>] 0x402ca000
>   [<400a0934>] 0x400a0934
> 
> Adjust the memory registration with memblock to include the beginning of
> the physical memory and make sure that the area occupied by the kernel is
> marked as reserved.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
>   arch/m68k/kernel/setup_no.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index e779b19e0193..f66f4b1d062e 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -138,7 +138,8 @@ void __init setup_arch(char **cmdline_p)
>   	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
>   		 __bss_stop, memory_start, memory_start, memory_end);
>   
> -	memblock_add(memory_start, memory_end - memory_start);
> +	memblock_add(_rambase, memory_end - _rambase);
> +	memblock_reserve(_rambase, memory_start - _rambase);
>   
>   	/* Keep a copy of command line */
>   	*cmdline_p = &command_line[0];
> 
