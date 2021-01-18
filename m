Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61762FA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391976AbhARNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389744AbhARNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:08:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E72EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:07:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q18so16425110wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fApAfVti2xStmYCcy/4S1EcAaXemwrEyH97isCiUdgA=;
        b=fkfgG2GGlDRAgOzcHfGUCb5XrhGcmeGRdSsDpWQ8suunOwB4DhxAxKytiwq57Sy9nT
         QkDRZSmhuWpxYdFiLinfXIlrNME/6hLpoih0jLyM2+85NyfLDjC6bX4zk8Cbpg1ckS8w
         43g0ssguzSAKsd5PI4H3Cv2F5Lbi9w57NCHLB6aWqc2L9117nWRDOAUVPr8HRBb0zTGG
         8C6LmyoQD8ep+dDWpxj1G1Vpijwr3/XqXxCZ+Bx5pF+7Ui+Anrw7aG5VbVyhzUcZYB6H
         w9uA4Ly8A4SjYwuzwqtkowELj81pooRxM08PXZPWALIZSHrPIZlraNJlR1waEDT8n6bt
         KUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fApAfVti2xStmYCcy/4S1EcAaXemwrEyH97isCiUdgA=;
        b=KS9R4P0g7t9NXkd7u8hAkBgLofaIDDqclT6T1pyrMQRRffNZamqbIwKTrZb35ygqjq
         JSvbQsHz6i7PlJqvkra4Y1AnyMUDBRINqDI4plZTPnqI1RtWFOjS7Gkt0fsN7iaSb0bM
         nX3BXwL1RQ4UeJ+o8ZGJ0s8tkKe+s42wZzb8awnsw3wimADo426dM+gnLuZK03gjVSAW
         mMuEPl0KQzDG2dM4t81K9e4I6ydLrRhxlFCT68PQKxnapsum0O9KdxEX132z5lHOyB2M
         n6LerwyFtKp0nsS3oBJsMCD0V2VdaNmSyWu8prq/gOvQ6sqn8kVuXiT1W72IRY0kcZvE
         pXEw==
X-Gm-Message-State: AOAM533FufHXq1iGsYlUzgQVtMmN6dqQOfVyQYiFO0j8dHoJzLfH9Fgi
        JCyKvCOebIwhJveBL81zmfcgBw==
X-Google-Smtp-Source: ABdhPJyQKadjPOln9TuGqhkP3mnY+iLzGGewW27eQj9ewfg04ijF5C6QPMBPqYy4T4GANzpf1dk/VQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr20350208wrd.118.1610975257074;
        Mon, 18 Jan 2021 05:07:37 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id b7sm28827076wru.33.2021.01.18.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:07:36 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:07:35 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 12/21] arm64: cpufeature: Add an early command-line
 cpufeature override facility
Message-ID: <20210118130735.aor3g4eqxazf3mkq@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-13-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-13-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:24AM +0000, Marc Zyngier wrote:
> In order to be able to override CPU features at boot time,
> let's add a command line parser that matches options of the
> form "cpureg.feature=value", and store the corresponding
> value into the override val/mask pair.
> 
> No features are currently defined, so no expected change in
> functionality.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: David Brazdil <dbrazdil@google.com>

> ---
>  arch/arm64/kernel/Makefile         |   2 +-
>  arch/arm64/kernel/head.S           |   1 +
>  arch/arm64/kernel/idreg-override.c | 119 +++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/idreg-override.c
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 86364ab6f13f..2262f0392857 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   return_address.o cpuinfo.o cpu_errata.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> -			   syscall.o proton-pack.o
> +			   syscall.o proton-pack.o idreg-override.o
>  
>  targets			+= efi-entry.o
>  
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index d74e5f84042e..b3c4dd04f74b 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -435,6 +435,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  
>  	mov	x0, x21				// pass FDT address in x0
>  	bl	early_fdt_map			// Try mapping the FDT early
> +	bl	init_shadow_regs
>  	bl	switch_to_vhe
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  	bl	kasan_early_init
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> new file mode 100644
> index 000000000000..392f93b67103
> --- /dev/null
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Early cpufeature override framework
> + *
> + * Copyright (C) 2020 Google LLC
> + * Author: Marc Zyngier <maz@kernel.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/libfdt.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/setup.h>
> +
> +struct reg_desc {
> +	const char * const	name;
> +	u64 * const		val;
> +	u64 * const		mask;
> +	struct {
> +		const char * const	name;
> +		u8			 shift;
nit: There's an extra space before `shift`.

> +	} 			fields[];
> +};
> +
> +static const struct reg_desc * const regs[] __initdata = {
> +};
> +
> +static int __init find_field(const char *cmdline, const struct reg_desc *reg,
> +			     int f, u64 *v)
> +{
> +	char buf[256], *str;
> +	size_t len;
> +
> +	snprintf(buf, ARRAY_SIZE(buf), "%s.%s=", reg->name, reg->fields[f].name);
> +
> +	str = strstr(cmdline, buf);
> +	if (!(str == cmdline || (str > cmdline && *(str - 1) == ' ')))
> +		return -1;
> +
> +	str += strlen(buf);
> +	len = strcspn(str, " ");
> +	len = min(len, ARRAY_SIZE(buf) - 1);
> +	strncpy(buf, str, len);
> +	buf[len] = 0;
> +
> +	return kstrtou64(buf, 0, v);
> +}
> +
> +static void __init match_options(const char *cmdline)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		int f;
> +
> +		if (!regs[i]->val || !regs[i]->mask)
> +			continue;
> +
> +		for (f = 0; regs[i]->fields[f].name; f++) {
> +			u64 v;
> +
> +			if (find_field(cmdline, regs[i], f, &v))
> +				continue;
> +
> +			*regs[i]->val  |= (v & 0xf) << regs[i]->fields[f].shift;
> +			*regs[i]->mask |= 0xfUL << regs[i]->fields[f].shift;
> +		}
> +	}
> +}
> +
> +static __init void parse_cmdline(void)
> +{
> +	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
> +		const u8 *prop;
> +		void *fdt;
> +		int node;
> +
> +		fdt = get_early_fdt_ptr();
> +		if (!fdt)
> +			goto out;
> +
> +		node = fdt_path_offset(fdt, "/chosen");
> +		if (node < 0)
> +			goto out;
> +
> +		prop = fdt_getprop(fdt, node, "bootargs", NULL);
> +		if (!prop)
> +			goto out;
> +
> +		match_options(prop);
> +
> +		if (!IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> +			return;
> +	}
> +
> +out:
> +	match_options(CONFIG_CMDLINE);
> +}
> +
> +void __init init_shadow_regs(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		if (regs[i]->val)
> +			*regs[i]->val  = 0;
> +		if (regs[i]->mask)
> +			*regs[i]->mask = 0;
> +	}
> +
> +	parse_cmdline();
> +
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		if (regs[i]->val)
> +			__flush_dcache_area(regs[i]->val, sizeof(*regs[i]->val));
> +		if (regs[i]->mask)
> +			__flush_dcache_area(regs[i]->mask, sizeof(*regs[i]->mask));
> +	}
> +}
> -- 
> 2.29.2
> 
