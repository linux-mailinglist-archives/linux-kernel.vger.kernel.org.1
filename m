Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7161B98FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgD0Htk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 03:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgD0Htk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:49:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABACA206B6;
        Mon, 27 Apr 2020 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587973780;
        bh=/8brvwQoEX2EnJSv6s+0ZBz9o81uCnXLIWCUSBACy34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXWldtU0yIsdIb51ZeaGkI+YsJ1FlbG49AyQHS3oEZgGmj7s3bCk0di1gzcww/GQn
         eBjh7vgXsm2OgAvkbxmRGsFdBN2DqTIXOlEtLRiSFkAGKaLiSSjLnnsTAGN3EkEr0h
         wWXP6s+LUDwPK7gCoxbl50U3M3XheUkHvdEnWYqM=
Date:   Mon, 27 Apr 2020 08:49:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: mm: use ARCH_HAS_DEBUG_WX instead of arch
 defined
Message-ID: <20200427074933.GB11787@willie-the-truck>
References: <cover.1587455584.git.zong.li@sifive.com>
 <e19709e7576f65e303245fe520cad5f7bae72763.1587455584.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19709e7576f65e303245fe520cad5f7bae72763.1587455584.git.zong.li@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:17:15PM +0800, Zong Li wrote:
> Extract DEBUG_WX to mm/Kconfig.debug for shared use. Change to use
> ARCH_HAS_DEBUG_WX instead of DEBUG_WX defined by arch port.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/arm64/Kconfig       |  1 +
>  arch/arm64/Kconfig.debug | 29 -----------------------------
>  2 files changed, 1 insertion(+), 29 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
