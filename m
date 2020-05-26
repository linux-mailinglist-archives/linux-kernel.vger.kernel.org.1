Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51CB1B98FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD0HtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 03:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgD0HtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:49:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC0B20728;
        Mon, 27 Apr 2020 07:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587973761;
        bh=gUEF4e+I+5LtkJ+KR7VccemOQ0DrTjrOVZmMSY/BJKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tM0MCyqEbiKAHZFfSbvrulUKGmf63KAanMfop+yxY/F6lhWkM0zaQHm6rQTTcpbFO
         HOLa2VqGqzrsyLsi9beTUDK/YUbfTbFXhIaq0lXicUQ2nltnRNrmYVf2nEyZ5hYtxm
         L4qNVWY1RZq3IAt1JnQvY/wDdHSjRRAJ1cpgYvGY=
Date:   Mon, 27 Apr 2020 08:49:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] mm: add DEBUG_WX support
Message-ID: <20200427074915.GA11787@willie-the-truck>
References: <cover.1587455584.git.zong.li@sifive.com>
 <23980cd0f0e5d79e24a92169116407c75bcc650d.1587455584.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23980cd0f0e5d79e24a92169116407c75bcc650d.1587455584.git.zong.li@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:17:12PM +0800, Zong Li wrote:
> Some architectures support DEBUG_WX function, it's verbatim from each
> others. Extract to mm/Kconfig.debug for shared use.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  mm/Kconfig.debug | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 0271b22e063f..077458ad968d 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -118,6 +118,39 @@ config DEBUG_RODATA_TEST
>      ---help---
>        This option enables a testcase for the setting rodata read-only.
>  
> +config ARCH_HAS_DEBUG_WX
> +	bool
> +
> +config DEBUG_WX
> +	bool "Warn on W+X mappings at boot"
> +	depends on ARCH_HAS_DEBUG_WX
> +	select PTDUMP_CORE
> +	help
> +	  Generate a warning if any W+X mappings are found at boot.
> +
> +	  This is useful for discovering cases where the kernel is leaving
> +	  W+X mappings after applying NX, as such mappings are a security risk.
> +	  This check also includes UXN, which should be set on all kernel
> +	  mappings.

"UXN" is the name of a bit in the arm64 page-table descriptors, so this
should be reworded now that it's in generic help text.

Will
