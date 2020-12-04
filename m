Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3AC2CEB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgLDJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgLDJ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:59:56 -0500
Date:   Fri, 4 Dec 2020 09:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607075955;
        bh=eTDLlwNPvwWPy8dSGHo/qizkZsw89ufbibXjcv+b2Is=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUQ3oQG4CW9V97oGyQFm3HYJe0oRoVdgnprgaAsiTQDy772ZmyFoez0NjlMhmLsHb
         YF0RCsiDjalvmpo5Mf71U8g+vkP3GdrMT4WQ3KPtQpBkgjRN92Dqfvbc53d7VVxRxv
         AMBV3SfdDFhLO+BuSgOM1IUvruyMsLlGa4Em2qylwg6/mg0QNgkDU5O+ru3gUleO41
         2SxyEDrAdEubV9gKZYFasRJEC9UN7X5t4a6tXEtkBeMHctc+Auh9w40KiIMZ85L7f3
         u3yfQpjlMyObgX3sW9A0XUnHWpKx0WgUUbNkD16M+oY6Y3ocmR1gV333r4/NfWuXfH
         9RDytO1hfaRgQ==
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: fix unused function warning
Message-ID: <20201204095909.GC461@willie-the-truck>
References: <20201203223217.1238899-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203223217.1238899-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:32:11PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __system_matches_cap() function is now only used in an #ifdef
> section:
> 
> arch/arm64/kernel/cpufeature.c:2649:13: error: unused function '__system_matches_cap' [-Werror,-Wunused-function]
> 
> Move it into that #ifdef section.
> 
> Fixes: 7cf283c7bd62 ("arm64: uaccess: remove redundant PAN toggling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/cpufeature.c | 36 ++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

We can probably go further and remove the helper altogether as I don't
think it really helps has_generic_auth(), but this should fix the warning.

Will
