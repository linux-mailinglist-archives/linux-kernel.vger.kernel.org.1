Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC22B262C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKMVDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgKMVDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:03:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEDCC0613D1;
        Fri, 13 Nov 2020 13:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OBsI07erNTyixYReomvholKl84/3CHg5ng3ksTR0ogM=; b=tpTL6ggJ9Axrh2n6ooTVLHMEwJ
        T0gw8n5WEpQq1R6NytBCCecHOjwiZkDOnNCG5gAyGiR7b7TRJuT1gIU5wCzX3gLvjWuVNIC/WiWeJ
        4TUCRf6Dlqy4BpbNfd6d4pIU43tDt268AFc6F6dBDy+4gc3rGRy1JhzM+f/J35SDaxv3UrUecqt/R
        ZSovjWhw4t9Jyz+yTa7WcGohvDaZ4YoWdwG1R4la3QFCW8BIvXyTHCNBd1uDK6QbfX4rqEMLKP3PI
        7ChD8TyvNWpWAbTDTd8218uKWaLtdHJTh8UZ+fRtXwprA4yTG2qOk/05AYf7fzVKahn9BORXkxeXB
        8iSepNgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdgEB-0003uP-Eg; Fri, 13 Nov 2020 21:03:27 +0000
Date:   Fri, 13 Nov 2020 21:03:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201113210327.GJ17076@casper.infradead.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +==========================
> +Sequence Number Operations
> +==========================
> +
> +:Author: Shuah Khan
> +:Copyright: |copy| 2020, The Linux Foundation
> +:Copyright: |copy| 2020, Shuah Khan <skhan@linuxfoundation.org>
> +
> +Sequence Number api provides interfaces for unsigned up counters
> +leveraging atomic_t and atomic64_t ops underneath.

As I said last time you posted this, the documentation is all
back-to-front.  You're describing what it isn't, not what it is.

> +There are a number of atomic_t usages in the kernel where atomic_t api
> +is used for counting sequence numbers and other statistical counters.
> +Several of these usages, convert atomic_read() and atomic_inc_return()
> +return values to unsigned. Introducing sequence number ops supports
> +these use-cases with a standard core-api.
> +
> +The atomic_t api provides a wide range of atomic operations as a base
> +api to implement atomic counters, bitops, spinlock interfaces. The usages
> +also evolved into being used for resource lifetimes and state management.
> +The refcount_t api was introduced to address resource lifetime problems
> +related to atomic_t wrapping. There is a large overlap between the
> +atomic_t api used for resource lifetimes and just counters, stats, and
> +sequence numbers. It has become difficult to differentiate between the
> +atomic_t usages that should be converted to refcount_t and the ones that
> +can be left alone. Introducing seqnum_ops to wrap the usages that are
> +stats, counters, sequence numbers makes it easier for tools that scan
> +for underflow and overflow on atomic_t usages to detect overflow and
> +underflows to scan just the cases that are prone to errors.
> +
> +In addition, to supporting sequence number use-cases, Sequence Number Ops
> +helps differentiate atomic_t counter usages from atomic_t usages that guard
> +object lifetimes, hence prone to overflow and underflow errors from up
> +counting use-cases.

I think almost all of this information should go into atomic_ops.rst
pushing people towards using the other APIs instead of atomic_t.
Someone who already landed here doesn't want to read about refcount_t.
They want to know what a seqnum_t is and how to use it.

> +Sequence Number Ops
> +===================
> +
> +seqnum32 and seqnum64 types use atomic_t and atomic64_t underneath to

Don't talk about the implementation.

> +leverage atomic_t api, to provide increment by 1 and return new value
> +and fetch current value interfaces necessary to support unsigned up
> +counters. ::
> +
> +        struct seqnum32 { atomic_t seqnum; };
> +        struct seqnum64 { atomic64_t seqnum; };
> +
> +Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
> +information on the Semantics and Behavior of Atomic operations.
> +
> +Initializers
> +------------
> +
> +Interfaces for initializing sequence numbers are write operations which
> +in turn invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
> +
> +        #define SEQNUM_INIT(i)    { .seqnum = ATOMIC_INIT(i) }
> +        seqnum32_init() --> atomic_set() to 0
> +        seqnum64_init() --> atomic64_set() to 0
> +
> +Increment interface
> +-------------------
> +
> +Increments sequence number and returns the new value. ::
> +
> +        seqnum32_inc_return() --> (u32) atomic_inc_return(seqnum)
> +        seqnum64_inc_return() --> (u64) atomic64_inc_return(seqnum)

seqnum_inc() should just return the new value -- seqnum_inc_return is
too verbose.  And do we not need a seqnum_add()?

Also, this would be a good point to talk about behaviour on overflow.

> +Fetch interface
> +---------------
> +
> +Fetched and returns current sequence number value. ::
> +
> +        seqnum32_fetch() --> (u32) atomic_add_return(0, seqnum)
> +        seqnum64_fetch() --> (u64) atomic64_add_return(0, seqnum)

Er ... why would you force an atomic operation instead of atomic_read()?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b516bb34a8d5..c83a6f05610b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15977,6 +15977,13 @@ S:	Maintained
>  F:	Documentation/fb/sm712fb.rst
>  F:	drivers/video/fbdev/sm712*
>  
> +SEQNUM OPS
> +M:	Shuah Khan <skhan@linuxfoundation.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	include/linux/seqnum_ops.h
> +F:	lib/test_seqnum_ops.c
> +
>  SIMPLE FIRMWARE INTERFACE (SFI)
>  S:	Obsolete
>  W:	http://simplefirmware.org/
> diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
> new file mode 100644
> index 000000000000..17d327b78050
> --- /dev/null
> +++ b/include/linux/seqnum_ops.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * seqnum_ops.h - Interfaces for sequential and statistical counters.
> + *
> + * Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
> + * Copyright (c) 2020 The Linux Foundation
> + *
> + * Sequence Number functions provide support for unsgined atomic up
> + * counters.
> + *
> + * The interface provides:
> + * seqnumu32 & seqnumu64 functions:
> + *	initialization
> + *	increment and return
> + *	fetch and return
> + *
> + * seqnumu32 and seqnumu64 functions leverage/use atomic*_t ops to
> + * implement support for unsigned atomic up counters.
> + *
> + * Reference and API guide:
> + *	Documentation/core-api/seqnum_ops.rst for more information.
> + */
> +
> +#ifndef __LINUX_SEQNUM_OPS_H
> +#define __LINUX_SEQNUM_OPS_H
> +
> +#include <linux/atomic.h>
> +
> +/**
> + * struct seqnum32 - Sequential/Statistical atomic counter
> + * @seqnum: atomic_t
> + *
> + **/
> +struct seqnum32 {
> +	atomic_t seqnum;
> +};
> +
> +#define SEQNUM_INIT(i)		{ .seqnum = ATOMIC_INIT(i) }
> +
> +/*
> + * seqnum32_init() - initialize seqnum value
> + * @seq: struct seqnum32 pointer
> + *
> + */
> +static inline void seqnum32_init(struct seqnum32 *seq)
> +{
> +	atomic_set(&seq->seqnum, 0);
> +}
> +
> +/*
> + * seqnum32_inc_return() - increment seqnum value and return the new value
> + * @seq: struct seqnum32 pointer
> + *
> + * Return u32
> + */
> +static inline u32 seqnum32_inc_return(struct seqnum32 *seq)
> +{
> +	return (u32) atomic_inc_return(&seq->seqnum);
> +}
> +
> +/*
> + * seqnum32_fetch() - return the current value
> + * @seq: struct seqnum32 pointer
> + *
> + * Return u32
> + */
> +static inline u32 seqnum32_fetch(struct seqnum32 *seq)
> +{
> +	return (u32) atomic_add_return(0, &seq->seqnum);
> +}
> +
> +#ifdef CONFIG_64BIT
> +/* atomic64_t is defined in CONFIG_64BIT in include/linux/types.h */
> +/*
> + * struct seqnum64 - Sequential/Statistical atomic counter
> + * @seq: atomic64_t
> + *
> + */
> +struct seqnum64 {
> +	atomic64_t seqnum;
> +};
> +
> +/*
> + * seqnum64_init() - initialize seqnum value
> + * @seq: struct seqnum64 pointer
> + *
> + */
> +static inline void seqnum64_init(struct seqnum64 *seq)
> +{
> +	atomic64_set(&seq->seqnum, 0);
> +}
> +
> +/*
> + * seqnum64_inc() - increment seqnum value and return the new value
> + * @seq: struct seqnum64 pointer
> + *
> + * Return u64
> + */
> +static inline u64 seqnum64_inc_return(struct seqnum64 *seq)
> +{
> +	return (u64) atomic64_inc_return(&seq->seqnum);
> +}
> +
> +/*
> + * seqnum64_fetch() - return the current value
> + * @seq: struct seqnum64 pointer
> + *
> + * Return u64
> + */
> +static inline u64 seqnum64_fetch(struct seqnum64 *seq)
> +{
> +	return (u64) atomic64_add_return(0, &seq->seqnum);
> +}
> +#endif /* CONFIG_64BIT */
> +
> +#endif /* __LINUX_SEQNUM_OPS_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b46a9fd122c8..c362c2713e11 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -663,6 +663,15 @@ config OBJAGG
>  config STRING_SELFTEST
>  	tristate "Test string functions"
>  
> +config TEST_SEQNUM_OPS
> +	tristate "Test Sequence Number Ops API"
> +	help
> +	   A test module for Sequence Number Ops API. A corresponding
> +	   selftest can be used to test the Seqnum Ops API. Select this
> +	   for testing Sequence Number Ops API.
> +
> +	   See Documentation/core-api/seqnum_ops.rst
> +
>  endmenu
>  
>  config GENERIC_IOREMAP
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a..7d17c25e4d73 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
>  obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
> +obj-$(CONFIG_TEST_SEQNUM_OPS) += test_seqnum_ops.o
>  
>  #
>  # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
> diff --git a/lib/test_seqnum_ops.c b/lib/test_seqnum_ops.c
> new file mode 100644
> index 000000000000..6e58b6a0a2be
> --- /dev/null
> +++ b/lib/test_seqnum_ops.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * test_seqnum_ops.c - Kernel module for testing Seqnum API
> + *
> + * Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
> + * Copyright (c) 2020 The Linux Foundation
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/seqnum_ops.h>
> +
> +static inline void
> +test_seqnum32_result(char *msg, u32 start, u32 end, u32 expected)
> +{
> +	pr_info("%s: %u to %u - %s\n",
> +		msg, start, end,
> +		((expected == end) ? "PASS" : "FAIL"));
> +}
> +
> +
> +static void test_seqnum32(void)
> +{
> +	static struct seqnum32 seq = SEQNUM_INIT(0);
> +	u32 start_val = seqnum32_fetch(&seq);
> +	u32 end_val;
> +
> +	end_val = seqnum32_inc_return(&seq);
> +	test_seqnum32_result("Test fetch and increment",
> +			     start_val, end_val, start_val+1);
> +
> +	start_val = seqnum32_fetch(&seq);
> +	seqnum32_init(&seq);
> +	end_val = seqnum32_fetch(&seq);
> +	test_seqnum32_result("Test init", start_val, end_val, 0);
> +
> +}
> +
> +static void test_seqnum32_overflow(void)
> +{
> +	static struct seqnum32 seq = SEQNUM_INIT(UINT_MAX-1);
> +	u32 start_val = seqnum32_fetch(&seq);
> +	u32 end_val = seqnum32_inc_return(&seq);
> +
> +	test_seqnum32_result("Test UINT_MAX limit compare with (val+1)",
> +			     start_val, end_val, start_val+1);
> +
> +	test_seqnum32_result("Test UINT_MAX limit compare with (UINT_MAX)",
> +			     start_val, end_val, UINT_MAX);
> +}
> +
> +#ifdef CONFIG_64BIT
> +static inline void
> +test_seqnum64_result(char *msg, u64 start, u64 end, u64 expected)
> +{
> +	pr_info("%s: %llu to %llu - %s\n",
> +		msg, start, end,
> +		((expected == end) ? "PASS" : "FAIL"));
> +}
> +
> +static void test_seqnum64(void)
> +{
> +	static struct seqnum64 seq = SEQNUM_INIT(0);
> +	u64 start_val = seqnum64_fetch(&seq);
> +	u64 end_val;
> +
> +	end_val = seqnum64_inc_return(&seq);
> +	test_seqnum64_result("Test fetch and increment",
> +			     start_val, end_val, start_val+1);
> +
> +	start_val = seqnum64_fetch(&seq);
> +	seqnum64_init(&seq);
> +	end_val = seqnum64_fetch(&seq);
> +	test_seqnum64_result("Test init", start_val, end_val, 0);
> +}
> +
> +static void test_seqnum64_overflow(void)
> +{
> +	static struct seqnum64 seq = SEQNUM_INIT(UINT_MAX-1);
> +	u64 start_val = seqnum64_fetch(&seq);
> +	u64 end_val = seqnum64_inc_return(&seq);
> +
> +	test_seqnum64_result("Test UINT_MAX limit compare with (val+1)",
> +			     start_val, end_val, start_val+1);
> +	test_seqnum64_result("Test UINT_MAX limit compare with (UINT_MAX)",
> +			     start_val, end_val, UINT_MAX);
> +}
> +#endif /* CONFIG_64BIT */
> +
> +static int __init test_seqnum_ops_init(void)
> +{
> +	pr_info("Start seqnum32_*() interfaces test\n");
> +	test_seqnum32();
> +	test_seqnum32_overflow();
> +	pr_info("End seqnum32_*() interfaces test\n\n");
> +
> +#ifdef CONFIG_64BIT
> +	pr_info("Start seqnum64_*() interfaces test\n");
> +	test_seqnum64();
> +	test_seqnum64_overflow();
> +	pr_info("End seqnum64_*() interfaces test\n\n");
> +#endif /* CONFIG_64BIT */
> +
> +	return 0;
> +}
> +
> +module_init(test_seqnum_ops_init);
> +
> +static void __exit test_seqnum_ops_exit(void)
> +{
> +	pr_info("exiting.\n");
> +}
> +
> +module_exit(test_seqnum_ops_exit);
> +
> +MODULE_AUTHOR("Shuah Khan <skhan@linuxfoundation.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.27.0
> 
