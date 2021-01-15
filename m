Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F912F7ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbhAOPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:01:46 -0500
Received: from foss.arm.com ([217.140.110.172]:42286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAOPBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:01:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4E3D6E;
        Fri, 15 Jan 2021 07:00:58 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E1B3F70D;
        Fri, 15 Jan 2021 07:00:55 -0800 (PST)
Subject: Re: [PATCH 05/11] kasan, arm64: allow using KUnit tests with HW_TAGS
 mode
To:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1609871239.git.andreyknvl@google.com>
 <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e5d858ba-c2e3-e024-7398-008ec2d89236@arm.com>
Date:   Fri, 15 Jan 2021 15:04:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 1/5/21 6:27 PM, Andrey Konovalov wrote:
> On a high level, this patch allows running KUnit KASAN tests with the
> hardware tag-based KASAN mode.
> 
> Internally, this change reenables tag checking at the end of each KASAN
> test that triggers a tag fault and leads to tag checking being disabled.
> 
> With this patch KASAN tests are still failing for the hardware tag-based
> mode; fixes come in the next few patches.
> 

A part what Catalin noticed already:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Id94dc9eccd33b23cda4950be408c27f879e474c8
> ---
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h | 12 +++++++++
>  arch/arm64/kernel/mte.c            | 12 +++++++++
>  arch/arm64/mm/fault.c              | 16 +++++++-----
>  lib/Kconfig.kasan                  |  4 +--
>  lib/test_kasan.c                   | 42 +++++++++++++++++++++---------
>  mm/kasan/kasan.h                   |  9 +++++++
>  7 files changed, 75 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 18fce223b67b..cedfc9e97bcc 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -232,6 +232,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define arch_enable_tagging()			mte_enable_kernel()
> +#define arch_set_tagging_report_once(state)	mte_set_report_once(state)
>  #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
>  #define arch_get_random_tag()			mte_get_random_tag()
>  #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index 26349a4b5e2e..3748d5bb88c0 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -32,6 +32,9 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
>  void mte_enable_kernel(void);
>  void mte_init_tags(u64 max_tag);
>  
> +void mte_set_report_once(bool state);
> +bool mte_report_once(void);
> +
>  #else /* CONFIG_ARM64_MTE */
>  
>  static inline u8 mte_get_ptr_tag(void *ptr)
> @@ -60,6 +63,15 @@ static inline void mte_init_tags(u64 max_tag)
>  {
>  }
>  
> +static inline void mte_set_report_once(bool state)
> +{
> +}
> +
> +static inline bool mte_report_once(void)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_ARM64_MTE */
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index dc9ada64feed..c63b3d7a3cd9 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -25,6 +25,8 @@
>  
>  u64 gcr_kernel_excl __ro_after_init;
>  
> +static bool report_fault_once = true;
> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -158,6 +160,16 @@ void mte_enable_kernel(void)
>  	isb();
>  }
>  
> +void mte_set_report_once(bool state)
> +{
> +	WRITE_ONCE(report_fault_once, state);
> +}
> +
> +bool mte_report_once(void)
> +{
> +	return READ_ONCE(report_fault_once);
> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3c40da479899..57d3f165d907 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -302,12 +302,20 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  static void report_tag_fault(unsigned long addr, unsigned int esr,
>  			     struct pt_regs *regs)
>  {
> -	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> +	static bool reported;
> +	bool is_write;
> +
> +	if (READ_ONCE(reported))
> +		return;
> +
> +	if (mte_report_once())
> +		WRITE_ONCE(reported, true);
>  
>  	/*
>  	 * SAS bits aren't set for all faults reported in EL1, so we can't
>  	 * find out access size.
>  	 */
> +	is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
>  	kasan_report(addr, 0, is_write, regs->pc);
>  }
>  #else
> @@ -319,12 +327,8 @@ static inline void report_tag_fault(unsigned long addr, unsigned int esr,
>  static void do_tag_recovery(unsigned long addr, unsigned int esr,
>  			   struct pt_regs *regs)
>  {
> -	static bool reported;
>  
> -	if (!READ_ONCE(reported)) {
> -		report_tag_fault(addr, esr, regs);
> -		WRITE_ONCE(reported, true);
> -	}
> +	report_tag_fault(addr, esr, regs);
>  
>  	/*
>  	 * Disable MTE Tag Checking on the local CPU for the current EL.
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f5fa4ba126bf..3091432acb0a 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -190,11 +190,11 @@ config KASAN_KUNIT_TEST
>  	  kernel debugging features like KASAN.
>  
>  	  For more information on KUnit and unit tests in general, please refer
> -	  to the KUnit documentation in Documentation/dev-tools/kunit
> +	  to the KUnit documentation in Documentation/dev-tools/kunit.
>  
>  config TEST_KASAN_MODULE
>  	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
> -	depends on m && KASAN
> +	depends on m && KASAN && !KASAN_HW_TAGS
>  	help
>  	  This is a part of the KASAN test suite that is incompatible with
>  	  KUnit. Currently includes tests that do bad copy_from/to_user
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index f1eda0bcc780..dd3d2f95c24e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -41,16 +41,20 @@ static bool multishot;
>  
>  /*
>   * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
> - * first detected bug and panic the kernel if panic_on_warn is enabled.
> + * first detected bug and panic the kernel if panic_on_warn is enabled. For
> + * hardware tag-based KASAN also allow tag checking to be reenabled for each
> + * test, see the comment for KUNIT_EXPECT_KASAN_FAIL().
>   */
>  static int kasan_test_init(struct kunit *test)
>  {
>  	multishot = kasan_save_enable_multi_shot();
> +	hw_set_tagging_report_once(false);
>  	return 0;
>  }
>  
>  static void kasan_test_exit(struct kunit *test)
>  {
> +	hw_set_tagging_report_once(true);
>  	kasan_restore_multi_shot(multishot);
>  }
>  
> @@ -59,19 +63,31 @@ static void kasan_test_exit(struct kunit *test)
>   * KASAN report; causes a test failure otherwise. This relies on a KUnit
>   * resource named "kasan_data". Do not use this name for KUnit resources
>   * outside of KASAN tests.
> + *
> + * For hardware tag-based KASAN, when a tag fault happens, tag checking is
> + * normally auto-disabled. When this happens, this test handler reenables
> + * tag checking. As tag checking can be only disabled or enabled per CPU, this
> + * handler disables migration (preemption).
>   */
> -#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do { \
> -	fail_data.report_expected = true; \
> -	fail_data.report_found = false; \
> -	kunit_add_named_resource(test, \
> -				NULL, \
> -				NULL, \
> -				&resource, \
> -				"kasan_data", &fail_data); \
> -	expression; \
> -	KUNIT_EXPECT_EQ(test, \
> -			fail_data.report_expected, \
> -			fail_data.report_found); \
> +#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {		\
> +	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))			\
> +		migrate_disable();				\
> +	fail_data.report_expected = true;			\
> +	fail_data.report_found = false;				\
> +	kunit_add_named_resource(test,				\
> +				NULL,				\
> +				NULL,				\
> +				&resource,			\
> +				"kasan_data", &fail_data);	\
> +	expression;						\
> +	KUNIT_EXPECT_EQ(test,					\
> +			fail_data.report_expected,		\
> +			fail_data.report_found);		\
> +	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
> +		if (fail_data.report_found)			\
> +			hw_enable_tagging();			\
> +		migrate_enable();				\
> +	}							\
>  } while (0)
>  
>  static void kmalloc_oob_right(struct kunit *test)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index c3fb9bf241d3..292dfbc37deb 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -280,6 +280,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #ifndef arch_init_tags
>  #define arch_init_tags(max_tag)
>  #endif
> +#ifndef arch_set_tagging_report_once
> +#define arch_set_tagging_report_once(state)
> +#endif
>  #ifndef arch_get_random_tag
>  #define arch_get_random_tag()	(0xFF)
>  #endif
> @@ -292,10 +295,16 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  
>  #define hw_enable_tagging()			arch_enable_tagging()
>  #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
> +#define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
>  #define hw_get_random_tag()			arch_get_random_tag()
>  #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
>  #define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
>  
> +#else /* CONFIG_KASAN_HW_TAGS */
> +
> +#define hw_enable_tagging()
> +#define hw_set_tagging_report_once(state)
> +
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
>  #ifdef CONFIG_KASAN_SW_TAGS
> 

-- 
Regards,
Vincenzo
