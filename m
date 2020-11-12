Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E392B022E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgKLJoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgKLJoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:44:00 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12DD21D40;
        Thu, 12 Nov 2020 09:43:56 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:43:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 30/44] arm64: kasan: Allow enabling in-kernel MTE
Message-ID: <20201112094354.GF29613@gaia>
References: <cover.1605046192.git.andreyknvl@google.com>
 <5ce2fc45920e59623a4a9d8d39b6c96792f1e055.1605046192.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce2fc45920e59623a4a9d8d39b6c96792f1e055.1605046192.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:10:27PM +0100, Andrey Konovalov wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
> feature and requires it to be enabled. MTE supports
> 
> This patch adds a new mte_init_tags() helper, that enables MTE in
> Synchronous mode in EL1 and is intended to be called from KASAN runtime
> during initialization.

There's no mte_init_tags() in this function.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 600b26d65b41..7f477991a6cf 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -129,6 +129,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  	return ptr;
>  }
>  
> +void mte_enable(void)
> +{
> +	/* Enable MTE Sync Mode for EL1. */
> +	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +	isb();
> +}

Nitpick: maybe rename this to mte_enable_kernel() since MTE is already
enabled for user apps.

-- 
Catalin
