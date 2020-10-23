Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC64296C14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461449AbgJWJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461430AbgJWJ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:27:05 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A8D2225F;
        Fri, 23 Oct 2020 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603445218;
        bh=Y/EvzImq3B1xz5svfUDv//FLlpSPB+dR8mDx9lOkUSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHA6SZJrggzlUMAituX/7P4WD7EgPYtzkYu1lKlaU7er9kzLQ+jFlYAC86w+cbbQP
         feEbk9cvw5Csw21Mg/oHLsnjc9B0LIDHLlT5WuertfB8H1S5Dw1kafgN3hsKWDiVOn
         4xnjz1aON/V4MPc1UCzZFF3Ck/EQoWQLNgHWX8zA=
Date:   Fri, 23 Oct 2020 11:26:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel-doc: validate kernel-doc markup with the
 actual names
Message-ID: <20201023112653.6a6e2c3c@coco.lan>
In-Reply-To: <ebd075324a26f07b801cc47465cff51e9bf5c115.1603443534.git.mchehab+huawei@kernel.org>
References: <ebd075324a26f07b801cc47465cff51e9bf5c115.1603443534.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Oct 2020 10:59:02 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Kernel-doc currently expects that the kernel-doc markup to come
> just before the function/enum/struct/union/typedef prototype.
> 
> Yet, if it find things like:
> 
> 	/**
> 	 * refcount_add - add a value to a refcount
> 	 * @i: the value to add to the refcount
> 	 * @r: the refcount
> 	 */
> 	static inline void __refcount_add(int i, refcount_t *r, int *oldp);
> 	static inline void refcount_add(int i, refcount_t *r);
> 
> Kernel-doc will do the wrong thing:
> 
> 	foobar.h:6: warning: Function parameter or member 'oldp' not described in '__refcount_add'
> 	.. c:function:: void __refcount_add (int i, refcount_t *r, int *oldp)
> 
> 	   add a value to a refcount
> 
> 	**Parameters**
> 
> 	``int i``
> 	  the value to add to the refcount
> 
> 	``refcount_t *r``
> 	  the refcount
> 
> 	``int *oldp``
> 	  *undescribed*
> 
> Basically, it will document "__refcount_add" with the kernel-doc
> markup for refcount_add.
> 
> If both functions have the same arguments, this won't even
> produce any warning!
> 
> Add a logic to check if the kernel-doc identifier matches the actual
> name of the C function or data structure that will be documented.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Jon,

If this patch gets applied, a huge amount of warnings will be
produced (see enclosed).

I didn't check all of them, but it sounds that there are a large amount
of kernel-doc markups that have mistakes, on several categories.

As expected, there are several functions or data structures whose
kernel-doc prototype doesn't match the name of the data declaration
or function prototype, like:

	fs/pstore/zone.c:39: warning: expecting prototype for struct psz_head. Prototype was for struct psz_buffer instead
	kernel/irq/generic-chip.c:287: warning: expecting prototype for __irq_alloc_domain_generic_chip(). Prototype was for __irq_alloc_domain_generic_chips() instead

I guess most of those markups are ok, except for the function name,
but some care should be taken here in order to double-check them, as
I bet that some of the Kernel-doc markups are at the wrong places.

2) broken kernel-doc markups.

   For example, ipu3 has two structs declared as "struct struct foo":

	drivers/staging/media/ipu3/include/intel-ipu3.h:1526: warning: expecting prototype for struct struct. Prototype was for struct ipu3_uapi_far_w instead
	drivers/staging/media/ipu3/include/intel-ipu3.h:1543: warning: expecting prototype for struct struct. Prototype was for struct ipu3_uapi_unsharp_cfg instead

   Another example: kselftest uses its own format on several declarations:

	tools/testing/selftests/kselftest_harness.h:82: warning: wrong kernel-doc identifier on line:
	 * TH_LOG(fmt, ...)

   Right now, this shouldn't be causing any real harm, except that
   it breaks the new validation code, but, again, some of those
   could be misplaced.

3) There are several files that don't contain the first line with an
   identifier and a function summary, but, instead, they start with a
   description, like this one:

	/**
	 * Finds the lowest iomem resource that covers part of [@start..@end].  The
	 * caller must specify @start, @end, @flags, and @desc (which may be
	 * IORES_DESC_NONE).
	...
	 */
	static int find_next_iomem_res(resource_size_t start, resource_size_t end,
				       unsigned long flags, unsigned long desc,
				       bool first_lvl, struct resource *res)

   Those are likely the worse case, as the Kernel-doc script will very
   likely be producing a broken markup, if the markup is completely 
   violating the expected format.

Thanks,
Mauro

../fs/pstore/zone.c:39: warning: expecting prototype for struct psz_head. Prototype was for struct psz_buffer instead
../kernel/irq/generic-chip.c:287: warning: expecting prototype for __irq_alloc_domain_generic_chip(). Prototype was for __irq_alloc_domain_generic_chips() instead
../drivers/rapidio/rio.c:758: warning: expecting prototype for rio_unmap_inb_region(). Prototype was for rio_unmap_outb_region() instead
../kernel/irq/chip.c:69: warning: expecting prototype for irq_set_type(). Prototype was for irq_set_irq_type() instead
../include/linux/memblock.h:292: warning: expecting prototype for for_each_free_mem_range_in_zone(). Prototype was for for_each_free_mem_pfn_range_in_zone() instead
../include/linux/memblock.h:308: warning: expecting prototype for for_each_free_mem_range_in_zone_from(). Prototype was for for_each_free_mem_pfn_range_in_zone_from() instead
../kernel/irq/chip.c:69: warning: expecting prototype for irq_set_type(). Prototype was for irq_set_irq_type() instead
../drivers/rapidio/rio.c:758: warning: expecting prototype for rio_unmap_inb_region(). Prototype was for rio_unmap_outb_region() instead
../drivers/staging/media/ipu3/include/intel-ipu3.h:428: warning: expecting prototype for struct ipu3_uapi_awb_fr_meta_data. Prototype was for struct ipu3_uapi_awb_fr_raw_buffer instead
../drivers/staging/media/ipu3/include/intel-ipu3.h:1526: warning: expecting prototype for struct struct. Prototype was for struct ipu3_uapi_far_w instead
../drivers/staging/media/ipu3/include/intel-ipu3.h:1543: warning: expecting prototype for struct struct. Prototype was for struct ipu3_uapi_unsharp_cfg instead
../drivers/staging/media/ipu3/include/intel-ipu3.h:1783: warning: expecting prototype for struct ipu3_uapi_yuvp1_iefd_vssnlm_cf. Prototype was for struct ipu3_uapi_yuvp1_iefd_vssnlm_cfg instead
../include/linux/list.h:910: warning: expecting prototype for hlist_add_behing(). Prototype was for hlist_add_behind() instead
../tools/testing/selftests/kselftest_harness.h:82: warning: wrong kernel-doc identifier on line:
 * TH_LOG(fmt, ...)
../tools/testing/selftests/kselftest_harness.h:116: warning: wrong kernel-doc identifier on line:
 * SKIP(statement, fmt, ...)
../tools/testing/selftests/kselftest_harness.h:139: warning: wrong kernel-doc identifier on line:
 * TEST(test_name) - Defines the test function and creates the registration
../tools/testing/selftests/kselftest_harness.h:158: warning: wrong kernel-doc identifier on line:
 * TEST_SIGNAL(test_name, signal)
../tools/testing/selftests/kselftest_harness.h:198: warning: wrong kernel-doc identifier on line:
 * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
../tools/testing/selftests/kselftest_harness.h:215: warning: wrong kernel-doc identifier on line:
 * FIXTURE(fixture_name) - Called once per fixture to setup the data and
../tools/testing/selftests/kselftest_harness.h:242: warning: wrong kernel-doc identifier on line:
 * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
../tools/testing/selftests/kselftest_harness.h:268: warning: wrong kernel-doc identifier on line:
 * FIXTURE_TEARDOWN(fixture_name)
../tools/testing/selftests/kselftest_harness.h:289: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
../tools/testing/selftests/kselftest_harness.h:308: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
../tools/testing/selftests/kselftest_harness.h:342: warning: wrong kernel-doc identifier on line:
 * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
../tools/testing/selftests/kselftest_harness.h:435: warning: wrong kernel-doc identifier on line:
 * ASSERT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:446: warning: wrong kernel-doc identifier on line:
 * ASSERT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:457: warning: wrong kernel-doc identifier on line:
 * ASSERT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:468: warning: wrong kernel-doc identifier on line:
 * ASSERT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:479: warning: wrong kernel-doc identifier on line:
 * ASSERT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:490: warning: wrong kernel-doc identifier on line:
 * ASSERT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:501: warning: wrong kernel-doc identifier on line:
 * ASSERT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:511: warning: wrong kernel-doc identifier on line:
 * ASSERT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:521: warning: wrong kernel-doc identifier on line:
 * ASSERT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:531: warning: wrong kernel-doc identifier on line:
 * ASSERT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:542: warning: wrong kernel-doc identifier on line:
 * ASSERT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:553: warning: wrong kernel-doc identifier on line:
 * EXPECT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:564: warning: wrong kernel-doc identifier on line:
 * EXPECT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:575: warning: wrong kernel-doc identifier on line:
 * EXPECT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:586: warning: wrong kernel-doc identifier on line:
 * EXPECT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:597: warning: wrong kernel-doc identifier on line:
 * EXPECT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:608: warning: wrong kernel-doc identifier on line:
 * EXPECT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:619: warning: wrong kernel-doc identifier on line:
 * EXPECT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:629: warning: wrong kernel-doc identifier on line:
 * EXPECT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:639: warning: wrong kernel-doc identifier on line:
 * EXPECT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:649: warning: wrong kernel-doc identifier on line:
 * EXPECT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:660: warning: wrong kernel-doc identifier on line:
 * EXPECT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:82: warning: wrong kernel-doc identifier on line:
 * TH_LOG(fmt, ...)
../tools/testing/selftests/kselftest_harness.h:116: warning: wrong kernel-doc identifier on line:
 * SKIP(statement, fmt, ...)
../tools/testing/selftests/kselftest_harness.h:139: warning: wrong kernel-doc identifier on line:
 * TEST(test_name) - Defines the test function and creates the registration
../tools/testing/selftests/kselftest_harness.h:158: warning: wrong kernel-doc identifier on line:
 * TEST_SIGNAL(test_name, signal)
../tools/testing/selftests/kselftest_harness.h:198: warning: wrong kernel-doc identifier on line:
 * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
../tools/testing/selftests/kselftest_harness.h:215: warning: wrong kernel-doc identifier on line:
 * FIXTURE(fixture_name) - Called once per fixture to setup the data and
../tools/testing/selftests/kselftest_harness.h:242: warning: wrong kernel-doc identifier on line:
 * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
../tools/testing/selftests/kselftest_harness.h:268: warning: wrong kernel-doc identifier on line:
 * FIXTURE_TEARDOWN(fixture_name)
../tools/testing/selftests/kselftest_harness.h:289: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
../tools/testing/selftests/kselftest_harness.h:308: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
../tools/testing/selftests/kselftest_harness.h:342: warning: wrong kernel-doc identifier on line:
 * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
../tools/testing/selftests/kselftest_harness.h:435: warning: wrong kernel-doc identifier on line:
 * ASSERT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:446: warning: wrong kernel-doc identifier on line:
 * ASSERT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:457: warning: wrong kernel-doc identifier on line:
 * ASSERT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:468: warning: wrong kernel-doc identifier on line:
 * ASSERT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:479: warning: wrong kernel-doc identifier on line:
 * ASSERT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:490: warning: wrong kernel-doc identifier on line:
 * ASSERT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:501: warning: wrong kernel-doc identifier on line:
 * ASSERT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:511: warning: wrong kernel-doc identifier on line:
 * ASSERT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:521: warning: wrong kernel-doc identifier on line:
 * ASSERT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:531: warning: wrong kernel-doc identifier on line:
 * ASSERT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:542: warning: wrong kernel-doc identifier on line:
 * ASSERT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:553: warning: wrong kernel-doc identifier on line:
 * EXPECT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:564: warning: wrong kernel-doc identifier on line:
 * EXPECT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:575: warning: wrong kernel-doc identifier on line:
 * EXPECT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:586: warning: wrong kernel-doc identifier on line:
 * EXPECT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:597: warning: wrong kernel-doc identifier on line:
 * EXPECT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:608: warning: wrong kernel-doc identifier on line:
 * EXPECT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:619: warning: wrong kernel-doc identifier on line:
 * EXPECT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:629: warning: wrong kernel-doc identifier on line:
 * EXPECT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:639: warning: wrong kernel-doc identifier on line:
 * EXPECT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:649: warning: wrong kernel-doc identifier on line:
 * EXPECT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:660: warning: wrong kernel-doc identifier on line:
 * EXPECT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:82: warning: wrong kernel-doc identifier on line:
 * TH_LOG(fmt, ...)
../tools/testing/selftests/kselftest_harness.h:116: warning: wrong kernel-doc identifier on line:
 * SKIP(statement, fmt, ...)
../tools/testing/selftests/kselftest_harness.h:139: warning: wrong kernel-doc identifier on line:
 * TEST(test_name) - Defines the test function and creates the registration
../tools/testing/selftests/kselftest_harness.h:158: warning: wrong kernel-doc identifier on line:
 * TEST_SIGNAL(test_name, signal)
../tools/testing/selftests/kselftest_harness.h:198: warning: wrong kernel-doc identifier on line:
 * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
../tools/testing/selftests/kselftest_harness.h:215: warning: wrong kernel-doc identifier on line:
 * FIXTURE(fixture_name) - Called once per fixture to setup the data and
../tools/testing/selftests/kselftest_harness.h:242: warning: wrong kernel-doc identifier on line:
 * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
../tools/testing/selftests/kselftest_harness.h:268: warning: wrong kernel-doc identifier on line:
 * FIXTURE_TEARDOWN(fixture_name)
../tools/testing/selftests/kselftest_harness.h:289: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
../tools/testing/selftests/kselftest_harness.h:308: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
../tools/testing/selftests/kselftest_harness.h:342: warning: wrong kernel-doc identifier on line:
 * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
../tools/testing/selftests/kselftest_harness.h:435: warning: wrong kernel-doc identifier on line:
 * ASSERT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:446: warning: wrong kernel-doc identifier on line:
 * ASSERT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:457: warning: wrong kernel-doc identifier on line:
 * ASSERT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:468: warning: wrong kernel-doc identifier on line:
 * ASSERT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:479: warning: wrong kernel-doc identifier on line:
 * ASSERT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:490: warning: wrong kernel-doc identifier on line:
 * ASSERT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:501: warning: wrong kernel-doc identifier on line:
 * ASSERT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:511: warning: wrong kernel-doc identifier on line:
 * ASSERT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:521: warning: wrong kernel-doc identifier on line:
 * ASSERT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:531: warning: wrong kernel-doc identifier on line:
 * ASSERT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:542: warning: wrong kernel-doc identifier on line:
 * ASSERT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:553: warning: wrong kernel-doc identifier on line:
 * EXPECT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:564: warning: wrong kernel-doc identifier on line:
 * EXPECT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:575: warning: wrong kernel-doc identifier on line:
 * EXPECT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:586: warning: wrong kernel-doc identifier on line:
 * EXPECT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:597: warning: wrong kernel-doc identifier on line:
 * EXPECT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:608: warning: wrong kernel-doc identifier on line:
 * EXPECT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:619: warning: wrong kernel-doc identifier on line:
 * EXPECT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:629: warning: wrong kernel-doc identifier on line:
 * EXPECT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:639: warning: wrong kernel-doc identifier on line:
 * EXPECT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:649: warning: wrong kernel-doc identifier on line:
 * EXPECT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:660: warning: wrong kernel-doc identifier on line:
 * EXPECT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:82: warning: wrong kernel-doc identifier on line:
 * TH_LOG(fmt, ...)
../tools/testing/selftests/kselftest_harness.h:116: warning: wrong kernel-doc identifier on line:
 * SKIP(statement, fmt, ...)
../tools/testing/selftests/kselftest_harness.h:139: warning: wrong kernel-doc identifier on line:
 * TEST(test_name) - Defines the test function and creates the registration
../tools/testing/selftests/kselftest_harness.h:158: warning: wrong kernel-doc identifier on line:
 * TEST_SIGNAL(test_name, signal)
../tools/testing/selftests/kselftest_harness.h:198: warning: wrong kernel-doc identifier on line:
 * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
../tools/testing/selftests/kselftest_harness.h:215: warning: wrong kernel-doc identifier on line:
 * FIXTURE(fixture_name) - Called once per fixture to setup the data and
../tools/testing/selftests/kselftest_harness.h:242: warning: wrong kernel-doc identifier on line:
 * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
../tools/testing/selftests/kselftest_harness.h:268: warning: wrong kernel-doc identifier on line:
 * FIXTURE_TEARDOWN(fixture_name)
../tools/testing/selftests/kselftest_harness.h:289: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
../tools/testing/selftests/kselftest_harness.h:308: warning: wrong kernel-doc identifier on line:
 * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
../tools/testing/selftests/kselftest_harness.h:342: warning: wrong kernel-doc identifier on line:
 * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
../tools/testing/selftests/kselftest_harness.h:435: warning: wrong kernel-doc identifier on line:
 * ASSERT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:446: warning: wrong kernel-doc identifier on line:
 * ASSERT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:457: warning: wrong kernel-doc identifier on line:
 * ASSERT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:468: warning: wrong kernel-doc identifier on line:
 * ASSERT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:479: warning: wrong kernel-doc identifier on line:
 * ASSERT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:490: warning: wrong kernel-doc identifier on line:
 * ASSERT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:501: warning: wrong kernel-doc identifier on line:
 * ASSERT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:511: warning: wrong kernel-doc identifier on line:
 * ASSERT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:521: warning: wrong kernel-doc identifier on line:
 * ASSERT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:531: warning: wrong kernel-doc identifier on line:
 * ASSERT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:542: warning: wrong kernel-doc identifier on line:
 * ASSERT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:553: warning: wrong kernel-doc identifier on line:
 * EXPECT_EQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:564: warning: wrong kernel-doc identifier on line:
 * EXPECT_NE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:575: warning: wrong kernel-doc identifier on line:
 * EXPECT_LT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:586: warning: wrong kernel-doc identifier on line:
 * EXPECT_LE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:597: warning: wrong kernel-doc identifier on line:
 * EXPECT_GT(expected, seen)
../tools/testing/selftests/kselftest_harness.h:608: warning: wrong kernel-doc identifier on line:
 * EXPECT_GE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:619: warning: wrong kernel-doc identifier on line:
 * EXPECT_NULL(seen)
../tools/testing/selftests/kselftest_harness.h:629: warning: wrong kernel-doc identifier on line:
 * EXPECT_TRUE(seen)
../tools/testing/selftests/kselftest_harness.h:639: warning: wrong kernel-doc identifier on line:
 * EXPECT_FALSE(seen)
../tools/testing/selftests/kselftest_harness.h:649: warning: wrong kernel-doc identifier on line:
 * EXPECT_STREQ(expected, seen)
../tools/testing/selftests/kselftest_harness.h:660: warning: wrong kernel-doc identifier on line:
 * EXPECT_STRNE(expected, seen)
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_GT' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_NE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_STRNE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_LT' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_EQ' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_NULL' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_GE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_FALSE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_STREQ' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_LE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_TRUE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_GT' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_NE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_LT' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_STRNE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'ASSERT_GE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_EQ' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_NULL' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_TRUE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_STREQ' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_FALSE' not found
../tools/testing/selftests/kselftest_harness.h:1: warning: 'EXPECT_LE' not found
../lib/crc7.c:66: warning: expecting prototype for crc7(). Prototype was for crc7_be() instead
../lib/crc7.c:1: warning: no structured comments found
../kernel/resource.c:344: warning: expecting prototype for The(). Prototype was for find_next_iomem_res() instead
../kernel/resource.c:436: warning: expecting prototype for with matching resource(). Prototype was for walk_iomem_res_desc() instead
../kernel/resource.c:344: warning: expecting prototype for The(). Prototype was for find_next_iomem_res() instead
../kernel/resource.c:436: warning: expecting prototype for with matching resource(). Prototype was for walk_iomem_res_desc() instead
../arch/x86/kernel/cpu/mtrr/mtrr.c:819: warning: expecting prototype for Save current fixed(). Prototype was for mtrr_save_state() instead
../kernel/audit.c:533: warning: expecting prototype for kauditd_print_skb(). Prototype was for kauditd_printk_skb() instead
../sound/core/pcm_lib.c:499: warning: expecting prototype for snd_pcm_sync(). Prototype was for snd_pcm_set_sync() instead
../sound/core/pcm_native.c:121: warning: expecting prototype for snd_pcm_stream_lock(). Prototype was for snd_pcm_stream_unlock() instead
../sound/core/pcm_native.c:611: warning: expecting prototype for snd_pcm_hw_param_choose(). Prototype was for snd_pcm_hw_params_choose() instead
../include/sound/pcm.h:1296: warning: expecting prototype for snd_pcm_sgbuf_chunk_size(). Prototype was for snd_pcm_sgbuf_get_chunk_size() instead
../sound/core/pcm_dmaengine.c:365: warning: expecting prototype for snd_dmaengine_pcm_release_chan_close(). Prototype was for snd_dmaengine_pcm_close_release_chan() instead
../sound/core/control.c:1933: warning: expecting prototype for snd_ctl_unregister_ioctl(). Prototype was for snd_ctl_unregister_ioctl_compat() instead
../net/core/skbuff.c:847: warning: expecting prototype for consume_stateless_skb(). Prototype was for __consume_stateless_skb() instead
../include/linux/clk.h:160: warning: expecting prototype for clk_get_duty_cycle(). Prototype was for clk_get_scaled_duty_cycle() instead
../include/uapi/sound/compress_offload.h:165: warning: expecting prototype for compress path ioctl definitions(). Prototype was for SNDRV_COMPRESS_IOCTL_VERSION() instead
../net/core/datagram.c:723: warning: expecting prototype for skb_copy_and_csum_datagram_iter(). Prototype was for skb_copy_and_csum_datagram() instead
../sound/soc/soc-core.c:2349: warning: expecting prototype for snd_soc_unregister_dai(). Prototype was for snd_soc_unregister_dais() instead
../sound/soc/soc-dapm.c:1301: warning: expecting prototype for snd_soc_dapm_get_connected_widgets(). Prototype was for snd_soc_dapm_dai_get_connected_widgets() instead
../include/sound/core.h:335: warning: wrong kernel-doc identifier on line:
 * Suppress high rates of output when CONFIG_SND_DEBUG is enabled.
../net/sunrpc/rpc_pipe.c:803: warning: expecting prototype for rpc_mkpipe(). Prototype was for rpc_mkpipe_dentry() instead
../net/core/dev.c:6929: warning: expecting prototype for netdev_has_upper_dev_all(). Prototype was for netdev_has_upper_dev_all_rcu() instead
../net/core/dev.c:8165: warning: expecting prototype for netdev_lower_change(). Prototype was for netdev_lower_state_changed() instead
../net/ethernet/eth.c:279: warning: expecting prototype for eth_header_parser_protocol(). Prototype was for eth_header_parse_protocol() instead
../net/ethernet/eth.c:535: warning: expecting prototype for mac(). Prototype was for nvmem_get_mac_address() instead
../include/linux/netdevice.h:1570: warning: expecting prototype for enum net_device_priv_flags. Prototype was for enum netdev_priv_flags instead
../include/linux/netdevice.h:3587: warning: expecting prototype for netif_subqueue_stopped(). Prototype was for __netif_subqueue_stopped() instead
../drivers/net/phy/phy.c:497: warning: expecting prototype for phy_queue_state_machine(). Prototype was for phy_trigger_machine() instead
../drivers/net/phy/phy.c:497: warning: expecting prototype for phy_queue_state_machine(). Prototype was for phy_trigger_machine() instead
../drivers/net/phy/phy-c45.c:16: warning: expecting prototype for genphy_c45_setup_forced(). Prototype was for genphy_c45_pma_setup_forced() instead
../include/linux/seqlock.h:181: error: Cannot parse typedef!
../include/linux/seqlock.h:824: warning: wrong kernel-doc identifier on line:
 * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
../mm/gup.c:1963: warning: expecting prototype for is suitable to replace the form(). Prototype was for get_user_pages_locked() instead
../drivers/net/phy/phy_device.c:2755: warning: expecting prototype for phy_get_delay_index(). Prototype was for phy_get_internal_delay() instead
../drivers/net/phy/phy_device.c:2755: warning: expecting prototype for phy_get_delay_index(). Prototype was for phy_get_internal_delay() instead
../drivers/net/phy/mdio_bus.c:484: warning: expecting prototype for mdiobus_create_device_from_board_info(). Prototype was for mdiobus_create_device() instead
../drivers/net/phy/mdio_bus.c:484: warning: expecting prototype for mdiobus_create_device_from_board_info(). Prototype was for mdiobus_create_device() instead
../mm/truncate.c:646: warning: expecting prototype for except that it accounts for pages(). Prototype was for invalidate_mapping_pagevec() instead
../drivers/net/phy/phylink.c:1662: warning: expecting prototype for phylink_ethtool_get_eee_err(). Prototype was for phylink_get_eee_err() instead
../mm/page_alloc.c:510: warning: expecting prototype for get_pfnblock_flags_mask(). Prototype was for __get_pfnblock_flags_mask() instead
../include/trace/events/irq.h:65: warning: expecting prototype for irq_handler_entry(). Prototype was for trace_irq_handler_entry() instead
../include/trace/events/irq.h:95: warning: expecting prototype for irq_handler_exit(). Prototype was for trace_irq_handler_exit() instead
../include/trace/events/irq.h:133: warning: expecting prototype for softirq_entry(). Prototype was for trace_softirq_entry() instead
../include/trace/events/irq.h:147: warning: expecting prototype for softirq_exit(). Prototype was for trace_softirq_exit() instead
../include/trace/events/irq.h:161: warning: expecting prototype for softirq_raise(). Prototype was for trace_softirq_raise() instead
../include/trace/events/irq.h:1: warning: no structured comments found
../include/trace/events/signal.h:68: warning: expecting prototype for signal_generate(). Prototype was for trace_signal_generate() instead
../include/trace/events/signal.h:111: warning: expecting prototype for signal_deliver(). Prototype was for trace_signal_deliver() instead
../include/trace/events/signal.h:1: warning: no structured comments found
../include/trace/events/block.h:50: warning: expecting prototype for block_touch_buffer(). Prototype was for trace_block_touch_buffer() instead
../include/trace/events/block.h:63: warning: expecting prototype for block_dirty_buffer(). Prototype was for trace_block_dirty_buffer() instead
../include/trace/events/block.h:89: warning: expecting prototype for block_rq_requeue(). Prototype was for trace_block_rq_requeue() instead
../include/trace/events/block.h:132: warning: expecting prototype for block_rq_complete(). Prototype was for trace_block_rq_complete() instead
../include/trace/events/block.h:197: warning: expecting prototype for block_rq_insert(). Prototype was for trace_block_rq_insert() instead
../include/trace/events/block.h:212: warning: expecting prototype for block_rq_issue(). Prototype was for trace_block_rq_issue() instead
../include/trace/events/block.h:227: warning: expecting prototype for block_rq_merge(). Prototype was for trace_block_rq_merge() instead
../include/trace/events/block.h:255: warning: expecting prototype for block_bio_bounce(). Prototype was for trace_block_bio_bounce() instead
../include/trace/events/block.h:291: warning: expecting prototype for block_bio_complete(). Prototype was for trace_block_bio_complete() instead
../include/trace/events/block.h:346: warning: expecting prototype for block_bio_backmerge(). Prototype was for trace_block_bio_backmerge() instead
../include/trace/events/block.h:362: warning: expecting prototype for block_bio_frontmerge(). Prototype was for trace_block_bio_frontmerge() instead
../include/trace/events/block.h:386: warning: expecting prototype for block_bio_queue(). Prototype was for trace_block_bio_queue() instead
../include/trace/events/block.h:442: warning: expecting prototype for block_getrq(). Prototype was for trace_block_getrq() instead
../include/trace/events/block.h:460: warning: expecting prototype for block_sleeprq(). Prototype was for trace_block_sleeprq() instead
../include/trace/events/block.h:481: warning: expecting prototype for block_plug(). Prototype was for trace_block_plug() instead
../include/trace/events/block.h:520: warning: expecting prototype for block_unplug(). Prototype was for trace_block_unplug() instead
../include/trace/events/block.h:549: warning: expecting prototype for block_split(). Prototype was for trace_block_split() instead
../include/trace/events/block.h:590: warning: expecting prototype for block_bio_remap(). Prototype was for trace_block_bio_remap() instead
../include/trace/events/block.h:635: warning: expecting prototype for block_rq_remap(). Prototype was for trace_block_rq_remap() instead
../include/trace/events/block.h:1: warning: no structured comments found
../include/trace/events/workqueue.h:39: warning: expecting prototype for workqueue_queue_work(). Prototype was for trace_workqueue_queue_work() instead
../include/trace/events/workqueue.h:70: warning: expecting prototype for workqueue_activate_work(). Prototype was for trace_workqueue_activate_work() instead
../include/trace/events/workqueue.h:94: warning: expecting prototype for workqueue_execute_start(). Prototype was for trace_workqueue_execute_start() instead
../include/trace/events/workqueue.h:120: warning: expecting prototype for workqueue_execute_end(). Prototype was for trace_workqueue_execute_end() instead
../include/trace/events/workqueue.h:1: warning: no structured comments found
../include/uapi/drm/amdgpu_drm.h:674: warning: expecting prototype for w info(). Prototype was for AMDGPU_IDS_FLAGS_FUSION() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2180: warning: expecting prototype for amdgpu_vm_bo_insert_mapping(). Prototype was for amdgpu_vm_bo_insert_map() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2180: warning: expecting prototype for amdgpu_vm_bo_insert_mapping(). Prototype was for amdgpu_vm_bo_insert_map() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:243: warning: wrong kernel-doc identifier on line:
 * VRAM access helper functions.
../drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:243: warning: wrong kernel-doc identifier on line:
 * VRAM access helper functions.
../drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:243: warning: wrong kernel-doc identifier on line:
 * VRAM access helper functions.
../drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:542: warning: expecting prototype for amdgpu_vram_mgr_alloc_sgt(). Prototype was for amdgpu_vram_mgr_free_sgt() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:542: warning: expecting prototype for amdgpu_vram_mgr_alloc_sgt(). Prototype was for amdgpu_vram_mgr_free_sgt() instead
../fs/dcache.c:477: warning: expecting prototype for d_drop(). Prototype was for ___d_drop() instead
../fs/dcache.c:1007: warning: expecting prototype for d_find_alias(). Prototype was for __d_find_alias() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:542: warning: expecting prototype for amdgpu_vram_mgr_alloc_sgt(). Prototype was for amdgpu_vram_mgr_free_sgt() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:542: warning: expecting prototype for amdgpu_vram_mgr_alloc_sgt(). Prototype was for amdgpu_vram_mgr_free_sgt() instead
../fs/inode.c:1519: warning: expecting prototype for find_inode_by_rcu(). Prototype was for find_inode_by_ino_rcu() instead
../fs/inode.c:1790: warning: expecting prototype for touch_atime(). Prototype was for atime_needs_update() instead
../drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:243: warning: wrong kernel-doc identifier on line:
 * VRAM access helper functions.
../fs/super.c:1830: warning: expecting prototype for thaw_super(). Prototype was for thaw_super_locked() instead
../fs/locks.c:759: warning: expecting prototype for locks_delete_lock(). Prototype was for locks_delete_block() instead
../fs/locks.c:759: warning: expecting prototype for locks_delete_lock(). Prototype was for locks_delete_block() instead
../fs/seq_file.c:656: warning: wrong kernel-doc identifier on line:
 * A helper routine for putting decimal numbers without rich format of printf().
../fs/seq_file.c:1040: warning: expecting prototype for seq_hlist_start_precpu(). Prototype was for seq_hlist_start_percpu() instead
../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:93: warning: expecting prototype for struct dm_compressor_info. Prototype was for struct dm_comressor_info instead
../drivers/usb/typec/mux.c:80: warning: expecting prototype for typec_put_switch(). Prototype was for typec_switch_put() instead
../arch/s390/include/asm/cio.h:343: warning: expecting prototype for ccw_device_id_is_equal(). Prototype was for ccw_dev_id_is_equal() instead
../arch/s390/include/asm/ccwdev.h:153: warning: expecting prototype for struct ccw. Prototype was for struct ccw_driver instead
../include/linux/jbd2.h:452: warning: expecting prototype for struct jbd_inode. Prototype was for struct jbd2_inode instead
../fs/jbd2/journal.c:577: warning: expecting prototype for Force and wait upon a commit if the calling process is not within(). Prototype was for jbd2_journal_force_commit_nested() instead
../fs/jbd2/journal.c:592: warning: expecting prototype for int journal_force_commit(). Prototype was for jbd2_journal_force_commit() instead
../fs/jbd2/journal.c:1910: warning: expecting prototype for int jbd2_journal_load(). Prototype was for jbd2_journal_load() instead
../fs/jbd2/journal.c:1983: warning: expecting prototype for void jbd2_journal_destroy(). Prototype was for jbd2_journal_destroy() instead
../fs/jbd2/journal.c:2065: warning: expecting prototype for int jbd2_journal_check_used_features(). Prototype was for jbd2_journal_check_used_features() instead
../fs/jbd2/journal.c:2100: warning: expecting prototype for int jbd2_journal_check_available_features(). Prototype was for jbd2_journal_check_available_features() instead
../fs/jbd2/journal.c:2133: warning: expecting prototype for int jbd2_journal_set_features(). Prototype was for jbd2_journal_set_features() instead
../fs/jbd2/journal.c:2242: warning: expecting prototype for int jbd2_journal_flush(). Prototype was for jbd2_journal_flush() instead
../fs/jbd2/journal.c:2321: warning: expecting prototype for int jbd2_journal_wipe(). Prototype was for jbd2_journal_wipe() instead
../fs/jbd2/journal.c:2390: warning: expecting prototype for void jbd2_journal_abort(). Prototype was for jbd2_journal_abort() instead
../fs/jbd2/journal.c:2451: warning: expecting prototype for int jbd2_journal_errno(). Prototype was for jbd2_journal_errno() instead
../fs/jbd2/journal.c:2471: warning: expecting prototype for int jbd2_journal_clear_err(). Prototype was for jbd2_journal_clear_err() instead
../fs/jbd2/journal.c:2491: warning: expecting prototype for void jbd2_journal_ack_err(). Prototype was for jbd2_journal_ack_err() instead
../fs/jbd2/transaction.c:582: warning: expecting prototype for int jbd2_journal_start_reserved(). Prototype was for jbd2_journal_start_reserved() instead
../fs/jbd2/transaction.c:642: warning: expecting prototype for int jbd2_journal_extend(). Prototype was for jbd2_journal_extend() instead
../fs/jbd2/transaction.c:764: warning: expecting prototype for int jbd2_journal_restart(). Prototype was for jbd2__journal_restart() instead
../fs/jbd2/transaction.c:826: warning: expecting prototype for void jbd2_journal_lock_updates(). Prototype was for jbd2_journal_lock_updates() instead
../fs/jbd2/transaction.c:875: warning: wrong kernel-doc identifier on line:
 * void jbd2_journal_unlock_updates (journal_t* journal) - release barrier
../fs/jbd2/transaction.c:1194: warning: expecting prototype for int jbd2_journal_get_write_access(). Prototype was for jbd2_journal_get_write_access() instead
../fs/jbd2/transaction.c:1234: warning: expecting prototype for int jbd2_journal_get_create_access(). Prototype was for jbd2_journal_get_create_access() instead
../fs/jbd2/transaction.c:1333: warning: expecting prototype for int jbd2_journal_get_undo_access(). Prototype was for jbd2_journal_get_undo_access() instead
../fs/jbd2/transaction.c:1396: warning: expecting prototype for void jbd2_journal_set_triggers(). Prototype was for jbd2_journal_set_triggers() instead
../fs/jbd2/transaction.c:1449: warning: expecting prototype for int jbd2_journal_dirty_metadata(). Prototype was for jbd2_journal_dirty_metadata() instead
../fs/jbd2/transaction.c:1611: warning: expecting prototype for void jbd2_journal_forget(). Prototype was for jbd2_journal_forget() instead
../fs/jbd2/transaction.c:1779: warning: expecting prototype for int jbd2_journal_stop(). Prototype was for jbd2_journal_stop() instead
../fs/jbd2/transaction.c:2115: warning: expecting prototype for int jbd2_journal_try_to_free_buffers(). Prototype was for jbd2_journal_try_to_free_buffers() instead
../fs/jbd2/transaction.c:2427: warning: expecting prototype for void jbd2_journal_invalidatepage(). Prototype was for jbd2_journal_invalidatepage() instead
../include/drm/drm_device.h:45: warning: expecting prototype for enum drm_switch_power. Prototype was for enum switch_power_state instead
../drivers/scsi/scsi_devinfo.c:576: warning: expecting prototype for get_device_flags(). Prototype was for scsi_get_device_flags() instead
../drivers/scsi/scsi_lib.c:1512: warning: expecting prototype for scsi_dispatch_command(). Prototype was for scsi_dispatch_cmd() instead
../drivers/scsi/scsi_lib.c:2374: warning: expecting prototype for sdev_evt_emit(). Prototype was for scsi_evt_emit() instead
../drivers/scsi/scsi_lib.c:2422: warning: expecting prototype for sdev_evt_thread(). Prototype was for scsi_evt_thread() instead
../include/linux/mtd/rawnand.h:1293: warning: expecting prototype for s address should be sent only on the lower 8 bits(). Prototype was for nand_opcode_8bits() instead
../drivers/scsi/scsi_transport_fc.c:642: warning: expecting prototype for fc_host_rcv_fpin(). Prototype was for fc_host_fpin_rcv() instead
../include/drm/drm_print.h:341: warning: wrong kernel-doc identifier on line:
 * Error output.
../include/drm/drm_print.h:350: warning: wrong kernel-doc identifier on line:
 * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
../include/drm/drm_print.h:378: warning: wrong kernel-doc identifier on line:
 * Debug output.
../include/drm/drm_print.h:341: warning: wrong kernel-doc identifier on line:
 * Error output.
../include/drm/drm_print.h:350: warning: wrong kernel-doc identifier on line:
 * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
../include/drm/drm_print.h:378: warning: wrong kernel-doc identifier on line:
 * Debug output.
../drivers/mtd/nand/raw/nand_bbt.c:1098: warning: expecting prototype for mark_bbt_regions(). Prototype was for mark_bbt_region() instead
../drivers/vme/vme.c:88: warning: expecting prototype for vme_free_consistent(). Prototype was for vme_alloc_consistent() instead
../drivers/vme/vme.c:666: warning: expecting prototype for vme_master_write(). Prototype was for vme_master_read() instead
../include/linux/w1.h:292: warning: expecting prototype for module_w1_driver(). Prototype was for module_w1_family() instead
../drivers/gpu/drm/drm_mode_object.c:125: warning: expecting prototype for drm_lease_required(). Prototype was for drm_mode_object_lease_required() instead
../drivers/gpu/drm/drm_framebuffer.c:569: warning: expecting prototype for drm_mode_getfb2(). Prototype was for drm_mode_getfb2_ioctl() instead
../include/linux/iio/trigger.h:108: warning: expecting prototype for iio_device_set_drvdata(). Prototype was for iio_trigger_set_drvdata() instead
../drivers/gpu/drm/drm_framebuffer.c:569: warning: expecting prototype for drm_mode_getfb2(). Prototype was for drm_mode_getfb2_ioctl() instead
../drivers/infiniband/core/iwpm_util.h:148: warning: expecting prototype for iwpm_add_reminfo(). Prototype was for iwpm_add_remote_info() instead
../drivers/pci/p2pdma.c:629: warning: expecting prototype for pci_p2pmem_find(). Prototype was for pci_p2pmem_find_many() instead
../drivers/pci/p2pdma.c:684: warning: expecting prototype for pci_alloc_p2p_mem(). Prototype was for pci_alloc_p2pmem() instead
../drivers/pci/p2pdma.c:736: warning: expecting prototype for pci_virt_to_bus(). Prototype was for pci_p2pmem_virt_to_bus() instead
../drivers/pci/p2pdma.c:876: warning: expecting prototype for pci_p2pdma_map_sg(). Prototype was for pci_p2pdma_map_sg_attrs() instead
../drivers/pci/p2pdma.c:909: warning: expecting prototype for pci_p2pdma_unmap_sg(). Prototype was for pci_p2pdma_unmap_sg_attrs() instead
../drivers/pci/pci.c:3493: warning: expecting prototype for pci_acs_path_enable(). Prototype was for pci_acs_path_enabled() instead
../drivers/slimbus/slimbus.h:257: warning: expecting prototype for enum slim_ch_aux_fmt. Prototype was for enum slim_ch_aux_bit_fmt instead
../drivers/pci/pci-driver.c:102: warning: expecting prototype for store_new_id(). Prototype was for new_id_store() instead
../drivers/pci/pci-driver.c:170: warning: expecting prototype for store_remove_id(). Prototype was for remove_id_store() instead
../drivers/gpu/drm/drm_modes.c:1901: warning: expecting prototype for drm_crtc_convert_to_umode(). Prototype was for drm_mode_convert_to_umode() instead
../drivers/gpu/drm/drm_modes.c:1958: warning: expecting prototype for drm_crtc_convert_umode(). Prototype was for drm_mode_convert_umode() instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../drivers/infiniband/core/cq.c:140: warning: expecting prototype for ib_process_direct_cq(). Prototype was for ib_process_cq_direct() instead
../drivers/infiniband/core/cq.c:216: warning: expecting prototype for __ib_alloc_cq        allocate a completion queue(). Prototype was for __ib_alloc_cq() instead
../include/drm/drm_connector.h:131: warning: expecting prototype for enum drm_connector_registration_status. Prototype was for enum drm_connector_registration_state instead
../drivers/infiniband/core/cm.c:1254: warning: wrong kernel-doc identifier on line:
 * Create a new listening ib_cm_id and listen on the given service ID.
../drivers/infiniband/core/cm.c:1777: warning: expecting prototype for Convert OPA SGID to IB SGID(). Prototype was for cm_opa_to_ib_sgid() instead
../drivers/pci/probe.c:178: warning: expecting prototype for pci_read_base(). Prototype was for __pci_read_base() instead
../drivers/pci/probe.c:1626: warning: expecting prototype for pci_cfg_space_size(). Prototype was for pci_cfg_space_size_ext() instead
../drivers/pci/slot.c:333: warning: expecting prototype for pci_hp_create_link(). Prototype was for pci_hp_create_module_link() instead
../drivers/pci/slot.c:359: warning: expecting prototype for pci_hp_remove_link(). Prototype was for pci_hp_remove_module_link() instead
../drivers/infiniband/core/verbs.c:260: warning: expecting prototype for ib_alloc_pd(). Prototype was for __ib_alloc_pd() instead
../drivers/infiniband/core/verbs.c:1666: warning: wrong kernel-doc identifier on line:
 * IB core internal function to perform QP attributes modification.
../drivers/spi/spi.c:3210: warning: expecting prototype for spi_split_tranfers_maxsize(). Prototype was for spi_split_transfers_maxsize() instead
../drivers/infiniband/core/sa_query.c:1438: warning: wrong kernel-doc identifier on line:
 * Check if current PR query can be an OPA query.
../drivers/spi/spi.c:3210: warning: expecting prototype for spi_split_tranfers_maxsize(). Prototype was for spi_split_transfers_maxsize() instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../include/linux/edac.h:255: warning: expecting prototype for enum edac. Prototype was for enum edac_type instead
../include/linux/edac.h:331: warning: expecting prototype for enum edac_mc_layer. Prototype was for enum edac_mc_layer_type instead
../drivers/infiniband/sw/rdmavt/ah.c:136: warning: expecting prototype for rvt_destory_ah(). Prototype was for rvt_destroy_ah() instead
../drivers/edac/edac_device.h:289: warning: wrong kernel-doc identifier on line:
 * Log correctable errors.
../drivers/edac/edac_device.h:302: warning: wrong kernel-doc identifier on line:
 * Log uncorrectable errors.
../drivers/infiniband/sw/rdmavt/qp.c:1837: warning: expecting prototype for rvt_post_receive(). Prototype was for rvt_post_recv() instead
../drivers/infiniband/sw/rdmavt/qp.c:2259: warning: expecting prototype for rvt_post_srq_receive(). Prototype was for rvt_post_srq_recv() instead
../drivers/infiniband/sw/rdmavt/qp.c:2504: warning: expecting prototype for qp_comm_est(). Prototype was for rvt_comm_est() instead
../drivers/infiniband/sw/rdmavt/qp.c:2956: warning: expecting prototype for ruc_loopback(). Prototype was for rvt_ruc_loopback() instead
../drivers/infiniband/sw/rdmavt/mcast.c:63: warning: expecting prototype for rvt_driver_mcast(). Prototype was for rvt_driver_mcast_init() instead
../drivers/infiniband/sw/rdmavt/mcast.c:76: warning: expecting prototype for mcast_qp_alloc(). Prototype was for rvt_mcast_qp_alloc() instead
../drivers/infiniband/sw/rdmavt/mcast.c:108: warning: expecting prototype for mcast_alloc(). Prototype was for rvt_mcast_alloc() instead
../drivers/infiniband/sw/rdmavt/mcast.c:195: warning: expecting prototype for mcast_add(). Prototype was for rvt_mcast_add() instead
../drivers/infiniband/sw/rdmavt/mcast.c:435: warning: expecting prototype for rvt_mast_tree_empty(). Prototype was for rvt_mcast_tree_empty() instead
../drivers/scsi/libiscsi.c:793: warning: expecting prototype for iscsi_cmd_rsp(). Prototype was for iscsi_scsi_cmd_rsp() instead
../drivers/infiniband/ulp/iser/iscsi_iser.c:750: warning: expecting prototype for iscsi_iser_set_param(). Prototype was for iscsi_iser_conn_get_stats() instead
../drivers/scsi/iscsi_tcp.c:187: warning: expecting prototype for iscsi_write_space(). Prototype was for iscsi_sw_tcp_write_space() instead
../drivers/scsi/iscsi_tcp.c:360: warning: expecting prototype for iscsi_tcp_xmit_qlen(). Prototype was for iscsi_sw_tcp_xmit_qlen() instead
../include/media/v4l2-ctrls.h:1304: warning: expecting prototype for v4l2_ctrl_request_ctrl_find(). Prototype was for v4l2_ctrl_request_hdl_ctrl_find() instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:445: warning: expecting prototype for struct opa_vnic_iface_macs_entry. Prototype was for struct opa_vnic_iface_mac_entry instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c:86: warning: expecting prototype for opa_vnic_get_error_counters(). Prototype was for opa_vnic_get_summary_counters() instead
../drivers/base/firmware_loader/fallback.c:145: warning: expecting prototype for firmware_timeout_store(). Prototype was for timeout_store() instead
../drivers/infiniband/ulp/srpt/ib_srpt.h:361: warning: expecting prototype for struct srpt_port_attib. Prototype was for struct srpt_port_attrib instead
../include/linux/firmware/intel/stratix10-svc-client.h:15: warning: expecting prototype for Service layer driver supports client names(). Prototype was for SVC_CLIENT_FPGA() instead
../include/linux/firmware/intel/stratix10-svc-client.h:45: warning: expecting prototype for in bit number(). Prototype was for SVC_STATUS_OK() instead
../include/linux/firmware/intel/stratix10-svc-client.h:59: warning: expecting prototype for Flag bit for COMMAND_RECONFIG(). Prototype was for COMMAND_RECONFIG_FLAG_PARTIAL() instead
../include/linux/firmware/intel/stratix10-svc-client.h:66: warning: expecting prototype for Timeout settings for service clients(). Prototype was for SVC_RECONFIG_REQUEST_TIMEOUT_MS() instead
../include/linux/firmware/intel/stratix10-svc-client.h:228: warning: expecting prototype for intel_svc_done(). Prototype was for stratix10_svc_done() instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../include/linux/firmware/intel/stratix10-svc-client.h:15: warning: expecting prototype for Service layer driver supports client names(). Prototype was for SVC_CLIENT_FPGA() instead
../include/linux/firmware/intel/stratix10-svc-client.h:45: warning: expecting prototype for in bit number(). Prototype was for SVC_STATUS_OK() instead
../include/linux/firmware/intel/stratix10-svc-client.h:59: warning: expecting prototype for Flag bit for COMMAND_RECONFIG(). Prototype was for COMMAND_RECONFIG_FLAG_PARTIAL() instead
../include/linux/firmware/intel/stratix10-svc-client.h:66: warning: expecting prototype for Timeout settings for service clients(). Prototype was for SVC_RECONFIG_REQUEST_TIMEOUT_MS() instead
../include/linux/firmware/intel/stratix10-svc-client.h:228: warning: expecting prototype for intel_svc_done(). Prototype was for stratix10_svc_done() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/linux/firmware/intel/stratix10-svc-client.h:15: warning: expecting prototype for Service layer driver supports client names(). Prototype was for SVC_CLIENT_FPGA() instead
../include/linux/firmware/intel/stratix10-svc-client.h:45: warning: expecting prototype for in bit number(). Prototype was for SVC_STATUS_OK() instead
../include/linux/firmware/intel/stratix10-svc-client.h:59: warning: expecting prototype for Flag bit for COMMAND_RECONFIG(). Prototype was for COMMAND_RECONFIG_FLAG_PARTIAL() instead
../include/linux/firmware/intel/stratix10-svc-client.h:66: warning: expecting prototype for Timeout settings for service clients(). Prototype was for SVC_RECONFIG_REQUEST_TIMEOUT_MS() instead
../include/linux/firmware/intel/stratix10-svc-client.h:228: warning: expecting prototype for intel_svc_done(). Prototype was for stratix10_svc_done() instead
../drivers/gpu/drm/drm_connector.c:1437: warning: expecting prototype for drm_mode_attach_tv_margin_properties(). Prototype was for drm_connector_attach_tv_margin_properties() instead
../include/media/v4l2-dev.h:59: warning: expecting prototype for enum vfl_direction. Prototype was for enum vfl_devnode_direction instead
../include/linux/firmware/intel/stratix10-svc-client.h:15: warning: expecting prototype for Service layer driver supports client names(). Prototype was for SVC_CLIENT_FPGA() instead
../include/linux/firmware/intel/stratix10-svc-client.h:45: warning: expecting prototype for in bit number(). Prototype was for SVC_STATUS_OK() instead
../include/linux/firmware/intel/stratix10-svc-client.h:59: warning: expecting prototype for Flag bit for COMMAND_RECONFIG(). Prototype was for COMMAND_RECONFIG_FLAG_PARTIAL() instead
../include/linux/firmware/intel/stratix10-svc-client.h:66: warning: expecting prototype for Timeout settings for service clients(). Prototype was for SVC_RECONFIG_REQUEST_TIMEOUT_MS() instead
../include/linux/firmware/intel/stratix10-svc-client.h:228: warning: expecting prototype for intel_svc_done(). Prototype was for stratix10_svc_done() instead
../include/linux/firmware/intel/stratix10-svc-client.h:15: warning: expecting prototype for Service layer driver supports client names(). Prototype was for SVC_CLIENT_FPGA() instead
../include/linux/firmware/intel/stratix10-svc-client.h:45: warning: expecting prototype for in bit number(). Prototype was for SVC_STATUS_OK() instead
../include/linux/firmware/intel/stratix10-svc-client.h:59: warning: expecting prototype for Flag bit for COMMAND_RECONFIG(). Prototype was for COMMAND_RECONFIG_FLAG_PARTIAL() instead
../include/linux/firmware/intel/stratix10-svc-client.h:66: warning: expecting prototype for Timeout settings for service clients(). Prototype was for SVC_RECONFIG_REQUEST_TIMEOUT_MS() instead
../include/linux/firmware/intel/stratix10-svc-client.h:228: warning: expecting prototype for intel_svc_done(). Prototype was for stratix10_svc_done() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../drivers/regulator/core.c:5536: warning: expecting prototype for regulator_get_id(). Prototype was for rdev_get_id() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../drivers/usb/dwc3/core.h:1336: warning: expecting prototype for struct dwc3_event_depvt. Prototype was for struct dwc3_event_depevt instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/media/v4l2-device.h:188: warning: expecting prototype for __v4l2_device_register_ro_subdev_nodes(). Prototype was for __v4l2_device_register_subdev_nodes() instead
../drivers/usb/dwc3/core.c:41: warning: expecting prototype for c(). Prototype was for DWC3_DEFAULT_AUTOSUSPEND_DELAY() instead
../include/media/v4l2-dv-timings.h:238: warning: expecting prototype for struct v4l2_hdmi_rx_colorimetry. Prototype was for struct v4l2_hdmi_colorimetry instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/linux/usb/composite.h:517: warning: expecting prototype for struct usb_composite_device. Prototype was for struct usb_composite_dev instead
../drivers/usb/gadget/composite.c:1264: warning: expecting prototype for usb_string_ids(). Prototype was for usb_string_ids_tab() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/media/v4l2-fwnode.h:535: warning: expecting prototype for v4l2_fwnode_reference_parse_sensor_common(). Prototype was for v4l2_async_notifier_parse_fwnode_sensor_common() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/media/v4l2-mediabus.h:159: warning: expecting prototype for v4l2_fill_pix_format(). Prototype was for v4l2_fill_mbus_format() instead
../include/media/v4l2-mediabus.h:180: warning: expecting prototype for v4l2_fill_pix_format(). Prototype was for v4l2_fill_pix_format_mplane() instead
../include/media/v4l2-mediabus.h:200: warning: expecting prototype for v4l2_fill_pix_format(). Prototype was for v4l2_fill_mbus_format_mplane() instead
../drivers/video/fbdev/core/fbcmap.c:93: warning: expecting prototype for fb_alloc_cmap(). Prototype was for fb_alloc_cmap_gfp() instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../drivers/base/class.c:228: warning: expecting prototype for class_create(). Prototype was for __class_create() instead
../include/media/v4l2-subdev.h:324: warning: expecting prototype for enum v4l2_mbus_frame_desc_entry. Prototype was for enum v4l2_mbus_frame_desc_flags instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../include/net/cfg80211.h:1466: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum rate_info_flags instead
../include/net/cfg80211.h:1533: warning: expecting prototype for enum station_info_rate_flags. Prototype was for enum bss_param_flags instead
../include/net/cfg80211.h:6484: warning: expecting prototype for cfg80211_notify_new_candidate(). Prototype was for cfg80211_notify_new_peer_candidate() instead
../include/net/cfg80211.h:7622: warning: expecting prototype for struct cfg80211_ft_event. Prototype was for struct cfg80211_ft_event_params instead
../drivers/pnp/core.c:60: warning: expecting prototype for pnp_protocol_register(). Prototype was for pnp_register_protocol() instead
../drivers/pnp/core.c:98: warning: expecting prototype for pnp_protocol_unregister(). Prototype was for pnp_unregister_protocol() instead
../drivers/pnp/core.c:1: warning: no structured comments found
../include/drm/drm_atomic_helper.h:180: warning: expecting prototype for drm_crtc_atomic_state_for_each_plane(). Prototype was for drm_atomic_crtc_state_for_each_plane() instead
../include/drm/drm_atomic_helper.h:201: warning: expecting prototype for drm_crtc_atomic_state_for_each_plane_state(). Prototype was for drm_atomic_crtc_state_for_each_plane_state() instead
../drivers/uio/uio.c:919: warning: expecting prototype for uio_register_device(). Prototype was for __uio_register_device() instead
../drivers/uio/uio.c:1015: warning: expecting prototype for devm_uio_register_device(). Prototype was for __devm_uio_register_device() instead
../include/media/videobuf2-core.h:1054: warning: expecting prototype for vb2_read(). Prototype was for vb2_write() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/gpu/drm/drm_atomic_state_helper.c:555: warning: expecting prototype for __drm_atomic_helper_private_duplicate_state(). Prototype was for __drm_atomic_helper_private_obj_duplicate_state() instead
../drivers/gpu/drm/drm_atomic_state_helper.c:555: warning: expecting prototype for __drm_atomic_helper_private_duplicate_state(). Prototype was for __drm_atomic_helper_private_obj_duplicate_state() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/drm/drm_fb_helper.h:211: warning: expecting prototype for define DRM_FB_HELPER_DEFAULT_OPS(). Prototype was for DRM_FB_HELPER_DEFAULT_OPS() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/misc/mei/bus.c:1050: warning: expecting prototype for mei_cl_dev_setup(). Prototype was for mei_cl_bus_dev_setup() instead
../drivers/hsi/hsi_core.c:359: warning: expecting prototype for hsi_unregister_port(). Prototype was for hsi_port_unregister_clients() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/ata/libata-core.c:5627: warning: expecting prototype for ata_sas_host_init(). Prototype was for ata_host_init() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/parport/share.c:280: warning: expecting prototype for parport_register_driver(). Prototype was for __parport_register_driver() instead
../drivers/ata/libata-core.c:5627: warning: expecting prototype for ata_sas_host_init(). Prototype was for ata_host_init() instead
../drivers/gpu/drm/drm_dp_helper.c:1099: warning: expecting prototype for drm_mode_set_dp_subconnector_property(). Prototype was for drm_dp_set_subconnector_property() instead
../drivers/gpu/drm/drm_dp_helper.c:1099: warning: expecting prototype for drm_mode_set_dp_subconnector_property(). Prototype was for drm_dp_set_subconnector_property() instead
../drivers/ata/libata-eh.c:1127: warning: expecting prototype for ata_port_thaw_port(). Prototype was for ata_eh_thaw_port() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/ata/libata-scsi.c:1021: warning: expecting prototype for atapi_drain_needed(). Prototype was for ata_scsi_dma_need_drain() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/ata/libata-scsi.c:1021: warning: expecting prototype for atapi_drain_needed(). Prototype was for ata_scsi_dma_need_drain() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/drm/drm_dsc.h:582: warning: expecting prototype for struct picture_parameter_set. Prototype was for struct drm_dsc_picture_parameter_set instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/gpu/drm/drm_scdc_helper.c:138: warning: expecting prototype for drm_scdc_check_scrambling_status(). Prototype was for drm_scdc_get_scrambling_status() instead
../drivers/gpu/drm/drm_scdc_helper.c:138: warning: expecting prototype for drm_scdc_check_scrambling_status(). Prototype was for drm_scdc_get_scrambling_status() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/video/hdmi.c:1706: warning: expecting prototype for hdmi_vendor_infoframe_unpack(). Prototype was for hdmi_vendor_any_infoframe_unpack() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/media/dvb-frontends/ascot2e.h:46: warning: expecting prototype for Attach an ascot2e tuner(). Prototype was for ascot2e_attach() instead
../include/net/mac80211.h:3327: warning: expecting prototype for enum ieee80211_reconfig_complete_type. Prototype was for enum ieee80211_reconfig_type instead
../include/net/mac80211.h:6342: warning: expecting prototype for Sanity(). Prototype was for ieee80211_parse_tx_radiotap() instead
../include/net/mac80211.h:6403: warning: expecting prototype for ieee80211_tdls_oper(). Prototype was for ieee80211_tdls_oper_request() instead
../drivers/media/dvb-frontends/cxd2820r.h:114: warning: expecting prototype for Attach a cxd2820r demod(). Prototype was for cxd2820r_attach() instead
../drivers/media/dvb-frontends/drxk.h:65: warning: expecting prototype for Attach a drxk demod(). Prototype was for drxk_attach() instead
../drivers/media/dvb-frontends/dvb-pll.h:53: warning: expecting prototype for Attach a dvb(). Prototype was for dvb_pll_attach() instead
../drivers/media/dvb-frontends/dvb-pll.h:1: warning: no structured comments found
../drivers/media/dvb-frontends/helene.h:47: warning: wrong kernel-doc identifier on line:
 * Attach a helene tuner (terrestrial and cable standards)
../drivers/media/dvb-frontends/helene.h:60: warning: wrong kernel-doc identifier on line:
 * Attach a helene tuner (satellite standards)
../net/mac80211/sta_info.h:795: warning: expecting prototype for sta_info_flush(). Prototype was for __sta_info_flush() instead
../drivers/media/dvb-frontends/horus3a.h:46: warning: expecting prototype for Attach a horus3a tuner(). Prototype was for horus3a_attach() instead
../drivers/media/dvb-frontends/ix2505v.h:9: warning: expecting prototype for DVB(). Prototype was for DVB_IX2505V_H() instead
../drivers/media/dvb-frontends/ix2505v.h:34: warning: wrong kernel-doc identifier on line:
 * Attach a ix2505v tuner to the supplied frontend structure.
../net/mac80211/sta_info.h:795: warning: expecting prototype for sta_info_flush(). Prototype was for __sta_info_flush() instead
../drivers/media/dvb-frontends/m88ds3103.h:144: warning: expecting prototype for Attach a m88ds3103 demod(). Prototype was for m88ds3103_attach() instead
../drivers/media/dvb-frontends/mb86a20s.h:37: warning: expecting prototype for Attach a mb86a20s demod(). Prototype was for mb86a20s_attach() instead
../drivers/media/dvb-frontends/stb6000.h:18: warning: wrong kernel-doc identifier on line:
 * Attach a stb6000 tuner to the supplied frontend structure.
../drivers/media/dvb-frontends/stb6000.h:1: warning: no structured comments found
../drivers/media/dvb-frontends/tda826x.h:17: warning: wrong kernel-doc identifier on line:
 * Attach a tda826x tuner to the supplied frontend structure.
../drivers/media/dvb-frontends/tda826x.h:1: warning: no structured comments found
../drivers/media/dvb-frontends/zl10036.h:10: warning: expecting prototype for Driver for Zarlink ZL10036 DVB(). Prototype was for DVB_ZL10036_H() instead
../drivers/media/dvb-frontends/zl10036.h:22: warning: wrong kernel-doc identifier on line:
 * Attach a zl10036 tuner to the supplied frontend structure.
../drivers/media/dvb-frontends/zl10036.h:1: warning: no structured comments found
../kernel/sched/core.c:6088: warning: expecting prototype for sys_sched_yield(). Prototype was for do_sched_yield() instead
../kernel/sched/fair.c:6328: warning: expecting prototype for used by CFS tasks(). Prototype was for cpu_util() instead
../include/linux/completion.h:86: warning: expecting prototype for init_completion(). Prototype was for __init_completion() instead
../include/media/dvbdev.h:332: warning: expecting prototype for dvb_generic_close(). Prototype was for dvb_generic_release() instead
../include/linux/hrtimer.h:469: warning: expecting prototype for whether the timer is on one of the queues(). Prototype was for hrtimer_is_queued() instead
../kernel/time/hrtimer.c:1297: warning: expecting prototype for hrtimer_get_remaining(). Prototype was for __hrtimer_get_remaining() instead
../include/linux/refcount.h:113: warning: expecting prototype for struct refcount_t. Prototype was for struct refcount_struct instead
../drivers/gpu/drm/drm_gem.c:889: warning: expecting prototype for drm_gem_open(). Prototype was for drm_gem_open_ioctl() instead
../drivers/gpu/drm/drm_gem.c:930: warning: expecting prototype for gem_gem_open(). Prototype was for drm_gem_open() instead
../drivers/base/devres.c:166: warning: expecting prototype for devres_alloc(). Prototype was for devres_alloc_node() instead
../drivers/gpu/drm/drm_gem_vram_helper.c:660: warning: expecting prototype for drm_gem_vram_driver_create_dumb(). Prototype was for drm_gem_vram_driver_dumb_create() instead
../include/drm/drm_gem_vram_helper.h:84: warning: Incorrect use of kernel-doc format:  * Returns the container of type &struct drm_gem_vram_object
../include/drm/drm_gem_vram_helper.h:97: error: Cannot parse struct or union!
../include/drm/drm_gem_vram_helper.h:156: warning: expecting prototype for define DRM_GEM_VRAM_DRIVER(). Prototype was for DRM_GEM_VRAM_DRIVER() instead
../drivers/gpu/drm/drm_gem_vram_helper.c:660: warning: expecting prototype for drm_gem_vram_driver_create_dumb(). Prototype was for drm_gem_vram_driver_dumb_create() instead
../drivers/gpu/drm/scheduler/sched_main.c:456: warning: expecting prototype for drm_sched_job_recovery(). Prototype was for drm_sched_start() instead
../include/linux/connector.h:122: warning: expecting prototype for cn_netlink_send_mult(). Prototype was for cn_netlink_send() instead
../drivers/gpu/drm/scheduler/sched_main.c:456: warning: expecting prototype for drm_sched_job_recovery(). Prototype was for drm_sched_start() instead
^[[A
../drivers/gpu/drm/i915/display/intel_dpll_mgr.c:4542: warning: expecting prototype for intel_shared_dpll_dump_hw_state(). Prototype was for intel_dpll_dump_hw_state() instead
../drivers/gpu/drm/i915/display/intel_dpll_mgr.c:4542: warning: expecting prototype for intel_shared_dpll_dump_hw_state(). Prototype was for intel_dpll_dump_hw_state() instead
../drivers/gpu/drm/i915/i915_gem_evict.c:254: warning: expecting prototype for i915_gem_evict_for_vma(). Prototype was for i915_gem_evict_for_node() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/i915/i915_perf.c:628: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:920: warning: wrong kernel-doc identifier on line:
 * Copies all buffered OA reports into userspace read() buffer.
../drivers/gpu/drm/i915/i915_perf.c:3244: warning: expecting prototype for i915_perf_ioctl(). Prototype was for i915_perf_ioctl_locked() instead
../drivers/gpu/drm/v3d/v3d_sched.c:67: warning: wrong kernel-doc identifier on line:
 * Returns the fences that the job depends on, one by one.


