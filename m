Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90740298CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775356AbgJZMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:40:57 -0400
Received: from wforward5-smtp.messagingengine.com ([64.147.123.35]:33739 "EHLO
        wforward5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775349AbgJZMk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:40:56 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 08:40:56 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailforward.west.internal (Postfix) with ESMTP id 8A7D1970;
        Mon, 26 Oct 2020 08:34:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 26 Oct 2020 08:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vIbCuk
        91i6QGTraXt+/cjM/+gEv1M6E58T0Do/aXATs=; b=hjKqf01Nh66q4xQKCx8EyJ
        qkeL1su0cwwW8LIZXcQBCI/m+KPVAHmVgmjk4P4zlY21t33RbSJxcrDqDGZQ8x+s
        MCh3NyT+oBYx22wCfvstcslSJmW1ZVyZE/IEPBrA0oz0nRKSj5V3MSsjCzl2ip9P
        +oiuYCSnlkhb6Jko2AWEVvTbfS/3XTuXo1E0G18f0vPkrtx0/1em8JdVl0IjsRIV
        UZmeWZU9Z9PdMovU4Mokt+suwOLkXUkOZxeiuNNAjtQenUBhMEWVli85qu9mHb/+
        aY3E6XseuHr4mHoWWE2c6WrIjYEFnxtoUocRf8WACutkNdhQqioANImSS8snUxhg
        ==
X-ME-Sender: <xms:TMKWX32SpsWgjAY8abk3XxOrqo9nZxvfAURr4zQnZNa8k8lCPMNKfw>
    <xme:TMKWX2HJuoj_tAhjchawvySm1vW_-fjuUw5VQY7uBYxBh0DYs0IyApsB54QV3xVE2
    08WrylAzM-jWWocSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrvghkkhgrucfgnhgsvghrghcuoehpvghnsggvrhhgsehikhhi
    rdhfiheqnecuggftrfgrthhtvghrnhepgfffgeekteetvdejledufeelleeuudeigfevvd
    eileeludehiedugefhleehvdeunecukfhppeeivddrjeekrddujeelrddufedunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvnhgsvghrgh
    esihhkihdrfhhi
X-ME-Proxy: <xmx:TMKWX348QcPt5zHbYrVn4uqgJvlkflWoA4eSeK4C2QmxMOBBoKWlpQ>
    <xmx:TMKWX81hKwyoIaIs0o5PJS4nfbUX0ZfZZijM0ITdoJ_w0hDzxLNHmQ>
    <xmx:TMKWX6GWllP0CNVPE2oEqiRnMyiuN0UhSfpaDV4TkfhdB4omm8EIeQ>
    <xmx:TsKWX4ZA0PYyTTWaBKYMwYeVdDjjztvCtGxr3E9ySOjomNHK2zqFv4svMk0LUlwu>
Received: from localhost (62-78-179-131.bb.dnainternet.fi [62.78.179.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C6E53280060;
        Mon, 26 Oct 2020 08:34:20 -0400 (EDT)
Date:   Mon, 26 Oct 2020 14:34:18 +0200
From:   Pekka Enberg <penberg@iki.fi>
To:     liush <liush@allwinnertech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, penberg@kernel.org,
        akpm@linux-foundation.org, peterx@redhat.com, vbabka@suse.cz,
        walken@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix pfn_to_virt err in do_page_fault().
Message-ID: <20201026123418.GA1087529@nero>
References: <1603715214-29082-1-git-send-email-liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603715214-29082-1-git-send-email-liush@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:26:54PM +0800, liush wrote:
> From: Liu Shaohua <liush@allwinnertech.com>
> 
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: liush <liush@allwinnertech.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>

> ---
>  arch/riscv/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 1359e21..3c8b9e4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -86,6 +86,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	pmd_t *pmd, *pmd_k;
>  	pte_t *pte_k;
>  	int index;
> +	unsigned long pfn;
>  
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs))
> @@ -100,7 +101,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 * of a task switch.
>  	 */
>  	index = pgd_index(addr);
> -	pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +	pfn = csr_read(CSR_SATP) & SATP_PPN;
> +	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
>  	pgd_k = init_mm.pgd + index;
>  
>  	if (!pgd_present(*pgd_k)) {
> -- 
> 2.7.4
> 
