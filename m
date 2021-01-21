Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26E92FE8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbhAUL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbhAUL2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:28:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D0E2222B;
        Thu, 21 Jan 2021 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611228451;
        bh=NNIBRAti613JrHVuyoNx3eoND4o9Cxpt15znQz5QslI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6I/9FOynulb34GA52aJvTWKNLg4FA+lcJ4ttaGKG9Fj2YTUvTHiBNEWASgveGEj6
         6fAxOEJaBygZ3Ut5JggIIgsfZFQE0a8Zb6DxD/iyYqHe14hMUH0xxsxJNK+aWqgzK7
         2xJnI24rYKqXCnWiGgGZ0MatLfG0sZVAL5F60RDkISgi3zhgXQuf3LvV4XFMLrhhb8
         zUI/hwHcinh5UnWaqkWrfxZxqYoEYIeZegK8BA6OTZ9gtLKnn6ZLAK9Jc+qP5kTD3J
         rkDBa/xQWf0jtSMc0lso6u3bj+ElkKiwRhdf33Yd2iqxYMVw/VH/J9x1dsObKyYwIa
         V5LnKG0cOHKIQ==
Date:   Thu, 21 Jan 2021 11:27:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
Message-ID: <20210121112725.GA21750@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120132717.395873-4-mohamed.mediouni@caramail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:27:13PM +0100, Mohamed Mediouni wrote:
> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious hardware quirk.
> 
> On Apple processors, writes using the nGnRE device memory type get dropped in flight,
> getting to nowhere.
> 
> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> ---
>  arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 1f7ee8c8b7b8..06436916f137 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -51,6 +51,25 @@
>  #define TCR_KASAN_HW_FLAGS 0
>  #endif
> 
> +#ifdef CONFIG_ARCH_APPLE
> +
> +/*
> + * Apple cores appear to black-hole writes done with nGnRE.
> + * We settled on a work-around that uses MAIR vs changing every single user of
> + * nGnRE across the arm64 code.
> + */
> +
> +#define MAIR_EL1_SET_APPLE						\
> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> +
> +#endif
> +
>  /*
>   * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
>   * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>  	 * Memory region attributes
>  	 */
>  	mov_q	x5, MAIR_EL1_SET
> +#ifdef CONFIG_ARCH_APPLE
> +	mrs	x0, MIDR_EL1
> +	lsr	w0, w0, #24
> +	mov_q	x1, MAIR_EL1_SET_APPLE
> +	cmp	x0, #0x61			// 0x61 = Implementer: Apple
> +	csel	x5, x1, x5, eq

Why does this need to be done so early? It would be a lot cleaner if we
could detect this in a similar fashion to other errata and update the MAIR
appropriately. If that's not possible because of early IO mappings (which
ones?), then we could instead initialise to nGnRnE unconditionally, but
relax it to nGnRE if we detect that we _don't_ have the erratum.

Will
