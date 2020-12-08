Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325922D2861
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgLHKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLHKDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:03:51 -0500
Date:   Tue, 8 Dec 2020 10:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607421790;
        bh=0xQQE6XjV4D2s2XwuGXUxgmwbt+HO7/Bo5g2EAfvJhc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLkdnqotbxUGCJnIs8rXWRDojB3UO1OdbOg8uoeSNYQ6wrFTiVjGrYB3DNRW3qBwB
         g4yg1nllKXgsokAtcXcx3Z84TtAVl02ZAzQQqfJpVSCSJ+Uah4jZnfUieh351d9Qxm
         835OL/F2h8T1RD2/SNTdZZQivSEaEK8GI5vSfTCHaijkyYKU2/lZ79B+Pds4ViBSsE
         awyEluZPJgHfjxEX40NTvAngQZvEw4O4B+pvGipg2M3h8leQMmmIOyumT5aiNZ9cZV
         CPL1Zog6my17zGr5y/T7p7v8lbiMm777Zb8dB2yzNwOwlzaOF+jqnJZXR9JzXFkTUX
         Qgl0E0ngiARbA==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20201208100304.GA5838@willie-the-truck>
References: <20201203223217.1238899-1-arnd@kernel.org>
 <20201204095909.GC461@willie-the-truck>
 <20201207181931.GE1526@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207181931.GE1526@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:19:31PM +0000, Catalin Marinas wrote:
> On Fri, Dec 04, 2020 at 09:59:10AM +0000, Will Deacon wrote:
> > On Thu, Dec 03, 2020 at 11:32:11PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The __system_matches_cap() function is now only used in an #ifdef
> > > section:
> > > 
> > > arch/arm64/kernel/cpufeature.c:2649:13: error: unused function '__system_matches_cap' [-Werror,-Wunused-function]
> > > 
> > > Move it into that #ifdef section.
> > > 
> > > Fixes: 7cf283c7bd62 ("arm64: uaccess: remove redundant PAN toggling")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I already queued a fix from Mark: 701f49065e68 ("arm64: mark
> __system_matches_cap as __maybe_unused").
> 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > We can probably go further and remove the helper altogether as I don't
> > think it really helps has_generic_auth(), but this should fix the warning.
> 
> We could replace the ARM64_HAS_GENERIC_AUTH checks with a single helper
> function that tests for ARM64_HAS_GENERIC_AUTH_ARCH or
> ARM64_HAS_GENERIC_AUTH_IMP_DEF. Or you had a different idea?

I was just thinking something like below, although it's a bit annoying
that we can't use cpucap_multi_entry_cap_matches() here afaict.

Will

--->8

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 39138f6d3ba2..32a138ce0a92 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -155,8 +155,6 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 
 static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 
-static bool __system_matches_cap(unsigned int n);
-
 /*
  * NOTE: Any changes to the visibility of features should be kept in
  * sync with the documentation of the CPU feature register ABI.
@@ -1652,8 +1650,13 @@ static bool has_address_auth_metacap(const struct arm64_cpu_capabilities *entry,
 static bool has_generic_auth(const struct arm64_cpu_capabilities *entry,
 			     int __unused)
 {
-	return __system_matches_cap(ARM64_HAS_GENERIC_AUTH_ARCH) ||
-	       __system_matches_cap(ARM64_HAS_GENERIC_AUTH_IMP_DEF);
+	const struct arm64_cpu_capabilities *cap_arch, *cap_impdef;
+
+	cap_arch = cpu_hwcaps_ptrs[ARM64_HAS_GENERIC_AUTH_ARCH];
+	cap_impdef = cpu_hwcaps_ptrs[ARM64_HAS_GENERIC_AUTH_IMP_DEF];
+
+	return cap_arch->matches(cap_arch, SCOPE_SYSTEM) ||
+	       cap_impdef->matches(cap_impdef, SCOPE_SYSTEM);
 }
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
@@ -2637,23 +2640,6 @@ bool this_cpu_has_cap(unsigned int n)
 	return false;
 }
 
-/*
- * This helper function is used in a narrow window when,
- * - The system wide safe registers are set with all the SMP CPUs and,
- * - The SYSTEM_FEATURE cpu_hwcaps may not have been set.
- * In all other cases cpus_have_{const_}cap() should be used.
- */
-static bool __maybe_unused __system_matches_cap(unsigned int n)
-{
-	if (n < ARM64_NCAPS) {
-		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
-
-		if (cap)
-			return cap->matches(cap, SCOPE_SYSTEM);
-	}
-	return false;
-}
-
 void cpu_set_feature(unsigned int num)
 {
 	WARN_ON(num >= MAX_CPU_FEATURES);
