Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B82D186A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgLGSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgLGSUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:20:16 -0500
Date:   Mon, 7 Dec 2020 18:19:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <20201207181931.GE1526@gaia>
References: <20201203223217.1238899-1-arnd@kernel.org>
 <20201204095909.GC461@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204095909.GC461@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:59:10AM +0000, Will Deacon wrote:
> On Thu, Dec 03, 2020 at 11:32:11PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The __system_matches_cap() function is now only used in an #ifdef
> > section:
> > 
> > arch/arm64/kernel/cpufeature.c:2649:13: error: unused function '__system_matches_cap' [-Werror,-Wunused-function]
> > 
> > Move it into that #ifdef section.
> > 
> > Fixes: 7cf283c7bd62 ("arm64: uaccess: remove redundant PAN toggling")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I already queued a fix from Mark: 701f49065e68 ("arm64: mark
__system_matches_cap as __maybe_unused").

> Acked-by: Will Deacon <will@kernel.org>
> 
> We can probably go further and remove the helper altogether as I don't
> think it really helps has_generic_auth(), but this should fix the warning.

We could replace the ARM64_HAS_GENERIC_AUTH checks with a single helper
function that tests for ARM64_HAS_GENERIC_AUTH_ARCH or
ARM64_HAS_GENERIC_AUTH_IMP_DEF. Or you had a different idea?

-- 
Catalin
