Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239B1294D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442863AbgJUNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441234AbgJUNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:10:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B132C0613CE;
        Wed, 21 Oct 2020 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMjOkbUQtyeR5+wl3KwNKG0mBA6u1w78Ht1qDvj8EUs=; b=XOXAe90uOp2gPvsCtG0tTg6Ao2
        2XE+Ty8fPaU5r8eefEGKM/d/kBOGs3aUCs8LYwORcbVoW1b8Dtnl1HHo9PLGTCzQGXEBPMm3sCniL
        muoYuTAyWDtqv2Pv5D7UYrlWZD1k2VbpR1OFJ5Y5k2lWPHbRXZeDfP5dhW/QNdF/PYdN+nSMLmSye
        ftr45RvGKireghJ+iRVF86cYnqAxMot8bOw6e0wLmbdV/PwQTDgbSqYxFwAnhHNoB4JI1nTdVwiyl
        oRNPumatQYa+h5FCA7LgQftkyJ1T5y7x+qK3hGFD+WKTQATkgXM2+yAaqkXz+SEqDv3vWQrDIeJyS
        k4zHdhbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVDsp-0008Nx-DF; Wed, 21 Oct 2020 13:10:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3F15304D2B;
        Wed, 21 Oct 2020 15:10:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5E22140541A; Wed, 21 Oct 2020 15:10:26 +0200 (CEST)
Date:   Wed, 21 Oct 2020 15:10:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021131026.GY2651@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <alpine.DEB.2.22.394.2010211336410.8475@hadrien>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021121950.GF2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:19:50PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > Prior to 5.8, my machine was using intel_pstate and had few background
> > tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> > the kernel decided that intel_cpufreq would be more appropriate, which
> > introduced kworkers every 0.004 seconds on all cores.
> 
> That still doesn't make any sense. Are you running the legacy on-demand
> thing or something?
> 
> Rafael, Srinivas, Viresh, how come it defaults to that?

Does we want something like this?

---
 arch/x86/configs/i386_defconfig   | 3 +--
 arch/x86/configs/x86_64_defconfig | 3 +--
 drivers/cpufreq/Kconfig           | 7 +++++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 78210793d357..c343ad459737 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -41,8 +41,7 @@ CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
 CONFIG_ACPI_DOCK=y
 CONFIG_ACPI_BGRT=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 9936528e1939..23e1ea85c1ec 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -38,8 +38,7 @@ CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
 CONFIG_ACPI_DOCK=y
 CONFIG_ACPI_BGRT=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_IA32_EMULATION=y
 CONFIG_EFI_VARS=y
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c7171e0b001..8dfca6e9b836 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -37,8 +37,7 @@ config CPU_FREQ_STAT
 choice
 	prompt "Default CPUFreq governor"
 	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
+	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if SMP
 	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
 	help
 	  This option sets which CPUFreq governor shall be loaded at
@@ -71,6 +70,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
 
 config CPU_FREQ_DEFAULT_GOV_ONDEMAND
 	bool "ondemand"
+	depends on !SMP
 	select CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_PERFORMANCE
 	help
@@ -83,6 +83,7 @@ config CPU_FREQ_DEFAULT_GOV_ONDEMAND
 
 config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
 	bool "conservative"
+	depends on !SMP
 	select CPU_FREQ_GOV_CONSERVATIVE
 	select CPU_FREQ_GOV_PERFORMANCE
 	help
@@ -144,6 +145,7 @@ config CPU_FREQ_GOV_USERSPACE
 
 config CPU_FREQ_GOV_ONDEMAND
 	tristate "'ondemand' cpufreq policy governor"
+	depends on !SMP
 	select CPU_FREQ_GOV_COMMON
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
@@ -163,6 +165,7 @@ config CPU_FREQ_GOV_ONDEMAND
 config CPU_FREQ_GOV_CONSERVATIVE
 	tristate "'conservative' cpufreq governor"
 	depends on CPU_FREQ
+	depends on !SMP
 	select CPU_FREQ_GOV_COMMON
 	help
 	  'conservative' - this driver is rather similar to the 'ondemand'
